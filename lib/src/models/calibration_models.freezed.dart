// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calibration_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalibrationProgress _$CalibrationProgressFromJson(Map<String, dynamic> json) {
  return _CalibrationProgress.fromJson(json);
}

/// @nodoc
mixin _$CalibrationProgress {
  String get id => throw _privateConstructorUsedError;
  CalibrationType get type => throw _privateConstructorUsedError;
  CalibrationStatus get status => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  String get currentStep => throw _privateConstructorUsedError;
  int get totalSteps => throw _privateConstructorUsedError;
  int get completedSteps => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get estimatedCompletion => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Map<String, dynamic>? get stepData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalibrationProgressCopyWith<CalibrationProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalibrationProgressCopyWith<$Res> {
  factory $CalibrationProgressCopyWith(
          CalibrationProgress value, $Res Function(CalibrationProgress) then) =
      _$CalibrationProgressCopyWithImpl<$Res, CalibrationProgress>;
  @useResult
  $Res call(
      {String id,
      CalibrationType type,
      CalibrationStatus status,
      double progress,
      String currentStep,
      int totalSteps,
      int completedSteps,
      DateTime? startTime,
      DateTime? estimatedCompletion,
      String? error,
      Map<String, dynamic>? stepData});
}

/// @nodoc
class _$CalibrationProgressCopyWithImpl<$Res, $Val extends CalibrationProgress>
    implements $CalibrationProgressCopyWith<$Res> {
  _$CalibrationProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? progress = null,
    Object? currentStep = null,
    Object? totalSteps = null,
    Object? completedSteps = null,
    Object? startTime = freezed,
    Object? estimatedCompletion = freezed,
    Object? error = freezed,
    Object? stepData = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String,
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      completedSteps: null == completedSteps
          ? _value.completedSteps
          : completedSteps // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      stepData: freezed == stepData
          ? _value.stepData
          : stepData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalibrationProgressImplCopyWith<$Res>
    implements $CalibrationProgressCopyWith<$Res> {
  factory _$$CalibrationProgressImplCopyWith(_$CalibrationProgressImpl value,
          $Res Function(_$CalibrationProgressImpl) then) =
      __$$CalibrationProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CalibrationType type,
      CalibrationStatus status,
      double progress,
      String currentStep,
      int totalSteps,
      int completedSteps,
      DateTime? startTime,
      DateTime? estimatedCompletion,
      String? error,
      Map<String, dynamic>? stepData});
}

