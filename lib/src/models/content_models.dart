import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_models.freezed.dart';
part 'content_models.g.dart';

/// Типы контента FreeDome
enum ContentType {
  video, // Видео файлы
  image, // Изображения
  interactive, // Интерактивный контент
  realtime, // Контент в реальном времени
  audio, // Аудио файлы
  procedural, // Процедурно генерируемый контент
}

/// Форматы проекции
enum ProjectionFormat {
  equirectangular, // Равнопромежуточная проекция
  fisheye, // Рыбий глаз
  cubemap, // Кубическая карта
  domemaster, // DomeMaster формат
  fulldome, // FullDome формат
  spherical, // Сферическая проекция
  cylindrical, // Цилиндрическая проекция
}

/// Статусы воспроизведения
enum PlaybackStatus {
  stopped, // Остановлено
  playing, // Воспроизводится
  paused, // На паузе
  buffering, // Буферизация
  error, // Ошибка
}

/// Режимы плейлиста
enum PlaylistMode {
  sequential, // Последовательное воспроизведение
  shuffle, // Случайное воспроизведение
  random, // Полностью случайное
}

/// Абстрактный базовый класс для контента FreeDome
abstract class FreeDomeContent {
  String get id;
  String get name;
  ContentType get type;
  Map<String, dynamic> toFreeDomeData();
}

/// Основная модель контента
@freezed
class ProjectionContent with _$ProjectionContent implements FreeDomeContent {
  const factory ProjectionContent({
    required String id,
    required String name,
    required String filePath,
    required ContentType type,
    required Duration duration,
    String? description,
    @Default([]) List<String> tags,
    @Default(ProjectionFormat.equirectangular) ProjectionFormat format,
    String? thumbnailPath,
    DateTime? createdAt,
    DateTime? lastPlayed,
    @Default(0) int playCount,
    @Default(1.0) double defaultVolume,
    @Default(1.0) double defaultBrightness,
    Map<String, dynamic>? metadata,
  }) = _ProjectionContent;

  factory ProjectionContent.fromJson(Map<String, dynamic> json) =>
      _$ProjectionContentFromJson(json);
}

