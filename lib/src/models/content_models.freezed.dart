// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectionContent {
  String get id;
  String get name;
  String get filePath;
  ContentType get type;
  Duration get duration;
  String? get description;
  List<String> get tags;
  ProjectionFormat get format;
  String? get thumbnailPath;
  DateTime? get createdAt;
  DateTime? get lastPlayed;
  int get playCount;
  double get defaultVolume;
  double get defaultBrightness;
  Map<String, dynamic>? get metadata;

  /// Create a copy of ProjectionContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProjectionContentCopyWith<ProjectionContent> get copyWith =>
      _$ProjectionContentCopyWithImpl<ProjectionContent>(
          this as ProjectionContent, _$identity);

  /// Serializes this ProjectionContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProjectionContent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
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
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      filePath,
      type,
      duration,
      description,
      const DeepCollectionEquality().hash(tags),
      format,
      thumbnailPath,
      createdAt,
      lastPlayed,
      playCount,
      defaultVolume,
      defaultBrightness,
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'ProjectionContent(id: $id, name: $name, filePath: $filePath, type: $type, duration: $duration, description: $description, tags: $tags, format: $format, thumbnailPath: $thumbnailPath, createdAt: $createdAt, lastPlayed: $lastPlayed, playCount: $playCount, defaultVolume: $defaultVolume, defaultBrightness: $defaultBrightness, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $ProjectionContentCopyWith<$Res> {
  factory $ProjectionContentCopyWith(
          ProjectionContent value, $Res Function(ProjectionContent) _then) =
      _$ProjectionContentCopyWithImpl;
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
class _$ProjectionContentCopyWithImpl<$Res>
    implements $ProjectionContentCopyWith<$Res> {
  _$ProjectionContentCopyWithImpl(this._self, this._then);

  final ProjectionContent _self;
  final $Res Function(ProjectionContent) _then;

  /// Create a copy of ProjectionContent
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as ProjectionFormat,
      thumbnailPath: freezed == thumbnailPath
          ? _self.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPlayed: freezed == lastPlayed
          ? _self.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      playCount: null == playCount
          ? _self.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      defaultVolume: null == defaultVolume
          ? _self.defaultVolume
          : defaultVolume // ignore: cast_nullable_to_non_nullable
              as double,
      defaultBrightness: null == defaultBrightness
          ? _self.defaultBrightness
          : defaultBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProjectionContent].
