// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calibration_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalibrationProgress {
  String get id;
  CalibrationType get type;
  CalibrationStatus get status;
  double get progress;
  String get currentStep;
  int get totalSteps;
  int get completedSteps;
  DateTime? get startTime;
  DateTime? get estimatedCompletion;
  String? get error;
  Map<String, dynamic>? get stepData;

  /// Create a copy of CalibrationProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalibrationProgressCopyWith<CalibrationProgress> get copyWith =>
      _$CalibrationProgressCopyWithImpl<CalibrationProgress>(
          this as CalibrationProgress, _$identity);

  /// Serializes this CalibrationProgress to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalibrationProgress &&
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
            const DeepCollectionEquality().equals(other.stepData, stepData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      const DeepCollectionEquality().hash(stepData));

  @override
  String toString() {
    return 'CalibrationProgress(id: $id, type: $type, status: $status, progress: $progress, currentStep: $currentStep, totalSteps: $totalSteps, completedSteps: $completedSteps, startTime: $startTime, estimatedCompletion: $estimatedCompletion, error: $error, stepData: $stepData)';
  }
}

/// @nodoc
abstract mixin class $CalibrationProgressCopyWith<$Res> {
  factory $CalibrationProgressCopyWith(
          CalibrationProgress value, $Res Function(CalibrationProgress) _then) =
      _$CalibrationProgressCopyWithImpl;
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
class _$CalibrationProgressCopyWithImpl<$Res>
    implements $CalibrationProgressCopyWith<$Res> {
  _$CalibrationProgressCopyWithImpl(this._self, this._then);

  final CalibrationProgress _self;
  final $Res Function(CalibrationProgress) _then;

  /// Create a copy of CalibrationProgress
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String,
      totalSteps: null == totalSteps
          ? _self.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      completedSteps: null == completedSteps
          ? _self.completedSteps
          : completedSteps // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _self.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      stepData: freezed == stepData
          ? _self.stepData
          : stepData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CalibrationProgress].
extension CalibrationProgressPatterns on CalibrationProgress {
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
    TResult Function(_CalibrationProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalibrationProgress() when $default != null:
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
    TResult Function(_CalibrationProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationProgress():
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
    TResult? Function(_CalibrationProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationProgress() when $default != null:
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
            CalibrationType type,
            CalibrationStatus status,
            double progress,
            String currentStep,
            int totalSteps,
            int completedSteps,
            DateTime? startTime,
            DateTime? estimatedCompletion,
            String? error,
            Map<String, dynamic>? stepData)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalibrationProgress() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.status,
            _that.progress,
            _that.currentStep,
            _that.totalSteps,
            _that.completedSteps,
            _that.startTime,
            _that.estimatedCompletion,
            _that.error,
            _that.stepData);
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
            CalibrationType type,
            CalibrationStatus status,
            double progress,
            String currentStep,
            int totalSteps,
            int completedSteps,
            DateTime? startTime,
            DateTime? estimatedCompletion,
            String? error,
            Map<String, dynamic>? stepData)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationProgress():
        return $default(
            _that.id,
            _that.type,
            _that.status,
            _that.progress,
            _that.currentStep,
            _that.totalSteps,
            _that.completedSteps,
            _that.startTime,
            _that.estimatedCompletion,
            _that.error,
            _that.stepData);
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
            CalibrationType type,
            CalibrationStatus status,
            double progress,
            String currentStep,
            int totalSteps,
            int completedSteps,
            DateTime? startTime,
            DateTime? estimatedCompletion,
            String? error,
            Map<String, dynamic>? stepData)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationProgress() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.status,
            _that.progress,
            _that.currentStep,
            _that.totalSteps,
            _that.completedSteps,
            _that.startTime,
            _that.estimatedCompletion,
            _that.error,
            _that.stepData);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CalibrationProgress implements CalibrationProgress {
  const _CalibrationProgress(
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
  factory _CalibrationProgress.fromJson(Map<String, dynamic> json) =>
      _$CalibrationProgressFromJson(json);

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

  /// Create a copy of CalibrationProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalibrationProgressCopyWith<_CalibrationProgress> get copyWith =>
      __$CalibrationProgressCopyWithImpl<_CalibrationProgress>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CalibrationProgressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalibrationProgress &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'CalibrationProgress(id: $id, type: $type, status: $status, progress: $progress, currentStep: $currentStep, totalSteps: $totalSteps, completedSteps: $completedSteps, startTime: $startTime, estimatedCompletion: $estimatedCompletion, error: $error, stepData: $stepData)';
  }
}

/// @nodoc
abstract mixin class _$CalibrationProgressCopyWith<$Res>
    implements $CalibrationProgressCopyWith<$Res> {
  factory _$CalibrationProgressCopyWith(_CalibrationProgress value,
          $Res Function(_CalibrationProgress) _then) =
      __$CalibrationProgressCopyWithImpl;
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
class __$CalibrationProgressCopyWithImpl<$Res>
    implements _$CalibrationProgressCopyWith<$Res> {
  __$CalibrationProgressCopyWithImpl(this._self, this._then);

  final _CalibrationProgress _self;
  final $Res Function(_CalibrationProgress) _then;

  /// Create a copy of CalibrationProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_CalibrationProgress(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String,
      totalSteps: null == totalSteps
          ? _self.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      completedSteps: null == completedSteps
          ? _self.completedSteps
          : completedSteps // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _self.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      stepData: freezed == stepData
          ? _self._stepData
          : stepData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$CalibrationResult {
  String get id;
  CalibrationType get type;
  CalibrationStatus get status;
  DateTime get startTime;
  DateTime? get endTime;
  List<ChannelResult> get channelResults;
  List<ProjectorResult> get projectorResults;
  Map<String, dynamic>? get systemResults;
  String? get error;
  double get overallQuality;

  /// Create a copy of CalibrationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalibrationResultCopyWith<CalibrationResult> get copyWith =>
      _$CalibrationResultCopyWithImpl<CalibrationResult>(
          this as CalibrationResult, _$identity);

  /// Serializes this CalibrationResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalibrationResult &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality()
                .equals(other.channelResults, channelResults) &&
            const DeepCollectionEquality()
                .equals(other.projectorResults, projectorResults) &&
            const DeepCollectionEquality()
                .equals(other.systemResults, systemResults) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.overallQuality, overallQuality) ||
                other.overallQuality == overallQuality));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      status,
      startTime,
      endTime,
      const DeepCollectionEquality().hash(channelResults),
      const DeepCollectionEquality().hash(projectorResults),
      const DeepCollectionEquality().hash(systemResults),
      error,
      overallQuality);

  @override
  String toString() {
    return 'CalibrationResult(id: $id, type: $type, status: $status, startTime: $startTime, endTime: $endTime, channelResults: $channelResults, projectorResults: $projectorResults, systemResults: $systemResults, error: $error, overallQuality: $overallQuality)';
  }
}

