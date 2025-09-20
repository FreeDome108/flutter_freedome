import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_freedome/src/core/freedome_provider.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/widgets/freedome_connection_widget.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

// Mocktail моки без кодогенерации
class MockFreeDomeProvider extends Mock implements FreeDomeProvider {}
class MockFreeDomeConnectionService extends Mock implements FreeDomeConnectionService {}

void main() {
  group('FreeDomeConnectionWidget', () {
    late MockFreeDomeProvider mockProvider;
    late MockFreeDomeConnectionService mockConnectionService;

    setUp(() {
      mockProvider = MockFreeDomeProvider();
      mockConnectionService = MockFreeDomeConnectionService();
    });

    Widget createTestWidget({
      bool autoConnect = true,
      bool showDiscoveredSystems = true,
      VoidCallback? onConnected,
      VoidCallback? onDisconnected,
      Widget Function(BuildContext, bool)? builder,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<FreeDomeProvider>.value(
            value: mockProvider,
            child: FreeDomeConnectionWidget(
              autoConnect: autoConnect,
              showDiscoveredSystems: showDiscoveredSystems,
              onConnected: onConnected,
              onDisconnected: onDisconnected,
              builder: builder,
            ),
          ),
        ),
      );
    }

    group('Initialization States', () {
      testWidgets('should show initialization loading when not initialized', (WidgetTester tester) async {
        when(() => mockProvider.isInitialized).thenReturn(false);
        when(() => mockProvider.isInitializing).thenReturn(true);

        await tester.pumpWidget(createTestWidget(autoConnect: false));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Инициализация FreeDome...'), findsOneWidget);
      });

      testWidgets('should auto-initialize and connect when autoConnect is true', (WidgetTester tester) async {
        when(() => mockProvider.isInitialized).thenReturn(false);
        when(() => mockProvider.isInitializing).thenReturn(false);
        when(() => mockProvider.isConnected).thenReturn(false);
        when(() => mockProvider.initialize()).thenAnswer((_) async => true);
        when(() => mockProvider.connectToNearestDome()).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget(autoConnect: true));
        await tester.pump(); // Process the post-frame callback

        verify(() => mockProvider.initialize()).called(1);
        verify(() => mockProvider.connectToNearestDome()).called(1);
      });
    });

    group('Connected State UI', () {
      testWidgets('should show connected UI when connected', (WidgetTester tester) async {
        const testDome = DomeSystem(
          id: 'test-dome',
          name: 'Test Dome System',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
          firmwareVersion: '1.2.3',
        );

        when(() => mockProvider.isInitialized).thenReturn(true);
        when(() => mockProvider.isConnected).thenReturn(true);
        when(() => mockProvider.activeDome).thenReturn(testDome);
        when(() => mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Подключен к FreeDome'), findsOneWidget);
        expect(find.text('Test Dome System'), findsOneWidget);
        expect(find.text('192.168.1.100:8080'), findsOneWidget);
        expect(find.text('Профессиональная'), findsOneWidget);
        expect(find.text('В сети'), findsOneWidget);
        expect(find.text('1.2.3'), findsOneWidget);
        expect(find.text('Отключиться'), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });

      testWidgets('should handle disconnect button tap', (WidgetTester tester) async {
        bool disconnectedCallbackCalled = false;
        
        const testDome = DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        );

        when(() => mockProvider.isInitialized).thenReturn(true);
        when(() => mockProvider.isConnected).thenReturn(true);
        when(() => mockProvider.activeDome).thenReturn(testDome);
        when(() => mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(false);
        when(() => mockProvider.disconnect()).thenAnswer((_) async {});

        await tester.pumpWidget(createTestWidget(
          onDisconnected: () => disconnectedCallbackCalled = true,
        ));

        await tester.tap(find.text('Отключиться'));
        await tester.pump();

        verify(() => mockProvider.disconnect()).called(1);
        expect(disconnectedCallbackCalled, true);
      });
    });

    group('Disconnected State UI', () {
      testWidgets('should show disconnected UI when not connected', (WidgetTester tester) async {
        when(() => mockProvider.isInitialized).thenReturn(true);
        when(() => mockProvider.isConnected).thenReturn(false);
        when(() => mockProvider.error).thenReturn(null);
        when(() => mockProvider.connection).thenReturn(mockConnectionService);
        when(() => mockConnectionService.discoveredSystems).thenReturn([]);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Не подключен к FreeDome'), findsOneWidget);
        expect(find.text('Найти купол'), findsOneWidget);
        expect(find.text('Ручное подключение'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });

      testWidgets('should show discovered systems when available', (WidgetTester tester) async {
        final discoveredSystems = [
          const DomeSystem(
            id: 'dome-1',
            name: 'Discovered Dome 1',
            ipAddress: '192.168.1.101',
            port: 8080,
            type: DomeSystemType.professional,
            status: DomeSystemStatus.online,
          ),
        ];

        when(() => mockProvider.isInitialized).thenReturn(true);
        when(() => mockProvider.isConnected).thenReturn(false);
        when(() => mockProvider.error).thenReturn(null);
        when(() => mockProvider.connection).thenReturn(mockConnectionService);
        when(() => mockConnectionService.discoveredSystems).thenReturn(discoveredSystems);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Обнаруженные системы:'), findsOneWidget);
        expect(find.text('Discovered Dome 1'), findsOneWidget);
        expect(find.text('192.168.1.101:8080 • Профессиональная'), findsOneWidget);
        expect(find.text('Подключить'), findsOneWidget);
      });
    });

    group('Custom Builder', () {
      testWidgets('should use custom builder when provided', (WidgetTester tester) async {
        when(() => mockProvider.isInitialized).thenReturn(true);
        when(() => mockProvider.isConnected).thenReturn(true);

        await tester.pumpWidget(createTestWidget(
          builder: (context, isConnected) {
            return Text(isConnected ? 'Custom Connected' : 'Custom Disconnected');
          },
        ));

        expect(find.text('Custom Connected'), findsOneWidget);
        expect(find.text('Подключен к FreeDome'), findsNothing);
      });
    });
  });
}