extension ProjectionContentPatterns on ProjectionContent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ProjectionContent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProjectionContent() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ProjectionContent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectionContent():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ProjectionContent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectionContent() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
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
            Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProjectionContent() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.filePath,
            _that.type,
            _that.duration,
            _that.description,
            _that.tags,
            _that.format,
            _that.thumbnailPath,
            _that.createdAt,
            _that.lastPlayed,
            _that.playCount,
            _that.defaultVolume,
            _that.defaultBrightness,
            _that.metadata);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
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
            Map<String, dynamic>? metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectionContent():
        return $default(
            _that.id,
            _that.name,
            _that.filePath,
            _that.type,
            _that.duration,
            _that.description,
            _that.tags,
            _that.format,
            _that.thumbnailPath,
            _that.createdAt,
            _that.lastPlayed,
            _that.playCount,
            _that.defaultVolume,
            _that.defaultBrightness,
            _that.metadata);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
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
            Map<String, dynamic>? metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectionContent() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.filePath,
            _that.type,
            _that.duration,
            _that.description,
            _that.tags,
            _that.format,
            _that.thumbnailPath,
            _that.createdAt,
            _that.lastPlayed,
            _that.playCount,
            _that.defaultVolume,
            _that.defaultBrightness,
            _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProjectionContent implements ProjectionContent {
  const _ProjectionContent(
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
  factory _ProjectionContent.fromJson(Map<String, dynamic> json) =>
      _$ProjectionContentFromJson(json);

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

  /// Create a copy of ProjectionContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProjectionContentCopyWith<_ProjectionContent> get copyWith =>
      __$ProjectionContentCopyWithImpl<_ProjectionContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProjectionContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectionContent &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'ProjectionContent(id: $id, name: $name, filePath: $filePath, type: $type, duration: $duration, description: $description, tags: $tags, format: $format, thumbnailPath: $thumbnailPath, createdAt: $createdAt, lastPlayed: $lastPlayed, playCount: $playCount, defaultVolume: $defaultVolume, defaultBrightness: $defaultBrightness, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$ProjectionContentCopyWith<$Res>
    implements $ProjectionContentCopyWith<$Res> {
  factory _$ProjectionContentCopyWith(
          _ProjectionContent value, $Res Function(_ProjectionContent) _then) =
      __$ProjectionContentCopyWithImpl;
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
class __$ProjectionContentCopyWithImpl<$Res>
    implements _$ProjectionContentCopyWith<$Res> {
  __$ProjectionContentCopyWithImpl(this._self, this._then);

  final _ProjectionContent _self;
  final $Res Function(_ProjectionContent) _then;

  /// Create a copy of ProjectionContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ProjectionContent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as ProjectionFormat,
      thumbnailPath: freezed == thumbnailPath
          ? _self.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPlayed: freezed == lastPlayed
          ? _self.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      playCount: null == playCount
          ? _self.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      defaultVolume: null == defaultVolume
          ? _self.defaultVolume
          : defaultVolume // ignore: cast_nullable_to_non_nullable
              as double,
      defaultBrightness: null == defaultBrightness
          ? _self.defaultBrightness
          : defaultBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: freezed == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$PlaybackState {
  PlaybackStatus get status;
  String? get currentContentId;
  String? get currentPlaylistId;
  Duration get position;
  Duration? get duration;
  double get volume;
  double get speed;
  bool get isLooping;
  bool get isMuted;
  String? get error;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlaybackStateCopyWith<PlaybackState> get copyWith =>
      _$PlaybackStateCopyWithImpl<PlaybackState>(
          this as PlaybackState, _$identity);

  /// Serializes this PlaybackState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlaybackState &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'PlaybackState(status: $status, currentContentId: $currentContentId, currentPlaylistId: $currentPlaylistId, position: $position, duration: $duration, volume: $volume, speed: $speed, isLooping: $isLooping, isMuted: $isMuted, error: $error)';
  }
}

/// @nodoc
abstract mixin class $PlaybackStateCopyWith<$Res> {
  factory $PlaybackStateCopyWith(
          PlaybackState value, $Res Function(PlaybackState) _then) =
      _$PlaybackStateCopyWithImpl;
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
class _$PlaybackStateCopyWithImpl<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._self, this._then);

  final PlaybackState _self;
  final $Res Function(PlaybackState) _then;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlaybackStatus,
      currentContentId: freezed == currentContentId
          ? _self.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPlaylistId: freezed == currentPlaylistId
          ? _self.currentPlaylistId
          : currentPlaylistId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isLooping: null == isLooping
          ? _self.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _self.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlaybackState].
extension PlaybackStatePatterns on PlaybackState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PlaybackState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PlaybackState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PlaybackState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            PlaybackStatus status,
            String? currentContentId,
            String? currentPlaylistId,
            Duration position,
            Duration? duration,
            double volume,
            double speed,
            bool isLooping,
            bool isMuted,
            String? error)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(
            _that.status,
            _that.currentContentId,
            _that.currentPlaylistId,
            _that.position,
            _that.duration,
            _that.volume,
            _that.speed,
            _that.isLooping,
            _that.isMuted,
            _that.error);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            PlaybackStatus status,
            String? currentContentId,
            String? currentPlaylistId,
            Duration position,
            Duration? duration,
            double volume,
            double speed,
            bool isLooping,
            bool isMuted,
            String? error)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState():
        return $default(
            _that.status,
            _that.currentContentId,
            _that.currentPlaylistId,
            _that.position,
            _that.duration,
            _that.volume,
            _that.speed,
            _that.isLooping,
            _that.isMuted,
            _that.error);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            PlaybackStatus status,
            String? currentContentId,
            String? currentPlaylistId,
            Duration position,
            Duration? duration,
            double volume,
            double speed,
            bool isLooping,
            bool isMuted,
            String? error)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(
            _that.status,
            _that.currentContentId,
            _that.currentPlaylistId,
            _that.position,
            _that.duration,
            _that.volume,
            _that.speed,
            _that.isLooping,
            _that.isMuted,
            _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PlaybackState implements PlaybackState {
  const _PlaybackState(
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
  factory _PlaybackState.fromJson(Map<String, dynamic> json) =>
      _$PlaybackStateFromJson(json);

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

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlaybackStateCopyWith<_PlaybackState> get copyWith =>
      __$PlaybackStateCopyWithImpl<_PlaybackState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlaybackStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlaybackState &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'PlaybackState(status: $status, currentContentId: $currentContentId, currentPlaylistId: $currentPlaylistId, position: $position, duration: $duration, volume: $volume, speed: $speed, isLooping: $isLooping, isMuted: $isMuted, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$PlaybackStateCopyWith<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  factory _$PlaybackStateCopyWith(
          _PlaybackState value, $Res Function(_PlaybackState) _then) =
      __$PlaybackStateCopyWithImpl;
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
class __$PlaybackStateCopyWithImpl<$Res>
    implements _$PlaybackStateCopyWith<$Res> {
  __$PlaybackStateCopyWithImpl(this._self, this._then);

  final _PlaybackState _self;
  final $Res Function(_PlaybackState) _then;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_PlaybackState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlaybackStatus,
      currentContentId: freezed == currentContentId
          ? _self.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPlaylistId: freezed == currentPlaylistId
          ? _self.currentPlaylistId
          : currentPlaylistId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isLooping: null == isLooping
          ? _self.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _self.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Playlist {
  String get id;
  String get name;
  List<String> get contentIds;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get lastModified;
  int get currentIndex;
  PlaylistMode get mode;
  bool get isLooping;
  bool get isShuffled;
  String? get description;
  List<String> get tags;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlaylistCopyWith<Playlist> get copyWith =>
      _$PlaylistCopyWithImpl<Playlist>(this as Playlist, _$identity);

  /// Serializes this Playlist to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Playlist &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.contentIds, contentIds) &&
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
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(contentIds),
      createdAt,
      updatedAt,
      lastModified,
      currentIndex,
      mode,
      isLooping,
      isShuffled,
      description,
      const DeepCollectionEquality().hash(tags));

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, contentIds: $contentIds, createdAt: $createdAt, updatedAt: $updatedAt, lastModified: $lastModified, currentIndex: $currentIndex, mode: $mode, isLooping: $isLooping, isShuffled: $isShuffled, description: $description, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class $PlaylistCopyWith<$Res> {
  factory $PlaylistCopyWith(Playlist value, $Res Function(Playlist) _then) =
      _$PlaylistCopyWithImpl;
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
class _$PlaylistCopyWithImpl<$Res> implements $PlaylistCopyWith<$Res> {
  _$PlaylistCopyWithImpl(this._self, this._then);

  final Playlist _self;
  final $Res Function(Playlist) _then;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _self.contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastModified: freezed == lastModified
          ? _self.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentIndex: null == currentIndex
          ? _self.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PlaylistMode,
      isLooping: null == isLooping
          ? _self.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffled: null == isShuffled
          ? _self.isShuffled
          : isShuffled // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Playlist].
extension PlaylistPatterns on Playlist {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Playlist value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Playlist() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Playlist value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Playlist():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Playlist value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Playlist() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
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
            List<String> tags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Playlist() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.contentIds,
            _that.createdAt,
            _that.updatedAt,
            _that.lastModified,
            _that.currentIndex,
            _that.mode,
            _that.isLooping,
            _that.isShuffled,
            _that.description,
            _that.tags);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
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
            List<String> tags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Playlist():
        return $default(
            _that.id,
            _that.name,
            _that.contentIds,
            _that.createdAt,
            _that.updatedAt,
            _that.lastModified,
            _that.currentIndex,
            _that.mode,
            _that.isLooping,
            _that.isShuffled,
            _that.description,
            _that.tags);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
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
            List<String> tags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Playlist() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.contentIds,
            _that.createdAt,
            _that.updatedAt,
            _that.lastModified,
            _that.currentIndex,
            _that.mode,
            _that.isLooping,
            _that.isShuffled,
            _that.description,
            _that.tags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Playlist implements Playlist {
  const _Playlist(
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
  factory _Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

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

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlaylistCopyWith<_Playlist> get copyWith =>
      __$PlaylistCopyWithImpl<_Playlist>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlaylistToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Playlist &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, contentIds: $contentIds, createdAt: $createdAt, updatedAt: $updatedAt, lastModified: $lastModified, currentIndex: $currentIndex, mode: $mode, isLooping: $isLooping, isShuffled: $isShuffled, description: $description, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class _$PlaylistCopyWith<$Res>
    implements $PlaylistCopyWith<$Res> {
  factory _$PlaylistCopyWith(_Playlist value, $Res Function(_Playlist) _then) =
      __$PlaylistCopyWithImpl;
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
class __$PlaylistCopyWithImpl<$Res> implements _$PlaylistCopyWith<$Res> {
  __$PlaylistCopyWithImpl(this._self, this._then);

  final _Playlist _self;
  final $Res Function(_Playlist) _then;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Playlist(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _self._contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastModified: freezed == lastModified
          ? _self.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentIndex: null == currentIndex
          ? _self.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PlaylistMode,
      isLooping: null == isLooping
          ? _self.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffled: null == isShuffled
          ? _self.isShuffled
          : isShuffled // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$InteractiveContent {
  String get id;
  String get name;
  String get appName;
  Map<String, dynamic> get appData;
  String? get description;
  List<String> get tags;
  DateTime? get createdAt;

  /// Create a copy of InteractiveContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InteractiveContentCopyWith<InteractiveContent> get copyWith =>
      _$InteractiveContentCopyWithImpl<InteractiveContent>(
          this as InteractiveContent, _$identity);

  /// Serializes this InteractiveContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InteractiveContent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            const DeepCollectionEquality().equals(other.appData, appData) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      appName,
      const DeepCollectionEquality().hash(appData),
      description,
      const DeepCollectionEquality().hash(tags),
      createdAt);

  @override
  String toString() {
    return 'InteractiveContent(id: $id, name: $name, appName: $appName, appData: $appData, description: $description, tags: $tags, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $InteractiveContentCopyWith<$Res> {
  factory $InteractiveContentCopyWith(
          InteractiveContent value, $Res Function(InteractiveContent) _then) =
      _$InteractiveContentCopyWithImpl;
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
class _$InteractiveContentCopyWithImpl<$Res>
    implements $InteractiveContentCopyWith<$Res> {
  _$InteractiveContentCopyWithImpl(this._self, this._then);

  final InteractiveContent _self;
  final $Res Function(InteractiveContent) _then;

  /// Create a copy of InteractiveContent
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _self.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appData: null == appData
          ? _self.appData
          : appData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [InteractiveContent].
extension InteractiveContentPatterns on InteractiveContent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InteractiveContent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InteractiveContent() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InteractiveContent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InteractiveContent():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InteractiveContent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InteractiveContent() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String appName,
            Map<String, dynamic> appData,
            String? description,
            List<String> tags,
            DateTime? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InteractiveContent() when $default != null:
        return $default(_that.id, _that.name, _that.appName, _that.appData,
            _that.description, _that.tags, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String appName,
            Map<String, dynamic> appData,
            String? description,
            List<String> tags,
            DateTime? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InteractiveContent():
        return $default(_that.id, _that.name, _that.appName, _that.appData,
            _that.description, _that.tags, _that.createdAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String appName,
            Map<String, dynamic> appData,
            String? description,
            List<String> tags,
            DateTime? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InteractiveContent() when $default != null:
        return $default(_that.id, _that.name, _that.appName, _that.appData,
            _that.description, _that.tags, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InteractiveContent implements InteractiveContent {
  const _InteractiveContent(
      {required this.id,
      required this.name,
      required this.appName,
      required final Map<String, dynamic> appData,
      this.description,
      final List<String> tags = const [],
      this.createdAt})
      : _appData = appData,
        _tags = tags;
  factory _InteractiveContent.fromJson(Map<String, dynamic> json) =>
      _$InteractiveContentFromJson(json);

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

  /// Create a copy of InteractiveContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InteractiveContentCopyWith<_InteractiveContent> get copyWith =>
      __$InteractiveContentCopyWithImpl<_InteractiveContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InteractiveContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InteractiveContent &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'InteractiveContent(id: $id, name: $name, appName: $appName, appData: $appData, description: $description, tags: $tags, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$InteractiveContentCopyWith<$Res>
    implements $InteractiveContentCopyWith<$Res> {
  factory _$InteractiveContentCopyWith(
          _InteractiveContent value, $Res Function(_InteractiveContent) _then) =
      __$InteractiveContentCopyWithImpl;
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
class __$InteractiveContentCopyWithImpl<$Res>
    implements _$InteractiveContentCopyWith<$Res> {
  __$InteractiveContentCopyWithImpl(this._self, this._then);

  final _InteractiveContent _self;
  final $Res Function(_InteractiveContent) _then;

  /// Create a copy of InteractiveContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? appName = null,
    Object? appData = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
  }) {
    return _then(_InteractiveContent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _self.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appData: null == appData
          ? _self._appData
          : appData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$RealtimeContent {
  String get id;
  String get name;
  String get sourceType;
  Map<String, dynamic> get sourceConfig;
  String? get description;
  List<String> get tags;

  /// Create a copy of RealtimeContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RealtimeContentCopyWith<RealtimeContent> get copyWith =>
      _$RealtimeContentCopyWithImpl<RealtimeContent>(
          this as RealtimeContent, _$identity);

  /// Serializes this RealtimeContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RealtimeContent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            const DeepCollectionEquality()
                .equals(other.sourceConfig, sourceConfig) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      sourceType,
      const DeepCollectionEquality().hash(sourceConfig),
      description,
      const DeepCollectionEquality().hash(tags));

  @override
  String toString() {
    return 'RealtimeContent(id: $id, name: $name, sourceType: $sourceType, sourceConfig: $sourceConfig, description: $description, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class $RealtimeContentCopyWith<$Res> {
  factory $RealtimeContentCopyWith(
          RealtimeContent value, $Res Function(RealtimeContent) _then) =
      _$RealtimeContentCopyWithImpl;
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
class _$RealtimeContentCopyWithImpl<$Res>
    implements $RealtimeContentCopyWith<$Res> {
  _$RealtimeContentCopyWithImpl(this._self, this._then);

  final RealtimeContent _self;
  final $Res Function(RealtimeContent) _then;

  /// Create a copy of RealtimeContent
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceConfig: null == sourceConfig
          ? _self.sourceConfig
          : sourceConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [RealtimeContent].
extension RealtimeContentPatterns on RealtimeContent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RealtimeContent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RealtimeContent() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RealtimeContent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimeContent():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RealtimeContent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimeContent() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String sourceType,
            Map<String, dynamic> sourceConfig,
            String? description,
            List<String> tags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RealtimeContent() when $default != null:
        return $default(_that.id, _that.name, _that.sourceType,
            _that.sourceConfig, _that.description, _that.tags);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String sourceType,
            Map<String, dynamic> sourceConfig,
            String? description,
            List<String> tags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimeContent():
        return $default(_that.id, _that.name, _that.sourceType,
            _that.sourceConfig, _that.description, _that.tags);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String sourceType,
            Map<String, dynamic> sourceConfig,
            String? description,
            List<String> tags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimeContent() when $default != null:
        return $default(_that.id, _that.name, _that.sourceType,
            _that.sourceConfig, _that.description, _that.tags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RealtimeContent implements RealtimeContent {
  const _RealtimeContent(
      {required this.id,
      required this.name,
      required this.sourceType,
      required final Map<String, dynamic> sourceConfig,
      this.description,
      final List<String> tags = const []})
      : _sourceConfig = sourceConfig,
        _tags = tags;
  factory _RealtimeContent.fromJson(Map<String, dynamic> json) =>
      _$RealtimeContentFromJson(json);

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

  /// Create a copy of RealtimeContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RealtimeContentCopyWith<_RealtimeContent> get copyWith =>
      __$RealtimeContentCopyWithImpl<_RealtimeContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RealtimeContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RealtimeContent &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      sourceType,
      const DeepCollectionEquality().hash(_sourceConfig),
      description,
      const DeepCollectionEquality().hash(_tags));

  @override
  String toString() {
    return 'RealtimeContent(id: $id, name: $name, sourceType: $sourceType, sourceConfig: $sourceConfig, description: $description, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class _$RealtimeContentCopyWith<$Res>
    implements $RealtimeContentCopyWith<$Res> {
  factory _$RealtimeContentCopyWith(
          _RealtimeContent value, $Res Function(_RealtimeContent) _then) =
      __$RealtimeContentCopyWithImpl;
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
class __$RealtimeContentCopyWithImpl<$Res>
    implements _$RealtimeContentCopyWith<$Res> {
  __$RealtimeContentCopyWithImpl(this._self, this._then);

  final _RealtimeContent _self;
  final $Res Function(_RealtimeContent) _then;

  /// Create a copy of RealtimeContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sourceType = null,
    Object? sourceConfig = null,
    Object? description = freezed,
    Object? tags = null,
  }) {
    return _then(_RealtimeContent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceConfig: null == sourceConfig
          ? _self._sourceConfig
          : sourceConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$ContentLibrary {
  String get id;
  String get name;
  List<String> get contentIds;
  String? get description;
  List<String> get tags;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of ContentLibrary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentLibraryCopyWith<ContentLibrary> get copyWith =>
      _$ContentLibraryCopyWithImpl<ContentLibrary>(
          this as ContentLibrary, _$identity);

  /// Serializes this ContentLibrary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentLibrary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.contentIds, contentIds) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(contentIds),
      description,
      const DeepCollectionEquality().hash(tags),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'ContentLibrary(id: $id, name: $name, contentIds: $contentIds, description: $description, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ContentLibraryCopyWith<$Res> {
  factory $ContentLibraryCopyWith(
          ContentLibrary value, $Res Function(ContentLibrary) _then) =
      _$ContentLibraryCopyWithImpl;
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
class _$ContentLibraryCopyWithImpl<$Res>
    implements $ContentLibraryCopyWith<$Res> {
  _$ContentLibraryCopyWithImpl(this._self, this._then);

  final ContentLibrary _self;
  final $Res Function(ContentLibrary) _then;

  /// Create a copy of ContentLibrary
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _self.contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentLibrary].
extension ContentLibraryPatterns on ContentLibrary {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ContentLibrary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentLibrary() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ContentLibrary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentLibrary():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ContentLibrary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentLibrary() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            List<String> contentIds,
            String? description,
            List<String> tags,
            DateTime? createdAt,
            DateTime? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentLibrary() when $default != null:
        return $default(_that.id, _that.name, _that.contentIds,
            _that.description, _that.tags, _that.createdAt, _that.updatedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            List<String> contentIds,
            String? description,
            List<String> tags,
            DateTime? createdAt,
            DateTime? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentLibrary():
        return $default(_that.id, _that.name, _that.contentIds,
            _that.description, _that.tags, _that.createdAt, _that.updatedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            List<String> contentIds,
            String? description,
            List<String> tags,
            DateTime? createdAt,
            DateTime? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentLibrary() when $default != null:
        return $default(_that.id, _that.name, _that.contentIds,
            _that.description, _that.tags, _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentLibrary implements ContentLibrary {
  const _ContentLibrary(
      {required this.id,
      required this.name,
      required final List<String> contentIds,
      this.description,
      final List<String> tags = const [],
      this.createdAt,
      this.updatedAt})
      : _contentIds = contentIds,
        _tags = tags;
  factory _ContentLibrary.fromJson(Map<String, dynamic> json) =>
      _$ContentLibraryFromJson(json);

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

  /// Create a copy of ContentLibrary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentLibraryCopyWith<_ContentLibrary> get copyWith =>
      __$ContentLibraryCopyWithImpl<_ContentLibrary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentLibraryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentLibrary &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'ContentLibrary(id: $id, name: $name, contentIds: $contentIds, description: $description, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ContentLibraryCopyWith<$Res>
    implements $ContentLibraryCopyWith<$Res> {
  factory _$ContentLibraryCopyWith(
          _ContentLibrary value, $Res Function(_ContentLibrary) _then) =
      __$ContentLibraryCopyWithImpl;
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
class __$ContentLibraryCopyWithImpl<$Res>
    implements _$ContentLibraryCopyWith<$Res> {
  __$ContentLibraryCopyWithImpl(this._self, this._then);

  final _ContentLibrary _self;
  final $Res Function(_ContentLibrary) _then;

  /// Create a copy of ContentLibrary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contentIds = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_ContentLibrary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contentIds: null == contentIds
          ? _self._contentIds
          : contentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
