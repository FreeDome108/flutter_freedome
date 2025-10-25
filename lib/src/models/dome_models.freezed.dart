// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dome_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DomeSystem {
  String get id;
  String get name;
  String get ipAddress;
  int get port;
  DomeSystemType get type;
  DomeSystemStatus get status;
  bool get isConnected;
  List<ProjectorConfig> get projectors;
  List<AudioChannel> get audioChannels;
  DateTime? get lastConnected;
  String? get firmwareVersion;
  Map<String, dynamic>? get capabilities;
  String? get activeVendor;
  double get systemVolume;
  double get systemBrightness;
  double get systemRotation;

  /// Create a copy of DomeSystem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DomeSystemCopyWith<DomeSystem> get copyWith =>
      _$DomeSystemCopyWithImpl<DomeSystem>(this as DomeSystem, _$identity);

  /// Serializes this DomeSystem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DomeSystem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            const DeepCollectionEquality()
                .equals(other.projectors, projectors) &&
            const DeepCollectionEquality()
                .equals(other.audioChannels, audioChannels) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.firmwareVersion, firmwareVersion) ||
                other.firmwareVersion == firmwareVersion) &&
            const DeepCollectionEquality()
                .equals(other.capabilities, capabilities) &&
            (identical(other.activeVendor, activeVendor) ||
                other.activeVendor == activeVendor) &&
            (identical(other.systemVolume, systemVolume) ||
                other.systemVolume == systemVolume) &&
            (identical(other.systemBrightness, systemBrightness) ||
                other.systemBrightness == systemBrightness) &&
            (identical(other.systemRotation, systemRotation) ||
                other.systemRotation == systemRotation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      ipAddress,
      port,
      type,
      status,
      isConnected,
      const DeepCollectionEquality().hash(projectors),
      const DeepCollectionEquality().hash(audioChannels),
      lastConnected,
      firmwareVersion,
      const DeepCollectionEquality().hash(capabilities),
      activeVendor,
      systemVolume,
      systemBrightness,
      systemRotation);

  @override
  String toString() {
    return 'DomeSystem(id: $id, name: $name, ipAddress: $ipAddress, port: $port, type: $type, status: $status, isConnected: $isConnected, projectors: $projectors, audioChannels: $audioChannels, lastConnected: $lastConnected, firmwareVersion: $firmwareVersion, capabilities: $capabilities, activeVendor: $activeVendor, systemVolume: $systemVolume, systemBrightness: $systemBrightness, systemRotation: $systemRotation)';
  }
}

/// @nodoc
abstract mixin class $DomeSystemCopyWith<$Res> {
  factory $DomeSystemCopyWith(
          DomeSystem value, $Res Function(DomeSystem) _then) =
      _$DomeSystemCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String ipAddress,
      int port,
      DomeSystemType type,
      DomeSystemStatus status,
      bool isConnected,
      List<ProjectorConfig> projectors,
      List<AudioChannel> audioChannels,
      DateTime? lastConnected,
      String? firmwareVersion,
      Map<String, dynamic>? capabilities,
      String? activeVendor,
      double systemVolume,
      double systemBrightness,
      double systemRotation});
}

/// @nodoc
class _$DomeSystemCopyWithImpl<$Res> implements $DomeSystemCopyWith<$Res> {
  _$DomeSystemCopyWithImpl(this._self, this._then);

  final DomeSystem _self;
  final $Res Function(DomeSystem) _then;

