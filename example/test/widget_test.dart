import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome_example/main.dart';

void main() {
  testWidgets('FreeDome example app test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FreeDomeExampleApp());

    // Verify that the app starts with the correct title.
    expect(find.text('Flutter FreeDome Example'), findsOneWidget);
  });
}
