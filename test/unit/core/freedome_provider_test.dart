import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_freedome/src/core/freedome_provider.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/core/content_service.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';
import 'package:flutter_freedome/src/models/content_models.dart';

// Mocktail не требует кодогенерации - просто наследуем от Mock
class MockFreeDomeConnectionService extends Mock implements FreeDomeConnectionService {}
class MockFreeDomeAuthService extends Mock implements FreeDomeAuthService {}
class MockFreeDomeContentService extends Mock implements FreeDomeContentService {}

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
        when(() => mockConnectionService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.initialize()).thenAnswer((_) async {});
        when(() => mockContentService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.createGuestSession()).thenAnswer((_) async => true);

        final result = await provider.initialize();

        expect(result, true);
        expect(provider.isInitialized, true);
        expect(provider.isInitializing, false);
        expect(provider.error, null);
        expect(provider.isReady, true);
      });

      test('should handle initialization failure gracefully', () async {
        when(() => mockConnectionService.initialize()).thenThrow(Exception('Connection failed'));
        when(() => mockAuthService.initialize()).thenAnswer((_) async {});
        when(() => mockContentService.initialize()).thenAnswer((_) async {});

        final result = await provider.initialize();

        expect(result, false);
        expect(provider.isInitialized, false);
        expect(provider.isInitializing, false);
        expect(provider.error, isNotNull);
        expect(provider.isReady, false);
      });

      test('should not reinitialize if already initialized', () async {
        when(() => mockConnectionService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.initialize()).thenAnswer((_) async {});
        when(() => mockContentService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.createGuestSession()).thenAnswer((_) async => true);

        // First initialization
        await provider.initialize();
        expect(provider.isInitialized, true);

        // Second initialization should return immediately
        final result = await provider.initialize();
        expect(result, true);
        
        // Verify services were only initialized once
        verify(() => mockConnectionService.initialize()).called(1);
        verify(() => mockAuthService.initialize()).called(1);
        verify(() => mockContentService.initialize()).called(1);
      });

      test('should not reinitialize if currently initializing', () async {
        when(() => mockConnectionService.initialize()).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
        });
        when(() => mockAuthService.initialize()).thenAnswer((_) async {});
        when(() => mockContentService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.createGuestSession()).thenAnswer((_) async => true);

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
        when(() => mockConnectionService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.initialize()).thenAnswer((_) async {});
        when(() => mockContentService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.createGuestSession()).thenAnswer((_) async => true);
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

        when(() => mockConnectionService.discoveredSystems).thenReturn([testDome]);
        when(() => mockConnectionService.connectToDome(testDome)).thenAnswer((_) async => true);

        final result = await provider.connectToNearestDome();

        expect(result, true);
        verify(() => mockConnectionService.connectToDome(testDome)).called(1);
      });

      test('should fail to connect when no domes are discovered', () async {
        when(() => mockConnectionService.discoveredSystems).thenReturn([]);

        final result = await provider.connectToNearestDome();

        expect(result, false);
        verifyNever(() => mockConnectionService.connectToDome(any()));
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

        when(() => mockConnectionService.connectToDome(testDome)).thenAnswer((_) async => true);

        final result = await provider.connectToDome(testDome);

        expect(result, true);
        verify(() => mockConnectionService.connectToDome(testDome)).called(1);
      });

      test('should disconnect from dome', () async {
        when(() => mockConnectionService.disconnectFromDome()).thenAnswer((_) async {});

        await provider.disconnect();

        verify(() => mockConnectionService.disconnectFromDome()).called(1);
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
        when(() => mockConnectionService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.initialize()).thenAnswer((_) async {});
        when(() => mockContentService.initialize()).thenAnswer((_) async {});
        when(() => mockAuthService.createGuestSession()).thenAnswer((_) async => true);
        await provider.initialize();
      });

      test('should authenticate admin successfully', () async {
        when(() => mockAuthService.authenticateAdmin(
          username: 'admin',
          password: 'password',
          domeId: null,
        )).thenAnswer((_) async => true);

        final result = await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'password',
        );

        expect(result, true);
        verify(() => mockAuthService.authenticateAdmin(
          username: 'admin',
          password: 'password',
          domeId: null,
        )).called(1);
      });

      test('should fail admin authentication with wrong credentials', () async {
        when(() => mockAuthService.authenticateAdmin(
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
        when(() => mockAuthService.switchToGuestMode()).thenAnswer((_) async => true);

        final result = await provider.switchToGuestMode();

        expect(result, true);
        verify(() => mockAuthService.switchToGuestMode()).called(1);
      });

      test('should logout successfully', () async {
        when(() => mockAuthService.logout()).thenAnswer((_) async {});

        await provider.logout();

        verify(() => mockAuthService.logout()).called(1);
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

    // Остальные тесты аналогично обновляются...
    // Для краткости показываю основные группы
  });
}
