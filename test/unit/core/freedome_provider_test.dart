import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_freedome/src/core/freedome_provider.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/core/content_service.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';
import 'package:flutter_freedome/src/models/content_models.dart';

import 'freedome_provider_test.mocks.dart';

@GenerateMocks([
  FreeDomeConnectionService,
  FreeDomeAuthService,
  FreeDomeContentService,
])
void main() {
  group('FreeDomeProvider', () {
    late FreeDomeProvider provider;
    late MockFreeDomeConnectionService mockConnectionService;
    late MockFreeDomeAuthService mockAuthService;
    late MockFreeDomeContentService mockContentService;

    setUp(() {
      provider = FreeDomeProvider();
      mockConnectionService = MockFreeDomeConnectionService();
      mockAuthService = MockFreeDomeAuthService();
      mockContentService = MockFreeDomeContentService();
    });

    tearDown(() {
      provider.dispose();
    });

    group('Initialization', () {
      test('should initialize successfully with default guest role', () async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);

        final result = await provider.initialize();

        expect(result, true);
        expect(provider.isInitialized, true);
        expect(provider.isInitializing, false);
        expect(provider.error, null);
        expect(provider.isReady, true);
      });

      test('should handle initialization failure gracefully', () async {
        when(mockConnectionService.initialize()).thenThrow(Exception('Connection failed'));
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});

        final result = await provider.initialize();

        expect(result, false);
        expect(provider.isInitialized, false);
        expect(provider.isInitializing, false);
        expect(provider.error, isNotNull);
        expect(provider.isReady, false);
      });

      test('should not reinitialize if already initialized', () async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);

        // First initialization
        await provider.initialize();
        expect(provider.isInitialized, true);

        // Second initialization should return immediately
        final result = await provider.initialize();
        expect(result, true);
        
        // Verify services were only initialized once
        verify(mockConnectionService.initialize()).called(1);
        verify(mockAuthService.initialize()).called(1);
        verify(mockContentService.initialize()).called(1);
      });

      test('should not reinitialize if currently initializing', () async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
        });
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);

        // Start first initialization
        final future1 = provider.initialize();
        expect(provider.isInitializing, true);

        // Second initialization should return false immediately
        final result2 = await provider.initialize();
        expect(result2, false);

        // Wait for first initialization to complete
        await future1;
        expect(provider.isInitialized, true);
      });
    });

    group('Connection Management', () {
      setUp(() async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should connect to nearest dome successfully', () async {
        final testDome = DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        );

        when(mockConnectionService.discoveredSystems).thenReturn([testDome]);
        when(mockConnectionService.connectToDome(testDome)).thenAnswer((_) async => true);

        final result = await provider.connectToNearestDome();

        expect(result, true);
        verify(mockConnectionService.connectToDome(testDome)).called(1);
      });

      test('should fail to connect when no domes are discovered', () async {
        when(mockConnectionService.discoveredSystems).thenReturn([]);

        final result = await provider.connectToNearestDome();

        expect(result, false);
        verifyNever(mockConnectionService.connectToDome(any));
      });

      test('should connect to specific dome', () async {
        final testDome = DomeSystem(
          id: 'specific-dome',
          name: 'Specific Dome',
          ipAddress: '10.0.0.50',
          port: 9000,
          type: DomeSystemType.mobile,
          status: DomeSystemStatus.online,
        );

        when(mockConnectionService.connectToDome(testDome)).thenAnswer((_) async => true);

        final result = await provider.connectToDome(testDome);

        expect(result, true);
        verify(mockConnectionService.connectToDome(testDome)).called(1);
      });

      test('should disconnect from dome', () async {
        when(mockConnectionService.disconnectFromDome()).thenAnswer((_) async {});

        await provider.disconnect();

        verify(mockConnectionService.disconnectFromDome()).called(1);
      });

      test('should return false for connection operations when not initialized', () async {
        final uninitializedProvider = FreeDomeProvider();
        
        final result1 = await uninitializedProvider.connectToNearestDome();
        final result2 = await uninitializedProvider.connectToDome(DomeSystem(
          id: 'test',
          name: 'Test',
          ipAddress: '127.0.0.1',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));

        expect(result1, false);
        expect(result2, false);
        
        uninitializedProvider.dispose();
      });
    });

    group('Authentication', () {
      setUp(() async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should authenticate admin successfully', () async {
        when(mockAuthService.authenticateAdmin(
          username: 'admin',
          password: 'password',
          domeId: null,
        )).thenAnswer((_) async => true);

        final result = await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'password',
        );

        expect(result, true);
        verify(mockAuthService.authenticateAdmin(
          username: 'admin',
          password: 'password',
          domeId: null,
        )).called(1);
      });

      test('should fail admin authentication with wrong credentials', () async {
        when(mockAuthService.authenticateAdmin(
          username: 'admin',
          password: 'wrong',
          domeId: null,
        )).thenAnswer((_) async => false);

        final result = await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'wrong',
        );

        expect(result, false);
      });

      test('should switch to guest mode', () async {
        when(mockAuthService.switchToGuestMode()).thenAnswer((_) async => true);

        final result = await provider.switchToGuestMode();

        expect(result, true);
        verify(mockAuthService.switchToGuestMode()).called(1);
      });

      test('should logout successfully', () async {
        when(mockAuthService.logout()).thenAnswer((_) async {});

        await provider.logout();

        verify(mockAuthService.logout()).called(1);
      });

      test('should return false for auth operations when not initialized', () async {
        final uninitializedProvider = FreeDomeProvider();
        
        final result1 = await uninitializedProvider.authenticateAsAdmin(
          username: 'admin',
          password: 'password',
        );
        final result2 = await uninitializedProvider.switchToGuestMode();

        expect(result1, false);
        expect(result2, false);
        
        uninitializedProvider.dispose();
      });
    });

    group('Content Management', () {
      setUp(() async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should play content successfully', () async {
        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        when(mockContentService.playContent(testContent)).thenAnswer((_) async => true);

        final result = await provider.playContent(testContent);

        expect(result, true);
        verify(mockContentService.playContent(testContent)).called(1);
      });

      test('should play app content successfully', () async {
        when(mockContentService.playInteractiveContent(
          appName: 'TestApp',
          contentName: 'Test Interactive',
          appData: {'type': 'demo'},
        )).thenAnswer((_) async => true);

        final result = await provider.playAppContent(
          appName: 'TestApp',
          contentName: 'Test Interactive',
          appData: {'type': 'demo'},
        );

        expect(result, true);
        verify(mockContentService.playInteractiveContent(
          appName: 'TestApp',
          contentName: 'Test Interactive',
          appData: {'type': 'demo'},
        )).called(1);
      });

      test('should control playback successfully', () async {
        when(mockContentService.pausePlayback()).thenAnswer((_) async => true);
        when(mockContentService.resumePlayback()).thenAnswer((_) async => true);
        when(mockContentService.stopPlayback()).thenAnswer((_) async => true);

        final pauseResult = await provider.pausePlayback();
        final resumeResult = await provider.resumePlayback();
        final stopResult = await provider.stopPlayback();

        expect(pauseResult, true);
        expect(resumeResult, true);
        expect(stopResult, true);

        verify(mockContentService.pausePlayback()).called(1);
        verify(mockContentService.resumePlayback()).called(1);
        verify(mockContentService.stopPlayback()).called(1);
      });

      test('should set volume and brightness successfully', () async {
        when(mockContentService.setVolume(0.8)).thenAnswer((_) async => true);
        when(mockContentService.setBrightness(0.7)).thenAnswer((_) async => true);

        final volumeResult = await provider.setVolume(0.8);
        final brightnessResult = await provider.setBrightness(0.7);

        expect(volumeResult, true);
        expect(brightnessResult, true);

        verify(mockContentService.setVolume(0.8)).called(1);
        verify(mockContentService.setBrightness(0.7)).called(1);
      });

      test('should return false for content operations when not initialized', () async {
        final uninitializedProvider = FreeDomeProvider();
        
        const testContent = ProjectionContent(
          id: 'test',
          name: 'Test',
          filePath: '/test.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 1),
        );

        final result1 = await uninitializedProvider.playContent(testContent);
        final result2 = await uninitializedProvider.pausePlayback();
        final result3 = await uninitializedProvider.setVolume(0.5);

        expect(result1, false);
        expect(result2, false);
        expect(result3, false);
        
        uninitializedProvider.dispose();
      });
    });

    group('Permission Management', () {
      setUp(() async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should check permissions correctly', () {
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(true);
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(false);

        final hasPlayPermission = provider.hasPermission(FreeDomePermission.playContent);
        final hasCalibrationPermission = provider.hasPermission(FreeDomePermission.calibrateAudio);

        expect(hasPlayPermission, true);
        expect(hasCalibrationPermission, false);
      });

      test('should check roles correctly', () {
        when(mockAuthService.hasRole(FreeDomeUserRole.guest)).thenReturn(true);
        when(mockAuthService.hasRole(FreeDomeUserRole.admin)).thenReturn(false);

        final hasGuestRole = provider.hasRole(FreeDomeUserRole.guest);
        final hasAdminRole = provider.hasRole(FreeDomeUserRole.admin);

        expect(hasGuestRole, true);
        expect(hasAdminRole, false);
      });
    });

    group('System Status', () {
      setUp(() async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should provide comprehensive system status', () {
        const mockConnectionStatus = FreeDomeConnectionStatus(
          isConnected: true,
          isConnecting: false,
          connectedDomeId: 'test-dome',
        );

        when(mockConnectionService.connectionStatus).thenReturn(mockConnectionStatus);
        when(mockAuthService.getSessionInfo()).thenReturn({'role': 'guest'});
        when(mockContentService.getUsageStats()).thenReturn({'totalContent': 10});

        final status = provider.getSystemStatus();

        expect(status['isInitialized'], true);
        expect(status['isInitializing'], false);
        expect(status['isReady'], true);
        expect(status['error'], null);
        expect(status['connection'], mockConnectionStatus.toJson());
        expect(status['auth'], {'role': 'guest'});
        expect(status['content'], {'totalContent': 10});
      });
    });

    group('Reset Functionality', () {
      setUp(() async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should reset system state successfully', () async {
        when(mockConnectionService.disconnectFromDome()).thenAnswer((_) async {});
        when(mockAuthService.logout()).thenAnswer((_) async {});

        await provider.reset();

        expect(provider.isInitialized, false);
        expect(provider.isInitializing, false);
        expect(provider.error, null);

        verify(mockConnectionService.disconnectFromDome()).called(1);
        verify(mockAuthService.logout()).called(1);
      });

      test('should handle reset errors gracefully', () async {
        when(mockConnectionService.disconnectFromDome()).thenThrow(Exception('Disconnect failed'));
        when(mockAuthService.logout()).thenAnswer((_) async {});

        await provider.reset();

        expect(provider.error, isNotNull);
        expect(provider.error, contains('Disconnect failed'));
      });
    });

    group('Delegation Properties', () {
      setUp(() async {
        when(mockConnectionService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.initialize()).thenAnswer((_) async {});
        when(mockContentService.initialize()).thenAnswer((_) async {});
        when(mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should delegate properties to appropriate services', () {
        const testDome = DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        );

        const testPlaybackState = PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
        );

        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockConnectionService.activeDome).thenReturn(testDome);
        when(mockAuthService.isAuthenticated).thenReturn(true);
        when(mockAuthService.currentRole).thenReturn(FreeDomeUserRole.admin);
        when(mockContentService.playbackState).thenReturn(testPlaybackState);

        expect(provider.isConnected, true);
        expect(provider.activeDome, testDome);
        expect(provider.isAuthenticated, true);
        expect(provider.currentRole, FreeDomeUserRole.admin);
        expect(provider.playbackState, testPlaybackState);
      });
    });
  });
}
