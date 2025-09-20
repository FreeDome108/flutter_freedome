import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_freedome/src/core/freedome_provider.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/widgets/freedome_connection_widget.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

import 'freedome_connection_widget_test.mocks.dart';

@GenerateMocks([FreeDomeProvider, FreeDomeConnectionService])
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
        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(true);

        await tester.pumpWidget(createTestWidget(autoConnect: false));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Инициализация FreeDome...'), findsOneWidget);
      });

      testWidgets('should auto-initialize and connect when autoConnect is true', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.initialize()).thenAnswer((_) async => true);
        when(mockProvider.connectToNearestDome()).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget(autoConnect: true));
        await tester.pump(); // Process the post-frame callback

        verify(mockProvider.initialize()).called(1);
        verify(mockProvider.connectToNearestDome()).called(1);
      });

      testWidgets('should not auto-connect when autoConnect is false', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);

        await tester.pumpWidget(createTestWidget(autoConnect: false));
        await tester.pump();

        verifyNever(mockProvider.connectToNearestDome());
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

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(testDome);
        when(mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(false);

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

      testWidgets('should show admin settings button for admin users', (WidgetTester tester) async {
        const testDome = DomeSystem(
          id: 'test-dome',
          name: 'Admin Test Dome',
          ipAddress: '10.0.0.100',
          port: 9000,
          type: DomeSystemType.hybrid,
          status: DomeSystemStatus.online,
        );

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(testDome);
        when(mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(true);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Настройки'), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
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

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(testDome);
        when(mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(false);
        when(mockProvider.disconnect()).thenAnswer((_) async {});

        await tester.pumpWidget(createTestWidget(
          onDisconnected: () => disconnectedCallbackCalled = true,
        ));

        await tester.tap(find.text('Отключиться'));
        await tester.pump();

        verify(mockProvider.disconnect()).called(1);
        expect(disconnectedCallbackCalled, true);
      });

      testWidgets('should show admin panel dialog when settings tapped', (WidgetTester tester) async {
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
        when(mockProvider.activeDome).thenReturn(testDome);
        when(mockProvider.hasRole(FreeDomeUserRole.admin)).thenReturn(true);

        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Настройки'));
        await tester.pumpAndSettle();

        expect(find.text('Панель администратора'), findsOneWidget);
        expect(find.text('Функции администратора будут доступны в полной версии.'), findsOneWidget);
      });
    });

    group('Disconnected State UI', () {
      testWidgets('should show disconnected UI when not connected', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Не подключен к FreeDome'), findsOneWidget);
        expect(find.text('Найти купол'), findsOneWidget);
        expect(find.text('Ручное подключение'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });

      testWidgets('should show error message when error exists', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.error).thenReturn('Connection timeout');
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Ошибка: Connection timeout'), findsOneWidget);
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
          const DomeSystem(
            id: 'dome-2',
            name: 'Discovered Dome 2',
            ipAddress: '192.168.1.102',
            port: 8080,
            type: DomeSystemType.mobile,
            status: DomeSystemStatus.offline,
          ),
        ];

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn(discoveredSystems);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Обнаруженные системы:'), findsOneWidget);
        expect(find.text('Discovered Dome 1'), findsOneWidget);
        expect(find.text('192.168.1.101:8080 • Профессиональная'), findsOneWidget);
        expect(find.text('Discovered Dome 2'), findsOneWidget);
        expect(find.text('192.168.1.102:8080 • Мобильная'), findsOneWidget);
        expect(find.text('Подключить'), findsNWidget(2));
      });

      testWidgets('should hide discovered systems when showDiscoveredSystems is false', (WidgetTester tester) async {
        final discoveredSystems = [
          const DomeSystem(
            id: 'dome-1',
            name: 'Hidden Dome',
            ipAddress: '192.168.1.101',
            port: 8080,
            type: DomeSystemType.professional,
            status: DomeSystemStatus.online,
          ),
        ];

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn(discoveredSystems);

        await tester.pumpWidget(createTestWidget(showDiscoveredSystems: false));

        expect(find.text('Обнаруженные системы:'), findsNothing);
        expect(find.text('Hidden Dome'), findsNothing);
      });

      testWidgets('should handle connect to specific dome', (WidgetTester tester) async {
        bool connectedCallbackCalled = false;
        
        final discoveredSystem = const DomeSystem(
          id: 'dome-1',
          name: 'Specific Dome',
          ipAddress: '192.168.1.101',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        );

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.error).thenReturn(null);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([discoveredSystem]);
        when(mockProvider.connectToDome(discoveredSystem)).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget(
          onConnected: () => connectedCallbackCalled = true,
        ));

        await tester.tap(find.text('Подключить').first);
        await tester.pump();

        verify(mockProvider.connectToDome(discoveredSystem)).called(1);
        expect(connectedCallbackCalled, true);
      });

      testWidgets('should handle find dome button', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(false);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);
        when(mockProvider.connectToNearestDome()).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Найти купол'));
        await tester.pump();

        verify(mockProvider.connectToNearestDome()).called(1);
      });

      testWidgets('should disable find dome button when initializing', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.isInitializing).thenReturn(true);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);

        await tester.pumpWidget(createTestWidget());

        final button = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Найти купол'),
        );
        expect(button.onPressed, null);
      });
    });

    group('Manual Connection Dialog', () {
      testWidgets('should show manual connection dialog', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);

        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Ручное подключение'));
        await tester.pumpAndSettle();

        expect(find.text('Ручное подключение'), findsNWidget(2)); // Title and button
        expect(find.text('IP адрес'), findsOneWidget);
        expect(find.text('Порт'), findsOneWidget);
        expect(find.text('192.168.1.100'), findsOneWidget); // Default IP
        expect(find.text('8080'), findsOneWidget); // Default port
      });

      testWidgets('should handle manual connection success', (WidgetTester tester) async {
        bool connectedCallbackCalled = false;

        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);
        when(mockProvider.connectToDome(any)).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget(
          onConnected: () => connectedCallbackCalled = true,
        ));

        // Open manual connection dialog
        await tester.tap(find.text('Ручное подключение'));
        await tester.pumpAndSettle();

        // Enter custom IP and port
        await tester.enterText(find.widgetWithText(TextField, '192.168.1.100'), '10.0.0.50');
        await tester.enterText(find.widgetWithText(TextField, '8080'), '9000');

        // Tap connect button
        await tester.tap(find.widgetWithText(ElevatedButton, 'Подключить'));
        await tester.pumpAndSettle();

        expect(connectedCallbackCalled, true);
        expect(find.text('Успешно подключен к FreeDome'), findsOneWidget);
      });

      testWidgets('should handle manual connection failure', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);
        when(mockProvider.connectToDome(any)).thenAnswer((_) async => false);

        await tester.pumpWidget(createTestWidget());

        // Open manual connection dialog
        await tester.tap(find.text('Ручное подключение'));
        await tester.pumpAndSettle();

        // Tap connect button with default values
        await tester.tap(find.widgetWithText(ElevatedButton, 'Подключить'));
        await tester.pumpAndSettle();

        expect(find.text('Не удалось подключиться к FreeDome'), findsOneWidget);
      });

      testWidgets('should validate input fields in manual connection', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.connection).thenReturn(mockConnectionService);
        when(mockConnectionService.discoveredSystems).thenReturn([]);

        await tester.pumpWidget(createTestWidget());

        // Open manual connection dialog
        await tester.tap(find.text('Ручное подключение'));
        await tester.pumpAndSettle();

        // Clear fields
        await tester.enterText(find.widgetWithText(TextField, '192.168.1.100'), '');
        await tester.enterText(find.widgetWithText(TextField, '8080'), '');

        // Try to connect with empty fields
        await tester.tap(find.widgetWithText(ElevatedButton, 'Подключить'));
        await tester.pump();

        // Should not call connectToDome with empty fields
        verifyNever(mockProvider.connectToDome(any));
      });
    });

    group('Custom Builder', () {
      testWidgets('should use custom builder when provided', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(true);

        await tester.pumpWidget(createTestWidget(
          builder: (context, isConnected) {
            return Text(isConnected ? 'Custom Connected' : 'Custom Disconnected');
          },
        ));

        expect(find.text('Custom Connected'), findsOneWidget);
        expect(find.text('Подключен к FreeDome'), findsNothing);
      });

      testWidgets('should pass correct connection state to custom builder', (WidgetTester tester) async {
        when(mockProvider.isInitialized).thenReturn(true);
        when(mockProvider.isConnected).thenReturn(false);

        await tester.pumpWidget(createTestWidget(
          builder: (context, isConnected) {
            return Text(isConnected ? 'Custom Connected' : 'Custom Disconnected');
          },
        ));

        expect(find.text('Custom Disconnected'), findsOneWidget);
        expect(find.text('Custom Connected'), findsNothing);
      });
    });

    group('Callback Handling', () {
      testWidgets('should call onConnected callback when auto-connect succeeds', (WidgetTester tester) async {
        bool connectedCallbackCalled = false;

        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.initialize()).thenAnswer((_) async => true);
        when(mockProvider.connectToNearestDome()).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget(
          autoConnect: true,
          onConnected: () => connectedCallbackCalled = true,
        ));
        await tester.pump();

        expect(connectedCallbackCalled, true);
      });

      testWidgets('should not call onConnected callback when auto-connect fails', (WidgetTester tester) async {
        bool connectedCallbackCalled = false;

        when(mockProvider.isInitialized).thenReturn(false);
        when(mockProvider.isConnected).thenReturn(false);
        when(mockProvider.initialize()).thenAnswer((_) async => true);
        when(mockProvider.connectToNearestDome()).thenAnswer((_) async => false);

        await tester.pumpWidget(createTestWidget(
          autoConnect: true,
          onConnected: () => connectedCallbackCalled = true,
        ));
        await tester.pump();

        expect(connectedCallbackCalled, false);
      });
    });
  });
}