/// Реализация toFreeDomeData для ProjectionContent
extension ProjectionContentFreeDome on ProjectionContent {
  @override
  Map<String, dynamic> toFreeDomeData() {
    return {
      'type': 'projection_content',
      'content': {
        'id': id,
        'name': name,
        'filePath': filePath,
        'contentType': type.name,
        'format': format.name,
        'duration': duration.inMilliseconds,
        'description': description,
        'tags': tags,
        'metadata': metadata ?? {},
      },
      'settings': {
        'volume': defaultVolume,
        'brightness': defaultBrightness,
      },
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// Состояние воспроизведения
@freezed
class PlaybackState with _$PlaybackState {
  const factory PlaybackState({
    @Default(PlaybackStatus.stopped) PlaybackStatus status,
    String? currentContentId,
    String? currentPlaylistId,
    @Default(Duration.zero) Duration position,
    Duration? duration,
    @Default(0.5) double volume,
    @Default(1.0) double speed,
    @Default(false) bool isLooping,
    @Default(false) bool isMuted,
    String? error,
  }) = _PlaybackState;

  factory PlaybackState.fromJson(Map<String, dynamic> json) =>
      _$PlaybackStateFromJson(json);
}

/// Плейлист
@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String name,
    required List<String> contentIds,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastModified,
    @Default(0) int currentIndex,
    @Default(PlaylistMode.sequential) PlaylistMode mode,
    @Default(false) bool isLooping,
    @Default(false) bool isShuffled,
    String? description,
    @Default([]) List<String> tags,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
}

/// Интерактивный контент (для приложений)
@freezed
class InteractiveContent with _$InteractiveContent implements FreeDomeContent {
  const factory InteractiveContent({
    required String id,
    required String name,
    required String appName,
    required Map<String, dynamic> appData,
    String? description,
    @Default([]) List<String> tags,
    DateTime? createdAt,
  }) = _InteractiveContent;

  factory InteractiveContent.fromJson(Map<String, dynamic> json) =>
      _$InteractiveContentFromJson(json);
}

/// Реализация toFreeDomeData для InteractiveContent
extension InteractiveContentFreeDome on InteractiveContent {
  @override
  ContentType get type => ContentType.interactive;

  @override
  Map<String, dynamic> toFreeDomeData() {
    return {
      'type': 'interactive_content',
      'app': {
        'name': appName,
        'contentId': id,
        'contentName': name,
        'data': appData,
      },
      'metadata': {
        'description': description,
        'tags': tags,
        'createdAt': createdAt?.toIso8601String(),
      },
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// Контент в реальном времени
@freezed
class RealtimeContent with _$RealtimeContent implements FreeDomeContent {
  const factory RealtimeContent({
    required String id,
    required String name,
    required String sourceType,
    required Map<String, dynamic> sourceConfig,
    String? description,
    @Default([]) List<String> tags,
  }) = _RealtimeContent;

  factory RealtimeContent.fromJson(Map<String, dynamic> json) =>
      _$RealtimeContentFromJson(json);
}

/// Реализация toFreeDomeData для RealtimeContent
extension RealtimeContentFreeDome on RealtimeContent {
  @override
  ContentType get type => ContentType.realtime;

  @override
  Map<String, dynamic> toFreeDomeData() {
    return {
      'type': 'realtime_content',
      'source': {
        'type': sourceType,
        'config': sourceConfig,
        'contentId': id,
        'contentName': name,
      },
      'metadata': {
        'description': description,
        'tags': tags,
      },
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// Библиотека контента
@freezed
class ContentLibrary with _$ContentLibrary {
  const factory ContentLibrary({
    required String id,
    required String name,
    required List<String> contentIds,
    String? description,
    @Default([]) List<String> tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ContentLibrary;

  factory ContentLibrary.fromJson(Map<String, dynamic> json) =>
      _$ContentLibraryFromJson(json);
}

/// Расширения для типов контента
extension ContentTypeExtension on ContentType {
  String get displayName {
    switch (this) {
      case ContentType.video:
        return 'Видео';
      case ContentType.image:
        return 'Изображение';
      case ContentType.interactive:
        return 'Интерактивный';
      case ContentType.realtime:
        return 'В реальном времени';
      case ContentType.audio:
        return 'Аудио';
      case ContentType.procedural:
        return 'Процедурный';
    }
  }

  String get fileExtensions {
    switch (this) {
      case ContentType.video:
        return 'mp4, mov, avi, mkv';
      case ContentType.image:
        return 'jpg, png, tiff, exr';
      case ContentType.interactive:
        return 'app, unity, web';
      case ContentType.realtime:
        return 'stream, rtmp, webrtc';
      case ContentType.audio:
        return 'wav, mp3, flac, ogg';
      case ContentType.procedural:
        return 'shader, script, algorithm';
    }
  }
}

/// Расширения для форматов проекции
extension ProjectionFormatExtension on ProjectionFormat {
  String get displayName {
    switch (this) {
      case ProjectionFormat.equirectangular:
        return 'Равнопромежуточная';
      case ProjectionFormat.fisheye:
        return 'Рыбий глаз';
      case ProjectionFormat.cubemap:
        return 'Кубическая карта';
      case ProjectionFormat.domemaster:
        return 'DomeMaster';
      case ProjectionFormat.fulldome:
        return 'FullDome';
      case ProjectionFormat.spherical:
        return 'Сферическая';
      case ProjectionFormat.cylindrical:
        return 'Цилиндрическая';
    }
  }

  bool get supportsInteraction {
    switch (this) {
      case ProjectionFormat.equirectangular:
      case ProjectionFormat.spherical:
        return true;
      default:
        return false;
    }
  }
}