  /// Create a copy of DomeSystem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ipAddress = null,
    Object? port = null,
    Object? type = null,
    Object? status = null,
    Object? isConnected = null,
    Object? projectors = null,
    Object? audioChannels = null,
    Object? lastConnected = freezed,
    Object? firmwareVersion = freezed,
    Object? capabilities = freezed,
    Object? activeVendor = freezed,
    Object? systemVolume = null,
    Object? systemBrightness = null,
    Object? systemRotation = null,
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
      ipAddress: null == ipAddress
          ? _self.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _self.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as DomeSystemType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DomeSystemStatus,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      projectors: null == projectors
          ? _self.projectors
          : projectors // ignore: cast_nullable_to_non_nullable
              as List<ProjectorConfig>,
      audioChannels: null == audioChannels
          ? _self.audioChannels
          : audioChannels // ignore: cast_nullable_to_non_nullable
              as List<AudioChannel>,
      lastConnected: freezed == lastConnected
          ? _self.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firmwareVersion: freezed == firmwareVersion
          ? _self.firmwareVersion
          : firmwareVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      capabilities: freezed == capabilities
          ? _self.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      activeVendor: freezed == activeVendor
          ? _self.activeVendor
          : activeVendor // ignore: cast_nullable_to_non_nullable
              as String?,
      systemVolume: null == systemVolume
          ? _self.systemVolume
          : systemVolume // ignore: cast_nullable_to_non_nullable
              as double,
      systemBrightness: null == systemBrightness
          ? _self.systemBrightness
          : systemBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      systemRotation: null == systemRotation
          ? _self.systemRotation
          : systemRotation // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [DomeSystem].
extension DomeSystemPatterns on DomeSystem {
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
    TResult Function(_DomeSystem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DomeSystem() when $default != null:
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
    TResult Function(_DomeSystem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DomeSystem():
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
    TResult? Function(_DomeSystem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DomeSystem() when $default != null:
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
            String ipAddress,
            int port,
            DomeSystemType type,
            DomeSystemStatus status,
            bool isConnected,
            List<ProjectorConfig> projectors,
            List<AudioChannel> audioChannels,
            DateTime? lastConnected,
            String? firmwareVersion,
            Map<String, dynamic>? capabilities,
            String? activeVendor,
            double systemVolume,
            double systemBrightness,
            double systemRotation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DomeSystem() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.ipAddress,
            _that.port,
            _that.type,
            _that.status,
            _that.isConnected,
            _that.projectors,
            _that.audioChannels,
            _that.lastConnected,
            _that.firmwareVersion,
            _that.capabilities,
            _that.activeVendor,
            _that.systemVolume,
            _that.systemBrightness,
            _that.systemRotation);
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
            String ipAddress,
            int port,
            DomeSystemType type,
            DomeSystemStatus status,
            bool isConnected,
            List<ProjectorConfig> projectors,
            List<AudioChannel> audioChannels,
            DateTime? lastConnected,
            String? firmwareVersion,
            Map<String, dynamic>? capabilities,
            String? activeVendor,
            double systemVolume,
            double systemBrightness,
            double systemRotation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DomeSystem():
        return $default(
            _that.id,
            _that.name,
            _that.ipAddress,
            _that.port,
            _that.type,
            _that.status,
            _that.isConnected,
            _that.projectors,
            _that.audioChannels,
            _that.lastConnected,
            _that.firmwareVersion,
            _that.capabilities,
            _that.activeVendor,
            _that.systemVolume,
            _that.systemBrightness,
            _that.systemRotation);
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
            String ipAddress,
            int port,
            DomeSystemType type,
            DomeSystemStatus status,
            bool isConnected,
            List<ProjectorConfig> projectors,
            List<AudioChannel> audioChannels,
            DateTime? lastConnected,
            String? firmwareVersion,
            Map<String, dynamic>? capabilities,
            String? activeVendor,
            double systemVolume,
            double systemBrightness,
            double systemRotation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DomeSystem() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.ipAddress,
            _that.port,
            _that.type,
            _that.status,
            _that.isConnected,
            _that.projectors,
            _that.audioChannels,
            _that.lastConnected,
            _that.firmwareVersion,
            _that.capabilities,
            _that.activeVendor,
            _that.systemVolume,
            _that.systemBrightness,
            _that.systemRotation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DomeSystem implements DomeSystem {
  const _DomeSystem(
      {required this.id,
      required this.name,
      required this.ipAddress,
      required this.port,
      required this.type,
      required this.status,
      this.isConnected = false,
      final List<ProjectorConfig> projectors = const [],
      final List<AudioChannel> audioChannels = const [],
      this.lastConnected,
      this.firmwareVersion,
      final Map<String, dynamic>? capabilities,
      this.activeVendor,
      this.systemVolume = 0.5,
      this.systemBrightness = 0.8,
      this.systemRotation = 0.0})
      : _projectors = projectors,
        _audioChannels = audioChannels,
        _capabilities = capabilities;
  factory _DomeSystem.fromJson(Map<String, dynamic> json) =>
      _$DomeSystemFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String ipAddress;
  @override
  final int port;
  @override
  final DomeSystemType type;
  @override
  final DomeSystemStatus status;
  @override
  @JsonKey()
  final bool isConnected;
  final List<ProjectorConfig> _projectors;
  @override
  @JsonKey()
  List<ProjectorConfig> get projectors {
    if (_projectors is EqualUnmodifiableListView) return _projectors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectors);
  }

  final List<AudioChannel> _audioChannels;
  @override
  @JsonKey()
  List<AudioChannel> get audioChannels {
    if (_audioChannels is EqualUnmodifiableListView) return _audioChannels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audioChannels);
  }

  @override
  final DateTime? lastConnected;
  @override
  final String? firmwareVersion;
  final Map<String, dynamic>? _capabilities;
  @override
  Map<String, dynamic>? get capabilities {
    final value = _capabilities;
    if (value == null) return null;
    if (_capabilities is EqualUnmodifiableMapView) return _capabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? activeVendor;
  @override
  @JsonKey()
  final double systemVolume;
  @override
  @JsonKey()
  final double systemBrightness;
  @override
  @JsonKey()
  final double systemRotation;

  /// Create a copy of DomeSystem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DomeSystemCopyWith<_DomeSystem> get copyWith =>
      __$DomeSystemCopyWithImpl<_DomeSystem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DomeSystemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DomeSystem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            const DeepCollectionEquality()
                .equals(other._projectors, _projectors) &&
            const DeepCollectionEquality()
                .equals(other._audioChannels, _audioChannels) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.firmwareVersion, firmwareVersion) ||
                other.firmwareVersion == firmwareVersion) &&
            const DeepCollectionEquality()
                .equals(other._capabilities, _capabilities) &&
            (identical(other.activeVendor, activeVendor) ||
                other.activeVendor == activeVendor) &&
            (identical(other.systemVolume, systemVolume) ||
                other.systemVolume == systemVolume) &&
            (identical(other.systemBrightness, systemBrightness) ||
                other.systemBrightness == systemBrightness) &&
            (identical(other.systemRotation, systemRotation) ||
                other.systemRotation == systemRotation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      ipAddress,
      port,
      type,
      status,
      isConnected,
      const DeepCollectionEquality().hash(_projectors),
      const DeepCollectionEquality().hash(_audioChannels),
      lastConnected,
      firmwareVersion,
      const DeepCollectionEquality().hash(_capabilities),
      activeVendor,
      systemVolume,
      systemBrightness,
      systemRotation);

  @override
  String toString() {
    return 'DomeSystem(id: $id, name: $name, ipAddress: $ipAddress, port: $port, type: $type, status: $status, isConnected: $isConnected, projectors: $projectors, audioChannels: $audioChannels, lastConnected: $lastConnected, firmwareVersion: $firmwareVersion, capabilities: $capabilities, activeVendor: $activeVendor, systemVolume: $systemVolume, systemBrightness: $systemBrightness, systemRotation: $systemRotation)';
  }
}

/// @nodoc
abstract mixin class _$DomeSystemCopyWith<$Res>
    implements $DomeSystemCopyWith<$Res> {
  factory _$DomeSystemCopyWith(
          _DomeSystem value, $Res Function(_DomeSystem) _then) =
      __$DomeSystemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String ipAddress,
      int port,
      DomeSystemType type,
      DomeSystemStatus status,
      bool isConnected,
      List<ProjectorConfig> projectors,
      List<AudioChannel> audioChannels,
      DateTime? lastConnected,
      String? firmwareVersion,
      Map<String, dynamic>? capabilities,
      String? activeVendor,
      double systemVolume,
      double systemBrightness,
      double systemRotation});
}

/// @nodoc
class __$DomeSystemCopyWithImpl<$Res> implements _$DomeSystemCopyWith<$Res> {
  __$DomeSystemCopyWithImpl(this._self, this._then);

  final _DomeSystem _self;
  final $Res Function(_DomeSystem) _then;