/// @nodoc
abstract mixin class $CalibrationResultCopyWith<$Res> {
  factory $CalibrationResultCopyWith(
          CalibrationResult value, $Res Function(CalibrationResult) _then) =
      _$CalibrationResultCopyWithImpl;
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
class _$CalibrationResultCopyWithImpl<$Res>
    implements $CalibrationResultCopyWith<$Res> {
  _$CalibrationResultCopyWithImpl(this._self, this._then);

  final CalibrationResult _self;
  final $Res Function(CalibrationResult) _then;

  /// Create a copy of CalibrationResult
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      channelResults: null == channelResults
          ? _self.channelResults
          : channelResults // ignore: cast_nullable_to_non_nullable
              as List<ChannelResult>,
      projectorResults: null == projectorResults
          ? _self.projectorResults
          : projectorResults // ignore: cast_nullable_to_non_nullable
              as List<ProjectorResult>,
      systemResults: freezed == systemResults
          ? _self.systemResults
          : systemResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      overallQuality: null == overallQuality
          ? _self.overallQuality
          : overallQuality // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [CalibrationResult].
extension CalibrationResultPatterns on CalibrationResult {
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
    TResult Function(_CalibrationResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalibrationResult() when $default != null:
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
    TResult Function(_CalibrationResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationResult():
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
    TResult? Function(_CalibrationResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationResult() when $default != null:
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
            CalibrationType type,
            CalibrationStatus status,
            DateTime startTime,
            DateTime? endTime,
            List<ChannelResult> channelResults,
            List<ProjectorResult> projectorResults,
            Map<String, dynamic>? systemResults,
            String? error,
            double overallQuality)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalibrationResult() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.status,
            _that.startTime,
            _that.endTime,
            _that.channelResults,
            _that.projectorResults,
            _that.systemResults,
            _that.error,
            _that.overallQuality);
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
            CalibrationType type,
            CalibrationStatus status,
            DateTime startTime,
            DateTime? endTime,
            List<ChannelResult> channelResults,
            List<ProjectorResult> projectorResults,
            Map<String, dynamic>? systemResults,
            String? error,
            double overallQuality)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationResult():
        return $default(
            _that.id,
            _that.type,
            _that.status,
            _that.startTime,
            _that.endTime,
            _that.channelResults,
            _that.projectorResults,
            _that.systemResults,
            _that.error,
            _that.overallQuality);
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
            CalibrationType type,
            CalibrationStatus status,
            DateTime startTime,
            DateTime? endTime,
            List<ChannelResult> channelResults,
            List<ProjectorResult> projectorResults,
            Map<String, dynamic>? systemResults,
            String? error,
            double overallQuality)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationResult() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.status,
            _that.startTime,
            _that.endTime,
            _that.channelResults,
            _that.projectorResults,
            _that.systemResults,
            _that.error,
            _that.overallQuality);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CalibrationResult implements CalibrationResult {
  const _CalibrationResult(
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
  factory _CalibrationResult.fromJson(Map<String, dynamic> json) =>
      _$CalibrationResultFromJson(json);

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

  /// Create a copy of CalibrationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalibrationResultCopyWith<_CalibrationResult> get copyWith =>
      __$CalibrationResultCopyWithImpl<_CalibrationResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CalibrationResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalibrationResult &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'CalibrationResult(id: $id, type: $type, status: $status, startTime: $startTime, endTime: $endTime, channelResults: $channelResults, projectorResults: $projectorResults, systemResults: $systemResults, error: $error, overallQuality: $overallQuality)';
  }
}

/// @nodoc
abstract mixin class _$CalibrationResultCopyWith<$Res>
    implements $CalibrationResultCopyWith<$Res> {
  factory _$CalibrationResultCopyWith(
          _CalibrationResult value, $Res Function(_CalibrationResult) _then) =
      __$CalibrationResultCopyWithImpl;
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
class __$CalibrationResultCopyWithImpl<$Res>
    implements _$CalibrationResultCopyWith<$Res> {
  __$CalibrationResultCopyWithImpl(this._self, this._then);

  final _CalibrationResult _self;
  final $Res Function(_CalibrationResult) _then;

  /// Create a copy of CalibrationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_CalibrationResult(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as CalibrationType,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CalibrationStatus,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      channelResults: null == channelResults
          ? _self._channelResults
          : channelResults // ignore: cast_nullable_to_non_nullable
              as List<ChannelResult>,
      projectorResults: null == projectorResults
          ? _self._projectorResults
          : projectorResults // ignore: cast_nullable_to_non_nullable
              as List<ProjectorResult>,
      systemResults: freezed == systemResults
          ? _self._systemResults
          : systemResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      overallQuality: null == overallQuality
          ? _self.overallQuality
          : overallQuality // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ChannelResult {
  String get channelId;
  String get channelName;
  String get channelType;
  List<FrequencyPoint> get frequencyResponse;
  double get delay;
  double get distortion;
  double get noiseFloor;
  double get gain;
  double get phase;
  double get quality;
  Map<String, dynamic>? get equalizerSettings;

  /// Create a copy of ChannelResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChannelResultCopyWith<ChannelResult> get copyWith =>
      _$ChannelResultCopyWithImpl<ChannelResult>(
          this as ChannelResult, _$identity);

  /// Serializes this ChannelResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChannelResult &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.channelType, channelType) ||
                other.channelType == channelType) &&
            const DeepCollectionEquality()
                .equals(other.frequencyResponse, frequencyResponse) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.distortion, distortion) ||
                other.distortion == distortion) &&
            (identical(other.noiseFloor, noiseFloor) ||
                other.noiseFloor == noiseFloor) &&
            (identical(other.gain, gain) || other.gain == gain) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            const DeepCollectionEquality()
                .equals(other.equalizerSettings, equalizerSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      channelId,
      channelName,
      channelType,
      const DeepCollectionEquality().hash(frequencyResponse),
      delay,
      distortion,
      noiseFloor,
      gain,
      phase,
      quality,
      const DeepCollectionEquality().hash(equalizerSettings));

  @override
  String toString() {
    return 'ChannelResult(channelId: $channelId, channelName: $channelName, channelType: $channelType, frequencyResponse: $frequencyResponse, delay: $delay, distortion: $distortion, noiseFloor: $noiseFloor, gain: $gain, phase: $phase, quality: $quality, equalizerSettings: $equalizerSettings)';
  }
}

