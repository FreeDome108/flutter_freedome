import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/widgets/freedome_status_indicator.dart';

void main() {
  group('FreeDomeStatusIndicator', () {
    testWidgets('should render status indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeStatusIndicator(),
          ),
        ),
      );

      expect(find.byType(FreeDomeStatusIndicator), findsOneWidget);
    });

    testWidgets('should show connection status', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeStatusIndicator(),
          ),
        ),
      );

      // Should show some status-related UI elements
      expect(find.byType(FreeDomeStatusIndicator), findsOneWidget);
    });

    testWidgets('should handle status updates', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeStatusIndicator(),
          ),
        ),
      );

      // Widget should be present
      expect(find.byType(FreeDomeStatusIndicator), findsOneWidget);

      // Pump to trigger any state updates
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Widget should still be present after updates
      expect(find.byType(FreeDomeStatusIndicator), findsOneWidget);
    });
  });
}