  /// Create a copy of DomeSystem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ipAddress = null,
    Object? port = null,
    Object? type = null,
    Object? status = null,
    Object? isConnected = null,
    Object? projectors = null,
    Object? audioChannels = null,
    Object? lastConnected = freezed,
    Object? firmwareVersion = freezed,
    Object? capabilities = freezed,
    Object? activeVendor = freezed,
    Object? systemVolume = null,
    Object? systemBrightness = null,
    Object? systemRotation = null,
  }) {
    return _then(_DomeSystem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ipAddress: null == ipAddress
          ? _self.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _self.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as DomeSystemType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DomeSystemStatus,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      projectors: null == projectors
          ? _self._projectors
          : projectors // ignore: cast_nullable_to_non_nullable
              as List<ProjectorConfig>,
      audioChannels: null == audioChannels
          ? _self._audioChannels
          : audioChannels // ignore: cast_nullable_to_non_nullable
              as List<AudioChannel>,
      lastConnected: freezed == lastConnected
          ? _self.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firmwareVersion: freezed == firmwareVersion
          ? _self.firmwareVersion
          : firmwareVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      capabilities: freezed == capabilities
          ? _self._capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      activeVendor: freezed == activeVendor
          ? _self.activeVendor
          : activeVendor // ignore: cast_nullable_to_non_nullable
              as String?,
      systemVolume: null == systemVolume
          ? _self.systemVolume
          : systemVolume // ignore: cast_nullable_to_non_nullable
              as double,
      systemBrightness: null == systemBrightness
          ? _self.systemBrightness
          : systemBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      systemRotation: null == systemRotation
          ? _self.systemRotation
          : systemRotation // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ProjectorConfig {
  String get id;
  String get name;
  ProjectorType get type;
  int get brightness;
  int get contrast;
  ProjectorStatus get status;
  double get x;
  double get y;
  double get z;
  double get pitch;
  double get yaw;
  double get roll;
  int get resolutionWidth;
  int get resolutionHeight;
  double get refreshRate;
  Map<String, dynamic>? get calibrationData;

  /// Create a copy of ProjectorConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProjectorConfigCopyWith<ProjectorConfig> get copyWith =>
      _$ProjectorConfigCopyWithImpl<ProjectorConfig>(
          this as ProjectorConfig, _$identity);

  /// Serializes this ProjectorConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProjectorConfig &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.contrast, contrast) ||
                other.contrast == contrast) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.roll, roll) || other.roll == roll) &&
            (identical(other.resolutionWidth, resolutionWidth) ||
                other.resolutionWidth == resolutionWidth) &&
            (identical(other.resolutionHeight, resolutionHeight) ||
                other.resolutionHeight == resolutionHeight) &&
            (identical(other.refreshRate, refreshRate) ||
                other.refreshRate == refreshRate) &&
            const DeepCollectionEquality()
                .equals(other.calibrationData, calibrationData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      brightness,
      contrast,
      status,
      x,
      y,
      z,
      pitch,
      yaw,
      roll,
      resolutionWidth,
      resolutionHeight,
      refreshRate,
      const DeepCollectionEquality().hash(calibrationData));

  @override
  String toString() {
    return 'ProjectorConfig(id: $id, name: $name, type: $type, brightness: $brightness, contrast: $contrast, status: $status, x: $x, y: $y, z: $z, pitch: $pitch, yaw: $yaw, roll: $roll, resolutionWidth: $resolutionWidth, resolutionHeight: $resolutionHeight, refreshRate: $refreshRate, calibrationData: $calibrationData)';
  }
}

/// @nodoc
abstract mixin class $ProjectorConfigCopyWith<$Res> {
  factory $ProjectorConfigCopyWith(
          ProjectorConfig value, $Res Function(ProjectorConfig) _then) =
      _$ProjectorConfigCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      ProjectorType type,
      int brightness,
      int contrast,
      ProjectorStatus status,
      double x,
      double y,
      double z,
      double pitch,
      double yaw,
      double roll,
      int resolutionWidth,
      int resolutionHeight,
      double refreshRate,
      Map<String, dynamic>? calibrationData});
}

/// @nodoc
class _$ProjectorConfigCopyWithImpl<$Res>
    implements $ProjectorConfigCopyWith<$Res> {
  _$ProjectorConfigCopyWithImpl(this._self, this._then);

  final ProjectorConfig _self;
  final $Res Function(ProjectorConfig) _then;

  /// Create a copy of ProjectorConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? brightness = null,
    Object? contrast = null,
    Object? status = null,
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? pitch = null,
    Object? yaw = null,
    Object? roll = null,
    Object? resolutionWidth = null,
    Object? resolutionHeight = null,
    Object? refreshRate = null,
    Object? calibrationData = freezed,
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
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ProjectorType,
      brightness: null == brightness
          ? _self.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int,
      contrast: null == contrast
          ? _self.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectorStatus,
      x: null == x
          ? _self.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _self.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _self.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _self.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      yaw: null == yaw
          ? _self.yaw
          : yaw // ignore: cast_nullable_to_non_nullable
              as double,
      roll: null == roll
          ? _self.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as double,
      resolutionWidth: null == resolutionWidth
          ? _self.resolutionWidth
          : resolutionWidth // ignore: cast_nullable_to_non_nullable
              as int,
      resolutionHeight: null == resolutionHeight
          ? _self.resolutionHeight
          : resolutionHeight // ignore: cast_nullable_to_non_nullable
              as int,
      refreshRate: null == refreshRate
          ? _self.refreshRate
          : refreshRate // ignore: cast_nullable_to_non_nullable
              as double,
      calibrationData: freezed == calibrationData
          ? _self.calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProjectorConfig].
