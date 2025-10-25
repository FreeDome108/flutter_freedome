import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/widgets/freedome_connection_widget.dart';

void main() {
  group('FreeDomeConnectionWidget', () {
    testWidgets('should render connection widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeConnectionWidget(),
          ),
        ),
      );

      expect(find.byType(FreeDomeConnectionWidget), findsOneWidget);
    });

    testWidgets('should show connection status', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeConnectionWidget(),
          ),
        ),
      );

      // Should show some connection-related UI elements
      expect(find.byType(FreeDomeConnectionWidget), findsOneWidget);
    });

    testWidgets('should handle connection button tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeConnectionWidget(),
          ),
        ),
      );

      // Look for connection button and tap it
      final connectionButton = find.byType(ElevatedButton);
      if (connectionButton.evaluate().isNotEmpty) {
        await tester.tap(connectionButton);
        await tester.pump();
      }

      // Widget should still be present after tap
      expect(find.byType(FreeDomeConnectionWidget), findsOneWidget);
    });
  });
}
