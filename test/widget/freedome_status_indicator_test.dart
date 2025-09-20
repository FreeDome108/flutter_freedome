import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_freedome/src/core/freedome_provider.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/widgets/freedome_status_indicator.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';
import 'package:flutter_freedome/src/models/content_models.dart';

import 'freedome_status_indicator_test.mocks.dart';

@GenerateMocks([FreeDomeProvider, FreeDomeConnectionService])
void main() {
  group('FreeDomeStatusIndicator', () {
    late MockFreeDomeProvider mockProvider;
    late MockFreeDomeConnectionService mockConnectionService;

    setUp(() {
      mockProvider = MockFreeDomeProvider();
      mockConnectionService = MockFreeDomeConnectionService();
    });

    Widget createTestWidget({
      bool showDetails = false,
      bool showDomeName = true,
      VoidCallback? onTap,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<FreeDomeProvider>.value(
            value: mockProvider,
            child: FreeDomeStatusIndicator(
              showDetails: showDetails,
              showDomeName: showDomeName,
              onTap: onTap,
            ),
          ),
        ),
      );
    }

    group('Initialization State', () {
      testWidgets('should show not initialized status', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Не инициализирован'), findsOneWidget);
        expect(find.byIcon(Icons.error), findsOneWidget);
      });

      testWidgets('should show initializing status with loading indicator', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(true);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Инициализация...'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Connection States', () {
      testWidgets('should show connected status when connected', (WidgetTester tester) async {
        const testDome = DomeSystem(
          id: 'test-dome',
          name: 'Test Dome System',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        );

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: true, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(testDome);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Подключен'), findsOneWidget);
        expect(find.text('Test Dome System'), findsOneWidget);
        expect(find.byIcon(Icons.wifi), findsOneWidget);
      });

      testWidgets('should show connecting status with loading indicator', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: true),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Подключение...'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('should show not connected status', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Не подключен'), findsOneWidget);
        expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('should show error status when error exists', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn('Connection failed');
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget(showDetails: true));

        expect(find.text('Ошибка'), findsOneWidget);
        expect(find.text('Connection failed'), findsOneWidget);
        expect(find.byIcon(Icons.error), findsOneWidget);
      });

      testWidgets('should not show error details when showDetails is false', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn('Connection failed');
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget(showDetails: false));

        expect(find.text('Ошибка'), findsOneWidget);
        expect(find.text('Connection failed'), findsNothing);
      });
    });

    group('Configuration Options', () {
      testWidgets('should hide dome name when showDomeName is false', (WidgetTester tester) async {
        const testDome = DomeSystem(
          id: 'test-dome',
          name: 'Test Dome System',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        );

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: true, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(testDome);

        await tester.pumpWidget(createTestWidget(showDomeName: false));

        expect(find.text('Подключен'), findsOneWidget);
        expect(find.text('Test Dome System'), findsNothing);
      });

      testWidgets('should handle tap events', (WidgetTester tester) async {
        bool tapped = false;
        void onTap() => tapped = true;

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget(onTap: onTap));

        await tester.tap(find.byType(FreeDomeStatusIndicator));
        expect(tapped, true);
      });
    });

    group('Visual Styling', () {
      testWidgets('should apply correct colors for different states', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: true, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test',
          name: 'Test',
          ipAddress: '127.0.0.1',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));

        await tester.pumpWidget(createTestWidget());

        // Find the container with border
        final containerFinder = find.byType(Container).first;
        final container = tester.widget<Container>(containerFinder);
        final decoration = container.decoration as BoxDecoration;

        expect(decoration.border?.top.color, Colors.green);
        expect(decoration.color, Colors.green.withValues(alpha: 0.1));
      });

      testWidgets('should have proper layout structure', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.connectionStatus).thenReturn(
          const FreeDomeConnectionStatus(isConnected: false, isConnecting: false),
        );
        when(mockProvider.activeDome).thenReturn(null);

        await tester.pumpWidget(createTestWidget());

        expect(find.byType(GestureDetector), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
      });
    });
  });

  group('FreeDomeDetailedStatus', () {
    late MockFreeDomeProvider mockProvider;

    setUp(() {
      mockProvider = MockFreeDomeProvider();
    });

    Widget createDetailedStatusWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<FreeDomeProvider>.value(
            value: mockProvider,
            child: const FreeDomeDetailedStatus(),
          ),
        ),
      );
    }

    testWidgets('should display comprehensive system status', (WidgetTester tester) async {
      const testDome = DomeSystem(
        id: 'test-dome',
        name: 'Detailed Test Dome',
        ipAddress: '10.0.0.100',
        port: 9000,
        type: DomeSystemType.hybrid,
        status: DomeSystemStatus.online,
        projectors: [
          ProjectorConfig(
            id: 'proj-1',
            name: 'Main Projector',
            type: ProjectorType.laser,
            brightness: 85,
            contrast: 75,
            status: ProjectorStatus.active,
          ),
        ],
        audioChannels: [
          AudioChannel(
            id: 'audio-1',
            name: 'Main Audio',
            type: AudioChannelType.surround,
          ),
        ],
        firmwareVersion: '2.1.0',
      );

      const testPlaybackState = PlaybackState(
        status: PlaybackStatus.playing,
        currentContentId: 'test-content-123',
        volume: 0.8,
        duration: Duration(minutes: 10),
      );

      when(mockProvider.isInitialized).thenReturn(true);
      when(mockProvider.isConnected).thenReturn(true);
      when(mockProvider.isAuthenticated).thenReturn(true);
      when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.admin);
      when(mockProvider.activeDome).thenReturn(testDome);
      when(mockProvider.playbackState).thenReturn(testPlaybackState);

      await tester.pumpWidget(createDetailedStatusWidget());

      // Check main status information
      expect(find.text('Статус FreeDome'), findsOneWidget);
      expect(find.text('Инициализация:'), findsOneWidget);
      expect(find.text('Завершена'), findsOneWidget);
      expect(find.text('Подключение:'), findsOneWidget);
      expect(find.text('Установлено'), findsOneWidget);
      expect(find.text('Аутентификация:'), findsOneWidget);
      expect(find.text('Администратор'), findsOneWidget);

      // Check dome information
      expect(find.text('Информация о куполе'), findsOneWidget);
      expect(find.text('Detailed Test Dome'), findsOneWidget);
      expect(find.text('10.0.0.100:9000'), findsOneWidget);
      expect(find.text('Гибридная'), findsOneWidget);
      expect(find.text('1'), findsAtLeastNWidget(2)); // projectors and audio channels count
      expect(find.text('2.1.0'), findsOneWidget);

      // Check playback information
      expect(find.text('Воспроизведение'), findsOneWidget);
      expect(find.text('Воспроизводится'), findsOneWidget);
      expect(find.text('test-content-123'), findsOneWidget);
      expect(find.text('80%'), findsOneWidget);
      expect(find.text('10:00'), findsOneWidget);
    });

    testWidgets('should handle missing dome information', (WidgetTester tester) async {
      when(mockProvider.isInitialized).thenReturn(true);
      when(mockProvider.isConnected).thenReturn(false);
      when(mockProvider.isAuthenticated).thenReturn(false);
      when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
      when(mockProvider.activeDome).thenReturn(null);
      when(mockProvider.playbackState).thenReturn(const PlaybackState());

      await tester.pumpWidget(createDetailedStatusWidget());

      expect(find.text('Отсутствует'), findsOneWidget);
      expect(find.text('Не выполнена'), findsOneWidget);
      expect(find.text('Информация о куполе'), findsNothing);
      expect(find.text('Воспроизведение'), findsNothing);
    });

    testWidgets('should handle playback without content', (WidgetTester tester) async {
      const testDome = DomeSystem(
        id: 'test-dome',
        name: 'Test Dome',
        ipAddress: '192.168.1.100',
        port: 8080,
        type: DomeSystemType.professional,
        status: DomeSystemStatus.online,
      );

      when(mockProvider.isInitialized).thenReturn(true);
      when(mockProvider.isConnected).thenReturn(true);
      when(mockProvider.isAuthenticated).thenReturn(true);
      when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
      when(mockProvider.activeDome).thenReturn(testDome);
      when(mockProvider.playbackState).thenReturn(const PlaybackState(
        status: PlaybackStatus.stopped,
        currentContentId: null,
      ));

      await tester.pumpWidget(createDetailedStatusWidget());

      expect(find.text('Информация о куполе'), findsOneWidget);
      expect(find.text('Воспроизведение'), findsNothing); // No playback section when no content
    });

    testWidgets('should format duration correctly', (WidgetTester tester) async {
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
        duration: Duration(minutes: 2, seconds: 30),
      );

      when(mockProvider.isInitialized).thenReturn(true);
      when(mockProvider.isConnected).thenReturn(true);
      when(mockProvider.isAuthenticated).thenReturn(true);
      when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
      when(mockProvider.activeDome).thenReturn(testDome);
      when(mockProvider.playbackState).thenReturn(testPlaybackState);

      await tester.pumpWidget(createDetailedStatusWidget());

      expect(find.text('02:30'), findsOneWidget);
    });

    testWidgets('should display correct status colors', (WidgetTester tester) async {
      when(mockProvider.isInitialized).thenReturn(false);
      when(mockProvider.isConnected).thenReturn(false);
      when(mockProvider.isAuthenticated).thenReturn(false);
      when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
      when(mockProvider.activeDome).thenReturn(null);
      when(mockProvider.playbackState).thenReturn(const PlaybackState());

      await tester.pumpWidget(createDetailedStatusWidget());

      // Find status indicator icons
      final statusIcons = find.byIcon(Icons.circle);
      expect(statusIcons, findsAtLeastNWidget(3)); // At least 3 status indicators
    });
  });
}