extension ProjectorConfigPatterns on ProjectorConfig {
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
    TResult Function(_ProjectorConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProjectorConfig() when $default != null:
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
    TResult Function(_ProjectorConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorConfig():
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
    TResult? Function(_ProjectorConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorConfig() when $default != null:
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
            ProjectorType type,
            int brightness,
            int contrast,
            ProjectorStatus status,
            double x,
            double y,
            double z,
            double pitch,
            double yaw,
            double roll,
            int resolutionWidth,
            int resolutionHeight,
            double refreshRate,
            Map<String, dynamic>? calibrationData)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProjectorConfig() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.brightness,
            _that.contrast,
            _that.status,
            _that.x,
            _that.y,
            _that.z,
            _that.pitch,
            _that.yaw,
            _that.roll,
            _that.resolutionWidth,
            _that.resolutionHeight,
            _that.refreshRate,
            _that.calibrationData);
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
            ProjectorType type,
            int brightness,
            int contrast,
            ProjectorStatus status,
            double x,
            double y,
            double z,
            double pitch,
            double yaw,
            double roll,
            int resolutionWidth,
            int resolutionHeight,
            double refreshRate,
            Map<String, dynamic>? calibrationData)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorConfig():
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.brightness,
            _that.contrast,
            _that.status,
            _that.x,
            _that.y,
            _that.z,
            _that.pitch,
            _that.yaw,
            _that.roll,
            _that.resolutionWidth,
            _that.resolutionHeight,
            _that.refreshRate,
            _that.calibrationData);
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
            ProjectorType type,
            int brightness,
            int contrast,
            ProjectorStatus status,
            double x,
            double y,
            double z,
            double pitch,
            double yaw,
            double roll,
            int resolutionWidth,
            int resolutionHeight,
            double refreshRate,
            Map<String, dynamic>? calibrationData)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorConfig() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.brightness,
            _that.contrast,
            _that.status,
            _that.x,
            _that.y,
            _that.z,
            _that.pitch,
            _that.yaw,
            _that.roll,
            _that.resolutionWidth,
            _that.resolutionHeight,
            _that.refreshRate,
            _that.calibrationData);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProjectorConfig implements ProjectorConfig {
  const _ProjectorConfig(
      {required this.id,
      required this.name,
      required this.type,
      required this.brightness,
      required this.contrast,
      required this.status,
      this.x = 0.0,
      this.y = 0.0,
      this.z = 0.0,
      this.pitch = 0.0,
      this.yaw = 0.0,
      this.roll = 0.0,
      this.resolutionWidth = 1920,
      this.resolutionHeight = 1080,
      this.refreshRate = 60.0,
      final Map<String, dynamic>? calibrationData})
      : _calibrationData = calibrationData;
  factory _ProjectorConfig.fromJson(Map<String, dynamic> json) =>
      _$ProjectorConfigFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final ProjectorType type;
  @override
  final int brightness;
  @override
  final int contrast;
  @override
  final ProjectorStatus status;
  @override
  @JsonKey()
  final double x;
  @override
  @JsonKey()
  final double y;
  @override
  @JsonKey()
  final double z;
  @override
  @JsonKey()
  final double pitch;
  @override
  @JsonKey()
  final double yaw;
  @override
  @JsonKey()
  final double roll;
  @override
  @JsonKey()
  final int resolutionWidth;
  @override
  @JsonKey()
  final int resolutionHeight;
  @override
  @JsonKey()
  final double refreshRate;
  final Map<String, dynamic>? _calibrationData;
  @override
  Map<String, dynamic>? get calibrationData {
    final value = _calibrationData;
    if (value == null) return null;
    if (_calibrationData is EqualUnmodifiableMapView) return _calibrationData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of ProjectorConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProjectorConfigCopyWith<_ProjectorConfig> get copyWith =>
      __$ProjectorConfigCopyWithImpl<_ProjectorConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProjectorConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectorConfig &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.contrast, contrast) ||
                other.contrast == contrast) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.roll, roll) || other.roll == roll) &&
            (identical(other.resolutionWidth, resolutionWidth) ||
                other.resolutionWidth == resolutionWidth) &&
            (identical(other.resolutionHeight, resolutionHeight) ||
                other.resolutionHeight == resolutionHeight) &&
            (identical(other.refreshRate, refreshRate) ||
                other.refreshRate == refreshRate) &&
            const DeepCollectionEquality()
                .equals(other._calibrationData, _calibrationData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      brightness,
      contrast,
      status,
      x,
      y,
      z,
      pitch,
      yaw,
      roll,
      resolutionWidth,
      resolutionHeight,
      refreshRate,
      const DeepCollectionEquality().hash(_calibrationData));

  @override
  String toString() {
    return 'ProjectorConfig(id: $id, name: $name, type: $type, brightness: $brightness, contrast: $contrast, status: $status, x: $x, y: $y, z: $z, pitch: $pitch, yaw: $yaw, roll: $roll, resolutionWidth: $resolutionWidth, resolutionHeight: $resolutionHeight, refreshRate: $refreshRate, calibrationData: $calibrationData)';
  }
}

/// @nodoc
abstract mixin class _$ProjectorConfigCopyWith<$Res>
    implements $ProjectorConfigCopyWith<$Res> {
  factory _$ProjectorConfigCopyWith(
          _ProjectorConfig value, $Res Function(_ProjectorConfig) _then) =
      __$ProjectorConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ProjectorType type,
      int brightness,
      int contrast,
      ProjectorStatus status,
      double x,
      double y,
      double z,
      double pitch,
      double yaw,
      double roll,
      int resolutionWidth,
      int resolutionHeight,
      double refreshRate,
      Map<String, dynamic>? calibrationData});
}

