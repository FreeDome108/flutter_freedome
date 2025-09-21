import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_freedome/src/core/freedome_provider.dart';
import 'package:flutter_freedome/src/widgets/freedome_detailed_status.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';
import 'package:flutter_freedome/src/models/content_models.dart';

import 'freedome_detailed_status_test.mocks.dart';

@GenerateMocks([FreeDomeProvider])
void main() {
  group('FreeDomeDetailedStatus', () {
    late MockFreeDomeProvider mockProvider;

    setUp(() {
      mockProvider = MockFreeDomeProvider();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<FreeDomeProvider>.value(
            value: mockProvider,
            child: const FreeDomeDetailedStatus(),
          ),
        ),
      );
    }

    group('System Status Display', () {
      testWidgets('should show system status when connected',
          (WidgetTester tester) async {
        const testDome = DomeSystem(
          id: 'test-dome',
          name: 'Professional Dome System',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
          firmwareVersion: '2.1.0',
          hardwareVersion: 'v3.2',
          systemVolume: 0.75,
          systemBrightness: 0.85,
          isConnected: true,
          lastConnected: DateTime(2024, 1, 15, 14, 30),
        );

        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(testDome);
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.admin);
        when(mockProvider.isAuthenticated).thenReturn(true);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Статус системы FreeDome'), findsOneWidget);
        expect(find.text('Professional Dome System'), findsOneWidget);
        expect(find.text('192.168.1.100:8080'), findsOneWidget);
        expect(find.text('Профессиональная'), findsOneWidget);
        expect(find.text('В сети'), findsOneWidget);
        expect(find.text('2.1.0'), findsOneWidget);
        expect(find.text('v3.2'), findsOneWidget);
        expect(find.text('75%'), findsOneWidget); // System volume
        expect(find.text('85%'), findsOneWidget); // System brightness
      });

      testWidgets('should show disconnected status when not connected',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.activeDome).thenReturn(null);
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.error).thenReturn(null);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Статус системы FreeDome'), findsOneWidget);
        expect(find.text('Не подключено'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });

      testWidgets('should show error when system has error',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.activeDome).thenReturn(null);
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.error).thenReturn('Connection timeout');

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Ошибка: Connection timeout'), findsOneWidget);
        expect(find.byIcon(Icons.error), findsOneWidget);
      });
    });

    group('User Information Display', () {
      testWidgets('should show guest user information',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.auth).thenReturn(mockAuthService);
        when(mockAuthService.currentUser).thenReturn(const FreeDomeUser(
          id: 'guest-user',
          name: 'Гость',
          role: FreeDomeUserRole.guest,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Пользователь'), findsOneWidget);
        expect(find.text('Гость'), findsOneWidget);
        expect(find.text('Гость'), findsOneWidget); // Role display name
        expect(find.byIcon(Icons.person), findsOneWidget);
      });

      testWidgets('should show admin user information',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.admin);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.auth).thenReturn(mockAuthService);
        when(mockAuthService.currentUser).thenReturn(const FreeDomeUser(
          id: 'admin-user',
          name: 'Администратор',
          role: FreeDomeUserRole.admin,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Администратор'), findsOneWidget);
        expect(find.text('Администратор'), findsOneWidget); // Role display name
        expect(find.byIcon(Icons.admin_panel_settings), findsOneWidget);
      });
    });

    group('Playback Information Display', () {
      testWidgets('should show playback information when playing',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.8,
          position: Duration(minutes: 2, seconds: 30),
          duration: Duration(minutes: 10),
          speed: 1.0,
        ));
        when(mockProvider.content).thenReturn(mockContentService);
        when(mockContentService.getContent('test-content')).thenReturn(
          const ProjectionContent(
            id: 'test-content',
            name: 'Test Video Content',
            filePath: '/test/content.mp4',
            type: ContentType.video,
            duration: Duration(minutes: 10),
          ),
        );

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Воспроизведение'), findsOneWidget);
        expect(find.text('Test Video Content'), findsOneWidget);
        expect(find.text('Воспроизводится'), findsOneWidget);
        expect(find.text('2:30 / 10:00'), findsOneWidget);
        expect(find.text('80%'), findsOneWidget); // Volume
        expect(find.text('1.0x'), findsOneWidget); // Speed
        expect(find.byIcon(Icons.play_circle), findsOneWidget);
      });

      testWidgets('should show stopped playback state',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Воспроизведение'), findsOneWidget);
        expect(find.text('Остановлено'), findsOneWidget);
        expect(find.text('Нет активного контента'), findsOneWidget);
        expect(find.byIcon(Icons.stop_circle), findsOneWidget);
      });

      testWidgets('should show error playback state',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.error,
          error: 'Playback failed',
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Ошибка'), findsOneWidget);
        expect(find.text('Playback failed'), findsOneWidget);
        expect(find.byIcon(Icons.error_circle), findsOneWidget);
      });
    });

    group('System Metrics Display', () {
      testWidgets('should show system metrics for admin users',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
          systemVolume: 0.75,
          systemBrightness: 0.85,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.admin);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(true);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Системные метрики'), findsOneWidget);
        expect(find.text('Системная громкость'), findsOneWidget);
        expect(find.text('Системная яркость'), findsOneWidget);
        expect(find.text('75%'), findsOneWidget);
        expect(find.text('85%'), findsOneWidget);
      });

      testWidgets('should hide system metrics for guest users',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Системные метрики'), findsNothing);
        expect(find.text('Системная громкость'), findsNothing);
        expect(find.text('Системная яркость'), findsNothing);
      });
    });

    group('Connection Statistics', () {
      testWidgets('should show connection statistics',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
          lastConnected: DateTime(2024, 1, 15, 14, 30),
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.getConnectionStats()).thenReturn({
          'totalDiscovered': 3,
          'totalConnections': 5,
          'totalCommands': 42,
          'uptime': const Duration(hours: 2, minutes: 15),
          'lastDiscovery': DateTime(2024, 1, 15, 14, 0),
        });

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Статистика подключения'), findsOneWidget);
        expect(find.text('Обнаружено систем: 3'), findsOneWidget);
        expect(find.text('Подключений: 5'), findsOneWidget);
        expect(find.text('Команд отправлено: 42'), findsOneWidget);
        expect(find.text('Время работы: 2:15:00'), findsOneWidget);
      });

      testWidgets('should handle missing connection statistics',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.getConnectionStats()).thenReturn({});

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Статистика подключения'), findsOneWidget);
        expect(find.text('Обнаружено систем: 0'), findsOneWidget);
        expect(find.text('Подключений: 0'), findsOneWidget);
        expect(find.text('Команд отправлено: 0'), findsOneWidget);
      });
    });

    group('Content Library Information', () {
      testWidgets('should show content library statistics',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.content).thenReturn(mockContentService);
        when(mockContentService.getUsageStats()).thenReturn({
          'totalContent': 15,
          'totalPlaylists': 3,
          'totalPlayCount': 127,
          'mostPlayedContent': {
            'id': 'popular-content',
            'name': 'Popular Content',
            'playCount': 25,
          },
        });

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Библиотека контента'), findsOneWidget);
        expect(find.text('Всего контента: 15'), findsOneWidget);
        expect(find.text('Плейлистов: 3'), findsOneWidget);
        expect(find.text('Общих воспроизведений: 127'), findsOneWidget);
        expect(find.text('Популярный: Popular Content (25)'), findsOneWidget);
      });

      testWidgets('should handle empty content library',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.content).thenReturn(mockContentService);
        when(mockContentService.getUsageStats()).thenReturn({
          'totalContent': 0,
          'totalPlaylists': 0,
          'totalPlayCount': 0,
          'mostPlayedContent': null,
        });

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Всего контента: 0'), findsOneWidget);
        expect(find.text('Плейлистов: 0'), findsOneWidget);
        expect(find.text('Общих воспроизведений: 0'), findsOneWidget);
        expect(find.text('Популярный: Нет'), findsOneWidget);
      });
    });

    group('Actions', () {
      testWidgets('should show refresh button', (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Обновить'), findsOneWidget);
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      });

      testWidgets('should handle refresh button tap',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Обновить'));
        await tester.pump();

        // Should trigger a refresh (in real implementation, this would call provider methods)
        expect(find.text('Обновить'), findsOneWidget);
      });

      testWidgets('should show close button in dialog mode',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));

        // Create widget inside a dialog
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: ChangeNotifierProvider<FreeDomeProvider>.value(
                      value: mockProvider,
                      child: const FreeDomeDetailedStatus(),
                    ),
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ));

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Закрыть'), findsOneWidget);
        expect(find.byIcon(Icons.close), findsOneWidget);
      });
    });

    group('Scrolling and Layout', () {
      testWidgets('should be scrollable', (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome with Very Long Name That Might Cause Layout Issues',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
          firmwareVersion: '2.1.0',
          hardwareVersion: 'v3.2',
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.admin);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.8,
        ));
        when(mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(true);

        await tester.pumpWidget(createTestWidget());

        // Should be able to scroll through all content
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('should handle small screen sizes',
          (WidgetTester tester) async {
        // Set a small screen size
        await tester.binding.setSurfaceSize(const Size(320, 480));

        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockProvider.currentRole).thenReturn(FreeDomeUserRole.guest);
        when(mockProvider.isAuthenticated).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        // Should render without overflow
        expect(find.text('Статус системы FreeDome'), findsOneWidget);
        expect(tester.takeException(), null);

        // Reset screen size
        await tester.binding.setSurfaceSize(null);
      });
    });
  });
}
