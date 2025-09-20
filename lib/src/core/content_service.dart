import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connection_service.dart';
import 'auth_service.dart';
import '../models/content_models.dart';
import '../models/dome_models.dart';
import '../models/calibration_models.dart';

/// Сервис для управления контентом FreeDome
class FreeDomeContentService extends ChangeNotifier {
  static final FreeDomeContentService _instance =
      FreeDomeContentService._internal();
  factory FreeDomeContentService() => _instance;
  FreeDomeContentService._internal();

  final FreeDomeConnectionService _connectionService =
      FreeDomeConnectionService();
  final FreeDomeAuthService _authService = FreeDomeAuthService();

  // Состояние воспроизведения
  PlaybackState _playbackState = const PlaybackState();

  // Библиотека контента
  final List<ProjectionContent> _contentLibrary = [];
  final List<Playlist> _playlists = [];

  // Контроллеры событий
  final StreamController<PlaybackState> _playbackController =
      StreamController<PlaybackState>.broadcast();

  // Геттеры
  PlaybackState get playbackState => _playbackState;
  List<ProjectionContent> get contentLibrary => List.from(_contentLibrary);
  List<Playlist> get playlists => List.from(_playlists);
  Stream<PlaybackState> get playbackStream => _playbackController.stream;

  /// Инициализация сервиса
  Future<void> initialize() async {
    try {
      await _loadContentLibrary();
      await _loadPlaylists();

      if (kDebugMode) {
        print('✅ FreeDomeContentService инициализирован');
        print('📚 Загружено ${_contentLibrary.length} элементов контента');
        print('🎵 Загружено ${_playlists.length} плейлистов');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации FreeDomeContentService: $e');
      }
    }
  }

  /// Воспроизведение контента
  Future<bool> playContent(dynamic content) async {
    // Проверяем разрешения
    if (!_authService.hasPermission(FreeDomePermission.playContent)) {
      if (kDebugMode) {
        print('❌ Нет разрешения на воспроизведение контента');
      }
      return false;
    }

    if (!_connectionService.isConnected) {
      if (kDebugMode) {
        print('❌ Нет подключения к FreeDome системе');
      }
      return false;
    }

    try {
      _updatePlaybackState(status: PlaybackStatus.buffering);

      // Отправляем команду воспроизведения
      final command = FreeDomeCommand(
        type: 'play_content',
        data: content.toFreeDomeData(),
        targetSystemId: _connectionService.activeDome?.id,
        sessionId: _authService.currentSession?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _updatePlaybackState(
          status: PlaybackStatus.playing,
          currentContentId: content.id,
        );

        // Обновляем статистику контента
        if (content is ProjectionContent) {
          await _updateContentStats(content);
        }

        if (kDebugMode) {
          print('✅ Контент воспроизводится: ${content.name}');
        }

        return true;
      } else {
        _updatePlaybackState(
          status: PlaybackStatus.error,
          error: response.error,
        );
        return false;
      }
    } catch (e) {
      _updatePlaybackState(
        status: PlaybackStatus.error,
        error: e.toString(),
      );

      if (kDebugMode) {
        print('❌ Ошибка воспроизведения контента: $e');
      }

      return false;
    }
  }

  /// Пауза воспроизведения
  Future<bool> pausePlayback() async {
    if (!_authService.hasPermission(FreeDomePermission.playContent)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'pause_playback',
        data: {},
        targetSystemId: _connectionService.activeDome?.id,
        sessionId: _authService.currentSession?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _updatePlaybackState(status: PlaybackStatus.paused);
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка паузы: $e');
      }
    }

