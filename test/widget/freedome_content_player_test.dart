import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_freedome/src/core/freedome_provider.dart';
import 'package:flutter_freedome/src/widgets/freedome_content_player.dart';
import 'package:flutter_freedome/src/models/content_models.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

import 'freedome_content_player_test.mocks.dart';

@GenerateMocks([FreeDomeProvider])
void main() {
  group('FreeDomeContentPlayer', () {
    late MockFreeDomeProvider mockProvider;

    setUp(() {
      mockProvider = MockFreeDomeProvider();
    });

    Widget createTestWidget({
      FreeDomeContent? content,
      bool showControls = true,
      bool showVolumeSlider = true,
      bool showBrightnessSlider = true,
      VoidCallback? onPlayStarted,
      VoidCallback? onPlayStopped,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider<FreeDomeProvider>.value(
            value: mockProvider,
            child: FreeDomeContentPlayer(
              content: content,
              showControls: showControls,
              showVolumeSlider: showVolumeSlider,
              showBrightnessSlider: showBrightnessSlider,
              onPlayStarted: onPlayStarted,
              onPlayStopped: onPlayStopped,
            ),
          ),
        ),
      );
    }

    group('Not Connected State', () {
      testWidgets('should show not connected UI when disconnected',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.error_outline), findsOneWidget);
        expect(find.text('Нет подключения к FreeDome'), findsOneWidget);
        expect(
            find.text(
                'Подключитесь к купольной системе для воспроизведения контента'),
            findsOneWidget);
      });

      testWidgets('should not show controls when disconnected',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.play_arrow), findsNothing);
        expect(find.byIcon(Icons.pause), findsNothing);
        expect(find.byIcon(Icons.stop), findsNothing);
      });
    });

    group('Connected State', () {
      setUp(() {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
      });

      testWidgets('should show player UI when connected',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('FreeDome Плеер'), findsOneWidget);
        expect(find.text('Готов к воспроизведению'), findsOneWidget);
        expect(find.text('Test Dome'), findsOneWidget);
      });

      testWidgets('should show play controls by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
        expect(find.byIcon(Icons.stop), findsOneWidget);
      });

      testWidgets('should hide controls when showControls is false',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(showControls: false));

        expect(find.byIcon(Icons.play_arrow), findsNothing);
        expect(find.byIcon(Icons.stop), findsNothing);
      });

      testWidgets('should show volume slider by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('Громкость'), findsOneWidget);
        expect(find.byType(Slider), findsAtLeastNWidgets(1));
      });

      testWidgets('should hide volume slider when showVolumeSlider is false',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(showVolumeSlider: false));

        expect(find.text('Громкость'), findsNothing);
      });

      testWidgets('should show brightness slider by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('Яркость'), findsOneWidget);
        expect(find.byType(Slider),
            findsAtLeastNWidgets(2)); // Volume + Brightness
      });

      testWidgets(
          'should hide brightness slider when showBrightnessSlider is false',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(showBrightnessSlider: false));

        expect(find.text('Яркость'), findsNothing);
      });
    });

    group('Playback States', () {
      setUp(() {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
      });

      testWidgets('should show stopped state UI', (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Готов к воспроизведению'), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
        expect(find.byIcon(Icons.pause), findsNothing);
      });

      testWidgets('should show playing state UI', (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.5,
        ));

        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        await tester.pumpWidget(createTestWidget(content: testContent));

        expect(find.text('Воспроизводится'), findsOneWidget);
        expect(find.text('Test Content'), findsOneWidget);
        expect(find.byIcon(Icons.pause), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsNothing);
      });

      testWidgets('should show paused state UI', (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.paused,
          currentContentId: 'test-content',
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('На паузе'), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
        expect(find.byIcon(Icons.pause), findsNothing);
      });

      testWidgets('should show buffering state UI',
          (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.buffering,
          currentContentId: 'test-content',
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Загрузка...'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('should show error state UI', (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.error,
          error: 'Playback error occurred',
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Ошибка воспроизведения'), findsOneWidget);
        expect(find.text('Playback error occurred'), findsOneWidget);
        expect(find.byIcon(Icons.error), findsOneWidget);
      });
    });

    group('Control Interactions', () {
      setUp(() {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
      });

      testWidgets('should handle play button tap', (WidgetTester tester) async {
        bool playStartedCalled = false;

        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.resumePlayback()).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget(
          onPlayStarted: () => playStartedCalled = true,
        ));

        await tester.tap(find.byIcon(Icons.play_arrow));
        await tester.pump();

        verify(mockProvider.resumePlayback()).called(1);
        expect(playStartedCalled, true);
      });

      testWidgets('should handle pause button tap',
          (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.5,
        ));
        when(mockProvider.pausePlayback()).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.byIcon(Icons.pause));
        await tester.pump();

        verify(mockProvider.pausePlayback()).called(1);
      });

      testWidgets('should handle stop button tap', (WidgetTester tester) async {
        bool playStoppedCalled = false;

        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.5,
        ));
        when(mockProvider.stopPlayback()).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget(
          onPlayStopped: () => playStoppedCalled = true,
        ));

        await tester.tap(find.byIcon(Icons.stop));
        await tester.pump();

        verify(mockProvider.stopPlayback()).called(1);
        expect(playStoppedCalled, true);
      });

      testWidgets('should handle volume slider change',
          (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.setVolume(any)).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget());

        final volumeSlider = find.byType(Slider).first;
        await tester.drag(volumeSlider, const Offset(100, 0));
        await tester.pump();

        verify(mockProvider.setVolume(any)).called(atLeastOnce);
      });

      testWidgets('should handle brightness slider change',
          (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.setBrightness(any)).thenAnswer((_) async => true);

        await tester.pumpWidget(createTestWidget());

        // Find brightness slider (should be second slider)
        final sliders = find.byType(Slider);
        expect(sliders, findsAtLeastNWidgets(2));

        final brightnessSlider = sliders.at(1);
        await tester.drag(brightnessSlider, const Offset(100, 0));
        await tester.pump();

        verify(mockProvider.setBrightness(any)).called(atLeastOnce);
      });
    });

    group('Content Display', () {
      setUp(() {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
      });

      testWidgets('should display content information when playing',
          (WidgetTester tester) async {
        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Video Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5, seconds: 30),
          description: 'A test video for the dome',
        );

        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.5,
          duration: Duration(minutes: 5, seconds: 30),
          position: Duration(minutes: 1, seconds: 15),
        ));

        await tester.pumpWidget(createTestWidget(content: testContent));

        expect(find.text('Test Video Content'), findsOneWidget);
        expect(find.text('A test video for the dome'), findsOneWidget);
        expect(find.text('Видео'), findsOneWidget);
        expect(find.text('1:15 / 5:30'), findsOneWidget);
      });

      testWidgets('should show progress bar when playing',
          (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.5,
          duration: Duration(minutes: 5),
          position: Duration(minutes: 2),
        ));

        await tester.pumpWidget(createTestWidget());

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      });

      testWidgets('should handle content without description',
          (WidgetTester tester) async {
        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: 'test-content',
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget(content: testContent));

        expect(find.text('Test Content'), findsOneWidget);
        expect(find.text('Видео'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      setUp(() {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
      });

      testWidgets('should have proper semantic labels',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.bySemanticsLabel('Воспроизвести'), findsOneWidget);
        expect(find.bySemanticsLabel('Остановить'), findsOneWidget);
        expect(find.bySemanticsLabel('Громкость'), findsOneWidget);
        expect(find.bySemanticsLabel('Яркость'), findsOneWidget);
      });

      testWidgets('should have proper tooltips', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final playButton = find.byIcon(Icons.play_arrow);
        await tester.longPress(playButton);
        await tester.pumpAndSettle();

        expect(find.text('Воспроизвести'), findsOneWidget);
      });
    });

    group('Error Handling', () {
      setUp(() {
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
      });

      testWidgets('should handle control failures gracefully',
          (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.resumePlayback()).thenAnswer((_) async => false);

        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.byIcon(Icons.play_arrow));
        await tester.pump();

        // Should not crash when playback fails
        verify(mockProvider.resumePlayback()).called(1);
      });

      testWidgets('should handle null content gracefully',
          (WidgetTester tester) async {
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));

        await tester.pumpWidget(createTestWidget(content: null));

        expect(find.text('FreeDome Плеер'), findsOneWidget);
        expect(find.text('Готов к воспроизведению'), findsOneWidget);
      });
    });

    group('State Updates', () {
      testWidgets('should update UI when provider state changes',
          (WidgetTester tester) async {
        when(mockProvider.isConnected).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        expect(find.text('Нет подключения к FreeDome'), findsOneWidget);

        // Simulate connection
        when(mockProvider.isConnected).thenReturn(true);
        when(mockProvider.playbackState).thenReturn(const PlaybackState(
          status: PlaybackStatus.stopped,
          volume: 0.5,
        ));
        when(mockProvider.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));

        await tester.pump();

        expect(find.text('FreeDome Плеер'), findsOneWidget);
        expect(find.text('Готов к воспроизведению'), findsOneWidget);
      });
    });
  });
}
