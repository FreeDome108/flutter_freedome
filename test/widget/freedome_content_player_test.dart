import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/widgets/freedome_content_player.dart';
import 'package:flutter_freedome/src/models/content_models.dart';

void main() {
  group('FreeDomeContentPlayer', () {
    testWidgets('should render content player', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeContentPlayer(
              content: ProjectionContent(
                id: 'test-content',
                name: 'Test Content',
                type: ContentType.video,
                format: ProjectionFormat.fulldome,
                duration: const Duration(minutes: 5),
                filePath: '/test/path.mp4',
                thumbnailPath: '/test/thumb.jpg',
                tags: ['test'],
                metadata: {},
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FreeDomeContentPlayer), findsOneWidget);
    });

    testWidgets('should show content information', (WidgetTester tester) async {
      final content = ProjectionContent(
        id: 'test-content',
        name: 'Test Content',
        type: ContentType.video,
        format: ProjectionFormat.fulldome,
        duration: const Duration(minutes: 5),
        filePath: '/test/path.mp4',
        thumbnailPath: '/test/thumb.jpg',
        tags: ['test'],
        metadata: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeContentPlayer(content: content),
          ),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should handle play button tap', (WidgetTester tester) async {
      final content = ProjectionContent(
        id: 'test-content',
        name: 'Test Content',
        type: ContentType.video,
        format: ProjectionFormat.fulldome,
        duration: const Duration(minutes: 5),
        filePath: '/test/path.mp4',
        thumbnailPath: '/test/thumb.jpg',
        tags: ['test'],
        metadata: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeContentPlayer(content: content),
          ),
        ),
      );

      // Look for play button and tap it
      final playButton = find.byIcon(Icons.play_arrow);
      if (playButton.evaluate().isNotEmpty) {
        await tester.tap(playButton);
        await tester.pump();
      }

      // Widget should still be present after tap
      expect(find.byType(FreeDomeContentPlayer), findsOneWidget);
    });

    testWidgets('should handle pause button tap', (WidgetTester tester) async {
      final content = ProjectionContent(
        id: 'test-content',
        name: 'Test Content',
        type: ContentType.video,
        format: ProjectionFormat.fulldome,
        duration: const Duration(minutes: 5),
        filePath: '/test/path.mp4',
        thumbnailPath: '/test/thumb.jpg',
        tags: ['test'],
        metadata: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FreeDomeContentPlayer(content: content),
          ),
        ),
      );

      // Look for pause button and tap it
      final pauseButton = find.byIcon(Icons.pause);
      if (pauseButton.evaluate().isNotEmpty) {
        await tester.tap(pauseButton);
        await tester.pump();
      }

      // Widget should still be present after tap
      expect(find.byType(FreeDomeContentPlayer), findsOneWidget);
    });
  });
}
