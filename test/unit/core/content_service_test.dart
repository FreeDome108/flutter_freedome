import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_freedome/src/core/content_service.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/models/content_models.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

import 'content_service_test.mocks.dart';

@GenerateMocks([
  FreeDomeConnectionService,
  FreeDomeAuthService,
])
void main() {
  group('FreeDomeContentService', () {
    late FreeDomeContentService contentService;
    late MockFreeDomeConnectionService mockConnectionService;
    late MockFreeDomeAuthService mockAuthService;

    setUp(() async {
      // Set up SharedPreferences mock
      SharedPreferences.setMockInitialValues({});

      contentService = FreeDomeContentService();
      mockConnectionService = MockFreeDomeConnectionService();
      mockAuthService = MockFreeDomeAuthService();

      // Initialize service
      await contentService.initialize();
    });

    tearDown(() {
      contentService.dispose();
    });

    group('Initialization', () {
      test('should initialize with demo content', () {
        expect(contentService.contentLibrary.length, 3);
        expect(contentService.playlists.length, 0);

        final starryContent = contentService.contentLibrary
            .firstWhere((c) => c.id == 'demo_starry_sky');
        expect(starryContent.name, 'Звездное небо');
        expect(starryContent.type, ContentType.video);
        expect(starryContent.format, ProjectionFormat.fulldome);
      });

      test('should load cached content from storage', () async {
        // Set up SharedPreferences with cached content
        final cachedContent = [
          {
            'id': 'cached_content',
            'name': 'Cached Content',
            'filePath': '/cached/content.mp4',
            'type': 'video',
            'duration': 300000, // 5 minutes in milliseconds
            'format': 'equirectangular',
            'createdAt': DateTime.now().toIso8601String(),
          }
        ];

        SharedPreferences.setMockInitialValues({
          'freedome_content_library': jsonEncode(cachedContent),
        });

        final newService = FreeDomeContentService();
        await newService.initialize();

        expect(newService.contentLibrary.length, 1);
        expect(newService.contentLibrary.first.id, 'cached_content');
        expect(newService.contentLibrary.first.name, 'Cached Content');

        newService.dispose();
      });
    });

    group('Content Playback', () {
      setUp(() {
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockConnectionService.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(true);
        when(mockAuthService.currentSession).thenReturn(const FreeDomeSession(
          id: 'test-session',
          userId: 'test-user',
          role: FreeDomeUserRole.guest,
        ));
      });

      test('should play content successfully', () async {
        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.playContent(testContent);

        expect(result, true);
        expect(contentService.playbackState.status, PlaybackStatus.playing);
        expect(contentService.playbackState.currentContentId, 'test-content');

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should fail to play content without connection', () async {
        when(mockConnectionService.isConnected).thenReturn(false);

        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        final result = await contentService.playContent(testContent);

        expect(result, false);
        verifyNever(mockConnectionService.sendCommand(any));
      });

      test('should fail to play content without permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(false);

        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        final result = await contentService.playContent(testContent);

        expect(result, false);
        verifyNever(mockConnectionService.sendCommand(any));
      });

      test('should handle playback command failure', () async {
        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        when(mockConnectionService.sendCommand(any))
            .thenAnswer((_) async => const FreeDomeResponse(
                  success: false,
                  error: 'Command failed',
                  timestamp: DateTime.now(),
                ));

        final result = await contentService.playContent(testContent);

        expect(result, false);
        expect(contentService.playbackState.status, PlaybackStatus.error);
        expect(contentService.playbackState.error, 'Command failed');
      });

      test('should play interactive content from app', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.playInteractiveContent(
          appName: 'StarrySkr',
          contentName: 'Звездное небо',
          appData: {
            'type': 'starfield',
            'constellation': 'all',
            'time': DateTime.now().toIso8601String(),
          },
        );

        expect(result, true);
        expect(contentService.playbackState.status, PlaybackStatus.playing);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should play realtime content', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.playRealtimeContent(
          sourceType: 'camera',
          sourceConfig: {
            'device': '/dev/video0',
            'resolution': '1920x1080',
            'fps': 30,
          },
          contentName: 'Live Camera Feed',
        );

        expect(result, true);
        expect(contentService.playbackState.status, PlaybackStatus.playing);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });
    });

    group('Playback Controls', () {
      setUp(() {
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockConnectionService.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(true);
        when(mockAuthService.currentSession).thenReturn(const FreeDomeSession(
          id: 'test-session',
          userId: 'test-user',
          role: FreeDomeUserRole.guest,
        ));
      });

      test('should pause playback successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.pausePlayback();

        expect(result, true);
        expect(contentService.playbackState.status, PlaybackStatus.paused);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should resume playback successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.resumePlayback();

        expect(result, true);
        expect(contentService.playbackState.status, PlaybackStatus.playing);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should stop playback successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.stopPlayback();

        expect(result, true);
        expect(contentService.playbackState.status, PlaybackStatus.stopped);
        expect(contentService.playbackState.currentContentId, null);
        expect(contentService.playbackState.position, Duration.zero);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should set volume successfully', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.controlBasics))
            .thenReturn(true);
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.setVolume(0.8);

        expect(result, true);
        expect(contentService.playbackState.volume, 0.8);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should set brightness successfully', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.controlBasics))
            .thenReturn(true);
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await contentService.setBrightness(0.9);

        expect(result, true);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should clamp volume to valid range', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.controlBasics))
            .thenReturn(true);
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        // Test volume > 1.0
        await contentService.setVolume(1.5);
        expect(contentService.playbackState.volume, 1.0);

        // Test volume < 0.0
        await contentService.setVolume(-0.5);
        expect(contentService.playbackState.volume, 0.0);
      });

      test('should fail controls without permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.controlBasics))
            .thenReturn(false);
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(false);

        final volumeResult = await contentService.setVolume(0.8);
        final brightnessResult = await contentService.setBrightness(0.9);
        final pauseResult = await contentService.pausePlayback();

        expect(volumeResult, false);
        expect(brightnessResult, false);
        expect(pauseResult, false);

        verifyNever(mockConnectionService.sendCommand(any));
      });
    });

    group('Content Search', () {
      test('should search content by query', () {
        final results = contentService.searchContent(query: 'звезд');

        expect(results.length, 1);
        expect(results.first.name, 'Звездное небо');
      });

      test('should search content by type', () {
        final results = contentService.searchContent(type: ContentType.video);

        expect(results.length, 3); // All demo content is video
      });

      test('should search content by tags', () {
        final results = contentService.searchContent(tags: ['космос']);

        expect(results.length, 2); // Two items have 'космос' tag
      });

      test('should search with multiple criteria', () {
        final results = contentService.searchContent(
          query: 'солнечная',
          type: ContentType.video,
          tags: ['планеты'],
        );

        expect(results.length, 1);
        expect(results.first.name, 'Солнечная система');
      });

      test('should return empty list for no matches', () {
        final results = contentService.searchContent(query: 'nonexistent');

        expect(results.isEmpty, true);
      });

      test('should be case insensitive', () {
        final results = contentService.searchContent(query: 'ЗВЕЗД');

        expect(results.length, 1);
        expect(results.first.name, 'Звездное небо');
      });
    });

    group('Content Management', () {
      setUp(() {
        when(mockAuthService.hasPermission(FreeDomePermission.manageContent))
            .thenReturn(true);
      });

      test('should add content to library', () async {
        final content = await contentService.addContent(
          name: 'New Test Content',
          filePath: '/test/new_content.mp4',
          type: ContentType.video,
          duration: const Duration(minutes: 10),
          description: 'Test content for testing',
          tags: ['test', 'new'],
          format: ProjectionFormat.spherical,
        );

        expect(content, isNotNull);
        expect(content!.name, 'New Test Content');
        expect(content.type, ContentType.video);
        expect(content.tags, ['test', 'new']);

        expect(contentService.contentLibrary.length, 4); // 3 demo + 1 new
        expect(contentService.contentLibrary.contains(content), true);
      });

      test('should fail to add content without permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.manageContent))
            .thenReturn(false);

        final content = await contentService.addContent(
          name: 'Unauthorized Content',
          filePath: '/test/unauthorized.mp4',
          type: ContentType.video,
          duration: const Duration(minutes: 5),
        );

        expect(content, null);
        expect(contentService.contentLibrary.length, 3); // Only demo content
      });

      test('should remove content from library', () async {
        final initialCount = contentService.contentLibrary.length;
        const contentToRemove = 'demo_starry_sky';

        final result = await contentService.removeContent(contentToRemove);

        expect(result, true);
        expect(contentService.contentLibrary.length, initialCount - 1);
        expect(contentService.getContent(contentToRemove), null);
      });

      test('should fail to remove content without permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.manageContent))
            .thenReturn(false);

        final result = await contentService.removeContent('demo_starry_sky');

        expect(result, false);
        expect(contentService.contentLibrary.length, 3); // Unchanged
      });

      test('should get content by ID', () {
        final content = contentService.getContent('demo_starry_sky');

        expect(content, isNotNull);
        expect(content!.name, 'Звездное небо');
      });

      test('should return null for non-existent content', () {
        final content = contentService.getContent('nonexistent');

        expect(content, null);
      });
    });

    group('Playlist Management', () {
      setUp(() {
        when(mockAuthService.hasPermission(FreeDomePermission.manageContent))
            .thenReturn(true);
      });

      test('should create playlist successfully', () async {
        final contentIds =
            contentService.contentLibrary.take(2).map((c) => c.id).toList();

        final playlist = await contentService.createPlaylist(
          name: 'Test Playlist',
          contentIds: contentIds,
          description: 'Test playlist for testing',
        );

        expect(playlist, isNotNull);
        expect(playlist!.name, 'Test Playlist');
        expect(playlist.contentIds.length, 2);
        expect(playlist.description, 'Test playlist for testing');

        expect(contentService.playlists.length, 1);
        expect(contentService.playlists.contains(playlist), true);
      });

      test('should fail to create playlist without permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.manageContent))
            .thenReturn(false);

        final playlist = await contentService.createPlaylist(
          name: 'Unauthorized Playlist',
          contentIds: ['demo_starry_sky'],
        );

        expect(playlist, null);
        expect(contentService.playlists.length, 0);
      });

      test('should play playlist successfully', () async {
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(true);
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        // Create a playlist first
        final contentIds =
            contentService.contentLibrary.take(2).map((c) => c.id).toList();
        final playlist = await contentService.createPlaylist(
          name: 'Test Playlist',
          contentIds: contentIds,
        );

        final result = await contentService.playPlaylist(playlist!.id);

        expect(result, true);
        expect(contentService.playbackState.currentPlaylistId, playlist.id);
        expect(contentService.playbackState.status, PlaybackStatus.playing);
      });

      test('should fail to play empty playlist', () async {
        final playlist = await contentService.createPlaylist(
          name: 'Empty Playlist',
          contentIds: [],
        );

        final result = await contentService.playPlaylist(playlist!.id);

        expect(result, false);
      });

      test('should get playlist by ID', () async {
        final contentIds = ['demo_starry_sky'];
        final playlist = await contentService.createPlaylist(
          name: 'Test Playlist',
          contentIds: contentIds,
        );

        final retrievedPlaylist = contentService.getPlaylist(playlist!.id);

        expect(retrievedPlaylist, isNotNull);
        expect(retrievedPlaylist!.name, 'Test Playlist');
      });

      test('should return null for non-existent playlist', () {
        final playlist = contentService.getPlaylist('nonexistent');

        expect(playlist, null);
      });
    });

    group('Usage Statistics', () {
      test('should provide usage statistics', () {
        final stats = contentService.getUsageStats();

        expect(stats['totalContent'], 3);
        expect(stats['totalPlaylists'], 0);
        expect(stats['totalPlayCount'], 0);
        expect(stats['mostPlayedContent'], null);
        expect(stats['currentPlayback'], isA<Map>());
      });

      test('should update content statistics after playback', () async {
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(true);
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final content = contentService.contentLibrary.first;
        final initialPlayCount = content.playCount;

        await contentService.playContent(content);

        // Wait a bit for async update
        await Future.delayed(const Duration(milliseconds: 10));

        final updatedContent = contentService.getContent(content.id);
        expect(updatedContent!.playCount, initialPlayCount + 1);
        expect(updatedContent.lastPlayed, isNotNull);
      });
    });

    group('Playback State Stream', () {
      test('should emit playback state changes', () async {
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockAuthService.hasPermission(FreeDomePermission.playContent))
            .thenReturn(true);
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final states = <PlaybackState>[];
        final subscription = contentService.playbackStream.listen((state) {
          states.add(state);
        });

        const testContent = ProjectionContent(
          id: 'test-content',
          name: 'Test Content',
          filePath: '/test/content.mp4',
          type: ContentType.video,
          duration: Duration(minutes: 5),
        );

        await contentService.playContent(testContent);
        await contentService.pausePlayback();
        await contentService.stopPlayback();

        await subscription.cancel();

        expect(states.length, 3);
        expect(states[0].status, PlaybackStatus.playing);
        expect(states[1].status, PlaybackStatus.paused);
        expect(states[2].status, PlaybackStatus.stopped);
      });
    });
  });
}