/// @nodoc
class __$ProjectorConfigCopyWithImpl<$Res>
    implements _$ProjectorConfigCopyWith<$Res> {
  __$ProjectorConfigCopyWithImpl(this._self, this._then);

  final _ProjectorConfig _self;
  final $Res Function(_ProjectorConfig) _then;

  /// Create a copy of ProjectorConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? brightness = null,
    Object? contrast = null,
    Object? status = null,
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? pitch = null,
    Object? yaw = null,
    Object? roll = null,
    Object? resolutionWidth = null,
    Object? resolutionHeight = null,
    Object? refreshRate = null,
    Object? calibrationData = freezed,
  }) {
    return _then(_ProjectorConfig(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ProjectorType,
      brightness: null == brightness
          ? _self.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int,
      contrast: null == contrast
          ? _self.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectorStatus,
      x: null == x
          ? _self.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _self.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _self.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _self.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      yaw: null == yaw
          ? _self.yaw
          : yaw // ignore: cast_nullable_to_non_nullable
              as double,
      roll: null == roll
          ? _self.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as double,
      resolutionWidth: null == resolutionWidth
          ? _self.resolutionWidth
          : resolutionWidth // ignore: cast_nullable_to_non_nullable
              as int,
      resolutionHeight: null == resolutionHeight
          ? _self.resolutionHeight
          : resolutionHeight // ignore: cast_nullable_to_non_nullable
              as int,
      refreshRate: null == refreshRate
          ? _self.refreshRate
          : refreshRate // ignore: cast_nullable_to_non_nullable
              as double,
      calibrationData: freezed == calibrationData
          ? _self._calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$AudioChannel {
  String get id;
  String get name;
  AudioChannelType get type;
  double get volume;
  bool get isMuted;
  double get x;
  double get y;
  double get z;
  double get delay;
  Map<String, dynamic>? get equalizerSettings;
  Map<String, dynamic>? get calibrationData;

  /// Create a copy of AudioChannel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AudioChannelCopyWith<AudioChannel> get copyWith =>
      _$AudioChannelCopyWithImpl<AudioChannel>(
          this as AudioChannel, _$identity);

  /// Serializes this AudioChannel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AudioChannel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            const DeepCollectionEquality()
                .equals(other.equalizerSettings, equalizerSettings) &&
            const DeepCollectionEquality()
                .equals(other.calibrationData, calibrationData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      volume,
      isMuted,
      x,
      y,
      z,
      delay,
      const DeepCollectionEquality().hash(equalizerSettings),
      const DeepCollectionEquality().hash(calibrationData));

  @override
  String toString() {
    return 'AudioChannel(id: $id, name: $name, type: $type, volume: $volume, isMuted: $isMuted, x: $x, y: $y, z: $z, delay: $delay, equalizerSettings: $equalizerSettings, calibrationData: $calibrationData)';
  }
}

/// @nodoc
abstract mixin class $AudioChannelCopyWith<$Res> {
  factory $AudioChannelCopyWith(
          AudioChannel value, $Res Function(AudioChannel) _then) =
      _$AudioChannelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      AudioChannelType type,
      double volume,
      bool isMuted,
      double x,
      double y,
      double z,
      double delay,
      Map<String, dynamic>? equalizerSettings,
      Map<String, dynamic>? calibrationData});
}

/// @nodoc
class _$AudioChannelCopyWithImpl<$Res> implements $AudioChannelCopyWith<$Res> {
  _$AudioChannelCopyWithImpl(this._self, this._then);

  final AudioChannel _self;
  final $Res Function(AudioChannel) _then;

  /// Create a copy of AudioChannel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? volume = null,
    Object? isMuted = null,
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? delay = null,
    Object? equalizerSettings = freezed,
    Object? calibrationData = freezed,
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
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as AudioChannelType,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      isMuted: null == isMuted
          ? _self.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      x: null == x
          ? _self.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _self.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _self.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      delay: null == delay
          ? _self.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _self.equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      calibrationData: freezed == calibrationData
          ? _self.calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AudioChannel].
extension AudioChannelPatterns on AudioChannel {
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
    TResult Function(_AudioChannel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AudioChannel() when $default != null:
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
    TResult Function(_AudioChannel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioChannel():
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
    TResult? Function(_AudioChannel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioChannel() when $default != null:
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
            AudioChannelType type,
            double volume,
            bool isMuted,
            double x,
            double y,
            double z,
            double delay,
            Map<String, dynamic>? equalizerSettings,
            Map<String, dynamic>? calibrationData)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AudioChannel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.volume,
            _that.isMuted,
            _that.x,
            _that.y,
            _that.z,
            _that.delay,
            _that.equalizerSettings,
            _that.calibrationData);
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
            AudioChannelType type,
            double volume,
            bool isMuted,
            double x,
            double y,
            double z,
            double delay,
            Map<String, dynamic>? equalizerSettings,
            Map<String, dynamic>? calibrationData)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioChannel():
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.volume,
            _that.isMuted,
            _that.x,
            _that.y,
            _that.z,
            _that.delay,
            _that.equalizerSettings,
            _that.calibrationData);
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
            AudioChannelType type,
            double volume,
            bool isMuted,
            double x,
            double y,
            double z,
            double delay,
            Map<String, dynamic>? equalizerSettings,
            Map<String, dynamic>? calibrationData)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioChannel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.type,
            _that.volume,
            _that.isMuted,
            _that.x,
            _that.y,
            _that.z,
            _that.delay,
            _that.equalizerSettings,
            _that.calibrationData);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AudioChannel implements AudioChannel {
  const _AudioChannel(
      {required this.id,
      required this.name,
      required this.type,
      this.volume = 0.5,
      this.isMuted = false,
      this.x = 0.0,
      this.y = 0.0,
      this.z = 0.0,
      this.delay = 0.0,
      final Map<String, dynamic>? equalizerSettings,
      final Map<String, dynamic>? calibrationData})
      : _equalizerSettings = equalizerSettings,
        _calibrationData = calibrationData;
  factory _AudioChannel.fromJson(Map<String, dynamic> json) =>
      _$AudioChannelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final AudioChannelType type;
  @override
  @JsonKey()
  final double volume;
  @override
  @JsonKey()
  final bool isMuted;
  @override
  @JsonKey()
  final double x;
  @override
  @JsonKey()
  final double y;
  @override
  @JsonKey()
  final double z;
  @override
  @JsonKey()
  final double delay;
  final Map<String, dynamic>? _equalizerSettings;
  @override
  Map<String, dynamic>? get equalizerSettings {
    final value = _equalizerSettings;
    if (value == null) return null;
    if (_equalizerSettings is EqualUnmodifiableMapView)
      return _equalizerSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _calibrationData;
  @override
  Map<String, dynamic>? get calibrationData {
    final value = _calibrationData;
    if (value == null) return null;
    if (_calibrationData is EqualUnmodifiableMapView) return _calibrationData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of AudioChannel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AudioChannelCopyWith<_AudioChannel> get copyWith =>
      __$AudioChannelCopyWithImpl<_AudioChannel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AudioChannelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AudioChannel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            const DeepCollectionEquality()
                .equals(other._equalizerSettings, _equalizerSettings) &&
            const DeepCollectionEquality()
                .equals(other._calibrationData, _calibrationData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      volume,
      isMuted,
      x,
      y,
      z,
      delay,
      const DeepCollectionEquality().hash(_equalizerSettings),
      const DeepCollectionEquality().hash(_calibrationData));

  @override
  String toString() {
    return 'AudioChannel(id: $id, name: $name, type: $type, volume: $volume, isMuted: $isMuted, x: $x, y: $y, z: $z, delay: $delay, equalizerSettings: $equalizerSettings, calibrationData: $calibrationData)';
  }
}

/// @nodoc
abstract mixin class _$AudioChannelCopyWith<$Res>
    implements $AudioChannelCopyWith<$Res> {
  factory _$AudioChannelCopyWith(
          _AudioChannel value, $Res Function(_AudioChannel) _then) =
      __$AudioChannelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      AudioChannelType type,
      double volume,
      bool isMuted,
      double x,
      double y,
      double z,
      double delay,
      Map<String, dynamic>? equalizerSettings,
      Map<String, dynamic>? calibrationData});
}

/// @nodoc
class __$AudioChannelCopyWithImpl<$Res>
    implements _$AudioChannelCopyWith<$Res> {
  __$AudioChannelCopyWithImpl(this._self, this._then);

  final _AudioChannel _self;
  final $Res Function(_AudioChannel) _then;

  /// Create a copy of AudioChannel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? volume = null,
    Object? isMuted = null,
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? delay = null,
    Object? equalizerSettings = freezed,
    Object? calibrationData = freezed,
  }) {
    return _then(_AudioChannel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as AudioChannelType,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      isMuted: null == isMuted
          ? _self.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      x: null == x
          ? _self.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _self.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _self.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      delay: null == delay
          ? _self.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _self._equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      calibrationData: freezed == calibrationData
          ? _self._calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$FreeDomeConnectionStatus {
  bool get isConnected;
  bool get isConnecting;
  String? get connectedDomeId;
  String? get serverUrl;
  DateTime? get lastConnected;
  String? get error;
  int get reconnectAttempts;
  int get maxReconnectAttempts;

  /// Create a copy of FreeDomeConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreeDomeConnectionStatusCopyWith<FreeDomeConnectionStatus> get copyWith =>
      _$FreeDomeConnectionStatusCopyWithImpl<FreeDomeConnectionStatus>(
          this as FreeDomeConnectionStatus, _$identity);

  /// Serializes this FreeDomeConnectionStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreeDomeConnectionStatus &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isConnecting, isConnecting) ||
                other.isConnecting == isConnecting) &&
            (identical(other.connectedDomeId, connectedDomeId) ||
                other.connectedDomeId == connectedDomeId) &&
            (identical(other.serverUrl, serverUrl) ||
                other.serverUrl == serverUrl) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.reconnectAttempts, reconnectAttempts) ||
                other.reconnectAttempts == reconnectAttempts) &&
            (identical(other.maxReconnectAttempts, maxReconnectAttempts) ||
                other.maxReconnectAttempts == maxReconnectAttempts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isConnected,
      isConnecting,
      connectedDomeId,
      serverUrl,
      lastConnected,
      error,
      reconnectAttempts,
      maxReconnectAttempts);

  @override
  String toString() {
    return 'FreeDomeConnectionStatus(isConnected: $isConnected, isConnecting: $isConnecting, connectedDomeId: $connectedDomeId, serverUrl: $serverUrl, lastConnected: $lastConnected, error: $error, reconnectAttempts: $reconnectAttempts, maxReconnectAttempts: $maxReconnectAttempts)';
  }
}