    return false;
  }

  /// Возобновление воспроизведения
  Future<bool> resumePlayback() async {
    if (!_authService.hasPermission(FreeDomePermission.playContent)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'resume_playback',
        data: {},
        targetSystemId: _connectionService.activeDome?.id,
        sessionId: _authService.currentSession?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _updatePlaybackState(status: PlaybackStatus.playing);
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка возобновления: $e');
      }
    }

    return false;
  }

  /// Остановка воспроизведения
  Future<bool> stopPlayback() async {
    if (!_authService.hasPermission(FreeDomePermission.playContent)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'stop_playback',
        data: {},
        targetSystemId: _connectionService.activeDome?.id,
        sessionId: _authService.currentSession?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _updatePlaybackState(
          status: PlaybackStatus.stopped,
          currentContentId: null,
          position: Duration.zero,
        );
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка остановки: $e');
      }
    }

    return false;
  }

  /// Установка громкости
  Future<bool> setVolume(double volume) async {
    if (!_authService.hasPermission(FreeDomePermission.controlBasics)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_volume',
        data: {'volume': volume.clamp(0.0, 1.0)},
        targetSystemId: _connectionService.activeDome?.id,
        sessionId: _authService.currentSession?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _updatePlaybackState(volume: volume);
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки громкости: $e');
      }
    }

    return false;
  }

  /// Установка яркости
  Future<bool> setBrightness(double brightness) async {
    if (!_authService.hasPermission(FreeDomePermission.controlBasics)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_brightness',
        data: {'brightness': brightness.clamp(0.0, 1.0)},
        targetSystemId: _connectionService.activeDome?.id,
        sessionId: _authService.currentSession?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);
      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки яркости: $e');
      }
      return false;
    }
  }

  /// Воспроизведение интерактивного контента от приложения
  Future<bool> playInteractiveContent({
    required String appName,
    required String contentName,
    required Map<String, dynamic> appData,
  }) async {
    final content = InteractiveContent(
      id: 'interactive_${DateTime.now().millisecondsSinceEpoch}',
      name: contentName,
      appName: appName,
      appData: appData,
      createdAt: DateTime.now(),
    );

    return await playContent(content);
  }

  /// Воспроизведение контента в реальном времени
  Future<bool> playRealtimeContent({
    required String sourceType,
    required Map<String, dynamic> sourceConfig,
    String? contentName,
  }) async {
    final content = RealtimeContent(
      id: 'realtime_${DateTime.now().millisecondsSinceEpoch}',
      name: contentName ?? 'Realtime Content',
      sourceType: sourceType,
      sourceConfig: sourceConfig,
    );

    return await playContent(content);
  }

  /// Создание плейлиста (только для операторов и выше)
  Future<Playlist?> createPlaylist({
    required String name,
    required List<String> contentIds,
    String? description,
  }) async {
    if (!_authService.hasPermission(FreeDomePermission.manageContent)) {
      return null;
    }

    try {
      final playlist = Playlist(
        id: 'playlist_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        contentIds: contentIds,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      _playlists.add(playlist);
      await _savePlaylists();
      notifyListeners();

      if (kDebugMode) {
        print('✅ Плейлист создан: $name');
      }

      return playlist;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка создания плейлиста: $e');
      }
      return null;
    }
  }

  /// Воспроизведение плейлиста
  Future<bool> playPlaylist(String playlistId) async {
    try {
      final playlist = _playlists.firstWhere((p) => p.id == playlistId);

      if (playlist.contentIds.isEmpty) {
        return false;
      }

      final firstContentId = playlist.contentIds[playlist.currentIndex];
      final content = _contentLibrary.firstWhere((c) => c.id == firstContentId);

      _updatePlaybackState(currentPlaylistId: playlistId);

      return await playContent(content);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка воспроизведения плейлиста: $e');
      }
      return false;
    }
  }

  /// Поиск контента
  List<ProjectionContent> searchContent({
    String? query,
    ContentType? type,
    List<String>? tags,
  }) {
    return _contentLibrary.where((content) {
      bool matches = true;

      if (query != null && query.isNotEmpty) {
        matches = matches &&
            (content.name.toLowerCase().contains(query.toLowerCase()) ||
                (content.description
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false));
      }

      if (type != null) {
        matches = matches && content.type == type;
      }

      if (tags != null && tags.isNotEmpty) {
        matches = matches && tags.any((tag) => content.tags.contains(tag));
      }

      return matches;
    }).toList();
  }

  /// Добавление контента в библиотеку (только для операторов и выше)
  Future<ProjectionContent?> addContent({
    required String name,
    required String filePath,
    required ContentType type,
    required Duration duration,
    String? description,
    List<String>? tags,
    ProjectionFormat format = ProjectionFormat.equirectangular,
  }) async {
    if (!_authService.hasPermission(FreeDomePermission.manageContent)) {
      return null;
    }

    try {
      final content = ProjectionContent(
        id: 'content_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        filePath: filePath,
        type: type,
        duration: duration,
        description: description,
        tags: tags ?? [],
        format: format,
        createdAt: DateTime.now(),
      );

      _contentLibrary.add(content);
      await _saveContentLibrary();
      notifyListeners();

      if (kDebugMode) {
        print('✅ Контент добавлен: $name');
      }

      return content;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка добавления контента: $e');
      }
      return null;
    }
  }

  /// Удаление контента (только для операторов и выше)
  Future<bool> removeContent(String contentId) async {
    if (!_authService.hasPermission(FreeDomePermission.manageContent)) {
      return false;
    }

    try {
      _contentLibrary.removeWhere((content) => content.id == contentId);

      // Удаляем из всех плейлистов
      for (int i = 0; i < _playlists.length; i++) {
        final playlist = _playlists[i];
        final updatedContentIds =
            playlist.contentIds.where((id) => id != contentId).toList();

        if (updatedContentIds.length != playlist.contentIds.length) {
          _playlists[i] = playlist.copyWith(
            contentIds: updatedContentIds,
            updatedAt: DateTime.now(),
          );
        }
      }

      await _saveContentLibrary();
      await _savePlaylists();
      notifyListeners();

      if (kDebugMode) {
        print('✅ Контент удален: $contentId');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка удаления контента: $e');
      }
      return false;
    }
  }

  /// Получение контента по ID
  ProjectionContent? getContent(String contentId) {
    try {
      return _contentLibrary.firstWhere((content) => content.id == contentId);
    } catch (e) {
      return null;
    }
  }

  /// Получение плейлиста по ID
  Playlist? getPlaylist(String playlistId) {
    try {
      return _playlists.firstWhere((playlist) => playlist.id == playlistId);
    } catch (e) {
      return null;
    }
  }

  /// Обновление состояния воспроизведения
  void _updatePlaybackState({
    PlaybackStatus? status,
    String? currentContentId,
    String? currentPlaylistId,
    Duration? position,
    Duration? duration,
    double? volume,
    double? speed,
    bool? isLooping,
    bool? isMuted,
    String? error,
  }) {
    _playbackState = _playbackState.copyWith(
      status: status ?? _playbackState.status,
      currentContentId: currentContentId ?? _playbackState.currentContentId,
      currentPlaylistId: currentPlaylistId ?? _playbackState.currentPlaylistId,
      position: position ?? _playbackState.position,
      duration: duration ?? _playbackState.duration,
      volume: volume ?? _playbackState.volume,
      speed: speed ?? _playbackState.speed,
      isLooping: isLooping ?? _playbackState.isLooping,
      isMuted: isMuted ?? _playbackState.isMuted,
      error: error,
    );

    _playbackController.add(_playbackState);
    notifyListeners();
  }

  /// Обновление статистики контента
  Future<void> _updateContentStats(dynamic content) async {
    try {
      final index = _contentLibrary.indexWhere((c) => c.id == content.id);
      if (index != -1) {
        _contentLibrary[index] = content.copyWith(
          lastPlayed: DateTime.now(),
          playCount: content.playCount + 1,
        );
        await _saveContentLibrary();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления статистики: $e');
      }
    }
  }

  /// Загрузка библиотеки контента
  Future<void> _loadContentLibrary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final contentJson = prefs.getString('freedome_content_library');

      if (contentJson != null) {
        final contentList = json.decode(contentJson) as List;
        _contentLibrary.clear();
        _contentLibrary.addAll(
          contentList.map((item) => ProjectionContent.fromJson(item)).toList(),
        );
      } else {
        // Загружаем демо контент
        _loadDemoContent();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки библиотеки контента: $e');
      }
      _loadDemoContent();
    }
  }

  /// Загрузка плейлистов
  Future<void> _loadPlaylists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final playlistsJson = prefs.getString('freedome_playlists');

      if (playlistsJson != null) {
        final playlistsList = json.decode(playlistsJson) as List;
        _playlists.clear();
        _playlists.addAll(
          playlistsList.map((item) => Playlist.fromJson(item)).toList(),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки плейлистов: $e');
      }
    }
  }

  /// Загрузка демо контента
  void _loadDemoContent() {
    _contentLibrary.addAll([
      ProjectionContent(
        id: 'demo_starry_sky',
        name: 'Звездное небо',
        filePath: '/content/starry_sky.mp4',
        type: ContentType.video,
        duration: const Duration(minutes: 10),
        description: 'Красивое звездное небо для релаксации',
        tags: ['звезды', 'космос', 'релаксация'],
        format: ProjectionFormat.fulldome,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      ProjectionContent(
        id: 'demo_solar_system',
        name: 'Солнечная система',
        filePath: '/content/solar_system.mp4',
        type: ContentType.video,
        duration: const Duration(minutes: 15),
        description: 'Образовательный фильм о планетах',
        tags: ['планеты', 'образование', 'космос'],
        format: ProjectionFormat.spherical,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ProjectionContent(
        id: 'demo_abstract',
        name: 'Абстрактные узоры',
        filePath: '/content/abstract_patterns.mp4',
        type: ContentType.video,
        duration: const Duration(minutes: 8),
        description: 'Красочные абстрактные узоры',
        tags: ['абстракция', 'узоры', 'цвета'],
        format: ProjectionFormat.equirectangular,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ]);
  }

  /// Сохранение библиотеки контента
  Future<void> _saveContentLibrary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final contentJson = json.encode(
        _contentLibrary.map((content) => content.toJson()).toList(),
      );
      await prefs.setString('freedome_content_library', contentJson);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сохранения библиотеки контента: $e');
      }
    }
  }

  /// Сохранение плейлистов
  Future<void> _savePlaylists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final playlistsJson = json.encode(
        _playlists.map((playlist) => playlist.toJson()).toList(),
      );
      await prefs.setString('freedome_playlists', playlistsJson);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сохранения плейлистов: $e');
      }
    }
  }

  /// Получение статистики использования
  Map<String, dynamic> getUsageStats() {
    final totalPlayCount = _contentLibrary.fold<int>(
      0,
      (sum, content) => sum + content.playCount,
    );

    final mostPlayedContent = _contentLibrary.isNotEmpty
        ? _contentLibrary.reduce((a, b) => a.playCount > b.playCount ? a : b)
        : null;

    return {
      'totalContent': _contentLibrary.length,
      'totalPlaylists': _playlists.length,
      'totalPlayCount': totalPlayCount,
      'mostPlayedContent': mostPlayedContent?.toJson(),
      'currentPlayback': _playbackState.toJson(),
    };
  }

  @override
  void dispose() {
    _playbackController.close();
    super.dispose();
  }
}