/// @nodoc
abstract mixin class $ChannelResultCopyWith<$Res> {
  factory $ChannelResultCopyWith(
          ChannelResult value, $Res Function(ChannelResult) _then) =
      _$ChannelResultCopyWithImpl;
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
class _$ChannelResultCopyWithImpl<$Res>
    implements $ChannelResultCopyWith<$Res> {
  _$ChannelResultCopyWithImpl(this._self, this._then);

  final ChannelResult _self;
  final $Res Function(ChannelResult) _then;

  /// Create a copy of ChannelResult
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      channelId: null == channelId
          ? _self.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _self.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      channelType: null == channelType
          ? _self.channelType
          : channelType // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyResponse: null == frequencyResponse
          ? _self.frequencyResponse
          : frequencyResponse // ignore: cast_nullable_to_non_nullable
              as List<FrequencyPoint>,
      delay: null == delay
          ? _self.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      distortion: null == distortion
          ? _self.distortion
          : distortion // ignore: cast_nullable_to_non_nullable
              as double,
      noiseFloor: null == noiseFloor
          ? _self.noiseFloor
          : noiseFloor // ignore: cast_nullable_to_non_nullable
              as double,
      gain: null == gain
          ? _self.gain
          : gain // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _self.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _self.equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChannelResult].
extension ChannelResultPatterns on ChannelResult {
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
    TResult Function(_ChannelResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelResult() when $default != null:
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
    TResult Function(_ChannelResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelResult():
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
    TResult? Function(_ChannelResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelResult() when $default != null:
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
            String channelId,
            String channelName,
            String channelType,
            List<FrequencyPoint> frequencyResponse,
            double delay,
            double distortion,
            double noiseFloor,
            double gain,
            double phase,
            double quality,
            Map<String, dynamic>? equalizerSettings)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChannelResult() when $default != null:
        return $default(
            _that.channelId,
            _that.channelName,
            _that.channelType,
            _that.frequencyResponse,
            _that.delay,
            _that.distortion,
            _that.noiseFloor,
            _that.gain,
            _that.phase,
            _that.quality,
            _that.equalizerSettings);
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
            String channelId,
            String channelName,
            String channelType,
            List<FrequencyPoint> frequencyResponse,
            double delay,
            double distortion,
            double noiseFloor,
            double gain,
            double phase,
            double quality,
            Map<String, dynamic>? equalizerSettings)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelResult():
        return $default(
            _that.channelId,
            _that.channelName,
            _that.channelType,
            _that.frequencyResponse,
            _that.delay,
            _that.distortion,
            _that.noiseFloor,
            _that.gain,
            _that.phase,
            _that.quality,
            _that.equalizerSettings);
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
            String channelId,
            String channelName,
            String channelType,
            List<FrequencyPoint> frequencyResponse,
            double delay,
            double distortion,
            double noiseFloor,
            double gain,
            double phase,
            double quality,
            Map<String, dynamic>? equalizerSettings)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChannelResult() when $default != null:
        return $default(
            _that.channelId,
            _that.channelName,
            _that.channelType,
            _that.frequencyResponse,
            _that.delay,
            _that.distortion,
            _that.noiseFloor,
            _that.gain,
            _that.phase,
            _that.quality,
            _that.equalizerSettings);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChannelResult implements ChannelResult {
  const _ChannelResult(
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
  factory _ChannelResult.fromJson(Map<String, dynamic> json) =>
      _$ChannelResultFromJson(json);

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

  /// Create a copy of ChannelResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChannelResultCopyWith<_ChannelResult> get copyWith =>
      __$ChannelResultCopyWithImpl<_ChannelResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChannelResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChannelResult &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'ChannelResult(channelId: $channelId, channelName: $channelName, channelType: $channelType, frequencyResponse: $frequencyResponse, delay: $delay, distortion: $distortion, noiseFloor: $noiseFloor, gain: $gain, phase: $phase, quality: $quality, equalizerSettings: $equalizerSettings)';
  }
}

/// @nodoc
abstract mixin class _$ChannelResultCopyWith<$Res>
    implements $ChannelResultCopyWith<$Res> {
  factory _$ChannelResultCopyWith(
          _ChannelResult value, $Res Function(_ChannelResult) _then) =
      __$ChannelResultCopyWithImpl;
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
class __$ChannelResultCopyWithImpl<$Res>
    implements _$ChannelResultCopyWith<$Res> {
  __$ChannelResultCopyWithImpl(this._self, this._then);

  final _ChannelResult _self;
  final $Res Function(_ChannelResult) _then;

  /// Create a copy of ChannelResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ChannelResult(
      channelId: null == channelId
          ? _self.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _self.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      channelType: null == channelType
          ? _self.channelType
          : channelType // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyResponse: null == frequencyResponse
          ? _self._frequencyResponse
          : frequencyResponse // ignore: cast_nullable_to_non_nullable
              as List<FrequencyPoint>,
      delay: null == delay
          ? _self.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as double,
      distortion: null == distortion
          ? _self.distortion
          : distortion // ignore: cast_nullable_to_non_nullable
              as double,
      noiseFloor: null == noiseFloor
          ? _self.noiseFloor
          : noiseFloor // ignore: cast_nullable_to_non_nullable
              as double,
      gain: null == gain
          ? _self.gain
          : gain // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _self.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      equalizerSettings: freezed == equalizerSettings
          ? _self._equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$FrequencyPoint {
  double get frequency;
  double get magnitude;
  double get phase;

  /// Create a copy of FrequencyPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FrequencyPointCopyWith<FrequencyPoint> get copyWith =>
      _$FrequencyPointCopyWithImpl<FrequencyPoint>(
          this as FrequencyPoint, _$identity);

  /// Serializes this FrequencyPoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FrequencyPoint &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frequency, magnitude, phase);

  @override
  String toString() {
    return 'FrequencyPoint(frequency: $frequency, magnitude: $magnitude, phase: $phase)';
  }
}

/// @nodoc
abstract mixin class $FrequencyPointCopyWith<$Res> {
  factory $FrequencyPointCopyWith(
          FrequencyPoint value, $Res Function(FrequencyPoint) _then) =
      _$FrequencyPointCopyWithImpl;
  @useResult
  $Res call({double frequency, double magnitude, double phase});
}

/// @nodoc
class _$FrequencyPointCopyWithImpl<$Res>
    implements $FrequencyPointCopyWith<$Res> {
  _$FrequencyPointCopyWithImpl(this._self, this._then);

  final FrequencyPoint _self;
  final $Res Function(FrequencyPoint) _then;

  /// Create a copy of FrequencyPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? magnitude = null,
    Object? phase = null,
  }) {
    return _then(_self.copyWith(
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      magnitude: null == magnitude
          ? _self.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [FrequencyPoint].
extension FrequencyPointPatterns on FrequencyPoint {
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
    TResult Function(_FrequencyPoint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FrequencyPoint() when $default != null:
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
    TResult Function(_FrequencyPoint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPoint():
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
    TResult? Function(_FrequencyPoint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPoint() when $default != null:
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
    TResult Function(double frequency, double magnitude, double phase)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FrequencyPoint() when $default != null:
        return $default(_that.frequency, _that.magnitude, _that.phase);
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
    TResult Function(double frequency, double magnitude, double phase) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPoint():
        return $default(_that.frequency, _that.magnitude, _that.phase);
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
    TResult? Function(double frequency, double magnitude, double phase)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPoint() when $default != null:
        return $default(_that.frequency, _that.magnitude, _that.phase);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FrequencyPoint implements FrequencyPoint {
  const _FrequencyPoint(
      {required this.frequency, required this.magnitude, required this.phase});
  factory _FrequencyPoint.fromJson(Map<String, dynamic> json) =>
      _$FrequencyPointFromJson(json);

  @override
  final double frequency;
  @override
  final double magnitude;
  @override
  final double phase;

  /// Create a copy of FrequencyPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FrequencyPointCopyWith<_FrequencyPoint> get copyWith =>
      __$FrequencyPointCopyWithImpl<_FrequencyPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FrequencyPointToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FrequencyPoint &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frequency, magnitude, phase);

  @override
  String toString() {
    return 'FrequencyPoint(frequency: $frequency, magnitude: $magnitude, phase: $phase)';
  }
}

/// @nodoc
abstract mixin class _$FrequencyPointCopyWith<$Res>
    implements $FrequencyPointCopyWith<$Res> {
  factory _$FrequencyPointCopyWith(
          _FrequencyPoint value, $Res Function(_FrequencyPoint) _then) =
      __$FrequencyPointCopyWithImpl;
  @override
  @useResult
  $Res call({double frequency, double magnitude, double phase});
}

/// @nodoc
class __$FrequencyPointCopyWithImpl<$Res>
    implements _$FrequencyPointCopyWith<$Res> {
  __$FrequencyPointCopyWithImpl(this._self, this._then);

  final _FrequencyPoint _self;
  final $Res Function(_FrequencyPoint) _then;

  /// Create a copy of FrequencyPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? frequency = null,
    Object? magnitude = null,
    Object? phase = null,
  }) {
    return _then(_FrequencyPoint(
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      magnitude: null == magnitude
          ? _self.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double,
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ProjectorResult {
  String get projectorId;
  String get projectorName;
  List<CalibrationPoint> get calibrationPoints;
  double get brightness;
  double get contrast;
  double get gamma;
  List<double> get colorMatrix;
  double get geometryAccuracy;
  double get quality;
  Map<String, dynamic>? get lensCorrection;

  /// Create a copy of ProjectorResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProjectorResultCopyWith<ProjectorResult> get copyWith =>
      _$ProjectorResultCopyWithImpl<ProjectorResult>(
          this as ProjectorResult, _$identity);

  /// Serializes this ProjectorResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProjectorResult &&
            (identical(other.projectorId, projectorId) ||
                other.projectorId == projectorId) &&
            (identical(other.projectorName, projectorName) ||
                other.projectorName == projectorName) &&
            const DeepCollectionEquality()
                .equals(other.calibrationPoints, calibrationPoints) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.contrast, contrast) ||
                other.contrast == contrast) &&
            (identical(other.gamma, gamma) || other.gamma == gamma) &&
            const DeepCollectionEquality()
                .equals(other.colorMatrix, colorMatrix) &&
            (identical(other.geometryAccuracy, geometryAccuracy) ||
                other.geometryAccuracy == geometryAccuracy) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            const DeepCollectionEquality()
                .equals(other.lensCorrection, lensCorrection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectorId,
      projectorName,
      const DeepCollectionEquality().hash(calibrationPoints),
      brightness,
      contrast,
      gamma,
      const DeepCollectionEquality().hash(colorMatrix),
      geometryAccuracy,
      quality,
      const DeepCollectionEquality().hash(lensCorrection));

  @override
  String toString() {
    return 'ProjectorResult(projectorId: $projectorId, projectorName: $projectorName, calibrationPoints: $calibrationPoints, brightness: $brightness, contrast: $contrast, gamma: $gamma, colorMatrix: $colorMatrix, geometryAccuracy: $geometryAccuracy, quality: $quality, lensCorrection: $lensCorrection)';
  }
}

/// @nodoc
abstract mixin class $ProjectorResultCopyWith<$Res> {
  factory $ProjectorResultCopyWith(
          ProjectorResult value, $Res Function(ProjectorResult) _then) =
      _$ProjectorResultCopyWithImpl;
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
class _$ProjectorResultCopyWithImpl<$Res>
    implements $ProjectorResultCopyWith<$Res> {
  _$ProjectorResultCopyWithImpl(this._self, this._then);

  final ProjectorResult _self;
  final $Res Function(ProjectorResult) _then;

  /// Create a copy of ProjectorResult
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      projectorId: null == projectorId
          ? _self.projectorId
          : projectorId // ignore: cast_nullable_to_non_nullable
              as String,
      projectorName: null == projectorName
          ? _self.projectorName
          : projectorName // ignore: cast_nullable_to_non_nullable
              as String,
      calibrationPoints: null == calibrationPoints
          ? _self.calibrationPoints
          : calibrationPoints // ignore: cast_nullable_to_non_nullable
              as List<CalibrationPoint>,
      brightness: null == brightness
          ? _self.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as double,
      contrast: null == contrast
          ? _self.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as double,
      gamma: null == gamma
          ? _self.gamma
          : gamma // ignore: cast_nullable_to_non_nullable
              as double,
      colorMatrix: null == colorMatrix
          ? _self.colorMatrix
          : colorMatrix // ignore: cast_nullable_to_non_nullable
              as List<double>,
      geometryAccuracy: null == geometryAccuracy
          ? _self.geometryAccuracy
          : geometryAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _self.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      lensCorrection: freezed == lensCorrection
          ? _self.lensCorrection
          : lensCorrection // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProjectorResult].
extension ProjectorResultPatterns on ProjectorResult {
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
    TResult Function(_ProjectorResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProjectorResult() when $default != null:
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
    TResult Function(_ProjectorResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorResult():
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
    TResult? Function(_ProjectorResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorResult() when $default != null:
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
            String projectorId,
            String projectorName,
            List<CalibrationPoint> calibrationPoints,
            double brightness,
            double contrast,
            double gamma,
            List<double> colorMatrix,
            double geometryAccuracy,
            double quality,
            Map<String, dynamic>? lensCorrection)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProjectorResult() when $default != null:
        return $default(
            _that.projectorId,
            _that.projectorName,
            _that.calibrationPoints,
            _that.brightness,
            _that.contrast,
            _that.gamma,
            _that.colorMatrix,
            _that.geometryAccuracy,
            _that.quality,
            _that.lensCorrection);
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
            String projectorId,
            String projectorName,
            List<CalibrationPoint> calibrationPoints,
            double brightness,
            double contrast,
            double gamma,
            List<double> colorMatrix,
            double geometryAccuracy,
            double quality,
            Map<String, dynamic>? lensCorrection)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorResult():
        return $default(
            _that.projectorId,
            _that.projectorName,
            _that.calibrationPoints,
            _that.brightness,
            _that.contrast,
            _that.gamma,
            _that.colorMatrix,
            _that.geometryAccuracy,
            _that.quality,
            _that.lensCorrection);
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
            String projectorId,
            String projectorName,
            List<CalibrationPoint> calibrationPoints,
            double brightness,
            double contrast,
            double gamma,
            List<double> colorMatrix,
            double geometryAccuracy,
            double quality,
            Map<String, dynamic>? lensCorrection)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProjectorResult() when $default != null:
        return $default(
            _that.projectorId,
            _that.projectorName,
            _that.calibrationPoints,
            _that.brightness,
            _that.contrast,
            _that.gamma,
            _that.colorMatrix,
            _that.geometryAccuracy,
            _that.quality,
            _that.lensCorrection);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProjectorResult implements ProjectorResult {
  const _ProjectorResult(
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
  factory _ProjectorResult.fromJson(Map<String, dynamic> json) =>
      _$ProjectorResultFromJson(json);

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

  /// Create a copy of ProjectorResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProjectorResultCopyWith<_ProjectorResult> get copyWith =>
      __$ProjectorResultCopyWithImpl<_ProjectorResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProjectorResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectorResult &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'ProjectorResult(projectorId: $projectorId, projectorName: $projectorName, calibrationPoints: $calibrationPoints, brightness: $brightness, contrast: $contrast, gamma: $gamma, colorMatrix: $colorMatrix, geometryAccuracy: $geometryAccuracy, quality: $quality, lensCorrection: $lensCorrection)';
  }
}

/// @nodoc
abstract mixin class _$ProjectorResultCopyWith<$Res>
    implements $ProjectorResultCopyWith<$Res> {
  factory _$ProjectorResultCopyWith(
          _ProjectorResult value, $Res Function(_ProjectorResult) _then) =
      __$ProjectorResultCopyWithImpl;
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
class __$ProjectorResultCopyWithImpl<$Res>
    implements _$ProjectorResultCopyWith<$Res> {
  __$ProjectorResultCopyWithImpl(this._self, this._then);

  final _ProjectorResult _self;
  final $Res Function(_ProjectorResult) _then;

  /// Create a copy of ProjectorResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ProjectorResult(
      projectorId: null == projectorId
          ? _self.projectorId
          : projectorId // ignore: cast_nullable_to_non_nullable
              as String,
      projectorName: null == projectorName
          ? _self.projectorName
          : projectorName // ignore: cast_nullable_to_non_nullable
              as String,
      calibrationPoints: null == calibrationPoints
          ? _self._calibrationPoints
          : calibrationPoints // ignore: cast_nullable_to_non_nullable
              as List<CalibrationPoint>,
      brightness: null == brightness
          ? _self.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as double,
      contrast: null == contrast
          ? _self.contrast
          : contrast // ignore: cast_nullable_to_non_nullable
              as double,
      gamma: null == gamma
          ? _self.gamma
          : gamma // ignore: cast_nullable_to_non_nullable
              as double,
      colorMatrix: null == colorMatrix
          ? _self._colorMatrix
          : colorMatrix // ignore: cast_nullable_to_non_nullable
              as List<double>,
      geometryAccuracy: null == geometryAccuracy
          ? _self.geometryAccuracy
          : geometryAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _self.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      lensCorrection: freezed == lensCorrection
          ? _self._lensCorrection
          : lensCorrection // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$CalibrationPoint {
  double get x;
  double get y;
  double get targetX;
  double get targetY;
  double get error;

  /// Create a copy of CalibrationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalibrationPointCopyWith<CalibrationPoint> get copyWith =>
      _$CalibrationPointCopyWithImpl<CalibrationPoint>(
          this as CalibrationPoint, _$identity);

  /// Serializes this CalibrationPoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalibrationPoint &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.targetX, targetX) || other.targetX == targetX) &&
            (identical(other.targetY, targetY) || other.targetY == targetY) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, targetX, targetY, error);

  @override
  String toString() {
    return 'CalibrationPoint(x: $x, y: $y, targetX: $targetX, targetY: $targetY, error: $error)';
  }
}

/// @nodoc
abstract mixin class $CalibrationPointCopyWith<$Res> {
  factory $CalibrationPointCopyWith(
          CalibrationPoint value, $Res Function(CalibrationPoint) _then) =
      _$CalibrationPointCopyWithImpl;
  @useResult
  $Res call({double x, double y, double targetX, double targetY, double error});
}

/// @nodoc
class _$CalibrationPointCopyWithImpl<$Res>
    implements $CalibrationPointCopyWith<$Res> {
  _$CalibrationPointCopyWithImpl(this._self, this._then);

  final CalibrationPoint _self;
  final $Res Function(CalibrationPoint) _then;

  /// Create a copy of CalibrationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? targetX = null,
    Object? targetY = null,
    Object? error = null,
  }) {
    return _then(_self.copyWith(
      x: null == x
          ? _self.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _self.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      targetX: null == targetX
          ? _self.targetX
          : targetX // ignore: cast_nullable_to_non_nullable
              as double,
      targetY: null == targetY
          ? _self.targetY
          : targetY // ignore: cast_nullable_to_non_nullable
              as double,
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [CalibrationPoint].
extension CalibrationPointPatterns on CalibrationPoint {
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
    TResult Function(_CalibrationPoint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalibrationPoint() when $default != null:
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
    TResult Function(_CalibrationPoint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationPoint():
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
    TResult? Function(_CalibrationPoint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationPoint() when $default != null:
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
            double x, double y, double targetX, double targetY, double error)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalibrationPoint() when $default != null:
        return $default(
            _that.x, _that.y, _that.targetX, _that.targetY, _that.error);
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
            double x, double y, double targetX, double targetY, double error)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationPoint():
        return $default(
            _that.x, _that.y, _that.targetX, _that.targetY, _that.error);
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
            double x, double y, double targetX, double targetY, double error)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalibrationPoint() when $default != null:
        return $default(
            _that.x, _that.y, _that.targetX, _that.targetY, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CalibrationPoint implements CalibrationPoint {
  const _CalibrationPoint(
      {required this.x,
      required this.y,
      required this.targetX,
      required this.targetY,
      required this.error});
  factory _CalibrationPoint.fromJson(Map<String, dynamic> json) =>
      _$CalibrationPointFromJson(json);

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

  /// Create a copy of CalibrationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalibrationPointCopyWith<_CalibrationPoint> get copyWith =>
      __$CalibrationPointCopyWithImpl<_CalibrationPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CalibrationPointToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalibrationPoint &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.targetX, targetX) || other.targetX == targetX) &&
            (identical(other.targetY, targetY) || other.targetY == targetY) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, targetX, targetY, error);

  @override
  String toString() {
    return 'CalibrationPoint(x: $x, y: $y, targetX: $targetX, targetY: $targetY, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$CalibrationPointCopyWith<$Res>
    implements $CalibrationPointCopyWith<$Res> {
  factory _$CalibrationPointCopyWith(
          _CalibrationPoint value, $Res Function(_CalibrationPoint) _then) =
      __$CalibrationPointCopyWithImpl;
  @override
  @useResult
  $Res call({double x, double y, double targetX, double targetY, double error});
}

/// @nodoc
class __$CalibrationPointCopyWithImpl<$Res>
    implements _$CalibrationPointCopyWith<$Res> {
  __$CalibrationPointCopyWithImpl(this._self, this._then);

  final _CalibrationPoint _self;
  final $Res Function(_CalibrationPoint) _then;

  /// Create a copy of CalibrationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? targetX = null,
    Object? targetY = null,
    Object? error = null,
  }) {
    return _then(_CalibrationPoint(
      x: null == x
          ? _self.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _self.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      targetX: null == targetX
          ? _self.targetX
          : targetX // ignore: cast_nullable_to_non_nullable
              as double,
      targetY: null == targetY
          ? _self.targetY
          : targetY // ignore: cast_nullable_to_non_nullable
              as double,
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$MicrophoneStatus {
  String get id;
  String get name;
  bool get isConnected;
  bool get isCalibrated;
  double get sensitivity;
  double get noiseLevel;
  String get type;
  DateTime? get lastCalibrated;
  Map<String, dynamic>? get calibrationData;

  /// Create a copy of MicrophoneStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MicrophoneStatusCopyWith<MicrophoneStatus> get copyWith =>
      _$MicrophoneStatusCopyWithImpl<MicrophoneStatus>(
          this as MicrophoneStatus, _$identity);

  /// Serializes this MicrophoneStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MicrophoneStatus &&
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
                .equals(other.calibrationData, calibrationData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      const DeepCollectionEquality().hash(calibrationData));

  @override
  String toString() {
    return 'MicrophoneStatus(id: $id, name: $name, isConnected: $isConnected, isCalibrated: $isCalibrated, sensitivity: $sensitivity, noiseLevel: $noiseLevel, type: $type, lastCalibrated: $lastCalibrated, calibrationData: $calibrationData)';
  }
}

/// @nodoc
abstract mixin class $MicrophoneStatusCopyWith<$Res> {
  factory $MicrophoneStatusCopyWith(
          MicrophoneStatus value, $Res Function(MicrophoneStatus) _then) =
      _$MicrophoneStatusCopyWithImpl;
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
class _$MicrophoneStatusCopyWithImpl<$Res>
    implements $MicrophoneStatusCopyWith<$Res> {
  _$MicrophoneStatusCopyWithImpl(this._self, this._then);

  final MicrophoneStatus _self;
  final $Res Function(MicrophoneStatus) _then;

  /// Create a copy of MicrophoneStatus
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalibrated: null == isCalibrated
          ? _self.isCalibrated
          : isCalibrated // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitivity: null == sensitivity
          ? _self.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      noiseLevel: null == noiseLevel
          ? _self.noiseLevel
          : noiseLevel // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastCalibrated: freezed == lastCalibrated
          ? _self.lastCalibrated
          : lastCalibrated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      calibrationData: freezed == calibrationData
          ? _self.calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MicrophoneStatus].
extension MicrophoneStatusPatterns on MicrophoneStatus {
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
    TResult Function(_MicrophoneStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MicrophoneStatus() when $default != null:
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
    TResult Function(_MicrophoneStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MicrophoneStatus():
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
    TResult? Function(_MicrophoneStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MicrophoneStatus() when $default != null:
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
            bool isConnected,
            bool isCalibrated,
            double sensitivity,
            double noiseLevel,
            String type,
            DateTime? lastCalibrated,
            Map<String, dynamic>? calibrationData)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MicrophoneStatus() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.isConnected,
            _that.isCalibrated,
            _that.sensitivity,
            _that.noiseLevel,
            _that.type,
            _that.lastCalibrated,
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
            bool isConnected,
            bool isCalibrated,
            double sensitivity,
            double noiseLevel,
            String type,
            DateTime? lastCalibrated,
            Map<String, dynamic>? calibrationData)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MicrophoneStatus():
        return $default(
            _that.id,
            _that.name,
            _that.isConnected,
            _that.isCalibrated,
            _that.sensitivity,
            _that.noiseLevel,
            _that.type,
            _that.lastCalibrated,
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
            bool isConnected,
            bool isCalibrated,
            double sensitivity,
            double noiseLevel,
            String type,
            DateTime? lastCalibrated,
            Map<String, dynamic>? calibrationData)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MicrophoneStatus() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.isConnected,
            _that.isCalibrated,
            _that.sensitivity,
            _that.noiseLevel,
            _that.type,
            _that.lastCalibrated,
            _that.calibrationData);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MicrophoneStatus implements MicrophoneStatus {
  const _MicrophoneStatus(
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
  factory _MicrophoneStatus.fromJson(Map<String, dynamic> json) =>
      _$MicrophoneStatusFromJson(json);

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

  /// Create a copy of MicrophoneStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MicrophoneStatusCopyWith<_MicrophoneStatus> get copyWith =>
      __$MicrophoneStatusCopyWithImpl<_MicrophoneStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MicrophoneStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MicrophoneStatus &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'MicrophoneStatus(id: $id, name: $name, isConnected: $isConnected, isCalibrated: $isCalibrated, sensitivity: $sensitivity, noiseLevel: $noiseLevel, type: $type, lastCalibrated: $lastCalibrated, calibrationData: $calibrationData)';
  }
}

/// @nodoc
abstract mixin class _$MicrophoneStatusCopyWith<$Res>
    implements $MicrophoneStatusCopyWith<$Res> {
  factory _$MicrophoneStatusCopyWith(
          _MicrophoneStatus value, $Res Function(_MicrophoneStatus) _then) =
      __$MicrophoneStatusCopyWithImpl;
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
class __$MicrophoneStatusCopyWithImpl<$Res>
    implements _$MicrophoneStatusCopyWith<$Res> {
  __$MicrophoneStatusCopyWithImpl(this._self, this._then);

  final _MicrophoneStatus _self;
  final $Res Function(_MicrophoneStatus) _then;

  /// Create a copy of MicrophoneStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_MicrophoneStatus(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalibrated: null == isCalibrated
          ? _self.isCalibrated
          : isCalibrated // ignore: cast_nullable_to_non_nullable
              as bool,
      sensitivity: null == sensitivity
          ? _self.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      noiseLevel: null == noiseLevel
          ? _self.noiseLevel
          : noiseLevel // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastCalibrated: freezed == lastCalibrated
          ? _self.lastCalibrated
          : lastCalibrated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      calibrationData: freezed == calibrationData
          ? _self._calibrationData
          : calibrationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$VolumeSettings {
  double get masterVolume;
  Map<String, double> get channelVolumes;
  bool get isMuted;
  double get bassBoost;
  double get trebleBoost;
  bool get loudnessCompensation;

  /// Create a copy of VolumeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VolumeSettingsCopyWith<VolumeSettings> get copyWith =>
      _$VolumeSettingsCopyWithImpl<VolumeSettings>(
          this as VolumeSettings, _$identity);

  /// Serializes this VolumeSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VolumeSettings &&
            (identical(other.masterVolume, masterVolume) ||
                other.masterVolume == masterVolume) &&
            const DeepCollectionEquality()
                .equals(other.channelVolumes, channelVolumes) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.bassBoost, bassBoost) ||
                other.bassBoost == bassBoost) &&
            (identical(other.trebleBoost, trebleBoost) ||
                other.trebleBoost == trebleBoost) &&
            (identical(other.loudnessCompensation, loudnessCompensation) ||
                other.loudnessCompensation == loudnessCompensation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      masterVolume,
      const DeepCollectionEquality().hash(channelVolumes),
      isMuted,
      bassBoost,
      trebleBoost,
      loudnessCompensation);

  @override
  String toString() {
    return 'VolumeSettings(masterVolume: $masterVolume, channelVolumes: $channelVolumes, isMuted: $isMuted, bassBoost: $bassBoost, trebleBoost: $trebleBoost, loudnessCompensation: $loudnessCompensation)';
  }
}

/// @nodoc
abstract mixin class $VolumeSettingsCopyWith<$Res> {
  factory $VolumeSettingsCopyWith(
          VolumeSettings value, $Res Function(VolumeSettings) _then) =
      _$VolumeSettingsCopyWithImpl;
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
class _$VolumeSettingsCopyWithImpl<$Res>
    implements $VolumeSettingsCopyWith<$Res> {
  _$VolumeSettingsCopyWithImpl(this._self, this._then);

  final VolumeSettings _self;
  final $Res Function(VolumeSettings) _then;

  /// Create a copy of VolumeSettings
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      masterVolume: null == masterVolume
          ? _self.masterVolume
          : masterVolume // ignore: cast_nullable_to_non_nullable
              as double,
      channelVolumes: null == channelVolumes
          ? _self.channelVolumes
          : channelVolumes // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isMuted: null == isMuted
          ? _self.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      bassBoost: null == bassBoost
          ? _self.bassBoost
          : bassBoost // ignore: cast_nullable_to_non_nullable
              as double,
      trebleBoost: null == trebleBoost
          ? _self.trebleBoost
          : trebleBoost // ignore: cast_nullable_to_non_nullable
              as double,
      loudnessCompensation: null == loudnessCompensation
          ? _self.loudnessCompensation
          : loudnessCompensation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [VolumeSettings].
extension VolumeSettingsPatterns on VolumeSettings {
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
    TResult Function(_VolumeSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VolumeSettings() when $default != null:
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
    TResult Function(_VolumeSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VolumeSettings():
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
    TResult? Function(_VolumeSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VolumeSettings() when $default != null:
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
            double masterVolume,
            Map<String, double> channelVolumes,
            bool isMuted,
            double bassBoost,
            double trebleBoost,
            bool loudnessCompensation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VolumeSettings() when $default != null:
        return $default(_that.masterVolume, _that.channelVolumes, _that.isMuted,
            _that.bassBoost, _that.trebleBoost, _that.loudnessCompensation);
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
            double masterVolume,
            Map<String, double> channelVolumes,
            bool isMuted,
            double bassBoost,
            double trebleBoost,
            bool loudnessCompensation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VolumeSettings():
        return $default(_that.masterVolume, _that.channelVolumes, _that.isMuted,
            _that.bassBoost, _that.trebleBoost, _that.loudnessCompensation);
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
            double masterVolume,
            Map<String, double> channelVolumes,
            bool isMuted,
            double bassBoost,
            double trebleBoost,
            bool loudnessCompensation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VolumeSettings() when $default != null:
        return $default(_that.masterVolume, _that.channelVolumes, _that.isMuted,
            _that.bassBoost, _that.trebleBoost, _that.loudnessCompensation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VolumeSettings implements VolumeSettings {
  const _VolumeSettings(
      {this.masterVolume = 0.5,
      final Map<String, double> channelVolumes = const {},
      this.isMuted = false,
      this.bassBoost = 0.0,
      this.trebleBoost = 0.0,
      this.loudnessCompensation = false})
      : _channelVolumes = channelVolumes;
  factory _VolumeSettings.fromJson(Map<String, dynamic> json) =>
      _$VolumeSettingsFromJson(json);

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

  /// Create a copy of VolumeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VolumeSettingsCopyWith<_VolumeSettings> get copyWith =>
      __$VolumeSettingsCopyWithImpl<_VolumeSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VolumeSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VolumeSettings &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      masterVolume,
      const DeepCollectionEquality().hash(_channelVolumes),
      isMuted,
      bassBoost,
      trebleBoost,
      loudnessCompensation);

  @override
  String toString() {
    return 'VolumeSettings(masterVolume: $masterVolume, channelVolumes: $channelVolumes, isMuted: $isMuted, bassBoost: $bassBoost, trebleBoost: $trebleBoost, loudnessCompensation: $loudnessCompensation)';
  }
}

/// @nodoc
abstract mixin class _$VolumeSettingsCopyWith<$Res>
    implements $VolumeSettingsCopyWith<$Res> {
  factory _$VolumeSettingsCopyWith(
          _VolumeSettings value, $Res Function(_VolumeSettings) _then) =
      __$VolumeSettingsCopyWithImpl;
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
class __$VolumeSettingsCopyWithImpl<$Res>
    implements _$VolumeSettingsCopyWith<$Res> {
  __$VolumeSettingsCopyWithImpl(this._self, this._then);

  final _VolumeSettings _self;
  final $Res Function(_VolumeSettings) _then;

  /// Create a copy of VolumeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? masterVolume = null,
    Object? channelVolumes = null,
    Object? isMuted = null,
    Object? bassBoost = null,
    Object? trebleBoost = null,
    Object? loudnessCompensation = null,
  }) {
    return _then(_VolumeSettings(
      masterVolume: null == masterVolume
          ? _self.masterVolume
          : masterVolume // ignore: cast_nullable_to_non_nullable
              as double,
      channelVolumes: null == channelVolumes
          ? _self._channelVolumes
          : channelVolumes // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      isMuted: null == isMuted
          ? _self.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      bassBoost: null == bassBoost
          ? _self.bassBoost
          : bassBoost // ignore: cast_nullable_to_non_nullable
              as double,
      trebleBoost: null == trebleBoost
          ? _self.trebleBoost
          : trebleBoost // ignore: cast_nullable_to_non_nullable
              as double,
      loudnessCompensation: null == loudnessCompensation
          ? _self.loudnessCompensation
          : loudnessCompensation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$AudioProfile {
  String get id;
  String get name;
  VolumeSettings get volumeSettings;
  Map<String, dynamic> get equalizerSettings;
  String? get description;
  List<String> get tags;
  bool get isActive;
  DateTime? get createdAt;

  /// Create a copy of AudioProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AudioProfileCopyWith<AudioProfile> get copyWith =>
      _$AudioProfileCopyWithImpl<AudioProfile>(
          this as AudioProfile, _$identity);

  /// Serializes this AudioProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AudioProfile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.volumeSettings, volumeSettings) ||
                other.volumeSettings == volumeSettings) &&
            const DeepCollectionEquality()
                .equals(other.equalizerSettings, equalizerSettings) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      volumeSettings,
      const DeepCollectionEquality().hash(equalizerSettings),
      description,
      const DeepCollectionEquality().hash(tags),
      isActive,
      createdAt);

  @override
  String toString() {
    return 'AudioProfile(id: $id, name: $name, volumeSettings: $volumeSettings, equalizerSettings: $equalizerSettings, description: $description, tags: $tags, isActive: $isActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $AudioProfileCopyWith<$Res> {
  factory $AudioProfileCopyWith(
          AudioProfile value, $Res Function(AudioProfile) _then) =
      _$AudioProfileCopyWithImpl;
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
class _$AudioProfileCopyWithImpl<$Res> implements $AudioProfileCopyWith<$Res> {
  _$AudioProfileCopyWithImpl(this._self, this._then);

  final AudioProfile _self;
  final $Res Function(AudioProfile) _then;

  /// Create a copy of AudioProfile
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      volumeSettings: null == volumeSettings
          ? _self.volumeSettings
          : volumeSettings // ignore: cast_nullable_to_non_nullable
              as VolumeSettings,
      equalizerSettings: null == equalizerSettings
          ? _self.equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of AudioProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VolumeSettingsCopyWith<$Res> get volumeSettings {
    return $VolumeSettingsCopyWith<$Res>(_self.volumeSettings, (value) {
      return _then(_self.copyWith(volumeSettings: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AudioProfile].
extension AudioProfilePatterns on AudioProfile {
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
    TResult Function(_AudioProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AudioProfile() when $default != null:
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
    TResult Function(_AudioProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioProfile():
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
    TResult? Function(_AudioProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioProfile() when $default != null:
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
            VolumeSettings volumeSettings,
            Map<String, dynamic> equalizerSettings,
            String? description,
            List<String> tags,
            bool isActive,
            DateTime? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AudioProfile() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.volumeSettings,
            _that.equalizerSettings,
            _that.description,
            _that.tags,
            _that.isActive,
            _that.createdAt);
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
            VolumeSettings volumeSettings,
            Map<String, dynamic> equalizerSettings,
            String? description,
            List<String> tags,
            bool isActive,
            DateTime? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioProfile():
        return $default(
            _that.id,
            _that.name,
            _that.volumeSettings,
            _that.equalizerSettings,
            _that.description,
            _that.tags,
            _that.isActive,
            _that.createdAt);
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
            VolumeSettings volumeSettings,
            Map<String, dynamic> equalizerSettings,
            String? description,
            List<String> tags,
            bool isActive,
            DateTime? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioProfile() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.volumeSettings,
            _that.equalizerSettings,
            _that.description,
            _that.tags,
            _that.isActive,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AudioProfile implements AudioProfile {
  const _AudioProfile(
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
  factory _AudioProfile.fromJson(Map<String, dynamic> json) =>
      _$AudioProfileFromJson(json);

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

  /// Create a copy of AudioProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AudioProfileCopyWith<_AudioProfile> get copyWith =>
      __$AudioProfileCopyWithImpl<_AudioProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AudioProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AudioProfile &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'AudioProfile(id: $id, name: $name, volumeSettings: $volumeSettings, equalizerSettings: $equalizerSettings, description: $description, tags: $tags, isActive: $isActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$AudioProfileCopyWith<$Res>
    implements $AudioProfileCopyWith<$Res> {
  factory _$AudioProfileCopyWith(
          _AudioProfile value, $Res Function(_AudioProfile) _then) =
      __$AudioProfileCopyWithImpl;
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
class __$AudioProfileCopyWithImpl<$Res>
    implements _$AudioProfileCopyWith<$Res> {
  __$AudioProfileCopyWithImpl(this._self, this._then);

  final _AudioProfile _self;
  final $Res Function(_AudioProfile) _then;

  /// Create a copy of AudioProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_AudioProfile(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      volumeSettings: null == volumeSettings
          ? _self.volumeSettings
          : volumeSettings // ignore: cast_nullable_to_non_nullable
              as VolumeSettings,
      equalizerSettings: null == equalizerSettings
          ? _self._equalizerSettings
          : equalizerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of AudioProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VolumeSettingsCopyWith<$Res> get volumeSettings {
    return $VolumeSettingsCopyWith<$Res>(_self.volumeSettings, (value) {
      return _then(_self.copyWith(volumeSettings: value));
    });
  }
}

/// @nodoc
mixin _$FreeDomeCommand {
  String get type;
  Map<String, dynamic> get data;
  String? get targetSystemId;
  String? get sessionId;
  int get priority;
  DateTime? get timestamp;
  Duration? get timeout;

  /// Create a copy of FreeDomeCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreeDomeCommandCopyWith<FreeDomeCommand> get copyWith =>
      _$FreeDomeCommandCopyWithImpl<FreeDomeCommand>(
          this as FreeDomeCommand, _$identity);

  /// Serializes this FreeDomeCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreeDomeCommand &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.data, data) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(data),
      targetSystemId,
      sessionId,
      priority,
      timestamp,
      timeout);

  @override
  String toString() {
    return 'FreeDomeCommand(type: $type, data: $data, targetSystemId: $targetSystemId, sessionId: $sessionId, priority: $priority, timestamp: $timestamp, timeout: $timeout)';
  }
}

/// @nodoc
abstract mixin class $FreeDomeCommandCopyWith<$Res> {
  factory $FreeDomeCommandCopyWith(
          FreeDomeCommand value, $Res Function(FreeDomeCommand) _then) =
      _$FreeDomeCommandCopyWithImpl;
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
class _$FreeDomeCommandCopyWithImpl<$Res>
    implements $FreeDomeCommandCopyWith<$Res> {
  _$FreeDomeCommandCopyWithImpl(this._self, this._then);

  final FreeDomeCommand _self;
  final $Res Function(FreeDomeCommand) _then;

  /// Create a copy of FreeDomeCommand
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      targetSystemId: freezed == targetSystemId
          ? _self.targetSystemId
          : targetSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _self.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeout: freezed == timeout
          ? _self.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreeDomeCommand].
extension FreeDomeCommandPatterns on FreeDomeCommand {
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
    TResult Function(_FreeDomeCommand value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeCommand() when $default != null:
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
    TResult Function(_FreeDomeCommand value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeCommand():
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
    TResult? Function(_FreeDomeCommand value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeCommand() when $default != null:
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
            String type,
            Map<String, dynamic> data,
            String? targetSystemId,
            String? sessionId,
            int priority,
            DateTime? timestamp,
            Duration? timeout)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeCommand() when $default != null:
        return $default(_that.type, _that.data, _that.targetSystemId,
            _that.sessionId, _that.priority, _that.timestamp, _that.timeout);
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
            String type,
            Map<String, dynamic> data,
            String? targetSystemId,
            String? sessionId,
            int priority,
            DateTime? timestamp,
            Duration? timeout)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeCommand():
        return $default(_that.type, _that.data, _that.targetSystemId,
            _that.sessionId, _that.priority, _that.timestamp, _that.timeout);
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
            String type,
            Map<String, dynamic> data,
            String? targetSystemId,
            String? sessionId,
            int priority,
            DateTime? timestamp,
            Duration? timeout)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeCommand() when $default != null:
        return $default(_that.type, _that.data, _that.targetSystemId,
            _that.sessionId, _that.priority, _that.timestamp, _that.timeout);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FreeDomeCommand implements FreeDomeCommand {
  const _FreeDomeCommand(
      {required this.type,
      required final Map<String, dynamic> data,
      this.targetSystemId,
      this.sessionId,
      this.priority = 0,
      this.timestamp,
      this.timeout})
      : _data = data;
  factory _FreeDomeCommand.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeCommandFromJson(json);

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

  /// Create a copy of FreeDomeCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FreeDomeCommandCopyWith<_FreeDomeCommand> get copyWith =>
      __$FreeDomeCommandCopyWithImpl<_FreeDomeCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FreeDomeCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FreeDomeCommand &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'FreeDomeCommand(type: $type, data: $data, targetSystemId: $targetSystemId, sessionId: $sessionId, priority: $priority, timestamp: $timestamp, timeout: $timeout)';
  }
}

/// @nodoc
abstract mixin class _$FreeDomeCommandCopyWith<$Res>
    implements $FreeDomeCommandCopyWith<$Res> {
  factory _$FreeDomeCommandCopyWith(
          _FreeDomeCommand value, $Res Function(_FreeDomeCommand) _then) =
      __$FreeDomeCommandCopyWithImpl;
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
class __$FreeDomeCommandCopyWithImpl<$Res>
    implements _$FreeDomeCommandCopyWith<$Res> {
  __$FreeDomeCommandCopyWithImpl(this._self, this._then);

  final _FreeDomeCommand _self;
  final $Res Function(_FreeDomeCommand) _then;

  /// Create a copy of FreeDomeCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? targetSystemId = freezed,
    Object? sessionId = freezed,
    Object? priority = null,
    Object? timestamp = freezed,
    Object? timeout = freezed,
  }) {
    return _then(_FreeDomeCommand(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      targetSystemId: freezed == targetSystemId
          ? _self.targetSystemId
          : targetSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _self.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeout: freezed == timeout
          ? _self.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
mixin _$FreeDomeResponse {
  bool get success;
  String? get error;
  Map<String, dynamic>? get data;
  String? get commandId;
  DateTime? get timestamp;

  /// Create a copy of FreeDomeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreeDomeResponseCopyWith<FreeDomeResponse> get copyWith =>
      _$FreeDomeResponseCopyWithImpl<FreeDomeResponse>(
          this as FreeDomeResponse, _$identity);

  /// Serializes this FreeDomeResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreeDomeResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.commandId, commandId) ||
                other.commandId == commandId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, error,
      const DeepCollectionEquality().hash(data), commandId, timestamp);

  @override
  String toString() {
    return 'FreeDomeResponse(success: $success, error: $error, data: $data, commandId: $commandId, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $FreeDomeResponseCopyWith<$Res> {
  factory $FreeDomeResponseCopyWith(
          FreeDomeResponse value, $Res Function(FreeDomeResponse) _then) =
      _$FreeDomeResponseCopyWithImpl;
  @useResult
  $Res call(
      {bool success,
      String? error,
      Map<String, dynamic>? data,
      String? commandId,
      DateTime? timestamp});
}

/// @nodoc
class _$FreeDomeResponseCopyWithImpl<$Res>
    implements $FreeDomeResponseCopyWith<$Res> {
  _$FreeDomeResponseCopyWithImpl(this._self, this._then);

  final FreeDomeResponse _self;
  final $Res Function(FreeDomeResponse) _then;

  /// Create a copy of FreeDomeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? data = freezed,
    Object? commandId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      commandId: freezed == commandId
          ? _self.commandId
          : commandId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreeDomeResponse].
extension FreeDomeResponsePatterns on FreeDomeResponse {
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
    TResult Function(_FreeDomeResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeResponse() when $default != null:
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
    TResult Function(_FreeDomeResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeResponse():
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
    TResult? Function(_FreeDomeResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeResponse() when $default != null:
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
    TResult Function(bool success, String? error, Map<String, dynamic>? data,
            String? commandId, DateTime? timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeResponse() when $default != null:
        return $default(_that.success, _that.error, _that.data, _that.commandId,
            _that.timestamp);
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
    TResult Function(bool success, String? error, Map<String, dynamic>? data,
            String? commandId, DateTime? timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeResponse():
        return $default(_that.success, _that.error, _that.data, _that.commandId,
            _that.timestamp);
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
    TResult? Function(bool success, String? error, Map<String, dynamic>? data,
            String? commandId, DateTime? timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeResponse() when $default != null:
        return $default(_that.success, _that.error, _that.data, _that.commandId,
            _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FreeDomeResponse implements FreeDomeResponse {
  const _FreeDomeResponse(
      {required this.success,
      this.error,
      final Map<String, dynamic>? data,
      this.commandId,
      this.timestamp})
      : _data = data;
  factory _FreeDomeResponse.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeResponseFromJson(json);

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

  /// Create a copy of FreeDomeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FreeDomeResponseCopyWith<_FreeDomeResponse> get copyWith =>
      __$FreeDomeResponseCopyWithImpl<_FreeDomeResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FreeDomeResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FreeDomeResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.commandId, commandId) ||
                other.commandId == commandId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, error,
      const DeepCollectionEquality().hash(_data), commandId, timestamp);

  @override
  String toString() {
    return 'FreeDomeResponse(success: $success, error: $error, data: $data, commandId: $commandId, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$FreeDomeResponseCopyWith<$Res>
    implements $FreeDomeResponseCopyWith<$Res> {
  factory _$FreeDomeResponseCopyWith(
          _FreeDomeResponse value, $Res Function(_FreeDomeResponse) _then) =
      __$FreeDomeResponseCopyWithImpl;
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
class __$FreeDomeResponseCopyWithImpl<$Res>
    implements _$FreeDomeResponseCopyWith<$Res> {
  __$FreeDomeResponseCopyWithImpl(this._self, this._then);

  final _FreeDomeResponse _self;
  final $Res Function(_FreeDomeResponse) _then;

  /// Create a copy of FreeDomeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? data = freezed,
    Object? commandId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_FreeDomeResponse(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      commandId: freezed == commandId
          ? _self.commandId
          : commandId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$FreeDomeEvent {
  String get type;
  Map<String, dynamic> get data;
  String? get sourceSystemId;
  DateTime? get timestamp;

  /// Create a copy of FreeDomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreeDomeEventCopyWith<FreeDomeEvent> get copyWith =>
      _$FreeDomeEventCopyWithImpl<FreeDomeEvent>(
          this as FreeDomeEvent, _$identity);

  /// Serializes this FreeDomeEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreeDomeEvent &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.sourceSystemId, sourceSystemId) ||
                other.sourceSystemId == sourceSystemId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(data), sourceSystemId, timestamp);

  @override
  String toString() {
    return 'FreeDomeEvent(type: $type, data: $data, sourceSystemId: $sourceSystemId, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $FreeDomeEventCopyWith<$Res> {
  factory $FreeDomeEventCopyWith(
          FreeDomeEvent value, $Res Function(FreeDomeEvent) _then) =
      _$FreeDomeEventCopyWithImpl;
  @useResult
  $Res call(
      {String type,
      Map<String, dynamic> data,
      String? sourceSystemId,
      DateTime? timestamp});
}

/// @nodoc
class _$FreeDomeEventCopyWithImpl<$Res>
    implements $FreeDomeEventCopyWith<$Res> {
  _$FreeDomeEventCopyWithImpl(this._self, this._then);

  final FreeDomeEvent _self;
  final $Res Function(FreeDomeEvent) _then;

  /// Create a copy of FreeDomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? sourceSystemId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sourceSystemId: freezed == sourceSystemId
          ? _self.sourceSystemId
          : sourceSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreeDomeEvent].
extension FreeDomeEventPatterns on FreeDomeEvent {
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
    TResult Function(_FreeDomeEvent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeEvent() when $default != null:
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
    TResult Function(_FreeDomeEvent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeEvent():
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
    TResult? Function(_FreeDomeEvent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeEvent() when $default != null:
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
    TResult Function(String type, Map<String, dynamic> data,
            String? sourceSystemId, DateTime? timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FreeDomeEvent() when $default != null:
        return $default(
            _that.type, _that.data, _that.sourceSystemId, _that.timestamp);
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
    TResult Function(String type, Map<String, dynamic> data,
            String? sourceSystemId, DateTime? timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeEvent():
        return $default(
            _that.type, _that.data, _that.sourceSystemId, _that.timestamp);
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
    TResult? Function(String type, Map<String, dynamic> data,
            String? sourceSystemId, DateTime? timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FreeDomeEvent() when $default != null:
        return $default(
            _that.type, _that.data, _that.sourceSystemId, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FreeDomeEvent implements FreeDomeEvent {
  const _FreeDomeEvent(
      {required this.type,
      required final Map<String, dynamic> data,
      this.sourceSystemId,
      this.timestamp})
      : _data = data;
  factory _FreeDomeEvent.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeEventFromJson(json);

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

  /// Create a copy of FreeDomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FreeDomeEventCopyWith<_FreeDomeEvent> get copyWith =>
      __$FreeDomeEventCopyWithImpl<_FreeDomeEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FreeDomeEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FreeDomeEvent &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.sourceSystemId, sourceSystemId) ||
                other.sourceSystemId == sourceSystemId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(_data), sourceSystemId, timestamp);

  @override
  String toString() {
    return 'FreeDomeEvent(type: $type, data: $data, sourceSystemId: $sourceSystemId, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$FreeDomeEventCopyWith<$Res>
    implements $FreeDomeEventCopyWith<$Res> {
  factory _$FreeDomeEventCopyWith(
          _FreeDomeEvent value, $Res Function(_FreeDomeEvent) _then) =
      __$FreeDomeEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String type,
      Map<String, dynamic> data,
      String? sourceSystemId,
      DateTime? timestamp});
}

/// @nodoc
class __$FreeDomeEventCopyWithImpl<$Res>
    implements _$FreeDomeEventCopyWith<$Res> {
  __$FreeDomeEventCopyWithImpl(this._self, this._then);

  final _FreeDomeEvent _self;
  final $Res Function(_FreeDomeEvent) _then;

  /// Create a copy of FreeDomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? sourceSystemId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_FreeDomeEvent(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sourceSystemId: freezed == sourceSystemId
          ? _self.sourceSystemId
          : sourceSystemId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