/// @nodoc
abstract mixin class $FreeDomeConnectionStatusCopyWith<$Res> {
  factory $FreeDomeConnectionStatusCopyWith(FreeDomeConnectionStatus value,
          $Res Function(FreeDomeConnectionStatus) _then) =
      _$FreeDomeConnectionStatusCopyWithImpl;
  @useResult
  $Res call(
      {bool isConnected,
      bool isConnecting,
      String? connectedDomeId,
      String? serverUrl,
      DateTime? lastConnected,
      String? error,
      int reconnectAttempts,
      int maxReconnectAttempts});
}

/// @nodoc
class _$FreeDomeConnectionStatusCopyWithImpl<$Res>
    implements $FreeDomeConnectionStatusCopyWith<$Res> {
  _$FreeDomeConnectionStatusCopyWithImpl(this._self, this._then);

  final FreeDomeConnectionStatus _self;
  final $Res Function(FreeDomeConnectionStatus) _then;

  /// Create a copy of FreeDomeConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? isConnecting = null,
    Object? connectedDomeId = freezed,
    Object? serverUrl = freezed,
    Object? lastConnected = freezed,
    Object? error = freezed,
    Object? reconnectAttempts = null,
    Object? maxReconnectAttempts = null,
  }) {
    return _then(_self.copyWith(
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnecting: null == isConnecting
          ? _self.isConnecting
          : isConnecting // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedDomeId: freezed == connectedDomeId
          ? _self.connectedDomeId
          : connectedDomeId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverUrl: freezed == serverUrl
          ? _self.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _self.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      reconnectAttempts: null == reconnectAttempts
          ? _self.reconnectAttempts
          : reconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      maxReconnectAttempts: null == maxReconnectAttempts
          ? _self.maxReconnectAttempts
          : maxReconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreeDomeConnectionStatus].
extension FreeDomeConnectionStatusPatterns on FreeDomeConnectionStatus {
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
    TResult Function(_FreeDomeConnectionStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeConnectionStatus() when $default != null:
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
    TResult Function(_FreeDomeConnectionStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeConnectionStatus():
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
    TResult? Function(_FreeDomeConnectionStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeConnectionStatus() when $default != null:
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
            bool isConnected,
            bool isConnecting,
            String? connectedDomeId,
            String? serverUrl,
            DateTime? lastConnected,
            String? error,
            int reconnectAttempts,
            int maxReconnectAttempts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeConnectionStatus() when $default != null:
        return $default(
            _that.isConnected,
            _that.isConnecting,
            _that.connectedDomeId,
            _that.serverUrl,
            _that.lastConnected,
            _that.error,
            _that.reconnectAttempts,
            _that.maxReconnectAttempts);
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
            bool isConnected,
            bool isConnecting,
            String? connectedDomeId,
            String? serverUrl,
            DateTime? lastConnected,
            String? error,
            int reconnectAttempts,
            int maxReconnectAttempts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeConnectionStatus():
        return $default(
            _that.isConnected,
            _that.isConnecting,
            _that.connectedDomeId,
            _that.serverUrl,
            _that.lastConnected,
            _that.error,
            _that.reconnectAttempts,
            _that.maxReconnectAttempts);
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
            bool isConnected,
            bool isConnecting,
            String? connectedDomeId,
            String? serverUrl,
            DateTime? lastConnected,
            String? error,
            int reconnectAttempts,
            int maxReconnectAttempts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeConnectionStatus() when $default != null:
        return $default(
            _that.isConnected,
            _that.isConnecting,
            _that.connectedDomeId,
            _that.serverUrl,
            _that.lastConnected,
            _that.error,
            _that.reconnectAttempts,
            _that.maxReconnectAttempts);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FreeDomeConnectionStatus implements FreeDomeConnectionStatus {
  const _FreeDomeConnectionStatus(
      {required this.isConnected,
      required this.isConnecting,
      this.connectedDomeId,
      this.serverUrl,
      this.lastConnected,
      this.error,
      this.reconnectAttempts = 0,
      this.maxReconnectAttempts = 5});
  factory _FreeDomeConnectionStatus.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeConnectionStatusFromJson(json);

  @override
  final bool isConnected;
  @override
  final bool isConnecting;
  @override
  final String? connectedDomeId;
  @override
  final String? serverUrl;
  @override
  final DateTime? lastConnected;
  @override
  final String? error;
  @override
  @JsonKey()
  final int reconnectAttempts;
  @override
  @JsonKey()
  final int maxReconnectAttempts;

  /// Create a copy of FreeDomeConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FreeDomeConnectionStatusCopyWith<_FreeDomeConnectionStatus> get copyWith =>
      __$FreeDomeConnectionStatusCopyWithImpl<_FreeDomeConnectionStatus>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FreeDomeConnectionStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FreeDomeConnectionStatus &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isConnecting, isConnecting) ||
                other.isConnecting == isConnecting) &&
            (identical(other.connectedDomeId, connectedDomeId) ||
                other.connectedDomeId == connectedDomeId) &&
            (identical(other.serverUrl, serverUrl) ||
                other.serverUrl == serverUrl) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.reconnectAttempts, reconnectAttempts) ||
                other.reconnectAttempts == reconnectAttempts) &&
            (identical(other.maxReconnectAttempts, maxReconnectAttempts) ||
                other.maxReconnectAttempts == maxReconnectAttempts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isConnected,
      isConnecting,
      connectedDomeId,
      serverUrl,
      lastConnected,
      error,
      reconnectAttempts,
      maxReconnectAttempts);

  @override
  String toString() {
    return 'FreeDomeConnectionStatus(isConnected: $isConnected, isConnecting: $isConnecting, connectedDomeId: $connectedDomeId, serverUrl: $serverUrl, lastConnected: $lastConnected, error: $error, reconnectAttempts: $reconnectAttempts, maxReconnectAttempts: $maxReconnectAttempts)';
  }
}

/// @nodoc
abstract mixin class _$FreeDomeConnectionStatusCopyWith<$Res>
    implements $FreeDomeConnectionStatusCopyWith<$Res> {
  factory _$FreeDomeConnectionStatusCopyWith(_FreeDomeConnectionStatus value,
          $Res Function(_FreeDomeConnectionStatus) _then) =
      __$FreeDomeConnectionStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isConnected,
      bool isConnecting,
      String? connectedDomeId,
      String? serverUrl,
      DateTime? lastConnected,
      String? error,
      int reconnectAttempts,
      int maxReconnectAttempts});
}

