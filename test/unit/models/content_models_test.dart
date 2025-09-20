import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/models/content_models.dart';

void main() {
  group('ProjectionContent', () {
    test('should create ProjectionContent with required fields', () {
      const content = ProjectionContent(
        id: 'content-1',
        name: 'Test Content',
        filePath: '/path/to/content.mp4',
        type: ContentType.video,
        duration: Duration(minutes: 5),
      );

      expect(content.id, 'content-1');
      expect(content.name, 'Test Content');
      expect(content.filePath, '/path/to/content.mp4');
      expect(content.type, ContentType.video);
      expect(content.duration, const Duration(minutes: 5));
      expect(content.format, ProjectionFormat.equirectangular); // default
      expect(content.tags, isEmpty);
      expect(content.playCount, 0);
      expect(content.defaultVolume, 1.0);
      expect(content.defaultBrightness, 1.0);
    });

    test('should create ProjectionContent with all optional fields', () {
      final createdAt = DateTime.now();
      final lastPlayed = DateTime.now().subtract(const Duration(hours: 1));
      
      final content = ProjectionContent(
        id: 'content-2',
        name: 'Advanced Content',
        filePath: '/path/to/advanced.mp4',
        type: ContentType.interactive,
        duration: const Duration(minutes: 10),
        description: 'An advanced interactive experience',
        tags: ['interactive', 'educational', 'space'],
        format: ProjectionFormat.fulldome,
        thumbnailPath: '/path/to/thumbnail.jpg',
        createdAt: createdAt,
        lastPlayed: lastPlayed,
        playCount: 15,
        defaultVolume: 0.8,
        defaultBrightness: 0.9,
        metadata: {'resolution': '4K', 'framerate': 60},
      );

      expect(content.description, 'An advanced interactive experience');
      expect(content.tags, ['interactive', 'educational', 'space']);
      expect(content.format, ProjectionFormat.fulldome);
      expect(content.thumbnailPath, '/path/to/thumbnail.jpg');
      expect(content.createdAt, createdAt);
      expect(content.lastPlayed, lastPlayed);
      expect(content.playCount, 15);
      expect(content.defaultVolume, 0.8);
      expect(content.defaultBrightness, 0.9);
      expect(content.metadata?['resolution'], '4K');
    });

    test('should serialize to and from JSON correctly', () {
      final createdAt = DateTime.now();
      const originalContent = ProjectionContent(
        id: 'json-content',
        name: 'JSON Test Content',
        filePath: '/test/path.mp4',
        type: ContentType.video,
        duration: Duration(minutes: 8),
        description: 'Test description',
        tags: ['test', 'json'],
        format: ProjectionFormat.spherical,
        playCount: 5,
        defaultVolume: 0.7,
      );

      final json = originalContent.toJson();
      final reconstructed = ProjectionContent.fromJson(json);

      expect(reconstructed.id, originalContent.id);
      expect(reconstructed.name, originalContent.name);
      expect(reconstructed.filePath, originalContent.filePath);
      expect(reconstructed.type, originalContent.type);
      expect(reconstructed.duration, originalContent.duration);
      expect(reconstructed.description, originalContent.description);
      expect(reconstructed.tags, originalContent.tags);
      expect(reconstructed.format, originalContent.format);
      expect(reconstructed.playCount, originalContent.playCount);
      expect(reconstructed.defaultVolume, originalContent.defaultVolume);
    });

    test('should convert to FreeDome data format correctly', () {
      const content = ProjectionContent(
        id: 'freedome-content',
        name: 'FreeDome Test',
        filePath: '/freedome/test.mp4',
        type: ContentType.video,
        duration: Duration(minutes: 12),
        description: 'FreeDome test content',
        tags: ['freedome', 'test'],
        format: ProjectionFormat.domemaster,
        defaultVolume: 0.9,
        defaultBrightness: 0.8,
        metadata: {'custom': 'data'},
      );

      final freedomeData = content.toFreeDomeData();

      expect(freedomeData['type'], 'projection_content');
      expect(freedomeData['content']['id'], 'freedome-content');
      expect(freedomeData['content']['name'], 'FreeDome Test');
      expect(freedomeData['content']['filePath'], '/freedome/test.mp4');
      expect(freedomeData['content']['contentType'], 'video');
      expect(freedomeData['content']['format'], 'domemaster');
      expect(freedomeData['content']['duration'], 12 * 60 * 1000); // milliseconds
      expect(freedomeData['content']['description'], 'FreeDome test content');
      expect(freedomeData['content']['tags'], ['freedome', 'test']);
      expect(freedomeData['content']['metadata']['custom'], 'data');
      expect(freedomeData['settings']['volume'], 0.9);
      expect(freedomeData['settings']['brightness'], 0.8);
      expect(freedomeData.containsKey('timestamp'), true);
    });
  });

  group('PlaybackState', () {
    test('should create PlaybackState with default values', () {
      const state = PlaybackState();

      expect(state.status, PlaybackStatus.stopped);
      expect(state.currentContentId, null);
      expect(state.currentPlaylistId, null);
      expect(state.position, Duration.zero);
      expect(state.duration, null);
      expect(state.volume, 0.5);
      expect(state.speed, 1.0);
      expect(state.isLooping, false);
      expect(state.isMuted, false);
      expect(state.error, null);
    });

    test('should create PlaybackState with custom values', () {
      const state = PlaybackState(
        status: PlaybackStatus.playing,
        currentContentId: 'content-123',
        currentPlaylistId: 'playlist-456',
        position: Duration(minutes: 2),
        duration: Duration(minutes: 10),
        volume: 0.8,
        speed: 1.5,
        isLooping: true,
        isMuted: false,
        error: null,
      );

      expect(state.status, PlaybackStatus.playing);
      expect(state.currentContentId, 'content-123');
      expect(state.currentPlaylistId, 'playlist-456');
      expect(state.position, const Duration(minutes: 2));
      expect(state.duration, const Duration(minutes: 10));
      expect(state.volume, 0.8);
      expect(state.speed, 1.5);
      expect(state.isLooping, true);
      expect(state.isMuted, false);
    });

    test('should serialize to and from JSON correctly', () {
      const originalState = PlaybackState(
        status: PlaybackStatus.paused,
        currentContentId: 'json-content',
        position: Duration(seconds: 150),
        duration: Duration(minutes: 5),
        volume: 0.6,
        speed: 0.5,
        isLooping: true,
        isMuted: true,
        error: 'Test error',
      );

      final json = originalState.toJson();
      final reconstructed = PlaybackState.fromJson(json);

      expect(reconstructed.status, originalState.status);
      expect(reconstructed.currentContentId, originalState.currentContentId);
      expect(reconstructed.position, originalState.position);
      expect(reconstructed.duration, originalState.duration);
      expect(reconstructed.volume, originalState.volume);
      expect(reconstructed.speed, originalState.speed);
      expect(reconstructed.isLooping, originalState.isLooping);
      expect(reconstructed.isMuted, originalState.isMuted);
      expect(reconstructed.error, originalState.error);
    });
  });

  group('Playlist', () {
    test('should create Playlist with required fields', () {
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      
      final playlist = Playlist(
        id: 'playlist-1',
        name: 'Test Playlist',
        contentIds: ['content-1', 'content-2', 'content-3'],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      expect(playlist.id, 'playlist-1');
      expect(playlist.name, 'Test Playlist');
      expect(playlist.contentIds, ['content-1', 'content-2', 'content-3']);
      expect(playlist.createdAt, createdAt);
      expect(playlist.updatedAt, updatedAt);
      expect(playlist.currentIndex, 0);
      expect(playlist.mode, PlaylistMode.sequential);
      expect(playlist.isLooping, false);
      expect(playlist.isShuffled, false);
    });

    test('should create Playlist with all optional fields', () {
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      final lastModified = DateTime.now().subtract(const Duration(hours: 1));
      
      final playlist = Playlist(
        id: 'playlist-2',
        name: 'Advanced Playlist',
        contentIds: ['content-a', 'content-b'],
        createdAt: createdAt,
        updatedAt: updatedAt,
        lastModified: lastModified,
        currentIndex: 1,
        mode: PlaylistMode.shuffle,
        isLooping: true,
        isShuffled: true,
        description: 'An advanced playlist for testing',
        tags: ['test', 'advanced'],
      );

      expect(playlist.lastModified, lastModified);
      expect(playlist.currentIndex, 1);
      expect(playlist.mode, PlaylistMode.shuffle);
      expect(playlist.isLooping, true);
      expect(playlist.isShuffled, true);
      expect(playlist.description, 'An advanced playlist for testing');
      expect(playlist.tags, ['test', 'advanced']);
    });

    test('should serialize to and from JSON correctly', () {
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      
      final originalPlaylist = Playlist(
        id: 'json-playlist',
        name: 'JSON Playlist',
        contentIds: ['json-1', 'json-2'],
        createdAt: createdAt,
        updatedAt: updatedAt,
        currentIndex: 1,
        mode: PlaylistMode.random,
        isLooping: true,
        description: 'JSON test playlist',
        tags: ['json', 'test'],
      );

      final json = originalPlaylist.toJson();
      final reconstructed = Playlist.fromJson(json);

      expect(reconstructed.id, originalPlaylist.id);
      expect(reconstructed.name, originalPlaylist.name);
      expect(reconstructed.contentIds, originalPlaylist.contentIds);
      expect(reconstructed.currentIndex, originalPlaylist.currentIndex);
      expect(reconstructed.mode, originalPlaylist.mode);
      expect(reconstructed.isLooping, originalPlaylist.isLooping);
      expect(reconstructed.description, originalPlaylist.description);
      expect(reconstructed.tags, originalPlaylist.tags);
    });
  });

  group('InteractiveContent', () {
    test('should create InteractiveContent with required fields', () {
      const content = InteractiveContent(
        id: 'interactive-1',
        name: 'Interactive Test',
        appName: 'TestApp',
        appData: {'type': 'game', 'level': 1},
      );

      expect(content.id, 'interactive-1');
      expect(content.name, 'Interactive Test');
      expect(content.appName, 'TestApp');
      expect(content.appData, {'type': 'game', 'level': 1});
      expect(content.description, null);
      expect(content.tags, isEmpty);
    });

    test('should convert to FreeDome data format correctly', () {
      final createdAt = DateTime.now();
      final content = InteractiveContent(
        id: 'interactive-freedome',
        name: 'FreeDome Interactive',
        appName: 'FreeDomeApp',
        appData: {'mode': 'demo', 'difficulty': 'easy'},
        description: 'FreeDome interactive content',
        tags: ['interactive', 'demo'],
        createdAt: createdAt,
      );

      final freedomeData = content.toFreeDomeData();

      expect(freedomeData['type'], 'interactive_content');
      expect(freedomeData['app']['name'], 'FreeDomeApp');
      expect(freedomeData['app']['contentId'], 'interactive-freedome');
      expect(freedomeData['app']['contentName'], 'FreeDome Interactive');
      expect(freedomeData['app']['data'], {'mode': 'demo', 'difficulty': 'easy'});
      expect(freedomeData['metadata']['description'], 'FreeDome interactive content');
      expect(freedomeData['metadata']['tags'], ['interactive', 'demo']);
      expect(freedomeData['metadata']['createdAt'], createdAt.toIso8601String());
      expect(freedomeData.containsKey('timestamp'), true);
    });

    test('should have correct ContentType', () {
      const content = InteractiveContent(
        id: 'type-test',
        name: 'Type Test',
        appName: 'TypeApp',
        appData: {},
      );

      expect(content.type, ContentType.interactive);
    });
  });

  group('RealtimeContent', () {
    test('should create RealtimeContent with required fields', () {
      const content = RealtimeContent(
        id: 'realtime-1',
        name: 'Realtime Test',
        sourceType: 'camera',
        sourceConfig: {'resolution': '1080p', 'fps': 30},
      );

      expect(content.id, 'realtime-1');
      expect(content.name, 'Realtime Test');
      expect(content.sourceType, 'camera');
      expect(content.sourceConfig, {'resolution': '1080p', 'fps': 30});
      expect(content.description, null);
      expect(content.tags, isEmpty);
    });

    test('should convert to FreeDome data format correctly', () {
      const content = RealtimeContent(
        id: 'realtime-freedome',
        name: 'FreeDome Realtime',
        sourceType: 'stream',
        sourceConfig: {'url': 'rtmp://example.com', 'quality': 'high'},
        description: 'FreeDome realtime content',
        tags: ['realtime', 'stream'],
      );

      final freedomeData = content.toFreeDomeData();

      expect(freedomeData['type'], 'realtime_content');
      expect(freedomeData['source']['type'], 'stream');
      expect(freedomeData['source']['config'], {'url': 'rtmp://example.com', 'quality': 'high'});
      expect(freedomeData['source']['contentId'], 'realtime-freedome');
      expect(freedomeData['source']['contentName'], 'FreeDome Realtime');
      expect(freedomeData['metadata']['description'], 'FreeDome realtime content');
      expect(freedomeData['metadata']['tags'], ['realtime', 'stream']);
      expect(freedomeData.containsKey('timestamp'), true);
    });

    test('should have correct ContentType', () {
      const content = RealtimeContent(
        id: 'type-test',
        name: 'Type Test',
        sourceType: 'test',
        sourceConfig: {},
      );

      expect(content.type, ContentType.realtime);
    });
  });

  group('ContentLibrary', () {
    test('should create ContentLibrary with required fields', () {
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      
      final library = ContentLibrary(
        id: 'library-1',
        name: 'Test Library',
        contentIds: ['content-1', 'content-2'],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      expect(library.id, 'library-1');
      expect(library.name, 'Test Library');
      expect(library.contentIds, ['content-1', 'content-2']);
      expect(library.createdAt, createdAt);
      expect(library.updatedAt, updatedAt);
      expect(library.description, null);
      expect(library.tags, isEmpty);
    });

    test('should serialize to and from JSON correctly', () {
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      
      final originalLibrary = ContentLibrary(
        id: 'json-library',
        name: 'JSON Library',
        contentIds: ['json-1', 'json-2', 'json-3'],
        description: 'JSON test library',
        tags: ['json', 'test'],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      final json = originalLibrary.toJson();
      final reconstructed = ContentLibrary.fromJson(json);

      expect(reconstructed.id, originalLibrary.id);
      expect(reconstructed.name, originalLibrary.name);
      expect(reconstructed.contentIds, originalLibrary.contentIds);
      expect(reconstructed.description, originalLibrary.description);
      expect(reconstructed.tags, originalLibrary.tags);
    });
  });

  group('ContentType Extensions', () {
    test('should provide correct display names', () {
      expect(ContentType.video.displayName, 'Видео');
      expect(ContentType.image.displayName, 'Изображение');
      expect(ContentType.interactive.displayName, 'Интерактивный');
      expect(ContentType.realtime.displayName, 'В реальном времени');
      expect(ContentType.audio.displayName, 'Аудио');
      expect(ContentType.procedural.displayName, 'Процедурный');
    });

    test('should provide correct file extensions', () {
      expect(ContentType.video.fileExtensions, 'mp4, mov, avi, mkv');
      expect(ContentType.image.fileExtensions, 'jpg, png, tiff, exr');
      expect(ContentType.interactive.fileExtensions, 'app, unity, web');
      expect(ContentType.realtime.fileExtensions, 'stream, rtmp, webrtc');
      expect(ContentType.audio.fileExtensions, 'wav, mp3, flac, ogg');
      expect(ContentType.procedural.fileExtensions, 'shader, script, algorithm');
    });
  });

  group('PlaybackStatus Extensions', () {
    test('should provide correct display names', () {
      expect(PlaybackStatus.stopped.displayName, 'Остановлено');
      expect(PlaybackStatus.playing.displayName, 'Воспроизводится');
      expect(PlaybackStatus.paused.displayName, 'На паузе');
      expect(PlaybackStatus.buffering.displayName, 'Буферизация');
      expect(PlaybackStatus.error.displayName, 'Ошибка');
    });

    test('should correctly identify playing status', () {
      expect(PlaybackStatus.playing.isPlaying, true);
      expect(PlaybackStatus.paused.isPlaying, false);
      expect(PlaybackStatus.stopped.isPlaying, false);
    });

    test('should correctly identify control capabilities', () {
      expect(PlaybackStatus.playing.canPause, true);
      expect(PlaybackStatus.paused.canPause, false);
      expect(PlaybackStatus.paused.canResume, true);
      expect(PlaybackStatus.playing.canResume, false);
      expect(PlaybackStatus.playing.canStop, true);
      expect(PlaybackStatus.paused.canStop, true);
      expect(PlaybackStatus.stopped.canStop, false);
    });
  });

  group('PlaybackState Extensions', () {
    test('should delegate control capabilities correctly', () {
      const playingState = PlaybackState(status: PlaybackStatus.playing);
      const pausedState = PlaybackState(status: PlaybackStatus.paused);
      const stoppedState = PlaybackState(status: PlaybackStatus.stopped);

      expect(playingState.canStop, true);
      expect(playingState.canPause, true);
      expect(playingState.canResume, false);
      expect(playingState.isPlaying, true);

      expect(pausedState.canStop, true);
      expect(pausedState.canPause, false);
      expect(pausedState.canResume, true);
      expect(pausedState.isPlaying, false);

      expect(stoppedState.canStop, false);
      expect(stoppedState.isPlaying, false);
    });

    test('should calculate progress percentage correctly', () {
      const stateWithoutDuration = PlaybackState(
        position: Duration(minutes: 2),
      );
      expect(stateWithoutDuration.progressPercent, 0.0);

      const stateWithZeroDuration = PlaybackState(
        position: Duration(minutes: 2),
        duration: Duration.zero,
      );
      expect(stateWithZeroDuration.progressPercent, 0.0);

      const stateWithProgress = PlaybackState(
        position: Duration(minutes: 2),
        duration: Duration(minutes: 10),
      );
      expect(stateWithProgress.progressPercent, 0.2);

      const stateAtEnd = PlaybackState(
        position: Duration(minutes: 10),
        duration: Duration(minutes: 10),
      );
      expect(stateAtEnd.progressPercent, 1.0);
    });

    test('should provide status display name', () {
      const playingState = PlaybackState(status: PlaybackStatus.playing);
      expect(playingState.statusDisplayName, 'Воспроизводится');
    });
  });

  group('ProjectionFormat Extensions', () {
    test('should provide correct display names', () {
      expect(ProjectionFormat.equirectangular.displayName, 'Равнопромежуточная');
      expect(ProjectionFormat.fisheye.displayName, 'Рыбий глаз');
      expect(ProjectionFormat.cubemap.displayName, 'Кубическая карта');
      expect(ProjectionFormat.domemaster.displayName, 'DomeMaster');
      expect(ProjectionFormat.fulldome.displayName, 'FullDome');
      expect(ProjectionFormat.spherical.displayName, 'Сферическая');
      expect(ProjectionFormat.cylindrical.displayName, 'Цилиндрическая');
    });

    test('should correctly identify interaction support', () {
      expect(ProjectionFormat.equirectangular.supportsInteraction, true);
      expect(ProjectionFormat.spherical.supportsInteraction, true);
      expect(ProjectionFormat.fisheye.supportsInteraction, false);
      expect(ProjectionFormat.cubemap.supportsInteraction, false);
      expect(ProjectionFormat.domemaster.supportsInteraction, false);
    });
  });
}
