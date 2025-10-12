// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dome_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DomeSystem _$DomeSystemFromJson(Map<String, dynamic> json) {
  return _DomeSystem.fromJson(json);
}

/// @nodoc
mixin _$DomeSystem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get ipAddress => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  DomeSystemType get type => throw _privateConstructorUsedError;
  DomeSystemStatus get status => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  List<ProjectorConfig> get projectors => throw _privateConstructorUsedError;
  List<AudioChannel> get audioChannels => throw _privateConstructorUsedError;
  DateTime? get lastConnected => throw _privateConstructorUsedError;
  String? get firmwareVersion => throw _privateConstructorUsedError;
  Map<String, dynamic>? get capabilities => throw _privateConstructorUsedError;
  String? get activeVendor => throw _privateConstructorUsedError;
  double get systemVolume => throw _privateConstructorUsedError;
  double get systemBrightness => throw _privateConstructorUsedError;
  double get systemRotation => throw _privateConstructorUsedError;

  /// Serializes this DomeSystem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DomeSystem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DomeSystemCopyWith<DomeSystem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DomeSystemCopyWith<$Res> {
  factory $DomeSystemCopyWith(
          DomeSystem value, $Res Function(DomeSystem) then) =
      _$DomeSystemCopyWithImpl<$Res, DomeSystem>;
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
class _$DomeSystemCopyWithImpl<$Res, $Val extends DomeSystem>
    implements $DomeSystemCopyWith<$Res> {
  _$DomeSystemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ipAddress: null == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DomeSystemType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DomeSystemStatus,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      projectors: null == projectors
          ? _value.projectors
          : projectors // ignore: cast_nullable_to_non_nullable
              as List<ProjectorConfig>,
      audioChannels: null == audioChannels
          ? _value.audioChannels
          : audioChannels // ignore: cast_nullable_to_non_nullable
              as List<AudioChannel>,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firmwareVersion: freezed == firmwareVersion
          ? _value.firmwareVersion
          : firmwareVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      capabilities: freezed == capabilities
          ? _value.capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      activeVendor: freezed == activeVendor
          ? _value.activeVendor
          : activeVendor // ignore: cast_nullable_to_non_nullable
              as String?,
      systemVolume: null == systemVolume
          ? _value.systemVolume
          : systemVolume // ignore: cast_nullable_to_non_nullable
              as double,
      systemBrightness: null == systemBrightness
          ? _value.systemBrightness
          : systemBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      systemRotation: null == systemRotation
          ? _value.systemRotation
          : systemRotation // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DomeSystemImplCopyWith<$Res>
    implements $DomeSystemCopyWith<$Res> {
  factory _$$DomeSystemImplCopyWith(
          _$DomeSystemImpl value, $Res Function(_$DomeSystemImpl) then) =
      __$$DomeSystemImplCopyWithImpl<$Res>;
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
class __$$DomeSystemImplCopyWithImpl<$Res>
    extends _$DomeSystemCopyWithImpl<$Res, _$DomeSystemImpl>
    implements _$$DomeSystemImplCopyWith<$Res> {
  __$$DomeSystemImplCopyWithImpl(
      _$DomeSystemImpl _value, $Res Function(_$DomeSystemImpl) _then)
      : super(_value, _then);

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
    return _then(_$DomeSystemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ipAddress: null == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DomeSystemType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DomeSystemStatus,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      projectors: null == projectors
          ? _value._projectors
          : projectors // ignore: cast_nullable_to_non_nullable
              as List<ProjectorConfig>,
      audioChannels: null == audioChannels
          ? _value._audioChannels
          : audioChannels // ignore: cast_nullable_to_non_nullable
              as List<AudioChannel>,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firmwareVersion: freezed == firmwareVersion
          ? _value.firmwareVersion
          : firmwareVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      capabilities: freezed == capabilities
          ? _value._capabilities
          : capabilities // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      activeVendor: freezed == activeVendor
          ? _value.activeVendor
          : activeVendor // ignore: cast_nullable_to_non_nullable
              as String?,
      systemVolume: null == systemVolume
          ? _value.systemVolume
          : systemVolume // ignore: cast_nullable_to_non_nullable
              as double,
      systemBrightness: null == systemBrightness
          ? _value.systemBrightness
          : systemBrightness // ignore: cast_nullable_to_non_nullable
              as double,
      systemRotation: null == systemRotation
          ? _value.systemRotation
          : systemRotation // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DomeSystemImpl implements _DomeSystem {
  const _$DomeSystemImpl(
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

  factory _$DomeSystemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DomeSystemImplFromJson(json);

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

  @override
  String toString() {
    return 'DomeSystem(id: $id, name: $name, ipAddress: $ipAddress, port: $port, type: $type, status: $status, isConnected: $isConnected, projectors: $projectors, audioChannels: $audioChannels, lastConnected: $lastConnected, firmwareVersion: $firmwareVersion, capabilities: $capabilities, activeVendor: $activeVendor, systemVolume: $systemVolume, systemBrightness: $systemBrightness, systemRotation: $systemRotation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DomeSystemImpl &&
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

  /// Create a copy of DomeSystem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DomeSystemImplCopyWith<_$DomeSystemImpl> get copyWith =>
      __$$DomeSystemImplCopyWithImpl<_$DomeSystemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DomeSystemImplToJson(
      this,
    );
  }
}

abstract class _DomeSystem implements DomeSystem {
  const factory _DomeSystem(
      {required final String id,
      required final String name,
      required final String ipAddress,
      required final int port,
      required final DomeSystemType type,
      required final DomeSystemStatus status,
      final bool isConnected,
      final List<ProjectorConfig> projectors,
      final List<AudioChannel> audioChannels,
      final DateTime? lastConnected,
      final String? firmwareVersion,
      final Map<String, dynamic>? capabilities,
      final String? activeVendor,
      final double systemVolume,
      final double systemBrightness,
      final double systemRotation}) = _$DomeSystemImpl;

  factory _DomeSystem.fromJson(Map<String, dynamic> json) =
      _$DomeSystemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get ipAddress;
  @override
  int get port;
  @override
  DomeSystemType get type;
  @override
  DomeSystemStatus get status;
  @override
  bool get isConnected;
  @override
  List<ProjectorConfig> get projectors;
  @override
  List<AudioChannel> get audioChannels;
  @override
  DateTime? get lastConnected;
  @override
  String? get firmwareVersion;
  @override
  Map<String, dynamic>? get capabilities;
  @override
  String? get activeVendor;
  @override
  double get systemVolume;
  @override
  double get systemBrightness;
  @override
  double get systemRotation;

  /// Create a copy of DomeSystem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DomeSystemImplCopyWith<_$DomeSystemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectorConfig _$ProjectorConfigFromJson(Map<String, dynamic> json) {
  return _ProjectorConfig.fromJson(json);
}

/// @nodoc
mixin _$ProjectorConfig {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ProjectorType get type => throw _privateConstructorUsedError;
  int get brightness => throw _privateConstructorUsedError;
  int get contrast => throw _privateConstructorUsedError;
  ProjectorStatus get status => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get z => throw _privateConstructorUsedError;
  double get pitch => throw _privateConstructorUsedError;
  double get yaw => throw _privateConstructorUsedError;
  double get roll => throw _privateConstructorUsedError;
  int get resolutionWidth => throw _privateConstructorUsedError;
  int get resolutionHeight => throw _privateConstructorUsedError;
  double get refreshRate => throw _privateConstructorUsedError;
  Map<String, dynamic>? get calibrationData =>
      throw _privateConstructorUsedError;

  /// Serializes this ProjectorConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectorConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectorConfigCopyWith<ProjectorConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectorConfigCopyWith<$Res> {
  factory $ProjectorConfigCopyWith(
          ProjectorConfig value, $Res Function(ProjectorConfig) then) =
      _$ProjectorConfigCopyWithImpl<$Res, ProjectorConfig>;
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
class _$ProjectorConfigCopyWithImpl<$Res, $Val extends ProjectorConfig>
    implements $ProjectorConfigCopyWith<$Res> {
  _$ProjectorConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ProjectorType,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int,
      contrast: null == contrast
          ? _value.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectorStatus,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      yaw: null == yaw
          ? _value.yaw
          : yaw // ignore: cast_nullable_to_non_nullable
              as double,
      roll: null == roll
          ? _value.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as double,
      resolutionWidth: null == resolutionWidth
          ? _value.resolutionWidth
          : resolutionWidth // ignore: cast_nullable_to_non_nullable
              as int,
      resolutionHeight: null == resolutionHeight
          ? _value.resolutionHeight
          : resolutionHeight // ignore: cast_nullable_to_non_nullable
              as int,
      refreshRate: null == refreshRate
          ? _value.refreshRate
          : refreshRate // ignore: cast_nullable_to_non_nullable
              as double,
      calibrationData: freezed == calibrationData
          ? _value.calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectorConfigImplCopyWith<$Res>
    implements $ProjectorConfigCopyWith<$Res> {
  factory _$$ProjectorConfigImplCopyWith(_$ProjectorConfigImpl value,
          $Res Function(_$ProjectorConfigImpl) then) =
      __$$ProjectorConfigImplCopyWithImpl<$Res>;
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
class __$$ProjectorConfigImplCopyWithImpl<$Res>
    extends _$ProjectorConfigCopyWithImpl<$Res, _$ProjectorConfigImpl>
    implements _$$ProjectorConfigImplCopyWith<$Res> {
  __$$ProjectorConfigImplCopyWithImpl(
      _$ProjectorConfigImpl _value, $Res Function(_$ProjectorConfigImpl) _then)
      : super(_value, _then);

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
    return _then(_$ProjectorConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ProjectorType,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int,
      contrast: null == contrast
          ? _value.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectorStatus,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      yaw: null == yaw
          ? _value.yaw
          : yaw // ignore: cast_nullable_to_non_nullable
              as double,
      roll: null == roll
          ? _value.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as double,
      resolutionWidth: null == resolutionWidth
          ? _value.resolutionWidth
          : resolutionWidth // ignore: cast_nullable_to_non_nullable
              as int,
      resolutionHeight: null == resolutionHeight
          ? _value.resolutionHeight
          : resolutionHeight // ignore: cast_nullable_to_non_nullable
              as int,
      refreshRate: null == refreshRate
          ? _value.refreshRate
          : refreshRate // ignore: cast_nullable_to_non_nullable
              as double,
      calibrationData: freezed == calibrationData
          ? _value._calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectorConfigImpl implements _ProjectorConfig {
  const _$ProjectorConfigImpl(
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

  factory _$ProjectorConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectorConfigImplFromJson(json);

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

  @override
  String toString() {
    return 'ProjectorConfig(id: $id, name: $name, type: $type, brightness: $brightness, contrast: $contrast, status: $status, x: $x, y: $y, z: $z, pitch: $pitch, yaw: $yaw, roll: $roll, resolutionWidth: $resolutionWidth, resolutionHeight: $resolutionHeight, refreshRate: $refreshRate, calibrationData: $calibrationData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectorConfigImpl &&
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

  /// Create a copy of ProjectorConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectorConfigImplCopyWith<_$ProjectorConfigImpl> get copyWith =>
      __$$ProjectorConfigImplCopyWithImpl<_$ProjectorConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectorConfigImplToJson(
      this,
    );
  }
}

abstract class _ProjectorConfig implements ProjectorConfig {
  const factory _ProjectorConfig(
      {required final String id,
      required final String name,
      required final ProjectorType type,
      required final int brightness,
      required final int contrast,
      required final ProjectorStatus status,
      final double x,
      final double y,
      final double z,
      final double pitch,
      final double yaw,
      final double roll,
      final int resolutionWidth,
      final int resolutionHeight,
      final double refreshRate,
      final Map<String, dynamic>? calibrationData}) = _$ProjectorConfigImpl;

  factory _ProjectorConfig.fromJson(Map<String, dynamic> json) =
      _$ProjectorConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ProjectorType get type;
  @override
  int get brightness;
  @override
  int get contrast;
  @override
  ProjectorStatus get status;
  @override
  double get x;
  @override
  double get y;
  @override
  double get z;
  @override
  double get pitch;
  @override
  double get yaw;
  @override
  double get roll;
  @override
  int get resolutionWidth;
  @override
  int get resolutionHeight;
  @override
  double get refreshRate;
  @override
  Map<String, dynamic>? get calibrationData;

  /// Create a copy of ProjectorConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectorConfigImplCopyWith<_$ProjectorConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AudioChannel _$AudioChannelFromJson(Map<String, dynamic> json) {
  return _AudioChannel.fromJson(json);
}

/// @nodoc
mixin _$AudioChannel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  AudioChannelType get type => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get z => throw _privateConstructorUsedError;
  double get delay => throw _privateConstructorUsedError;
  Map<String, dynamic>? get equalizerSettings =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get calibrationData =>
      throw _privateConstructorUsedError;

  /// Serializes this AudioChannel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioChannel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioChannelCopyWith<AudioChannel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioChannelCopyWith<$Res> {
  factory $AudioChannelCopyWith(
          AudioChannel value, $Res Function(AudioChannel) then) =
      _$AudioChannelCopyWithImpl<$Res, AudioChannel>;
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
class _$AudioChannelCopyWithImpl<$Res, $Val extends AudioChannel>
    implements $AudioChannelCopyWith<$Res> {
  _$AudioChannelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AudioChannelType,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _value.equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      calibrationData: freezed == calibrationData
          ? _value.calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioChannelImplCopyWith<$Res>
    implements $AudioChannelCopyWith<$Res> {
  factory _$$AudioChannelImplCopyWith(
          _$AudioChannelImpl value, $Res Function(_$AudioChannelImpl) then) =
      __$$AudioChannelImplCopyWithImpl<$Res>;
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
class __$$AudioChannelImplCopyWithImpl<$Res>
    extends _$AudioChannelCopyWithImpl<$Res, _$AudioChannelImpl>
    implements _$$AudioChannelImplCopyWith<$Res> {
  __$$AudioChannelImplCopyWithImpl(
      _$AudioChannelImpl _value, $Res Function(_$AudioChannelImpl) _then)
      : super(_value, _then);

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
    return _then(_$AudioChannelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AudioChannelType,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _value._equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      calibrationData: freezed == calibrationData
          ? _value._calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioChannelImpl implements _AudioChannel {
  const _$AudioChannelImpl(
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

  factory _$AudioChannelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioChannelImplFromJson(json);

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

  @override
  String toString() {
    return 'AudioChannel(id: $id, name: $name, type: $type, volume: $volume, isMuted: $isMuted, x: $x, y: $y, z: $z, delay: $delay, equalizerSettings: $equalizerSettings, calibrationData: $calibrationData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioChannelImpl &&
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

  /// Create a copy of AudioChannel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioChannelImplCopyWith<_$AudioChannelImpl> get copyWith =>
      __$$AudioChannelImplCopyWithImpl<_$AudioChannelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioChannelImplToJson(
      this,
    );
  }
}

abstract class _AudioChannel implements AudioChannel {
  const factory _AudioChannel(
      {required final String id,
      required final String name,
      required final AudioChannelType type,
      final double volume,
      final bool isMuted,
      final double x,
      final double y,
      final double z,
      final double delay,
      final Map<String, dynamic>? equalizerSettings,
      final Map<String, dynamic>? calibrationData}) = _$AudioChannelImpl;

  factory _AudioChannel.fromJson(Map<String, dynamic> json) =
      _$AudioChannelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  AudioChannelType get type;
  @override
  double get volume;
  @override
  bool get isMuted;
  @override
  double get x;
  @override
  double get y;
  @override
  double get z;
  @override
  double get delay;
  @override
  Map<String, dynamic>? get equalizerSettings;
  @override
  Map<String, dynamic>? get calibrationData;

  /// Create a copy of AudioChannel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioChannelImplCopyWith<_$AudioChannelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FreeDomeConnectionStatus _$FreeDomeConnectionStatusFromJson(
    Map<String, dynamic> json) {
  return _FreeDomeConnectionStatus.fromJson(json);
}

/// @nodoc
mixin _$FreeDomeConnectionStatus {
  bool get isConnected => throw _privateConstructorUsedError;
  bool get isConnecting => throw _privateConstructorUsedError;
  String? get connectedDomeId => throw _privateConstructorUsedError;
  String? get serverUrl => throw _privateConstructorUsedError;
  DateTime? get lastConnected => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int get reconnectAttempts => throw _privateConstructorUsedError;
  int get maxReconnectAttempts => throw _privateConstructorUsedError;

  /// Serializes this FreeDomeConnectionStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FreeDomeConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FreeDomeConnectionStatusCopyWith<FreeDomeConnectionStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreeDomeConnectionStatusCopyWith<$Res> {
  factory $FreeDomeConnectionStatusCopyWith(FreeDomeConnectionStatus value,
          $Res Function(FreeDomeConnectionStatus) then) =
      _$FreeDomeConnectionStatusCopyWithImpl<$Res, FreeDomeConnectionStatus>;
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
class _$FreeDomeConnectionStatusCopyWithImpl<$Res,
        $Val extends FreeDomeConnectionStatus>
    implements $FreeDomeConnectionStatusCopyWith<$Res> {
  _$FreeDomeConnectionStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnecting: null == isConnecting
          ? _value.isConnecting
          : isConnecting // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedDomeId: freezed == connectedDomeId
          ? _value.connectedDomeId
          : connectedDomeId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverUrl: freezed == serverUrl
          ? _value.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      reconnectAttempts: null == reconnectAttempts
          ? _value.reconnectAttempts
          : reconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      maxReconnectAttempts: null == maxReconnectAttempts
          ? _value.maxReconnectAttempts
          : maxReconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreeDomeConnectionStatusImplCopyWith<$Res>
    implements $FreeDomeConnectionStatusCopyWith<$Res> {
  factory _$$FreeDomeConnectionStatusImplCopyWith(
          _$FreeDomeConnectionStatusImpl value,
          $Res Function(_$FreeDomeConnectionStatusImpl) then) =
      __$$FreeDomeConnectionStatusImplCopyWithImpl<$Res>;
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
class __$$FreeDomeConnectionStatusImplCopyWithImpl<$Res>
    extends _$FreeDomeConnectionStatusCopyWithImpl<$Res,
        _$FreeDomeConnectionStatusImpl>
    implements _$$FreeDomeConnectionStatusImplCopyWith<$Res> {
  __$$FreeDomeConnectionStatusImplCopyWithImpl(
      _$FreeDomeConnectionStatusImpl _value,
      $Res Function(_$FreeDomeConnectionStatusImpl) _then)
      : super(_value, _then);

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
    return _then(_$FreeDomeConnectionStatusImpl(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnecting: null == isConnecting
          ? _value.isConnecting
          : isConnecting // ignore: cast_nullable_to_non_nullable
              as bool,
      connectedDomeId: freezed == connectedDomeId
          ? _value.connectedDomeId
          : connectedDomeId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverUrl: freezed == serverUrl
          ? _value.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      reconnectAttempts: null == reconnectAttempts
          ? _value.reconnectAttempts
          : reconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
      maxReconnectAttempts: null == maxReconnectAttempts
          ? _value.maxReconnectAttempts
          : maxReconnectAttempts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreeDomeConnectionStatusImpl implements _FreeDomeConnectionStatus {
  const _$FreeDomeConnectionStatusImpl(
      {required this.isConnected,
      required this.isConnecting,
      this.connectedDomeId,
      this.serverUrl,
      this.lastConnected,
      this.error,
      this.reconnectAttempts = 0,
      this.maxReconnectAttempts = 5});

  factory _$FreeDomeConnectionStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreeDomeConnectionStatusImplFromJson(json);

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

  @override
  String toString() {
    return 'FreeDomeConnectionStatus(isConnected: $isConnected, isConnecting: $isConnecting, connectedDomeId: $connectedDomeId, serverUrl: $serverUrl, lastConnected: $lastConnected, error: $error, reconnectAttempts: $reconnectAttempts, maxReconnectAttempts: $maxReconnectAttempts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreeDomeConnectionStatusImpl &&
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

  /// Create a copy of FreeDomeConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FreeDomeConnectionStatusImplCopyWith<_$FreeDomeConnectionStatusImpl>
      get copyWith => __$$FreeDomeConnectionStatusImplCopyWithImpl<
          _$FreeDomeConnectionStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreeDomeConnectionStatusImplToJson(
      this,
    );
  }
}

abstract class _FreeDomeConnectionStatus implements FreeDomeConnectionStatus {
  const factory _FreeDomeConnectionStatus(
      {required final bool isConnected,
      required final bool isConnecting,
      final String? connectedDomeId,
      final String? serverUrl,
      final DateTime? lastConnected,
      final String? error,
      final int reconnectAttempts,
      final int maxReconnectAttempts}) = _$FreeDomeConnectionStatusImpl;

  factory _FreeDomeConnectionStatus.fromJson(Map<String, dynamic> json) =
      _$FreeDomeConnectionStatusImpl.fromJson;

  @override
  bool get isConnected;
  @override
  bool get isConnecting;
  @override
  String? get connectedDomeId;
  @override
  String? get serverUrl;
  @override
  DateTime? get lastConnected;
  @override
  String? get error;
  @override
  int get reconnectAttempts;
  @override
  int get maxReconnectAttempts;

  /// Create a copy of FreeDomeConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FreeDomeConnectionStatusImplCopyWith<_$FreeDomeConnectionStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FreeDomeUser _$FreeDomeUserFromJson(Map<String, dynamic> json) {
  return _FreeDomeUser.fromJson(json);
}

/// @nodoc
mixin _$FreeDomeUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  FreeDomeUserRole get role => throw _privateConstructorUsedError;
  List<FreeDomePermission> get permissions =>
      throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  Map<String, dynamic>? get preferences => throw _privateConstructorUsedError;

  /// Serializes this FreeDomeUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FreeDomeUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FreeDomeUserCopyWith<FreeDomeUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreeDomeUserCopyWith<$Res> {
  factory $FreeDomeUserCopyWith(
          FreeDomeUser value, $Res Function(FreeDomeUser) then) =
      _$FreeDomeUserCopyWithImpl<$Res, FreeDomeUser>;
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
class _$FreeDomeUserCopyWithImpl<$Res, $Val extends FreeDomeUser>
    implements $FreeDomeUserCopyWith<$Res> {
  _$FreeDomeUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as FreeDomeUserRole,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<FreeDomePermission>,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreeDomeUserImplCopyWith<$Res>
    implements $FreeDomeUserCopyWith<$Res> {
  factory _$$FreeDomeUserImplCopyWith(
          _$FreeDomeUserImpl value, $Res Function(_$FreeDomeUserImpl) then) =
      __$$FreeDomeUserImplCopyWithImpl<$Res>;
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
class __$$FreeDomeUserImplCopyWithImpl<$Res>
    extends _$FreeDomeUserCopyWithImpl<$Res, _$FreeDomeUserImpl>
    implements _$$FreeDomeUserImplCopyWith<$Res> {
  __$$FreeDomeUserImplCopyWithImpl(
      _$FreeDomeUserImpl _value, $Res Function(_$FreeDomeUserImpl) _then)
      : super(_value, _then);

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
    return _then(_$FreeDomeUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as FreeDomeUserRole,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<FreeDomePermission>,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: freezed == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreeDomeUserImpl implements _FreeDomeUser {
  const _$FreeDomeUserImpl(
      {required this.id,
      required this.name,
      required this.role,
      required final List<FreeDomePermission> permissions,
      this.email,
      this.lastLogin,
      final Map<String, dynamic>? preferences})
      : _permissions = permissions,
        _preferences = preferences;

  factory _$FreeDomeUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreeDomeUserImplFromJson(json);

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

  @override
  String toString() {
    return 'FreeDomeUser(id: $id, name: $name, role: $role, permissions: $permissions, email: $email, lastLogin: $lastLogin, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreeDomeUserImpl &&
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

  /// Create a copy of FreeDomeUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FreeDomeUserImplCopyWith<_$FreeDomeUserImpl> get copyWith =>
      __$$FreeDomeUserImplCopyWithImpl<_$FreeDomeUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreeDomeUserImplToJson(
      this,
    );
  }
}

abstract class _FreeDomeUser implements FreeDomeUser {
  const factory _FreeDomeUser(
      {required final String id,
      required final String name,
      required final FreeDomeUserRole role,
      required final List<FreeDomePermission> permissions,
      final String? email,
      final DateTime? lastLogin,
      final Map<String, dynamic>? preferences}) = _$FreeDomeUserImpl;

  factory _FreeDomeUser.fromJson(Map<String, dynamic> json) =
      _$FreeDomeUserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  FreeDomeUserRole get role;
  @override
  List<FreeDomePermission> get permissions;
  @override
  String? get email;
  @override
  DateTime? get lastLogin;
  @override
  Map<String, dynamic>? get preferences;

  /// Create a copy of FreeDomeUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FreeDomeUserImplCopyWith<_$FreeDomeUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FreeDomeSession _$FreeDomeSessionFromJson(Map<String, dynamic> json) {
  return _FreeDomeSession.fromJson(json);
}

/// @nodoc
mixin _$FreeDomeSession {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get domeId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get currentContentId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get sessionData => throw _privateConstructorUsedError;

  /// Serializes this FreeDomeSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FreeDomeSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FreeDomeSessionCopyWith<FreeDomeSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreeDomeSessionCopyWith<$Res> {
  factory $FreeDomeSessionCopyWith(
          FreeDomeSession value, $Res Function(FreeDomeSession) then) =
      _$FreeDomeSessionCopyWithImpl<$Res, FreeDomeSession>;
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
class _$FreeDomeSessionCopyWithImpl<$Res, $Val extends FreeDomeSession>
    implements $FreeDomeSessionCopyWith<$Res> {
  _$FreeDomeSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      domeId: null == domeId
          ? _value.domeId
          : domeId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      currentContentId: freezed == currentContentId
          ? _value.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionData: freezed == sessionData
          ? _value.sessionData
          : sessionData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreeDomeSessionImplCopyWith<$Res>
    implements $FreeDomeSessionCopyWith<$Res> {
  factory _$$FreeDomeSessionImplCopyWith(_$FreeDomeSessionImpl value,
          $Res Function(_$FreeDomeSessionImpl) then) =
      __$$FreeDomeSessionImplCopyWithImpl<$Res>;
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
class __$$FreeDomeSessionImplCopyWithImpl<$Res>
    extends _$FreeDomeSessionCopyWithImpl<$Res, _$FreeDomeSessionImpl>
    implements _$$FreeDomeSessionImplCopyWith<$Res> {
  __$$FreeDomeSessionImplCopyWithImpl(
      _$FreeDomeSessionImpl _value, $Res Function(_$FreeDomeSessionImpl) _then)
      : super(_value, _then);

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
    return _then(_$FreeDomeSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      domeId: null == domeId
          ? _value.domeId
          : domeId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      currentContentId: freezed == currentContentId
          ? _value.currentContentId
          : currentContentId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionData: freezed == sessionData
          ? _value._sessionData
          : sessionData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreeDomeSessionImpl implements _FreeDomeSession {
  const _$FreeDomeSessionImpl(
      {required this.id,
      required this.userId,
      required this.domeId,
      required this.startTime,
      this.endTime,
      this.duration = Duration.zero,
      this.currentContentId,
      final Map<String, dynamic>? sessionData})
      : _sessionData = sessionData;

  factory _$FreeDomeSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreeDomeSessionImplFromJson(json);

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

  @override
  String toString() {
    return 'FreeDomeSession(id: $id, userId: $userId, domeId: $domeId, startTime: $startTime, endTime: $endTime, duration: $duration, currentContentId: $currentContentId, sessionData: $sessionData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreeDomeSessionImpl &&
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

  /// Create a copy of FreeDomeSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FreeDomeSessionImplCopyWith<_$FreeDomeSessionImpl> get copyWith =>
      __$$FreeDomeSessionImplCopyWithImpl<_$FreeDomeSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreeDomeSessionImplToJson(
      this,
    );
  }
}

abstract class _FreeDomeSession implements FreeDomeSession {
  const factory _FreeDomeSession(
      {required final String id,
      required final String userId,
      required final String domeId,
      required final DateTime startTime,
      final DateTime? endTime,
      final Duration duration,
      final String? currentContentId,
      final Map<String, dynamic>? sessionData}) = _$FreeDomeSessionImpl;

  factory _FreeDomeSession.fromJson(Map<String, dynamic> json) =
      _$FreeDomeSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get domeId;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  Duration get duration;
  @override
  String? get currentContentId;
  @override
  Map<String, dynamic>? get sessionData;

  /// Create a copy of FreeDomeSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FreeDomeSessionImplCopyWith<_$FreeDomeSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