/// @nodoc
class __$FreeDomeConnectionStatusCopyWithImpl<$Res>
    implements _$FreeDomeConnectionStatusCopyWith<$Res> {
  __$FreeDomeConnectionStatusCopyWithImpl(this._self, this._then);

  final _FreeDomeConnectionStatus _self;
  final $Res Function(_FreeDomeConnectionStatus) _then;

  /// Create a copy of FreeDomeConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isConnected = null,
    Object? isConnecting = null,
    Object? connectedDomeId = freezed,
    Object? serverUrl = freezed,
    Object? lastConnected = freezed,
    Object? error = freezed,
    Object? reconnectAttempts = null,
    Object? maxReconnectAttempts = null,
  }) {
    return _then(_FreeDomeConnectionStatus(
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnecting: null == isConnecting
          ? _self.isConnecting
          : isConnecting // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedDomeId: freezed == connectedDomeId
          ? _self.connectedDomeId
          : connectedDomeId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverUrl: freezed == serverUrl
          ? _self.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _self.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      reconnectAttempts: null == reconnectAttempts
          ? _self.reconnectAttempts
          : reconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      maxReconnectAttempts: null == maxReconnectAttempts
          ? _self.maxReconnectAttempts
          : maxReconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$FreeDomeUser {
  String get id;
  String get name;
  FreeDomeUserRole get role;
  List<FreeDomePermission> get permissions;
  String? get email;
  DateTime? get lastLogin;
  Map<String, dynamic>? get preferences;

  /// Create a copy of FreeDomeUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreeDomeUserCopyWith<FreeDomeUser> get copyWith =>
      _$FreeDomeUserCopyWithImpl<FreeDomeUser>(
          this as FreeDomeUser, _$identity);

  /// Serializes this FreeDomeUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreeDomeUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other.permissions, permissions) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            const DeepCollectionEquality()
                .equals(other.preferences, preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      role,
      const DeepCollectionEquality().hash(permissions),
      email,
      lastLogin,
      const DeepCollectionEquality().hash(preferences));

  @override
  String toString() {
    return 'FreeDomeUser(id: $id, name: $name, role: $role, permissions: $permissions, email: $email, lastLogin: $lastLogin, preferences: $preferences)';
  }
}

/// @nodoc
abstract mixin class $FreeDomeUserCopyWith<$Res> {
  factory $FreeDomeUserCopyWith(
          FreeDomeUser value, $Res Function(FreeDomeUser) _then) =
      _$FreeDomeUserCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      FreeDomeUserRole role,
      List<FreeDomePermission> permissions,
      String? email,
      DateTime? lastLogin,
      Map<String, dynamic>? preferences});
}

/// @nodoc
class _$FreeDomeUserCopyWithImpl<$Res> implements $FreeDomeUserCopyWith<$Res> {
  _$FreeDomeUserCopyWithImpl(this._self, this._then);

  final FreeDomeUser _self;
  final $Res Function(FreeDomeUser) _then;

  /// Create a copy of FreeDomeUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? role = null,
    Object? permissions = null,
    Object? email = freezed,
    Object? lastLogin = freezed,
    Object? preferences = freezed,
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
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as FreeDomeUserRole,
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<FreeDomePermission>,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLogin: freezed == lastLogin
          ? _self.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: freezed == preferences
          ? _self.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreeDomeUser].
extension FreeDomeUserPatterns on FreeDomeUser {
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
    TResult Function(_FreeDomeUser value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeUser() when $default != null:
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
    TResult Function(_FreeDomeUser value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeUser():
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
    TResult? Function(_FreeDomeUser value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeUser() when $default != null:
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
            FreeDomeUserRole role,
            List<FreeDomePermission> permissions,
            String? email,
            DateTime? lastLogin,
            Map<String, dynamic>? preferences)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeUser() when $default != null:
        return $default(_that.id, _that.name, _that.role, _that.permissions,
            _that.email, _that.lastLogin, _that.preferences);
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
            FreeDomeUserRole role,
            List<FreeDomePermission> permissions,
            String? email,
            DateTime? lastLogin,
            Map<String, dynamic>? preferences)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeUser():
        return $default(_that.id, _that.name, _that.role, _that.permissions,
            _that.email, _that.lastLogin, _that.preferences);
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
            FreeDomeUserRole role,
            List<FreeDomePermission> permissions,
            String? email,
            DateTime? lastLogin,
            Map<String, dynamic>? preferences)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeUser() when $default != null:
        return $default(_that.id, _that.name, _that.role, _that.permissions,
            _that.email, _that.lastLogin, _that.preferences);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FreeDomeUser implements FreeDomeUser {
  const _FreeDomeUser(
      {required this.id,
      required this.name,
      required this.role,
      required final List<FreeDomePermission> permissions,
      this.email,
      this.lastLogin,
      final Map<String, dynamic>? preferences})
      : _permissions = permissions,
        _preferences = preferences;
  factory _FreeDomeUser.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeUserFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final FreeDomeUserRole role;
  final List<FreeDomePermission> _permissions;
  @override
  List<FreeDomePermission> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final String? email;
  @override
  final DateTime? lastLogin;
  final Map<String, dynamic>? _preferences;
  @override
  Map<String, dynamic>? get preferences {
    final value = _preferences;
    if (value == null) return null;
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of FreeDomeUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FreeDomeUserCopyWith<_FreeDomeUser> get copyWith =>
      __$FreeDomeUserCopyWithImpl<_FreeDomeUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FreeDomeUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FreeDomeUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      role,
      const DeepCollectionEquality().hash(_permissions),
      email,
      lastLogin,
      const DeepCollectionEquality().hash(_preferences));

  @override
  String toString() {
    return 'FreeDomeUser(id: $id, name: $name, role: $role, permissions: $permissions, email: $email, lastLogin: $lastLogin, preferences: $preferences)';
  }
}

/// @nodoc
abstract mixin class _$FreeDomeUserCopyWith<$Res>
    implements $FreeDomeUserCopyWith<$Res> {
  factory _$FreeDomeUserCopyWith(
          _FreeDomeUser value, $Res Function(_FreeDomeUser) _then) =
      __$FreeDomeUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      FreeDomeUserRole role,
      List<FreeDomePermission> permissions,
      String? email,
      DateTime? lastLogin,
      Map<String, dynamic>? preferences});
}

