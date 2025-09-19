// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectionContent _$ProjectionContentFromJson(Map<String, dynamic> json) {
  return _ProjectionContent.fromJson(json);
}

/// @nodoc
mixin _$ProjectionContent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  ContentType get type => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  ProjectionFormat get format => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastPlayed => throw _privateConstructorUsedError;
  int get playCount => throw _privateConstructorUsedError;
  double get defaultVolume => throw _privateConstructorUsedError;
  double get defaultBrightness => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectionContentCopyWith<ProjectionContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectionContentCopyWith<$Res> {
  factory $ProjectionContentCopyWith(
          ProjectionContent value, $Res Function(ProjectionContent) then) =
      _$ProjectionContentCopyWithImpl<$Res, ProjectionContent>;
  @useResult
  $Res call(
      {String id,
      String name,
      String filePath,
      ContentType type,
      Duration duration,
      String? description,
      List<String> tags,
      ProjectionFormat format,
      String? thumbnailPath,
      DateTime? createdAt,
      DateTime? lastPlayed,
      int playCount,
      double defaultVolume,
      double defaultBrightness,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ProjectionContentCopyWithImpl<$Res, $Val extends ProjectionContent>
    implements $ProjectionContentCopyWith<$Res> {
  _$ProjectionContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? type = null,
    Object? duration = null,
    Object? description = freezed,
    Object? tags = null,
    Object? format = null,
    Object? thumbnailPath = freezed,
    Object? createdAt = freezed,
    Object? lastPlayed = freezed,
    Object? playCount = null,
    Object? defaultVolume = null,
    Object? defaultBrightness = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ProjectionFormat,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPlayed: freezed == lastPlayed
          ? _value.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      defaultVolume: null == defaultVolume
          ? _value.defaultVolume
          : defaultVolume // ignore: cast_nullable_to_non_nullable
              as double,
      defaultBrightness: null == defaultBrightness
          ? _value.defaultBrightness
          : defaultBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectionContentImplCopyWith<$Res>
    implements $ProjectionContentCopyWith<$Res> {
  factory _$$ProjectionContentImplCopyWith(_$ProjectionContentImpl value,
          $Res Function(_$ProjectionContentImpl) then) =
      __$$ProjectionContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String filePath,
      ContentType type,
      Duration duration,
      String? description,
      List<String> tags,
      ProjectionFormat format,
      String? thumbnailPath,
      DateTime? createdAt,
      DateTime? lastPlayed,
      int playCount,
      double defaultVolume,
      double defaultBrightness,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ProjectionContentImplCopyWithImpl<$Res>
    extends _$ProjectionContentCopyWithImpl<$Res, _$ProjectionContentImpl>
    implements _$$ProjectionContentImplCopyWith<$Res> {
  __$$ProjectionContentImplCopyWithImpl(_$ProjectionContentImpl _value,
      $Res Function(_$ProjectionContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? type = null,
    Object? duration = null,
    Object? description = freezed,
    Object? tags = null,
    Object? format = null,
    Object? thumbnailPath = freezed,
    Object? createdAt = freezed,
    Object? lastPlayed = freezed,
    Object? playCount = null,
    Object? defaultVolume = null,
    Object? defaultBrightness = null,
    Object? metadata = freezed,
  }) {
    return _then(_$ProjectionContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ProjectionFormat,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPlayed: freezed == lastPlayed
          ? _value.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      defaultVolume: null == defaultVolume
          ? _value.defaultVolume
          : defaultVolume // ignore: cast_nullable_to_non_nullable
              as double,
      defaultBrightness: null == defaultBrightness
          ? _value.defaultBrightness
          : defaultBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectionContentImpl implements _ProjectionContent {
  const _$ProjectionContentImpl(
      {required this.id,
      required this.name,
      required this.filePath,
      required this.type,
      required this.duration,
      this.description,
      final List<String> tags = const [],
      this.format = ProjectionFormat.equirectangular,
      this.thumbnailPath,
      this.createdAt,
      this.lastPlayed,
      this.playCount = 0,
      this.defaultVolume = 1.0,
      this.defaultBrightness = 1.0,
      final Map<String, dynamic>? metadata})
      : _tags = tags,
        _metadata = metadata;

  factory _$ProjectionContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectionContentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String filePath;
  @override
  final ContentType type;
  @override
  final Duration duration;
  @override
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final ProjectionFormat format;
  @override
  final String? thumbnailPath;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastPlayed;
  @override
  @JsonKey()
  final int playCount;
  @override
  @JsonKey()
  final double defaultVolume;
  @override
  @JsonKey()
  final double defaultBrightness;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ProjectionContent(id: $id, name: $name, filePath: $filePath, type: $type, duration: $duration, description: $description, tags: $tags, format: $format, thumbnailPath: $thumbnailPath, createdAt: $createdAt, lastPlayed: $lastPlayed, playCount: $playCount, defaultVolume: $defaultVolume, defaultBrightness: $defaultBrightness, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectionContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastPlayed, lastPlayed) ||
                other.lastPlayed == lastPlayed) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount) &&
            (identical(other.defaultVolume, defaultVolume) ||
                other.defaultVolume == defaultVolume) &&
            (identical(other.defaultBrightness, defaultBrightness) ||
                other.defaultBrightness == defaultBrightness) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      filePath,
      type,
      duration,
      description,
      const DeepCollectionEquality().hash(_tags),
      format,
      thumbnailPath,
      createdAt,
      lastPlayed,
      playCount,
      defaultVolume,
      defaultBrightness,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectionContentImplCopyWith<_$ProjectionContentImpl> get copyWith =>
      __$$ProjectionContentImplCopyWithImpl<_$ProjectionContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectionContentImplToJson(
      this,
    );
  }
}

abstract class _ProjectionContent implements ProjectionContent {
  const factory _ProjectionContent(
      {required final String id,
      required final String name,
      required final String filePath,
      required final ContentType type,
      required final Duration duration,
      final String? description,
      final List<String> tags,
      final ProjectionFormat format,
      final String? thumbnailPath,
      final DateTime? createdAt,
      final DateTime? lastPlayed,
      final int playCount,
      final double defaultVolume,
      final double defaultBrightness,
      final Map<String, dynamic>? metadata}) = _$ProjectionContentImpl;

  factory _ProjectionContent.fromJson(Map<String, dynamic> json) =
      _$ProjectionContentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get filePath;
  @override
  ContentType get type;
  @override
  Duration get duration;
  @override
  String? get description;
  @override
  List<String> get tags;
  @override
  ProjectionFormat get format;
  @override
  String? get thumbnailPath;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastPlayed;
  @override
  int get playCount;
  @override
  double get defaultVolume;
  @override
  double get defaultBrightness;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ProjectionContentImplCopyWith<_$ProjectionContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaybackState _$PlaybackStateFromJson(Map<String, dynamic> json) {
  return _PlaybackState.fromJson(json);
}

/// @nodoc
mixin _$PlaybackState {
  PlaybackStatus get status => throw _privateConstructorUsedError;
  String? get currentContentId => throw _privateConstructorUsedError;
  String? get currentPlaylistId => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  double get speed => throw _privateConstructorUsedError;
  bool get isLooping => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaybackStateCopyWith<PlaybackState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackStateCopyWith<$Res> {
  factory $PlaybackStateCopyWith(
          PlaybackState value, $Res Function(PlaybackState) then) =
      _$PlaybackStateCopyWithImpl<$Res, PlaybackState>;
  @useResult
  $Res call(
      {PlaybackStatus status,
      String? currentContentId,
      String? currentPlaylistId,
      Duration position,
      Duration? duration,
      double volume,
      double speed,
      bool isLooping,
      bool isMuted,
      String? error});
}

/// @nodoc
class _$PlaybackStateCopyWithImpl<$Res, $Val extends PlaybackState>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentContentId = freezed,
    Object? currentPlaylistId = freezed,
    Object? position = null,
    Object? duration = freezed,
    Object? volume = null,
    Object? speed = null,
    Object? isLooping = null,
    Object? isMuted = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlaybackStatus,
      currentContentId: freezed == currentContentId
          ? _value.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPlaylistId: freezed == currentPlaylistId
          ? _value.currentPlaylistId
          : currentPlaylistId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isLooping: null == isLooping
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaybackStateImplCopyWith<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  factory _$$PlaybackStateImplCopyWith(
          _$PlaybackStateImpl value, $Res Function(_$PlaybackStateImpl) then) =
      __$$PlaybackStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PlaybackStatus status,
      String? currentContentId,
      String? currentPlaylistId,
      Duration position,
      Duration? duration,
      double volume,
      double speed,
      bool isLooping,
      bool isMuted,
      String? error});
}

/// @nodoc
class __$$PlaybackStateImplCopyWithImpl<$Res>
    extends _$PlaybackStateCopyWithImpl<$Res, _$PlaybackStateImpl>
    implements _$$PlaybackStateImplCopyWith<$Res> {
  __$$PlaybackStateImplCopyWithImpl(
      _$PlaybackStateImpl _value, $Res Function(_$PlaybackStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentContentId = freezed,
    Object? currentPlaylistId = freezed,
    Object? position = null,
    Object? duration = freezed,
    Object? volume = null,
    Object? speed = null,
    Object? isLooping = null,
    Object? isMuted = null,
    Object? error = freezed,
  }) {
    return _then(_$PlaybackStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlaybackStatus,
      currentContentId: freezed == currentContentId
          ? _value.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPlaylistId: freezed == currentPlaylistId
          ? _value.currentPlaylistId
          : currentPlaylistId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isLooping: null == isLooping
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybackStateImpl implements _PlaybackState {
  const _$PlaybackStateImpl(
      {this.status = PlaybackStatus.stopped,
      this.currentContentId,
      this.currentPlaylistId,
      this.position = Duration.zero,
      this.duration,
      this.volume = 0.5,
      this.speed = 1.0,
      this.isLooping = false,
      this.isMuted = false,
      this.error});

  factory _$PlaybackStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybackStateImplFromJson(json);

  @override
  @JsonKey()
  final PlaybackStatus status;
  @override
  final String? currentContentId;
  @override
  final String? currentPlaylistId;
  @override
  @JsonKey()
  final Duration position;
  @override
  final Duration? duration;
  @override
  @JsonKey()
  final double volume;
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final bool isLooping;
  @override
  @JsonKey()
  final bool isMuted;
  @override
  final String? error;

  @override
  String toString() {
    return 'PlaybackState(status: $status, currentContentId: $currentContentId, currentPlaylistId: $currentPlaylistId, position: $position, duration: $duration, volume: $volume, speed: $speed, isLooping: $isLooping, isMuted: $isMuted, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybackStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentContentId, currentContentId) ||
                other.currentContentId == currentContentId) &&
            (identical(other.currentPlaylistId, currentPlaylistId) ||
                other.currentPlaylistId == currentPlaylistId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.isLooping, isLooping) ||
                other.isLooping == isLooping) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      currentContentId,
      currentPlaylistId,
      position,
      duration,
      volume,
      speed,
      isLooping,
      isMuted,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybackStateImplCopyWith<_$PlaybackStateImpl> get copyWith =>
      __$$PlaybackStateImplCopyWithImpl<_$PlaybackStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybackStateImplToJson(
      this,
    );
  }
}

abstract class _PlaybackState implements PlaybackState {
  const factory _PlaybackState(
      {final PlaybackStatus status,
      final String? currentContentId,
      final String? currentPlaylistId,
      final Duration position,
      final Duration? duration,
      final double volume,
      final double speed,
      final bool isLooping,
      final bool isMuted,
      final String? error}) = _$PlaybackStateImpl;

  factory _PlaybackState.fromJson(Map<String, dynamic> json) =
      _$PlaybackStateImpl.fromJson;

  @override
  PlaybackStatus get status;
  @override
  String? get currentContentId;
  @override
  String? get currentPlaylistId;
  @override
  Duration get position;
  @override
  Duration? get duration;
  @override
  double get volume;
  @override
  double get speed;
  @override
  bool get isLooping;
  @override
  bool get isMuted;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$PlaybackStateImplCopyWith<_$PlaybackStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return _Playlist.fromJson(json);
}

/// @nodoc
mixin _$Playlist {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get contentIds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastModified => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  PlaylistMode get mode => throw _privateConstructorUsedError;
  bool get isLooping => throw _privateConstructorUsedError;
  bool get isShuffled => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaylistCopyWith<Playlist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistCopyWith<$Res> {
  factory $PlaylistCopyWith(Playlist value, $Res Function(Playlist) then) =
      _$PlaylistCopyWithImpl<$Res, Playlist>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> contentIds,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? lastModified,
      int currentIndex,
      PlaylistMode mode,
      bool isLooping,
      bool isShuffled,
      String? description,
      List<String> tags});
}

/// @nodoc
class _$PlaylistCopyWithImpl<$Res, $Val extends Playlist>
    implements $PlaylistCopyWith<$Res> {
  _$PlaylistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contentIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastModified = freezed,
    Object? currentIndex = null,
    Object? mode = null,
    Object? isLooping = null,
    Object? isShuffled = null,
    Object? description = freezed,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _value.contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PlaylistMode,
      isLooping: null == isLooping
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffled: null == isShuffled
          ? _value.isShuffled
          : isShuffled // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaylistImplCopyWith<$Res>
    implements $PlaylistCopyWith<$Res> {
  factory _$$PlaylistImplCopyWith(
          _$PlaylistImpl value, $Res Function(_$PlaylistImpl) then) =
      __$$PlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> contentIds,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? lastModified,
      int currentIndex,
      PlaylistMode mode,
      bool isLooping,
      bool isShuffled,
      String? description,
      List<String> tags});
}

/// @nodoc
class __$$PlaylistImplCopyWithImpl<$Res>
    extends _$PlaylistCopyWithImpl<$Res, _$PlaylistImpl>
    implements _$$PlaylistImplCopyWith<$Res> {
  __$$PlaylistImplCopyWithImpl(
      _$PlaylistImpl _value, $Res Function(_$PlaylistImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contentIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastModified = freezed,
    Object? currentIndex = null,
    Object? mode = null,
    Object? isLooping = null,
    Object? isShuffled = null,
    Object? description = freezed,
    Object? tags = null,
  }) {
    return _then(_$PlaylistImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _value._contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PlaylistMode,
      isLooping: null == isLooping
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffled: null == isShuffled
          ? _value.isShuffled
          : isShuffled // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaylistImpl implements _Playlist {
  const _$PlaylistImpl(
      {required this.id,
      required this.name,
      required final List<String> contentIds,
      required this.createdAt,
      required this.updatedAt,
      this.lastModified,
      this.currentIndex = 0,
      this.mode = PlaylistMode.sequential,
      this.isLooping = false,
      this.isShuffled = false,
      this.description,
      final List<String> tags = const []})
      : _contentIds = contentIds,
        _tags = tags;

  factory _$PlaylistImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaylistImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _contentIds;
  @override
  List<String> get contentIds {
    if (_contentIds is EqualUnmodifiableListView) return _contentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentIds);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? lastModified;
  @override
  @JsonKey()
  final int currentIndex;
  @override
  @JsonKey()
  final PlaylistMode mode;
  @override
  @JsonKey()
  final bool isLooping;
  @override
  @JsonKey()
  final bool isShuffled;
  @override
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, contentIds: $contentIds, createdAt: $createdAt, updatedAt: $updatedAt, lastModified: $lastModified, currentIndex: $currentIndex, mode: $mode, isLooping: $isLooping, isShuffled: $isShuffled, description: $description, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._contentIds, _contentIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.isLooping, isLooping) ||
                other.isLooping == isLooping) &&
            (identical(other.isShuffled, isShuffled) ||
                other.isShuffled == isShuffled) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_contentIds),
      createdAt,
      updatedAt,
      lastModified,
      currentIndex,
      mode,
      isLooping,
      isShuffled,
      description,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      __$$PlaylistImplCopyWithImpl<_$PlaylistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaylistImplToJson(
      this,
    );
  }
}

abstract class _Playlist implements Playlist {
  const factory _Playlist(
      {required final String id,
      required final String name,
      required final List<String> contentIds,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? lastModified,
      final int currentIndex,
      final PlaylistMode mode,
      final bool isLooping,
      final bool isShuffled,
      final String? description,
      final List<String> tags}) = _$PlaylistImpl;

  factory _Playlist.fromJson(Map<String, dynamic> json) =
      _$PlaylistImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get contentIds;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get lastModified;
  @override
  int get currentIndex;
  @override
  PlaylistMode get mode;
  @override
  bool get isLooping;
  @override
  bool get isShuffled;
  @override
  String? get description;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InteractiveContent _$InteractiveContentFromJson(Map<String, dynamic> json) {
  return _InteractiveContent.fromJson(json);
}

/// @nodoc
mixin _$InteractiveContent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get appName => throw _privateConstructorUsedError;
  Map<String, dynamic> get appData => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InteractiveContentCopyWith<InteractiveContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractiveContentCopyWith<$Res> {
  factory $InteractiveContentCopyWith(
          InteractiveContent value, $Res Function(InteractiveContent) then) =
      _$InteractiveContentCopyWithImpl<$Res, InteractiveContent>;
  @useResult
  $Res call(
      {String id,
      String name,
      String appName,
      Map<String, dynamic> appData,
      String? description,
      List<String> tags,
      DateTime? createdAt});
}

/// @nodoc
class _$InteractiveContentCopyWithImpl<$Res, $Val extends InteractiveContent>
    implements $InteractiveContentCopyWith<$Res> {
  _$InteractiveContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? appName = null,
    Object? appData = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appData: null == appData
          ? _value.appData
          : appData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InteractiveContentImplCopyWith<$Res>
    implements $InteractiveContentCopyWith<$Res> {
  factory _$$InteractiveContentImplCopyWith(_$InteractiveContentImpl value,
          $Res Function(_$InteractiveContentImpl) then) =
      __$$InteractiveContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String appName,
      Map<String, dynamic> appData,
      String? description,
      List<String> tags,
      DateTime? createdAt});
}

/// @nodoc
class __$$InteractiveContentImplCopyWithImpl<$Res>
    extends _$InteractiveContentCopyWithImpl<$Res, _$InteractiveContentImpl>
    implements _$$InteractiveContentImplCopyWith<$Res> {
  __$$InteractiveContentImplCopyWithImpl(_$InteractiveContentImpl _value,
      $Res Function(_$InteractiveContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? appName = null,
    Object? appData = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$InteractiveContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appData: null == appData
          ? _value._appData
          : appData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InteractiveContentImpl implements _InteractiveContent {
  const _$InteractiveContentImpl(
      {required this.id,
      required this.name,
      required this.appName,
      required final Map<String, dynamic> appData,
      this.description,
      final List<String> tags = const [],
      this.createdAt})
      : _appData = appData,
        _tags = tags;

  factory _$InteractiveContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$InteractiveContentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String appName;
  final Map<String, dynamic> _appData;
  @override
  Map<String, dynamic> get appData {
    if (_appData is EqualUnmodifiableMapView) return _appData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_appData);
  }

  @override
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'InteractiveContent(id: $id, name: $name, appName: $appName, appData: $appData, description: $description, tags: $tags, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InteractiveContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            const DeepCollectionEquality().equals(other._appData, _appData) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      appName,
      const DeepCollectionEquality().hash(_appData),
      description,
      const DeepCollectionEquality().hash(_tags),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InteractiveContentImplCopyWith<_$InteractiveContentImpl> get copyWith =>
      __$$InteractiveContentImplCopyWithImpl<_$InteractiveContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InteractiveContentImplToJson(
      this,
    );
  }
}

abstract class _InteractiveContent implements InteractiveContent {
  const factory _InteractiveContent(
      {required final String id,
      required final String name,
      required final String appName,
      required final Map<String, dynamic> appData,
      final String? description,
      final List<String> tags,
      final DateTime? createdAt}) = _$InteractiveContentImpl;

  factory _InteractiveContent.fromJson(Map<String, dynamic> json) =
      _$InteractiveContentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get appName;
  @override
  Map<String, dynamic> get appData;
  @override
  String? get description;
  @override
  List<String> get tags;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$InteractiveContentImplCopyWith<_$InteractiveContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RealtimeContent _$RealtimeContentFromJson(Map<String, dynamic> json) {
  return _RealtimeContent.fromJson(json);
}

/// @nodoc
mixin _$RealtimeContent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sourceType => throw _privateConstructorUsedError;
  Map<String, dynamic> get sourceConfig => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RealtimeContentCopyWith<RealtimeContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealtimeContentCopyWith<$Res> {
  factory $RealtimeContentCopyWith(
          RealtimeContent value, $Res Function(RealtimeContent) then) =
      _$RealtimeContentCopyWithImpl<$Res, RealtimeContent>;
  @useResult
  $Res call(
      {String id,
      String name,
      String sourceType,
      Map<String, dynamic> sourceConfig,
      String? description,
      List<String> tags});
}

/// @nodoc
class _$RealtimeContentCopyWithImpl<$Res, $Val extends RealtimeContent>
    implements $RealtimeContentCopyWith<$Res> {
  _$RealtimeContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sourceType = null,
    Object? sourceConfig = null,
    Object? description = freezed,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceConfig: null == sourceConfig
          ? _value.sourceConfig
          : sourceConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RealtimeContentImplCopyWith<$Res>
    implements $RealtimeContentCopyWith<$Res> {
  factory _$$RealtimeContentImplCopyWith(_$RealtimeContentImpl value,
          $Res Function(_$RealtimeContentImpl) then) =
      __$$RealtimeContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String sourceType,
      Map<String, dynamic> sourceConfig,
      String? description,
      List<String> tags});
}

/// @nodoc
class __$$RealtimeContentImplCopyWithImpl<$Res>
    extends _$RealtimeContentCopyWithImpl<$Res, _$RealtimeContentImpl>
    implements _$$RealtimeContentImplCopyWith<$Res> {
  __$$RealtimeContentImplCopyWithImpl(
      _$RealtimeContentImpl _value, $Res Function(_$RealtimeContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sourceType = null,
    Object? sourceConfig = null,
    Object? description = freezed,
    Object? tags = null,
  }) {
    return _then(_$RealtimeContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceConfig: null == sourceConfig
          ? _value._sourceConfig
          : sourceConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RealtimeContentImpl implements _RealtimeContent {
  const _$RealtimeContentImpl(
      {required this.id,
      required this.name,
      required this.sourceType,
      required final Map<String, dynamic> sourceConfig,
      this.description,
      final List<String> tags = const []})
      : _sourceConfig = sourceConfig,
        _tags = tags;

  factory _$RealtimeContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RealtimeContentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String sourceType;
  final Map<String, dynamic> _sourceConfig;
  @override
  Map<String, dynamic> get sourceConfig {
    if (_sourceConfig is EqualUnmodifiableMapView) return _sourceConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sourceConfig);
  }

  @override
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'RealtimeContent(id: $id, name: $name, sourceType: $sourceType, sourceConfig: $sourceConfig, description: $description, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealtimeContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            const DeepCollectionEquality()
                .equals(other._sourceConfig, _sourceConfig) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      sourceType,
      const DeepCollectionEquality().hash(_sourceConfig),
      description,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RealtimeContentImplCopyWith<_$RealtimeContentImpl> get copyWith =>
      __$$RealtimeContentImplCopyWithImpl<_$RealtimeContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RealtimeContentImplToJson(
      this,
    );
  }
}

abstract class _RealtimeContent implements RealtimeContent {
  const factory _RealtimeContent(
      {required final String id,
      required final String name,
      required final String sourceType,
      required final Map<String, dynamic> sourceConfig,
      final String? description,
      final List<String> tags}) = _$RealtimeContentImpl;

  factory _RealtimeContent.fromJson(Map<String, dynamic> json) =
      _$RealtimeContentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get sourceType;
  @override
  Map<String, dynamic> get sourceConfig;
  @override
  String? get description;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$RealtimeContentImplCopyWith<_$RealtimeContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentLibrary _$ContentLibraryFromJson(Map<String, dynamic> json) {
  return _ContentLibrary.fromJson(json);
}

/// @nodoc
mixin _$ContentLibrary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get contentIds => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentLibraryCopyWith<ContentLibrary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentLibraryCopyWith<$Res> {
  factory $ContentLibraryCopyWith(
          ContentLibrary value, $Res Function(ContentLibrary) then) =
      _$ContentLibraryCopyWithImpl<$Res, ContentLibrary>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> contentIds,
      String? description,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ContentLibraryCopyWithImpl<$Res, $Val extends ContentLibrary>
    implements $ContentLibraryCopyWith<$Res> {
  _$ContentLibraryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contentIds = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _value.contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentLibraryImplCopyWith<$Res>
    implements $ContentLibraryCopyWith<$Res> {
  factory _$$ContentLibraryImplCopyWith(_$ContentLibraryImpl value,
          $Res Function(_$ContentLibraryImpl) then) =
      __$$ContentLibraryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> contentIds,
      String? description,
      List<String> tags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ContentLibraryImplCopyWithImpl<$Res>
    extends _$ContentLibraryCopyWithImpl<$Res, _$ContentLibraryImpl>
    implements _$$ContentLibraryImplCopyWith<$Res> {
  __$$ContentLibraryImplCopyWithImpl(
      _$ContentLibraryImpl _value, $Res Function(_$ContentLibraryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contentIds = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ContentLibraryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _value._contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentLibraryImpl implements _ContentLibrary {
  const _$ContentLibraryImpl(
      {required this.id,
      required this.name,
      required final List<String> contentIds,
      this.description,
      final List<String> tags = const [],
      this.createdAt,
      this.updatedAt})
      : _contentIds = contentIds,
        _tags = tags;

  factory _$ContentLibraryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentLibraryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _contentIds;
  @override
  List<String> get contentIds {
    if (_contentIds is EqualUnmodifiableListView) return _contentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentIds);
  }

  @override
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ContentLibrary(id: $id, name: $name, contentIds: $contentIds, description: $description, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentLibraryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._contentIds, _contentIds) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_contentIds),
      description,
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentLibraryImplCopyWith<_$ContentLibraryImpl> get copyWith =>
      __$$ContentLibraryImplCopyWithImpl<_$ContentLibraryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentLibraryImplToJson(
      this,
    );
  }
}

abstract class _ContentLibrary implements ContentLibrary {
  const factory _ContentLibrary(
      {required final String id,
      required final String name,
      required final List<String> contentIds,
      final String? description,
      final List<String> tags,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ContentLibraryImpl;

  factory _ContentLibrary.fromJson(Map<String, dynamic> json) =
      _$ContentLibraryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get contentIds;
  @override
  String? get description;
  @override
  List<String> get tags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ContentLibraryImplCopyWith<_$ContentLibraryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