/// @nodoc
class __$$CalibrationProgressImplCopyWithImpl<$Res>
    extends _$CalibrationProgressCopyWithImpl<$Res, _$CalibrationProgressImpl>
    implements _$$CalibrationProgressImplCopyWith<$Res> {
  __$$CalibrationProgressImplCopyWithImpl(_$CalibrationProgressImpl _value,
      $Res Function(_$CalibrationProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? progress = null,
    Object? currentStep = null,
    Object? totalSteps = null,
    Object? completedSteps = null,
    Object? startTime = freezed,
    Object? estimatedCompletion = freezed,
    Object? error = freezed,
    Object? stepData = freezed,
  }) {
    return _then(_$CalibrationProgressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String,
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      completedSteps: null == completedSteps
          ? _value.completedSteps
          : completedSteps // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      stepData: freezed == stepData
          ? _value._stepData
          : stepData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalibrationProgressImpl implements _CalibrationProgress {
  const _$CalibrationProgressImpl(
      {required this.id,
      required this.type,
      required this.status,
      required this.progress,
      required this.currentStep,
      this.totalSteps = 0,
      this.completedSteps = 0,
      this.startTime,
      this.estimatedCompletion,
      this.error,
      final Map<String, dynamic>? stepData})
      : _stepData = stepData;

  factory _$CalibrationProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalibrationProgressImplFromJson(json);

  @override
  final String id;
  @override
  final CalibrationType type;
  @override
  final CalibrationStatus status;
  @override
  final double progress;
  @override
  final String currentStep;
  @override
  @JsonKey()
  final int totalSteps;
  @override
  @JsonKey()
  final int completedSteps;
  @override
  final DateTime? startTime;
  @override
  final DateTime? estimatedCompletion;
  @override
  final String? error;
  final Map<String, dynamic>? _stepData;
  @override
  Map<String, dynamic>? get stepData {
    final value = _stepData;
    if (value == null) return null;
    if (_stepData is EqualUnmodifiableMapView) return _stepData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CalibrationProgress(id: $id, type: $type, status: $status, progress: $progress, currentStep: $currentStep, totalSteps: $totalSteps, completedSteps: $completedSteps, startTime: $startTime, estimatedCompletion: $estimatedCompletion, error: $error, stepData: $stepData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalibrationProgressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.totalSteps, totalSteps) ||
                other.totalSteps == totalSteps) &&
            (identical(other.completedSteps, completedSteps) ||
                other.completedSteps == completedSteps) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.estimatedCompletion, estimatedCompletion) ||
                other.estimatedCompletion == estimatedCompletion) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._stepData, _stepData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      status,
      progress,
      currentStep,
      totalSteps,
      completedSteps,
      startTime,
      estimatedCompletion,
      error,
      const DeepCollectionEquality().hash(_stepData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalibrationProgressImplCopyWith<_$CalibrationProgressImpl> get copyWith =>
      __$$CalibrationProgressImplCopyWithImpl<_$CalibrationProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalibrationProgressImplToJson(
      this,
    );
  }
}

abstract class _CalibrationProgress implements CalibrationProgress {
  const factory _CalibrationProgress(
      {required final String id,
      required final CalibrationType type,
      required final CalibrationStatus status,
      required final double progress,
      required final String currentStep,
      final int totalSteps,
      final int completedSteps,
      final DateTime? startTime,
      final DateTime? estimatedCompletion,
      final String? error,
      final Map<String, dynamic>? stepData}) = _$CalibrationProgressImpl;

  factory _CalibrationProgress.fromJson(Map<String, dynamic> json) =
      _$CalibrationProgressImpl.fromJson;

  @override
  String get id;
  @override
  CalibrationType get type;
  @override
  CalibrationStatus get status;
  @override
  double get progress;
  @override
  String get currentStep;
  @override
  int get totalSteps;
  @override
  int get completedSteps;
  @override
  DateTime? get startTime;
  @override
  DateTime? get estimatedCompletion;
  @override
  String? get error;
  @override
  Map<String, dynamic>? get stepData;
  @override
  @JsonKey(ignore: true)
  _$$CalibrationProgressImplCopyWith<_$CalibrationProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalibrationResult _$CalibrationResultFromJson(Map<String, dynamic> json) {
  return _CalibrationResult.fromJson(json);
}

/// @nodoc
mixin _$CalibrationResult {
  String get id => throw _privateConstructorUsedError;
  CalibrationType get type => throw _privateConstructorUsedError;
  CalibrationStatus get status => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  List<ChannelResult> get channelResults => throw _privateConstructorUsedError;
  List<ProjectorResult> get projectorResults =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get systemResults => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  double get overallQuality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalibrationResultCopyWith<CalibrationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalibrationResultCopyWith<$Res> {
  factory $CalibrationResultCopyWith(
          CalibrationResult value, $Res Function(CalibrationResult) then) =
      _$CalibrationResultCopyWithImpl<$Res, CalibrationResult>;
  @useResult
  $Res call(
      {String id,
      CalibrationType type,
      CalibrationStatus status,
      DateTime startTime,
      DateTime? endTime,
      List<ChannelResult> channelResults,
      List<ProjectorResult> projectorResults,
      Map<String, dynamic>? systemResults,
      String? error,
      double overallQuality});
}

/// @nodoc
class _$CalibrationResultCopyWithImpl<$Res, $Val extends CalibrationResult>
    implements $CalibrationResultCopyWith<$Res> {
  _$CalibrationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? channelResults = null,
    Object? projectorResults = null,
    Object? systemResults = freezed,
    Object? error = freezed,
    Object? overallQuality = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      channelResults: null == channelResults
          ? _value.channelResults
          : channelResults // ignore: cast_nullable_to_non_nullable
              as List<ChannelResult>,
      projectorResults: null == projectorResults
          ? _value.projectorResults
          : projectorResults // ignore: cast_nullable_to_non_nullable
              as List<ProjectorResult>,
      systemResults: freezed == systemResults
          ? _value.systemResults
          : systemResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      overallQuality: null == overallQuality
          ? _value.overallQuality
          : overallQuality // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalibrationResultImplCopyWith<$Res>
    implements $CalibrationResultCopyWith<$Res> {
  factory _$$CalibrationResultImplCopyWith(_$CalibrationResultImpl value,
          $Res Function(_$CalibrationResultImpl) then) =
      __$$CalibrationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CalibrationType type,
      CalibrationStatus status,
      DateTime startTime,
      DateTime? endTime,
      List<ChannelResult> channelResults,
      List<ProjectorResult> projectorResults,
      Map<String, dynamic>? systemResults,
      String? error,
      double overallQuality});
}

/// @nodoc
class __$$CalibrationResultImplCopyWithImpl<$Res>
    extends _$CalibrationResultCopyWithImpl<$Res, _$CalibrationResultImpl>
    implements _$$CalibrationResultImplCopyWith<$Res> {
  __$$CalibrationResultImplCopyWithImpl(_$CalibrationResultImpl _value,
      $Res Function(_$CalibrationResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? channelResults = null,
    Object? projectorResults = null,
    Object? systemResults = freezed,
    Object? error = freezed,
    Object? overallQuality = null,
  }) {
    return _then(_$CalibrationResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      channelResults: null == channelResults
          ? _value._channelResults
          : channelResults // ignore: cast_nullable_to_non_nullable
              as List<ChannelResult>,
      projectorResults: null == projectorResults
          ? _value._projectorResults
          : projectorResults // ignore: cast_nullable_to_non_nullable
              as List<ProjectorResult>,
      systemResults: freezed == systemResults
          ? _value._systemResults
          : systemResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      overallQuality: null == overallQuality
          ? _value.overallQuality
          : overallQuality // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalibrationResultImpl implements _CalibrationResult {
  const _$CalibrationResultImpl(
      {required this.id,
      required this.type,
      required this.status,
      required this.startTime,
      this.endTime,
      final List<ChannelResult> channelResults = const [],
      final List<ProjectorResult> projectorResults = const [],
      final Map<String, dynamic>? systemResults,
      this.error,
      this.overallQuality = 0.0})
      : _channelResults = channelResults,
        _projectorResults = projectorResults,
        _systemResults = systemResults;

  factory _$CalibrationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalibrationResultImplFromJson(json);

  @override
  final String id;
  @override
  final CalibrationType type;
  @override
  final CalibrationStatus status;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  final List<ChannelResult> _channelResults;
  @override
  @JsonKey()
  List<ChannelResult> get channelResults {
    if (_channelResults is EqualUnmodifiableListView) return _channelResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channelResults);
  }

  final List<ProjectorResult> _projectorResults;
  @override
  @JsonKey()
  List<ProjectorResult> get projectorResults {
    if (_projectorResults is EqualUnmodifiableListView)
      return _projectorResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectorResults);
  }

  final Map<String, dynamic>? _systemResults;
  @override
  Map<String, dynamic>? get systemResults {
    final value = _systemResults;
    if (value == null) return null;
    if (_systemResults is EqualUnmodifiableMapView) return _systemResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? error;
  @override
  @JsonKey()
  final double overallQuality;

  @override
  String toString() {
    return 'CalibrationResult(id: $id, type: $type, status: $status, startTime: $startTime, endTime: $endTime, channelResults: $channelResults, projectorResults: $projectorResults, systemResults: $systemResults, error: $error, overallQuality: $overallQuality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalibrationResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality()
                .equals(other._channelResults, _channelResults) &&
            const DeepCollectionEquality()
                .equals(other._projectorResults, _projectorResults) &&
            const DeepCollectionEquality()
                .equals(other._systemResults, _systemResults) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.overallQuality, overallQuality) ||
                other.overallQuality == overallQuality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      status,
      startTime,
      endTime,
      const DeepCollectionEquality().hash(_channelResults),
      const DeepCollectionEquality().hash(_projectorResults),
      const DeepCollectionEquality().hash(_systemResults),
      error,
      overallQuality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalibrationResultImplCopyWith<_$CalibrationResultImpl> get copyWith =>
      __$$CalibrationResultImplCopyWithImpl<_$CalibrationResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalibrationResultImplToJson(
      this,
    );
  }
}

abstract class _CalibrationResult implements CalibrationResult {
  const factory _CalibrationResult(
      {required final String id,
      required final CalibrationType type,
      required final CalibrationStatus status,
      required final DateTime startTime,
      final DateTime? endTime,
      final List<ChannelResult> channelResults,
      final List<ProjectorResult> projectorResults,
      final Map<String, dynamic>? systemResults,
      final String? error,
      final double overallQuality}) = _$CalibrationResultImpl;

  factory _CalibrationResult.fromJson(Map<String, dynamic> json) =
      _$CalibrationResultImpl.fromJson;

  @override
  String get id;
  @override
  CalibrationType get type;
  @override
  CalibrationStatus get status;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  List<ChannelResult> get channelResults;
  @override
  List<ProjectorResult> get projectorResults;
  @override
  Map<String, dynamic>? get systemResults;
  @override
  String? get error;
  @override
  double get overallQuality;
  @override
  @JsonKey(ignore: true)
  _$$CalibrationResultImplCopyWith<_$CalibrationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChannelResult _$ChannelResultFromJson(Map<String, dynamic> json) {
  return _ChannelResult.fromJson(json);
}

/// @nodoc
mixin _$ChannelResult {
  String get channelId => throw _privateConstructorUsedError;
  String get channelName => throw _privateConstructorUsedError;
  String get channelType => throw _privateConstructorUsedError;
  List<FrequencyPoint> get frequencyResponse =>
      throw _privateConstructorUsedError;
  double get delay => throw _privateConstructorUsedError;
  double get distortion => throw _privateConstructorUsedError;
  double get noiseFloor => throw _privateConstructorUsedError;
  double get gain => throw _privateConstructorUsedError;
  double get phase => throw _privateConstructorUsedError;
  double get quality => throw _privateConstructorUsedError;
  Map<String, dynamic>? get equalizerSettings =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChannelResultCopyWith<ChannelResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelResultCopyWith<$Res> {
  factory $ChannelResultCopyWith(
          ChannelResult value, $Res Function(ChannelResult) then) =
      _$ChannelResultCopyWithImpl<$Res, ChannelResult>;
  @useResult
  $Res call(
      {String channelId,
      String channelName,
      String channelType,
      List<FrequencyPoint> frequencyResponse,
      double delay,
      double distortion,
      double noiseFloor,
      double gain,
      double phase,
      double quality,
      Map<String, dynamic>? equalizerSettings});
}

/// @nodoc
class _$ChannelResultCopyWithImpl<$Res, $Val extends ChannelResult>
    implements $ChannelResultCopyWith<$Res> {
  _$ChannelResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelId = null,
    Object? channelName = null,
    Object? channelType = null,
    Object? frequencyResponse = null,
    Object? delay = null,
    Object? distortion = null,
    Object? noiseFloor = null,
    Object? gain = null,
    Object? phase = null,
    Object? quality = null,
    Object? equalizerSettings = freezed,
  }) {
    return _then(_value.copyWith(
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      channelType: null == channelType
          ? _value.channelType
          : channelType // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyResponse: null == frequencyResponse
          ? _value.frequencyResponse
          : frequencyResponse // ignore: cast_nullable_to_non_nullable
              as List<FrequencyPoint>,
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      distortion: null == distortion
          ? _value.distortion
          : distortion // ignore: cast_nullable_to_non_nullable
              as double,
      noiseFloor: null == noiseFloor
          ? _value.noiseFloor
          : noiseFloor // ignore: cast_nullable_to_non_nullable
              as double,
      gain: null == gain
          ? _value.gain
          : gain // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _value.equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChannelResultImplCopyWith<$Res>
    implements $ChannelResultCopyWith<$Res> {
  factory _$$ChannelResultImplCopyWith(
          _$ChannelResultImpl value, $Res Function(_$ChannelResultImpl) then) =
      __$$ChannelResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String channelId,
      String channelName,
      String channelType,
      List<FrequencyPoint> frequencyResponse,
      double delay,
      double distortion,
      double noiseFloor,
      double gain,
      double phase,
      double quality,
      Map<String, dynamic>? equalizerSettings});
}

/// @nodoc
class __$$ChannelResultImplCopyWithImpl<$Res>
    extends _$ChannelResultCopyWithImpl<$Res, _$ChannelResultImpl>
    implements _$$ChannelResultImplCopyWith<$Res> {
  __$$ChannelResultImplCopyWithImpl(
      _$ChannelResultImpl _value, $Res Function(_$ChannelResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelId = null,
    Object? channelName = null,
    Object? channelType = null,
    Object? frequencyResponse = null,
    Object? delay = null,
    Object? distortion = null,
    Object? noiseFloor = null,
    Object? gain = null,
    Object? phase = null,
    Object? quality = null,
    Object? equalizerSettings = freezed,
  }) {
    return _then(_$ChannelResultImpl(
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      channelType: null == channelType
          ? _value.channelType
          : channelType // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyResponse: null == frequencyResponse
          ? _value._frequencyResponse
          : frequencyResponse // ignore: cast_nullable_to_non_nullable
              as List<FrequencyPoint>,
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      distortion: null == distortion
          ? _value.distortion
          : distortion // ignore: cast_nullable_to_non_nullable
              as double,
      noiseFloor: null == noiseFloor
          ? _value.noiseFloor
          : noiseFloor // ignore: cast_nullable_to_non_nullable
              as double,
      gain: null == gain
          ? _value.gain
          : gain // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _value._equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelResultImpl implements _ChannelResult {
  const _$ChannelResultImpl(
      {required this.channelId,
      required this.channelName,
      required this.channelType,
      final List<FrequencyPoint> frequencyResponse = const [],
      this.delay = 0.0,
      this.distortion = 0.0,
      this.noiseFloor = 0.0,
      this.gain = 1.0,
      this.phase = 0.0,
      this.quality = 100.0,
      final Map<String, dynamic>? equalizerSettings})
      : _frequencyResponse = frequencyResponse,
        _equalizerSettings = equalizerSettings;

  factory _$ChannelResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelResultImplFromJson(json);

  @override
  final String channelId;
  @override
  final String channelName;
  @override
  final String channelType;
  final List<FrequencyPoint> _frequencyResponse;
  @override
  @JsonKey()
  List<FrequencyPoint> get frequencyResponse {
    if (_frequencyResponse is EqualUnmodifiableListView)
      return _frequencyResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frequencyResponse);
  }

  @override
  @JsonKey()
  final double delay;
  @override
  @JsonKey()
  final double distortion;
  @override
  @JsonKey()
  final double noiseFloor;
  @override
  @JsonKey()
  final double gain;
  @override
  @JsonKey()
  final double phase;
  @override
  @JsonKey()
  final double quality;
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

  @override
  String toString() {
    return 'ChannelResult(channelId: $channelId, channelName: $channelName, channelType: $channelType, frequencyResponse: $frequencyResponse, delay: $delay, distortion: $distortion, noiseFloor: $noiseFloor, gain: $gain, phase: $phase, quality: $quality, equalizerSettings: $equalizerSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelResultImpl &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.channelType, channelType) ||
                other.channelType == channelType) &&
            const DeepCollectionEquality()
                .equals(other._frequencyResponse, _frequencyResponse) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.distortion, distortion) ||
                other.distortion == distortion) &&
            (identical(other.noiseFloor, noiseFloor) ||
                other.noiseFloor == noiseFloor) &&
            (identical(other.gain, gain) || other.gain == gain) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            const DeepCollectionEquality()
                .equals(other._equalizerSettings, _equalizerSettings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      channelId,
      channelName,
      channelType,
      const DeepCollectionEquality().hash(_frequencyResponse),
      delay,
      distortion,
      noiseFloor,
      gain,
      phase,
      quality,
      const DeepCollectionEquality().hash(_equalizerSettings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelResultImplCopyWith<_$ChannelResultImpl> get copyWith =>
      __$$ChannelResultImplCopyWithImpl<_$ChannelResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelResultImplToJson(
      this,
    );
  }
}

abstract class _ChannelResult implements ChannelResult {
  const factory _ChannelResult(
      {required final String channelId,
      required final String channelName,
      required final String channelType,
      final List<FrequencyPoint> frequencyResponse,
      final double delay,
      final double distortion,
      final double noiseFloor,
      final double gain,
      final double phase,
      final double quality,
      final Map<String, dynamic>? equalizerSettings}) = _$ChannelResultImpl;

  factory _ChannelResult.fromJson(Map<String, dynamic> json) =
      _$ChannelResultImpl.fromJson;

  @override
  String get channelId;
  @override
  String get channelName;
  @override
  String get channelType;
  @override
  List<FrequencyPoint> get frequencyResponse;
  @override
  double get delay;
  @override
  double get distortion;
  @override
  double get noiseFloor;
  @override
  double get gain;
  @override
  double get phase;
  @override
  double get quality;
  @override
  Map<String, dynamic>? get equalizerSettings;
  @override
  @JsonKey(ignore: true)
  _$$ChannelResultImplCopyWith<_$ChannelResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FrequencyPoint _$FrequencyPointFromJson(Map<String, dynamic> json) {
  return _FrequencyPoint.fromJson(json);
}

/// @nodoc
mixin _$FrequencyPoint {
  double get frequency => throw _privateConstructorUsedError;
  double get magnitude => throw _privateConstructorUsedError;
  double get phase => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FrequencyPointCopyWith<FrequencyPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrequencyPointCopyWith<$Res> {
  factory $FrequencyPointCopyWith(
          FrequencyPoint value, $Res Function(FrequencyPoint) then) =
      _$FrequencyPointCopyWithImpl<$Res, FrequencyPoint>;
  @useResult
  $Res call({double frequency, double magnitude, double phase});
}

/// @nodoc
class _$FrequencyPointCopyWithImpl<$Res, $Val extends FrequencyPoint>
    implements $FrequencyPointCopyWith<$Res> {
  _$FrequencyPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? magnitude = null,
    Object? phase = null,
  }) {
    return _then(_value.copyWith(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      magnitude: null == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrequencyPointImplCopyWith<$Res>
    implements $FrequencyPointCopyWith<$Res> {
  factory _$$FrequencyPointImplCopyWith(_$FrequencyPointImpl value,
          $Res Function(_$FrequencyPointImpl) then) =
      __$$FrequencyPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double frequency, double magnitude, double phase});
}

/// @nodoc
class __$$FrequencyPointImplCopyWithImpl<$Res>
    extends _$FrequencyPointCopyWithImpl<$Res, _$FrequencyPointImpl>
    implements _$$FrequencyPointImplCopyWith<$Res> {
  __$$FrequencyPointImplCopyWithImpl(
      _$FrequencyPointImpl _value, $Res Function(_$FrequencyPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? magnitude = null,
    Object? phase = null,
  }) {
    return _then(_$FrequencyPointImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      magnitude: null == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrequencyPointImpl implements _FrequencyPoint {
  const _$FrequencyPointImpl(
      {required this.frequency, required this.magnitude, required this.phase});

  factory _$FrequencyPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrequencyPointImplFromJson(json);

  @override
  final double frequency;
  @override
  final double magnitude;
  @override
  final double phase;

  @override
  String toString() {
    return 'FrequencyPoint(frequency: $frequency, magnitude: $magnitude, phase: $phase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrequencyPointImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, frequency, magnitude, phase);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FrequencyPointImplCopyWith<_$FrequencyPointImpl> get copyWith =>
      __$$FrequencyPointImplCopyWithImpl<_$FrequencyPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrequencyPointImplToJson(
      this,
    );
  }
}

abstract class _FrequencyPoint implements FrequencyPoint {
  const factory _FrequencyPoint(
      {required final double frequency,
      required final double magnitude,
      required final double phase}) = _$FrequencyPointImpl;

  factory _FrequencyPoint.fromJson(Map<String, dynamic> json) =
      _$FrequencyPointImpl.fromJson;

  @override
  double get frequency;
  @override
  double get magnitude;
  @override
  double get phase;
  @override
  @JsonKey(ignore: true)
  _$$FrequencyPointImplCopyWith<_$FrequencyPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectorResult _$ProjectorResultFromJson(Map<String, dynamic> json) {
  return _ProjectorResult.fromJson(json);
}

/// @nodoc
mixin _$ProjectorResult {
  String get projectorId => throw _privateConstructorUsedError;
  String get projectorName => throw _privateConstructorUsedError;
  List<CalibrationPoint> get calibrationPoints =>
      throw _privateConstructorUsedError;
  double get brightness => throw _privateConstructorUsedError;
  double get contrast => throw _privateConstructorUsedError;
  double get gamma => throw _privateConstructorUsedError;
  List<double> get colorMatrix => throw _privateConstructorUsedError;
  double get geometryAccuracy => throw _privateConstructorUsedError;
  double get quality => throw _privateConstructorUsedError;
  Map<String, dynamic>? get lensCorrection =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectorResultCopyWith<ProjectorResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectorResultCopyWith<$Res> {
  factory $ProjectorResultCopyWith(
          ProjectorResult value, $Res Function(ProjectorResult) then) =
      _$ProjectorResultCopyWithImpl<$Res, ProjectorResult>;
  @useResult
  $Res call(
      {String projectorId,
      String projectorName,
      List<CalibrationPoint> calibrationPoints,
      double brightness,
      double contrast,
      double gamma,
      List<double> colorMatrix,
      double geometryAccuracy,
      double quality,
      Map<String, dynamic>? lensCorrection});
}

/// @nodoc
class _$ProjectorResultCopyWithImpl<$Res, $Val extends ProjectorResult>
    implements $ProjectorResultCopyWith<$Res> {
  _$ProjectorResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectorId = null,
    Object? projectorName = null,
    Object? calibrationPoints = null,
    Object? brightness = null,
    Object? contrast = null,
    Object? gamma = null,
    Object? colorMatrix = null,
    Object? geometryAccuracy = null,
    Object? quality = null,
    Object? lensCorrection = freezed,
  }) {
    return _then(_value.copyWith(
      projectorId: null == projectorId
          ? _value.projectorId
          : projectorId // ignore: cast_nullable_to_non_nullable
              as String,
      projectorName: null == projectorName
          ? _value.projectorName
          : projectorName // ignore: cast_nullable_to_non_nullable
              as String,
      calibrationPoints: null == calibrationPoints
          ? _value.calibrationPoints
          : calibrationPoints // ignore: cast_nullable_to_non_nullable
              as List<CalibrationPoint>,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as double,
      contrast: null == contrast
          ? _value.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as double,
      gamma: null == gamma
          ? _value.gamma
          : gamma // ignore: cast_nullable_to_non_nullable
              as double,
      colorMatrix: null == colorMatrix
          ? _value.colorMatrix
          : colorMatrix // ignore: cast_nullable_to_non_nullable
              as List<double>,
      geometryAccuracy: null == geometryAccuracy
          ? _value.geometryAccuracy
          : geometryAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      lensCorrection: freezed == lensCorrection
          ? _value.lensCorrection
          : lensCorrection // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectorResultImplCopyWith<$Res>
    implements $ProjectorResultCopyWith<$Res> {
  factory _$$ProjectorResultImplCopyWith(_$ProjectorResultImpl value,
          $Res Function(_$ProjectorResultImpl) then) =
      __$$ProjectorResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String projectorId,
      String projectorName,
      List<CalibrationPoint> calibrationPoints,
      double brightness,
      double contrast,
      double gamma,
      List<double> colorMatrix,
      double geometryAccuracy,
      double quality,
      Map<String, dynamic>? lensCorrection});
}

/// @nodoc
class __$$ProjectorResultImplCopyWithImpl<$Res>
    extends _$ProjectorResultCopyWithImpl<$Res, _$ProjectorResultImpl>
    implements _$$ProjectorResultImplCopyWith<$Res> {
  __$$ProjectorResultImplCopyWithImpl(
      _$ProjectorResultImpl _value, $Res Function(_$ProjectorResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectorId = null,
    Object? projectorName = null,
    Object? calibrationPoints = null,
    Object? brightness = null,
    Object? contrast = null,
    Object? gamma = null,
    Object? colorMatrix = null,
    Object? geometryAccuracy = null,
    Object? quality = null,
    Object? lensCorrection = freezed,
  }) {
    return _then(_$ProjectorResultImpl(
      projectorId: null == projectorId
          ? _value.projectorId
          : projectorId // ignore: cast_nullable_to_non_nullable
              as String,
      projectorName: null == projectorName
          ? _value.projectorName
          : projectorName // ignore: cast_nullable_to_non_nullable
              as String,
      calibrationPoints: null == calibrationPoints
          ? _value._calibrationPoints
          : calibrationPoints // ignore: cast_nullable_to_non_nullable
              as List<CalibrationPoint>,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as double,
      contrast: null == contrast
          ? _value.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as double,
      gamma: null == gamma
          ? _value.gamma
          : gamma // ignore: cast_nullable_to_non_nullable
              as double,
      colorMatrix: null == colorMatrix
          ? _value._colorMatrix
          : colorMatrix // ignore: cast_nullable_to_non_nullable
              as List<double>,
      geometryAccuracy: null == geometryAccuracy
          ? _value.geometryAccuracy
          : geometryAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      lensCorrection: freezed == lensCorrection
          ? _value._lensCorrection
          : lensCorrection // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectorResultImpl implements _ProjectorResult {
  const _$ProjectorResultImpl(
      {required this.projectorId,
      required this.projectorName,
      final List<CalibrationPoint> calibrationPoints = const [],
      this.brightness = 0.0,
      this.contrast = 0.0,
      this.gamma = 0.0,
      final List<double> colorMatrix = const [],
      this.geometryAccuracy = 0.0,
      this.quality = 100.0,
      final Map<String, dynamic>? lensCorrection})
      : _calibrationPoints = calibrationPoints,
        _colorMatrix = colorMatrix,
        _lensCorrection = lensCorrection;

  factory _$ProjectorResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectorResultImplFromJson(json);

  @override
  final String projectorId;
  @override
  final String projectorName;
  final List<CalibrationPoint> _calibrationPoints;
  @override
  @JsonKey()
  List<CalibrationPoint> get calibrationPoints {
    if (_calibrationPoints is EqualUnmodifiableListView)
      return _calibrationPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_calibrationPoints);
  }

  @override
  @JsonKey()
  final double brightness;
  @override
  @JsonKey()
  final double contrast;
  @override
  @JsonKey()
  final double gamma;
  final List<double> _colorMatrix;
  @override
  @JsonKey()
  List<double> get colorMatrix {
    if (_colorMatrix is EqualUnmodifiableListView) return _colorMatrix;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_colorMatrix);
  }

  @override
  @JsonKey()
  final double geometryAccuracy;
  @override
  @JsonKey()
  final double quality;
  final Map<String, dynamic>? _lensCorrection;
  @override
  Map<String, dynamic>? get lensCorrection {
    final value = _lensCorrection;
    if (value == null) return null;
    if (_lensCorrection is EqualUnmodifiableMapView) return _lensCorrection;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ProjectorResult(projectorId: $projectorId, projectorName: $projectorName, calibrationPoints: $calibrationPoints, brightness: $brightness, contrast: $contrast, gamma: $gamma, colorMatrix: $colorMatrix, geometryAccuracy: $geometryAccuracy, quality: $quality, lensCorrection: $lensCorrection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectorResultImpl &&
            (identical(other.projectorId, projectorId) ||
                other.projectorId == projectorId) &&
            (identical(other.projectorName, projectorName) ||
                other.projectorName == projectorName) &&
            const DeepCollectionEquality()
                .equals(other._calibrationPoints, _calibrationPoints) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.contrast, contrast) ||
                other.contrast == contrast) &&
            (identical(other.gamma, gamma) || other.gamma == gamma) &&
            const DeepCollectionEquality()
                .equals(other._colorMatrix, _colorMatrix) &&
            (identical(other.geometryAccuracy, geometryAccuracy) ||
                other.geometryAccuracy == geometryAccuracy) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            const DeepCollectionEquality()
                .equals(other._lensCorrection, _lensCorrection));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectorId,
      projectorName,
      const DeepCollectionEquality().hash(_calibrationPoints),
      brightness,
      contrast,
      gamma,
      const DeepCollectionEquality().hash(_colorMatrix),
      geometryAccuracy,
      quality,
      const DeepCollectionEquality().hash(_lensCorrection));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectorResultImplCopyWith<_$ProjectorResultImpl> get copyWith =>
      __$$ProjectorResultImplCopyWithImpl<_$ProjectorResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectorResultImplToJson(
      this,
    );
  }
}

abstract class _ProjectorResult implements ProjectorResult {
  const factory _ProjectorResult(
      {required final String projectorId,
      required final String projectorName,
      final List<CalibrationPoint> calibrationPoints,
      final double brightness,
      final double contrast,
      final double gamma,
      final List<double> colorMatrix,
      final double geometryAccuracy,
      final double quality,
      final Map<String, dynamic>? lensCorrection}) = _$ProjectorResultImpl;

  factory _ProjectorResult.fromJson(Map<String, dynamic> json) =
      _$ProjectorResultImpl.fromJson;

  @override
  String get projectorId;
  @override
  String get projectorName;
  @override
  List<CalibrationPoint> get calibrationPoints;
  @override
  double get brightness;
  @override
  double get contrast;
  @override
  double get gamma;
  @override
  List<double> get colorMatrix;
  @override
  double get geometryAccuracy;
  @override
  double get quality;
  @override
  Map<String, dynamic>? get lensCorrection;
  @override
  @JsonKey(ignore: true)
  _$$ProjectorResultImplCopyWith<_$ProjectorResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalibrationPoint _$CalibrationPointFromJson(Map<String, dynamic> json) {
  return _CalibrationPoint.fromJson(json);
}

/// @nodoc
mixin _$CalibrationPoint {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get targetX => throw _privateConstructorUsedError;
  double get targetY => throw _privateConstructorUsedError;
  double get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalibrationPointCopyWith<CalibrationPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalibrationPointCopyWith<$Res> {
  factory $CalibrationPointCopyWith(
          CalibrationPoint value, $Res Function(CalibrationPoint) then) =
      _$CalibrationPointCopyWithImpl<$Res, CalibrationPoint>;
  @useResult
  $Res call({double x, double y, double targetX, double targetY, double error});
}

/// @nodoc
class _$CalibrationPointCopyWithImpl<$Res, $Val extends CalibrationPoint>
    implements $CalibrationPointCopyWith<$Res> {
  _$CalibrationPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? targetX = null,
    Object? targetY = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      targetX: null == targetX
          ? _value.targetX
          : targetX // ignore: cast_nullable_to_non_nullable
              as double,
      targetY: null == targetY
          ? _value.targetY
          : targetY // ignore: cast_nullable_to_non_nullable
              as double,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalibrationPointImplCopyWith<$Res>
    implements $CalibrationPointCopyWith<$Res> {
  factory _$$CalibrationPointImplCopyWith(_$CalibrationPointImpl value,
          $Res Function(_$CalibrationPointImpl) then) =
      __$$CalibrationPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, double targetX, double targetY, double error});
}

/// @nodoc
class __$$CalibrationPointImplCopyWithImpl<$Res>
    extends _$CalibrationPointCopyWithImpl<$Res, _$CalibrationPointImpl>
    implements _$$CalibrationPointImplCopyWith<$Res> {
  __$$CalibrationPointImplCopyWithImpl(_$CalibrationPointImpl _value,
      $Res Function(_$CalibrationPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? targetX = null,
    Object? targetY = null,
    Object? error = null,
  }) {
    return _then(_$CalibrationPointImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      targetX: null == targetX
          ? _value.targetX
          : targetX // ignore: cast_nullable_to_non_nullable
              as double,
      targetY: null == targetY
          ? _value.targetY
          : targetY // ignore: cast_nullable_to_non_nullable
              as double,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalibrationPointImpl implements _CalibrationPoint {
  const _$CalibrationPointImpl(
      {required this.x,
      required this.y,
      required this.targetX,
      required this.targetY,
      required this.error});

  factory _$CalibrationPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalibrationPointImplFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double targetX;
  @override
  final double targetY;
  @override
  final double error;

  @override
  String toString() {
    return 'CalibrationPoint(x: $x, y: $y, targetX: $targetX, targetY: $targetY, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalibrationPointImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.targetX, targetX) || other.targetX == targetX) &&
            (identical(other.targetY, targetY) || other.targetY == targetY) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, targetX, targetY, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalibrationPointImplCopyWith<_$CalibrationPointImpl> get copyWith =>
      __$$CalibrationPointImplCopyWithImpl<_$CalibrationPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalibrationPointImplToJson(
      this,
    );
  }
}

abstract class _CalibrationPoint implements CalibrationPoint {
  const factory _CalibrationPoint(
      {required final double x,
      required final double y,
      required final double targetX,
      required final double targetY,
      required final double error}) = _$CalibrationPointImpl;

  factory _CalibrationPoint.fromJson(Map<String, dynamic> json) =
      _$CalibrationPointImpl.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double get targetX;
  @override
  double get targetY;
  @override
  double get error;
  @override
  @JsonKey(ignore: true)
  _$$CalibrationPointImplCopyWith<_$CalibrationPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MicrophoneStatus _$MicrophoneStatusFromJson(Map<String, dynamic> json) {
  return _MicrophoneStatus.fromJson(json);
}

/// @nodoc
mixin _$MicrophoneStatus {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  bool get isCalibrated => throw _privateConstructorUsedError;
  double get sensitivity => throw _privateConstructorUsedError;
  double get noiseLevel => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime? get lastCalibrated => throw _privateConstructorUsedError;
  Map<String, dynamic>? get calibrationData =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MicrophoneStatusCopyWith<MicrophoneStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MicrophoneStatusCopyWith<$Res> {
  factory $MicrophoneStatusCopyWith(
          MicrophoneStatus value, $Res Function(MicrophoneStatus) then) =
      _$MicrophoneStatusCopyWithImpl<$Res, MicrophoneStatus>;
  @useResult
  $Res call(
      {String id,
      String name,
      bool isConnected,
      bool isCalibrated,
      double sensitivity,
      double noiseLevel,
      String type,
      DateTime? lastCalibrated,
      Map<String, dynamic>? calibrationData});
}

/// @nodoc
class _$MicrophoneStatusCopyWithImpl<$Res, $Val extends MicrophoneStatus>
    implements $MicrophoneStatusCopyWith<$Res> {
  _$MicrophoneStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isConnected = null,
    Object? isCalibrated = null,
    Object? sensitivity = null,
    Object? noiseLevel = null,
    Object? type = null,
    Object? lastCalibrated = freezed,
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
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalibrated: null == isCalibrated
          ? _value.isCalibrated
          : isCalibrated // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitivity: null == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      noiseLevel: null == noiseLevel
          ? _value.noiseLevel
          : noiseLevel // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastCalibrated: freezed == lastCalibrated
          ? _value.lastCalibrated
          : lastCalibrated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      calibrationData: freezed == calibrationData
          ? _value.calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MicrophoneStatusImplCopyWith<$Res>
    implements $MicrophoneStatusCopyWith<$Res> {
  factory _$$MicrophoneStatusImplCopyWith(_$MicrophoneStatusImpl value,
          $Res Function(_$MicrophoneStatusImpl) then) =
      __$$MicrophoneStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      bool isConnected,
      bool isCalibrated,
      double sensitivity,
      double noiseLevel,
      String type,
      DateTime? lastCalibrated,
      Map<String, dynamic>? calibrationData});
}

/// @nodoc
class __$$MicrophoneStatusImplCopyWithImpl<$Res>
    extends _$MicrophoneStatusCopyWithImpl<$Res, _$MicrophoneStatusImpl>
    implements _$$MicrophoneStatusImplCopyWith<$Res> {
  __$$MicrophoneStatusImplCopyWithImpl(_$MicrophoneStatusImpl _value,
      $Res Function(_$MicrophoneStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isConnected = null,
    Object? isCalibrated = null,
    Object? sensitivity = null,
    Object? noiseLevel = null,
    Object? type = null,
    Object? lastCalibrated = freezed,
    Object? calibrationData = freezed,
  }) {
    return _then(_$MicrophoneStatusImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalibrated: null == isCalibrated
          ? _value.isCalibrated
          : isCalibrated // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitivity: null == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      noiseLevel: null == noiseLevel
          ? _value.noiseLevel
          : noiseLevel // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastCalibrated: freezed == lastCalibrated
          ? _value.lastCalibrated
          : lastCalibrated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      calibrationData: freezed == calibrationData
          ? _value._calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MicrophoneStatusImpl implements _MicrophoneStatus {
  const _$MicrophoneStatusImpl(
      {required this.id,
      required this.name,
      required this.isConnected,
      required this.isCalibrated,
      this.sensitivity = 0.0,
      this.noiseLevel = 0.0,
      this.type = 'unknown',
      this.lastCalibrated,
      final Map<String, dynamic>? calibrationData})
      : _calibrationData = calibrationData;

  factory _$MicrophoneStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$MicrophoneStatusImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool isConnected;
  @override
  final bool isCalibrated;
  @override
  @JsonKey()
  final double sensitivity;
  @override
  @JsonKey()
  final double noiseLevel;
  @override
  @JsonKey()
  final String type;
  @override
  final DateTime? lastCalibrated;
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
    return 'MicrophoneStatus(id: $id, name: $name, isConnected: $isConnected, isCalibrated: $isCalibrated, sensitivity: $sensitivity, noiseLevel: $noiseLevel, type: $type, lastCalibrated: $lastCalibrated, calibrationData: $calibrationData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MicrophoneStatusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isCalibrated, isCalibrated) ||
                other.isCalibrated == isCalibrated) &&
            (identical(other.sensitivity, sensitivity) ||
                other.sensitivity == sensitivity) &&
            (identical(other.noiseLevel, noiseLevel) ||
                other.noiseLevel == noiseLevel) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.lastCalibrated, lastCalibrated) ||
                other.lastCalibrated == lastCalibrated) &&
            const DeepCollectionEquality()
                .equals(other._calibrationData, _calibrationData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      isConnected,
      isCalibrated,
      sensitivity,
      noiseLevel,
      type,
      lastCalibrated,
      const DeepCollectionEquality().hash(_calibrationData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MicrophoneStatusImplCopyWith<_$MicrophoneStatusImpl> get copyWith =>
      __$$MicrophoneStatusImplCopyWithImpl<_$MicrophoneStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MicrophoneStatusImplToJson(
      this,
    );
  }
}

abstract class _MicrophoneStatus implements MicrophoneStatus {
  const factory _MicrophoneStatus(
      {required final String id,
      required final String name,
      required final bool isConnected,
      required final bool isCalibrated,
      final double sensitivity,
      final double noiseLevel,
      final String type,
      final DateTime? lastCalibrated,
      final Map<String, dynamic>? calibrationData}) = _$MicrophoneStatusImpl;

  factory _MicrophoneStatus.fromJson(Map<String, dynamic> json) =
      _$MicrophoneStatusImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isConnected;
  @override
  bool get isCalibrated;
  @override
  double get sensitivity;
  @override
  double get noiseLevel;
  @override
  String get type;
  @override
  DateTime? get lastCalibrated;
  @override
  Map<String, dynamic>? get calibrationData;
  @override
  @JsonKey(ignore: true)
  _$$MicrophoneStatusImplCopyWith<_$MicrophoneStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VolumeSettings _$VolumeSettingsFromJson(Map<String, dynamic> json) {
  return _VolumeSettings.fromJson(json);
}

/// @nodoc
mixin _$VolumeSettings {
  double get masterVolume => throw _privateConstructorUsedError;
  Map<String, double> get channelVolumes => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  double get bassBoost => throw _privateConstructorUsedError;
  double get trebleBoost => throw _privateConstructorUsedError;
  bool get loudnessCompensation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VolumeSettingsCopyWith<VolumeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolumeSettingsCopyWith<$Res> {
  factory $VolumeSettingsCopyWith(
          VolumeSettings value, $Res Function(VolumeSettings) then) =
      _$VolumeSettingsCopyWithImpl<$Res, VolumeSettings>;
  @useResult
  $Res call(
      {double masterVolume,
      Map<String, double> channelVolumes,
      bool isMuted,
      double bassBoost,
      double trebleBoost,
      bool loudnessCompensation});
}

/// @nodoc
class _$VolumeSettingsCopyWithImpl<$Res, $Val extends VolumeSettings>
    implements $VolumeSettingsCopyWith<$Res> {
  _$VolumeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? masterVolume = null,
    Object? channelVolumes = null,
    Object? isMuted = null,
    Object? bassBoost = null,
    Object? trebleBoost = null,
    Object? loudnessCompensation = null,
  }) {
    return _then(_value.copyWith(
      masterVolume: null == masterVolume
          ? _value.masterVolume
          : masterVolume // ignore: cast_nullable_to_non_nullable
              as double,
      channelVolumes: null == channelVolumes
          ? _value.channelVolumes
          : channelVolumes // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      bassBoost: null == bassBoost
          ? _value.bassBoost
          : bassBoost // ignore: cast_nullable_to_non_nullable
              as double,
      trebleBoost: null == trebleBoost
          ? _value.trebleBoost
          : trebleBoost // ignore: cast_nullable_to_non_nullable
              as double,
      loudnessCompensation: null == loudnessCompensation
          ? _value.loudnessCompensation
          : loudnessCompensation // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VolumeSettingsImplCopyWith<$Res>
    implements $VolumeSettingsCopyWith<$Res> {
  factory _$$VolumeSettingsImplCopyWith(_$VolumeSettingsImpl value,
          $Res Function(_$VolumeSettingsImpl) then) =
      __$$VolumeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double masterVolume,
      Map<String, double> channelVolumes,
      bool isMuted,
      double bassBoost,
      double trebleBoost,
      bool loudnessCompensation});
}

/// @nodoc
class __$$VolumeSettingsImplCopyWithImpl<$Res>
    extends _$VolumeSettingsCopyWithImpl<$Res, _$VolumeSettingsImpl>
    implements _$$VolumeSettingsImplCopyWith<$Res> {
  __$$VolumeSettingsImplCopyWithImpl(
      _$VolumeSettingsImpl _value, $Res Function(_$VolumeSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? masterVolume = null,
    Object? channelVolumes = null,
    Object? isMuted = null,
    Object? bassBoost = null,
    Object? trebleBoost = null,
    Object? loudnessCompensation = null,
  }) {
    return _then(_$VolumeSettingsImpl(
      masterVolume: null == masterVolume
          ? _value.masterVolume
          : masterVolume // ignore: cast_nullable_to_non_nullable
              as double,
      channelVolumes: null == channelVolumes
          ? _value._channelVolumes
          : channelVolumes // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      bassBoost: null == bassBoost
          ? _value.bassBoost
          : bassBoost // ignore: cast_nullable_to_non_nullable
              as double,
      trebleBoost: null == trebleBoost
          ? _value.trebleBoost
          : trebleBoost // ignore: cast_nullable_to_non_nullable
              as double,
      loudnessCompensation: null == loudnessCompensation
          ? _value.loudnessCompensation
          : loudnessCompensation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VolumeSettingsImpl implements _VolumeSettings {
  const _$VolumeSettingsImpl(
      {this.masterVolume = 0.5,
      final Map<String, double> channelVolumes = const {},
      this.isMuted = false,
      this.bassBoost = 0.0,
      this.trebleBoost = 0.0,
      this.loudnessCompensation = false})
      : _channelVolumes = channelVolumes;

  factory _$VolumeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$VolumeSettingsImplFromJson(json);

  @override
  @JsonKey()
  final double masterVolume;
  final Map<String, double> _channelVolumes;
  @override
  @JsonKey()
  Map<String, double> get channelVolumes {
    if (_channelVolumes is EqualUnmodifiableMapView) return _channelVolumes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_channelVolumes);
  }

  @override
  @JsonKey()
  final bool isMuted;
  @override
  @JsonKey()
  final double bassBoost;
  @override
  @JsonKey()
  final double trebleBoost;
  @override
  @JsonKey()
  final bool loudnessCompensation;

  @override
  String toString() {
    return 'VolumeSettings(masterVolume: $masterVolume, channelVolumes: $channelVolumes, isMuted: $isMuted, bassBoost: $bassBoost, trebleBoost: $trebleBoost, loudnessCompensation: $loudnessCompensation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VolumeSettingsImpl &&
            (identical(other.masterVolume, masterVolume) ||
                other.masterVolume == masterVolume) &&
            const DeepCollectionEquality()
                .equals(other._channelVolumes, _channelVolumes) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.bassBoost, bassBoost) ||
                other.bassBoost == bassBoost) &&
            (identical(other.trebleBoost, trebleBoost) ||
                other.trebleBoost == trebleBoost) &&
            (identical(other.loudnessCompensation, loudnessCompensation) ||
                other.loudnessCompensation == loudnessCompensation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      masterVolume,
      const DeepCollectionEquality().hash(_channelVolumes),
      isMuted,
      bassBoost,
      trebleBoost,
      loudnessCompensation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VolumeSettingsImplCopyWith<_$VolumeSettingsImpl> get copyWith =>
      __$$VolumeSettingsImplCopyWithImpl<_$VolumeSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VolumeSettingsImplToJson(
      this,
    );
  }
}

abstract class _VolumeSettings implements VolumeSettings {
  const factory _VolumeSettings(
      {final double masterVolume,
      final Map<String, double> channelVolumes,
      final bool isMuted,
      final double bassBoost,
      final double trebleBoost,
      final bool loudnessCompensation}) = _$VolumeSettingsImpl;

  factory _VolumeSettings.fromJson(Map<String, dynamic> json) =
      _$VolumeSettingsImpl.fromJson;

  @override
  double get masterVolume;
  @override
  Map<String, double> get channelVolumes;
  @override
  bool get isMuted;
  @override
  double get bassBoost;
  @override
  double get trebleBoost;
  @override
  bool get loudnessCompensation;
  @override
  @JsonKey(ignore: true)
  _$$VolumeSettingsImplCopyWith<_$VolumeSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AudioProfile _$AudioProfileFromJson(Map<String, dynamic> json) {
  return _AudioProfile.fromJson(json);
}

/// @nodoc
mixin _$AudioProfile {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  VolumeSettings get volumeSettings => throw _privateConstructorUsedError;
  Map<String, dynamic> get equalizerSettings =>
      throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioProfileCopyWith<AudioProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioProfileCopyWith<$Res> {
  factory $AudioProfileCopyWith(
          AudioProfile value, $Res Function(AudioProfile) then) =
      _$AudioProfileCopyWithImpl<$Res, AudioProfile>;
  @useResult
  $Res call(
      {String id,
      String name,
      VolumeSettings volumeSettings,
      Map<String, dynamic> equalizerSettings,
      String? description,
      List<String> tags,
      bool isActive,
      DateTime? createdAt});

  $VolumeSettingsCopyWith<$Res> get volumeSettings;
}

/// @nodoc
class _$AudioProfileCopyWithImpl<$Res, $Val extends AudioProfile>
    implements $AudioProfileCopyWith<$Res> {
  _$AudioProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? volumeSettings = null,
    Object? equalizerSettings = null,
    Object? description = freezed,
    Object? tags = null,
    Object? isActive = null,
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
      volumeSettings: null == volumeSettings
          ? _value.volumeSettings
          : volumeSettings // ignore: cast_nullable_to_non_nullable
              as VolumeSettings,
      equalizerSettings: null == equalizerSettings
          ? _value.equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VolumeSettingsCopyWith<$Res> get volumeSettings {
    return $VolumeSettingsCopyWith<$Res>(_value.volumeSettings, (value) {
      return _then(_value.copyWith(volumeSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AudioProfileImplCopyWith<$Res>
    implements $AudioProfileCopyWith<$Res> {
  factory _$$AudioProfileImplCopyWith(
          _$AudioProfileImpl value, $Res Function(_$AudioProfileImpl) then) =
      __$$AudioProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      VolumeSettings volumeSettings,
      Map<String, dynamic> equalizerSettings,
      String? description,
      List<String> tags,
      bool isActive,
      DateTime? createdAt});

  @override
  $VolumeSettingsCopyWith<$Res> get volumeSettings;
}

/// @nodoc
class __$$AudioProfileImplCopyWithImpl<$Res>
    extends _$AudioProfileCopyWithImpl<$Res, _$AudioProfileImpl>
    implements _$$AudioProfileImplCopyWith<$Res> {
  __$$AudioProfileImplCopyWithImpl(
      _$AudioProfileImpl _value, $Res Function(_$AudioProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? volumeSettings = null,
    Object? equalizerSettings = null,
    Object? description = freezed,
    Object? tags = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$AudioProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      volumeSettings: null == volumeSettings
          ? _value.volumeSettings
          : volumeSettings // ignore: cast_nullable_to_non_nullable
              as VolumeSettings,
      equalizerSettings: null == equalizerSettings
          ? _value._equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioProfileImpl implements _AudioProfile {
  const _$AudioProfileImpl(
      {required this.id,
      required this.name,
      required this.volumeSettings,
      required final Map<String, dynamic> equalizerSettings,
      this.description,
      final List<String> tags = const [],
      this.isActive = false,
      this.createdAt})
      : _equalizerSettings = equalizerSettings,
        _tags = tags;

  factory _$AudioProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final VolumeSettings volumeSettings;
  final Map<String, dynamic> _equalizerSettings;
  @override
  Map<String, dynamic> get equalizerSettings {
    if (_equalizerSettings is EqualUnmodifiableMapView)
      return _equalizerSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_equalizerSettings);
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
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AudioProfile(id: $id, name: $name, volumeSettings: $volumeSettings, equalizerSettings: $equalizerSettings, description: $description, tags: $tags, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.volumeSettings, volumeSettings) ||
                other.volumeSettings == volumeSettings) &&
            const DeepCollectionEquality()
                .equals(other._equalizerSettings, _equalizerSettings) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      volumeSettings,
      const DeepCollectionEquality().hash(_equalizerSettings),
      description,
      const DeepCollectionEquality().hash(_tags),
      isActive,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioProfileImplCopyWith<_$AudioProfileImpl> get copyWith =>
      __$$AudioProfileImplCopyWithImpl<_$AudioProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioProfileImplToJson(
      this,
    );
  }
}

abstract class _AudioProfile implements AudioProfile {
  const factory _AudioProfile(
      {required final String id,
      required final String name,
      required final VolumeSettings volumeSettings,
      required final Map<String, dynamic> equalizerSettings,
      final String? description,
      final List<String> tags,
      final bool isActive,
      final DateTime? createdAt}) = _$AudioProfileImpl;

  factory _AudioProfile.fromJson(Map<String, dynamic> json) =
      _$AudioProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  VolumeSettings get volumeSettings;
  @override
  Map<String, dynamic> get equalizerSettings;
  @override
  String? get description;
  @override
  List<String> get tags;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AudioProfileImplCopyWith<_$AudioProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FreeDomeCommand _$FreeDomeCommandFromJson(Map<String, dynamic> json) {
  return _FreeDomeCommand.fromJson(json);
}

/// @nodoc
mixin _$FreeDomeCommand {
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  String? get targetSystemId => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;
  Duration? get timeout => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreeDomeCommandCopyWith<FreeDomeCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreeDomeCommandCopyWith<$Res> {
  factory $FreeDomeCommandCopyWith(
          FreeDomeCommand value, $Res Function(FreeDomeCommand) then) =
      _$FreeDomeCommandCopyWithImpl<$Res, FreeDomeCommand>;
  @useResult
  $Res call(
      {String type,
      Map<String, dynamic> data,
      String? targetSystemId,
      String? sessionId,
      int priority,
      DateTime? timestamp,
      Duration? timeout});
}

/// @nodoc
class _$FreeDomeCommandCopyWithImpl<$Res, $Val extends FreeDomeCommand>
    implements $FreeDomeCommandCopyWith<$Res> {
  _$FreeDomeCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? targetSystemId = freezed,
    Object? sessionId = freezed,
    Object? priority = null,
    Object? timestamp = freezed,
    Object? timeout = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      targetSystemId: freezed == targetSystemId
          ? _value.targetSystemId
          : targetSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeout: freezed == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreeDomeCommandImplCopyWith<$Res>
    implements $FreeDomeCommandCopyWith<$Res> {
  factory _$$FreeDomeCommandImplCopyWith(_$FreeDomeCommandImpl value,
          $Res Function(_$FreeDomeCommandImpl) then) =
      __$$FreeDomeCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      Map<String, dynamic> data,
      String? targetSystemId,
      String? sessionId,
      int priority,
      DateTime? timestamp,
      Duration? timeout});
}

/// @nodoc
class __$$FreeDomeCommandImplCopyWithImpl<$Res>
    extends _$FreeDomeCommandCopyWithImpl<$Res, _$FreeDomeCommandImpl>
    implements _$$FreeDomeCommandImplCopyWith<$Res> {
  __$$FreeDomeCommandImplCopyWithImpl(
      _$FreeDomeCommandImpl _value, $Res Function(_$FreeDomeCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? targetSystemId = freezed,
    Object? sessionId = freezed,
    Object? priority = null,
    Object? timestamp = freezed,
    Object? timeout = freezed,
  }) {
    return _then(_$FreeDomeCommandImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      targetSystemId: freezed == targetSystemId
          ? _value.targetSystemId
          : targetSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeout: freezed == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreeDomeCommandImpl implements _FreeDomeCommand {
  const _$FreeDomeCommandImpl(
      {required this.type,
      required final Map<String, dynamic> data,
      this.targetSystemId,
      this.sessionId,
      this.priority = 0,
      this.timestamp,
      this.timeout})
      : _data = data;

  factory _$FreeDomeCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreeDomeCommandImplFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final String? targetSystemId;
  @override
  final String? sessionId;
  @override
  @JsonKey()
  final int priority;
  @override
  final DateTime? timestamp;
  @override
  final Duration? timeout;

  @override
  String toString() {
    return 'FreeDomeCommand(type: $type, data: $data, targetSystemId: $targetSystemId, sessionId: $sessionId, priority: $priority, timestamp: $timestamp, timeout: $timeout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreeDomeCommandImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.targetSystemId, targetSystemId) ||
                other.targetSystemId == targetSystemId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.timeout, timeout) || other.timeout == timeout));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_data),
      targetSystemId,
      sessionId,
      priority,
      timestamp,
      timeout);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreeDomeCommandImplCopyWith<_$FreeDomeCommandImpl> get copyWith =>
      __$$FreeDomeCommandImplCopyWithImpl<_$FreeDomeCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreeDomeCommandImplToJson(
      this,
    );
  }
}

abstract class _FreeDomeCommand implements FreeDomeCommand {
  const factory _FreeDomeCommand(
      {required final String type,
      required final Map<String, dynamic> data,
      final String? targetSystemId,
      final String? sessionId,
      final int priority,
      final DateTime? timestamp,
      final Duration? timeout}) = _$FreeDomeCommandImpl;

  factory _FreeDomeCommand.fromJson(Map<String, dynamic> json) =
      _$FreeDomeCommandImpl.fromJson;

  @override
  String get type;
  @override
  Map<String, dynamic> get data;
  @override
  String? get targetSystemId;
  @override
  String? get sessionId;
  @override
  int get priority;
  @override
  DateTime? get timestamp;
  @override
  Duration? get timeout;
  @override
  @JsonKey(ignore: true)
  _$$FreeDomeCommandImplCopyWith<_$FreeDomeCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FreeDomeResponse _$FreeDomeResponseFromJson(Map<String, dynamic> json) {
  return _FreeDomeResponse.fromJson(json);
}

/// @nodoc
mixin _$FreeDomeResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  String? get commandId => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreeDomeResponseCopyWith<FreeDomeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreeDomeResponseCopyWith<$Res> {
  factory $FreeDomeResponseCopyWith(
          FreeDomeResponse value, $Res Function(FreeDomeResponse) then) =
      _$FreeDomeResponseCopyWithImpl<$Res, FreeDomeResponse>;
  @useResult
  $Res call(
      {bool success,
      String? error,
      Map<String, dynamic>? data,
      String? commandId,
      DateTime? timestamp});
}

/// @nodoc
class _$FreeDomeResponseCopyWithImpl<$Res, $Val extends FreeDomeResponse>
    implements $FreeDomeResponseCopyWith<$Res> {
  _$FreeDomeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? data = freezed,
    Object? commandId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      commandId: freezed == commandId
          ? _value.commandId
          : commandId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreeDomeResponseImplCopyWith<$Res>
    implements $FreeDomeResponseCopyWith<$Res> {
  factory _$$FreeDomeResponseImplCopyWith(_$FreeDomeResponseImpl value,
          $Res Function(_$FreeDomeResponseImpl) then) =
      __$$FreeDomeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String? error,
      Map<String, dynamic>? data,
      String? commandId,
      DateTime? timestamp});
}

/// @nodoc
class __$$FreeDomeResponseImplCopyWithImpl<$Res>
    extends _$FreeDomeResponseCopyWithImpl<$Res, _$FreeDomeResponseImpl>
    implements _$$FreeDomeResponseImplCopyWith<$Res> {
  __$$FreeDomeResponseImplCopyWithImpl(_$FreeDomeResponseImpl _value,
      $Res Function(_$FreeDomeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? data = freezed,
    Object? commandId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$FreeDomeResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      commandId: freezed == commandId
          ? _value.commandId
          : commandId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreeDomeResponseImpl implements _FreeDomeResponse {
  const _$FreeDomeResponseImpl(
      {required this.success,
      this.error,
      final Map<String, dynamic>? data,
      this.commandId,
      this.timestamp})
      : _data = data;

  factory _$FreeDomeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreeDomeResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String? error;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? commandId;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'FreeDomeResponse(success: $success, error: $error, data: $data, commandId: $commandId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreeDomeResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.commandId, commandId) ||
                other.commandId == commandId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, error,
      const DeepCollectionEquality().hash(_data), commandId, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreeDomeResponseImplCopyWith<_$FreeDomeResponseImpl> get copyWith =>
      __$$FreeDomeResponseImplCopyWithImpl<_$FreeDomeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreeDomeResponseImplToJson(
      this,
    );
  }
}

abstract class _FreeDomeResponse implements FreeDomeResponse {
  const factory _FreeDomeResponse(
      {required final bool success,
      final String? error,
      final Map<String, dynamic>? data,
      final String? commandId,
      final DateTime? timestamp}) = _$FreeDomeResponseImpl;

  factory _FreeDomeResponse.fromJson(Map<String, dynamic> json) =
      _$FreeDomeResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get error;
  @override
  Map<String, dynamic>? get data;
  @override
  String? get commandId;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$FreeDomeResponseImplCopyWith<_$FreeDomeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FreeDomeEvent _$FreeDomeEventFromJson(Map<String, dynamic> json) {
  return _FreeDomeEvent.fromJson(json);
}

/// @nodoc
mixin _$FreeDomeEvent {
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  String? get sourceSystemId => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreeDomeEventCopyWith<FreeDomeEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreeDomeEventCopyWith<$Res> {
  factory $FreeDomeEventCopyWith(
          FreeDomeEvent value, $Res Function(FreeDomeEvent) then) =
      _$FreeDomeEventCopyWithImpl<$Res, FreeDomeEvent>;
  @useResult
  $Res call(
      {String type,
      Map<String, dynamic> data,
      String? sourceSystemId,
      DateTime? timestamp});
}

/// @nodoc
class _$FreeDomeEventCopyWithImpl<$Res, $Val extends FreeDomeEvent>
    implements $FreeDomeEventCopyWith<$Res> {
  _$FreeDomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? sourceSystemId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sourceSystemId: freezed == sourceSystemId
          ? _value.sourceSystemId
          : sourceSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreeDomeEventImplCopyWith<$Res>
    implements $FreeDomeEventCopyWith<$Res> {
  factory _$$FreeDomeEventImplCopyWith(
          _$FreeDomeEventImpl value, $Res Function(_$FreeDomeEventImpl) then) =
      __$$FreeDomeEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      Map<String, dynamic> data,
      String? sourceSystemId,
      DateTime? timestamp});
}

/// @nodoc
class __$$FreeDomeEventImplCopyWithImpl<$Res>
    extends _$FreeDomeEventCopyWithImpl<$Res, _$FreeDomeEventImpl>
    implements _$$FreeDomeEventImplCopyWith<$Res> {
  __$$FreeDomeEventImplCopyWithImpl(
      _$FreeDomeEventImpl _value, $Res Function(_$FreeDomeEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? sourceSystemId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$FreeDomeEventImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sourceSystemId: freezed == sourceSystemId
          ? _value.sourceSystemId
          : sourceSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreeDomeEventImpl implements _FreeDomeEvent {
  const _$FreeDomeEventImpl(
      {required this.type,
      required final Map<String, dynamic> data,
      this.sourceSystemId,
      this.timestamp})
      : _data = data;

  factory _$FreeDomeEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreeDomeEventImplFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final String? sourceSystemId;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'FreeDomeEvent(type: $type, data: $data, sourceSystemId: $sourceSystemId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreeDomeEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.sourceSystemId, sourceSystemId) ||
                other.sourceSystemId == sourceSystemId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(_data), sourceSystemId, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreeDomeEventImplCopyWith<_$FreeDomeEventImpl> get copyWith =>
      __$$FreeDomeEventImplCopyWithImpl<_$FreeDomeEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreeDomeEventImplToJson(
      this,
    );
  }
}

abstract class _FreeDomeEvent implements FreeDomeEvent {
  const factory _FreeDomeEvent(
      {required final String type,
      required final Map<String, dynamic> data,
      final String? sourceSystemId,
      final DateTime? timestamp}) = _$FreeDomeEventImpl;

  factory _FreeDomeEvent.fromJson(Map<String, dynamic> json) =
      _$FreeDomeEventImpl.fromJson;

  @override
  String get type;
  @override
  Map<String, dynamic> get data;
  @override
  String? get sourceSystemId;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$FreeDomeEventImplCopyWith<_$FreeDomeEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