/// @nodoc
class __$FreeDomeUserCopyWithImpl<$Res>
    implements _$FreeDomeUserCopyWith<$Res> {
  __$FreeDomeUserCopyWithImpl(this._self, this._then);

  final _FreeDomeUser _self;
  final $Res Function(_FreeDomeUser) _then;

  /// Create a copy of FreeDomeUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? role = null,
    Object? permissions = null,
    Object? email = freezed,
    Object? lastLogin = freezed,
    Object? preferences = freezed,
  }) {
    return _then(_FreeDomeUser(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as FreeDomeUserRole,
      permissions: null == permissions
          ? _self._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<FreeDomePermission>,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLogin: freezed == lastLogin
          ? _self.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: freezed == preferences
          ? _self._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$FreeDomeSession {
  String get id;
  String get userId;
  String get domeId;
  DateTime get startTime;
  DateTime? get endTime;
  Duration get duration;
  String? get currentContentId;
  Map<String, dynamic>? get sessionData;

  /// Create a copy of FreeDomeSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreeDomeSessionCopyWith<FreeDomeSession> get copyWith =>
      _$FreeDomeSessionCopyWithImpl<FreeDomeSession>(
          this as FreeDomeSession, _$identity);

  /// Serializes this FreeDomeSession to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreeDomeSession &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.domeId, domeId) || other.domeId == domeId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.currentContentId, currentContentId) ||
                other.currentContentId == currentContentId) &&
            const DeepCollectionEquality()
                .equals(other.sessionData, sessionData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      domeId,
      startTime,
      endTime,
      duration,
      currentContentId,
      const DeepCollectionEquality().hash(sessionData));

  @override
  String toString() {
    return 'FreeDomeSession(id: $id, userId: $userId, domeId: $domeId, startTime: $startTime, endTime: $endTime, duration: $duration, currentContentId: $currentContentId, sessionData: $sessionData)';
  }
}

/// @nodoc
abstract mixin class $FreeDomeSessionCopyWith<$Res> {
  factory $FreeDomeSessionCopyWith(
          FreeDomeSession value, $Res Function(FreeDomeSession) _then) =
      _$FreeDomeSessionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String domeId,
      DateTime startTime,
      DateTime? endTime,
      Duration duration,
      String? currentContentId,
      Map<String, dynamic>? sessionData});
}

/// @nodoc
class _$FreeDomeSessionCopyWithImpl<$Res>
    implements $FreeDomeSessionCopyWith<$Res> {
  _$FreeDomeSessionCopyWithImpl(this._self, this._then);

  final FreeDomeSession _self;
  final $Res Function(FreeDomeSession) _then;

  /// Create a copy of FreeDomeSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? domeId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? duration = null,
    Object? currentContentId = freezed,
    Object? sessionData = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      domeId: null == domeId
          ? _self.domeId
          : domeId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      currentContentId: freezed == currentContentId
          ? _self.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionData: freezed == sessionData
          ? _self.sessionData
          : sessionData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreeDomeSession].
extension FreeDomeSessionPatterns on FreeDomeSession {
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
    TResult Function(_FreeDomeSession value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeSession() when $default != null:
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
    TResult Function(_FreeDomeSession value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeSession():
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
    TResult? Function(_FreeDomeSession value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeSession() when $default != null:
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
            String userId,
            String domeId,
            DateTime startTime,
            DateTime? endTime,
            Duration duration,
            String? currentContentId,
            Map<String, dynamic>? sessionData)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeSession() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.domeId,
            _that.startTime,
            _that.endTime,
            _that.duration,
            _that.currentContentId,
            _that.sessionData);
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
            String userId,
            String domeId,
            DateTime startTime,
            DateTime? endTime,
            Duration duration,
            String? currentContentId,
            Map<String, dynamic>? sessionData)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeSession():
        return $default(
            _that.id,
            _that.userId,
            _that.domeId,
            _that.startTime,
            _that.endTime,
            _that.duration,
            _that.currentContentId,
            _that.sessionData);
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
            String userId,
            String domeId,
            DateTime startTime,
            DateTime? endTime,
            Duration duration,
            String? currentContentId,
            Map<String, dynamic>? sessionData)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeSession() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.domeId,
            _that.startTime,
            _that.endTime,
            _that.duration,
            _that.currentContentId,
            _that.sessionData);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FreeDomeSession implements FreeDomeSession {
  const _FreeDomeSession(
      {required this.id,
      required this.userId,
      required this.domeId,
      required this.startTime,
      this.endTime,
      this.duration = Duration.zero,
      this.currentContentId,
      final Map<String, dynamic>? sessionData})
      : _sessionData = sessionData;
  factory _FreeDomeSession.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeSessionFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String domeId;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  @JsonKey()
  final Duration duration;
  @override
  final String? currentContentId;
  final Map<String, dynamic>? _sessionData;
  @override
  Map<String, dynamic>? get sessionData {
    final value = _sessionData;
    if (value == null) return null;
    if (_sessionData is EqualUnmodifiableMapView) return _sessionData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of FreeDomeSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FreeDomeSessionCopyWith<_FreeDomeSession> get copyWith =>
      __$FreeDomeSessionCopyWithImpl<_FreeDomeSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FreeDomeSessionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FreeDomeSession &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.domeId, domeId) || other.domeId == domeId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.currentContentId, currentContentId) ||
                other.currentContentId == currentContentId) &&
            const DeepCollectionEquality()
                .equals(other._sessionData, _sessionData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      domeId,
      startTime,
      endTime,
      duration,
      currentContentId,
      const DeepCollectionEquality().hash(_sessionData));

  @override
  String toString() {
    return 'FreeDomeSession(id: $id, userId: $userId, domeId: $domeId, startTime: $startTime, endTime: $endTime, duration: $duration, currentContentId: $currentContentId, sessionData: $sessionData)';
  }
}

/// @nodoc
abstract mixin class _$FreeDomeSessionCopyWith<$Res>
    implements $FreeDomeSessionCopyWith<$Res> {
  factory _$FreeDomeSessionCopyWith(
          _FreeDomeSession value, $Res Function(_FreeDomeSession) _then) =
      __$FreeDomeSessionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String domeId,
      DateTime startTime,
      DateTime? endTime,
      Duration duration,
      String? currentContentId,
      Map<String, dynamic>? sessionData});
}

/// @nodoc
class __$FreeDomeSessionCopyWithImpl<$Res>
    implements _$FreeDomeSessionCopyWith<$Res> {
  __$FreeDomeSessionCopyWithImpl(this._self, this._then);

  final _FreeDomeSession _self;
  final $Res Function(_FreeDomeSession) _then;

  /// Create a copy of FreeDomeSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? domeId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? duration = null,
    Object? currentContentId = freezed,
    Object? sessionData = freezed,
  }) {
    return _then(_FreeDomeSession(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      domeId: null == domeId
          ? _self.domeId
          : domeId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      currentContentId: freezed == currentContentId
          ? _self.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionData: freezed == sessionData
          ? _self._sessionData
          : sessionData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

// dart format on
