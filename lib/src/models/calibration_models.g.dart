// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalibrationProgressImpl _$$CalibrationProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$CalibrationProgressImpl(
      id: json['id'] as String,
      type: $enumDecode(_$CalibrationTypeEnumMap, json['type']),
      status: $enumDecode(_$CalibrationStatusEnumMap, json['status']),
      progress: (json['progress'] as num).toDouble(),
      currentStep: json['currentStep'] as String,
      totalSteps: (json['totalSteps'] as num?)?.toInt() ?? 0,
      completedSteps: (json['completedSteps'] as num?)?.toInt() ?? 0,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      estimatedCompletion: json['estimatedCompletion'] == null
          ? null
          : DateTime.parse(json['estimatedCompletion'] as String),
      error: json['error'] as String?,
      stepData: json['stepData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CalibrationProgressImplToJson(
        _$CalibrationProgressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CalibrationTypeEnumMap[instance.type]!,
      'status': _$CalibrationStatusEnumMap[instance.status]!,
      'progress': instance.progress,
      'currentStep': instance.currentStep,
      'totalSteps': instance.totalSteps,
      'completedSteps': instance.completedSteps,
      'startTime': instance.startTime?.toIso8601String(),
      'estimatedCompletion': instance.estimatedCompletion?.toIso8601String(),
      'error': instance.error,
      'stepData': instance.stepData,
    };

const _$CalibrationTypeEnumMap = {
  CalibrationType.auto: 'auto',
  CalibrationType.manual: 'manual',
  CalibrationType.quick: 'quick',
  CalibrationType.full: 'full',
  CalibrationType.audio_only: 'audio_only',
  CalibrationType.video_only: 'video_only',
};

const _$CalibrationStatusEnumMap = {
  CalibrationStatus.pending: 'pending',
  CalibrationStatus.running: 'running',
  CalibrationStatus.completed: 'completed',
  CalibrationStatus.failed: 'failed',
  CalibrationStatus.cancelled: 'cancelled',
  CalibrationStatus.paused: 'paused',
};

_$CalibrationResultImpl _$$CalibrationResultImplFromJson(
        Map<String, dynamic> json) =>
    _$CalibrationResultImpl(
      id: json['id'] as String,
      type: $enumDecode(_$CalibrationTypeEnumMap, json['type']),
      status: $enumDecode(_$CalibrationStatusEnumMap, json['status']),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      channelResults: (json['channelResults'] as List<dynamic>?)
              ?.map((e) => ChannelResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      projectorResults: (json['projectorResults'] as List<dynamic>?)
              ?.map((e) => ProjectorResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      systemResults: json['systemResults'] as Map<String, dynamic>?,
      error: json['error'] as String?,
      overallQuality: (json['overallQuality'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$CalibrationResultImplToJson(
        _$CalibrationResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CalibrationTypeEnumMap[instance.type]!,
      'status': _$CalibrationStatusEnumMap[instance.status]!,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'channelResults': instance.channelResults,
      'projectorResults': instance.projectorResults,
      'systemResults': instance.systemResults,
      'error': instance.error,
      'overallQuality': instance.overallQuality,
    };

_$ChannelResultImpl _$$ChannelResultImplFromJson(Map<String, dynamic> json) =>
    _$ChannelResultImpl(
      channelId: json['channelId'] as String,
      channelName: json['channelName'] as String,
      channelType: json['channelType'] as String,
      frequencyResponse: (json['frequencyResponse'] as List<dynamic>?)
              ?.map((e) => FrequencyPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      delay: (json['delay'] as num?)?.toDouble() ?? 0.0,
      distortion: (json['distortion'] as num?)?.toDouble() ?? 0.0,
      noiseFloor: (json['noiseFloor'] as num?)?.toDouble() ?? 0.0,
      gain: (json['gain'] as num?)?.toDouble() ?? 1.0,
      phase: (json['phase'] as num?)?.toDouble() ?? 0.0,
      quality: (json['quality'] as num?)?.toDouble() ?? 100.0,
      equalizerSettings: json['equalizerSettings'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ChannelResultImplToJson(_$ChannelResultImpl instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelName': instance.channelName,
      'channelType': instance.channelType,
      'frequencyResponse': instance.frequencyResponse,
      'delay': instance.delay,
      'distortion': instance.distortion,
      'noiseFloor': instance.noiseFloor,
      'gain': instance.gain,
      'phase': instance.phase,
      'quality': instance.quality,
      'equalizerSettings': instance.equalizerSettings,
    };

_$FrequencyPointImpl _$$FrequencyPointImplFromJson(Map<String, dynamic> json) =>
    _$FrequencyPointImpl(
      frequency: (json['frequency'] as num).toDouble(),
      magnitude: (json['magnitude'] as num).toDouble(),
      phase: (json['phase'] as num).toDouble(),
    );

Map<String, dynamic> _$$FrequencyPointImplToJson(
        _$FrequencyPointImpl instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'magnitude': instance.magnitude,
      'phase': instance.phase,
    };

_$ProjectorResultImpl _$$ProjectorResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectorResultImpl(
      projectorId: json['projectorId'] as String,
      projectorName: json['projectorName'] as String,
      calibrationPoints: (json['calibrationPoints'] as List<dynamic>?)
              ?.map((e) => CalibrationPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      brightness: (json['brightness'] as num?)?.toDouble() ?? 0.0,
      contrast: (json['contrast'] as num?)?.toDouble() ?? 0.0,
      gamma: (json['gamma'] as num?)?.toDouble() ?? 0.0,
      colorMatrix: (json['colorMatrix'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      geometryAccuracy: (json['geometryAccuracy'] as num?)?.toDouble() ?? 0.0,
      quality: (json['quality'] as num?)?.toDouble() ?? 100.0,
      lensCorrection: json['lensCorrection'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ProjectorResultImplToJson(
        _$ProjectorResultImpl instance) =>
    <String, dynamic>{
      'projectorId': instance.projectorId,
      'projectorName': instance.projectorName,
      'calibrationPoints': instance.calibrationPoints,
      'brightness': instance.brightness,
      'contrast': instance.contrast,
      'gamma': instance.gamma,
      'colorMatrix': instance.colorMatrix,
      'geometryAccuracy': instance.geometryAccuracy,
      'quality': instance.quality,
      'lensCorrection': instance.lensCorrection,
    };

_$CalibrationPointImpl _$$CalibrationPointImplFromJson(
        Map<String, dynamic> json) =>
    _$CalibrationPointImpl(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      targetX: (json['targetX'] as num).toDouble(),
      targetY: (json['targetY'] as num).toDouble(),
      error: (json['error'] as num).toDouble(),
    );

Map<String, dynamic> _$$CalibrationPointImplToJson(
        _$CalibrationPointImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'targetX': instance.targetX,
      'targetY': instance.targetY,
      'error': instance.error,
    };

_$MicrophoneStatusImpl _$$MicrophoneStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$MicrophoneStatusImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      isConnected: json['isConnected'] as bool,
      isCalibrated: json['isCalibrated'] as bool,
      sensitivity: (json['sensitivity'] as num?)?.toDouble() ?? 0.0,
      noiseLevel: (json['noiseLevel'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] as String? ?? 'unknown',
      lastCalibrated: json['lastCalibrated'] == null
          ? null
          : DateTime.parse(json['lastCalibrated'] as String),
      calibrationData: json['calibrationData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MicrophoneStatusImplToJson(
        _$MicrophoneStatusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isConnected': instance.isConnected,
      'isCalibrated': instance.isCalibrated,
      'sensitivity': instance.sensitivity,
      'noiseLevel': instance.noiseLevel,
      'type': instance.type,
      'lastCalibrated': instance.lastCalibrated?.toIso8601String(),
      'calibrationData': instance.calibrationData,
    };

_$VolumeSettingsImpl _$$VolumeSettingsImplFromJson(Map<String, dynamic> json) =>
    _$VolumeSettingsImpl(
      masterVolume: (json['masterVolume'] as num?)?.toDouble() ?? 0.5,
      channelVolumes: (json['channelVolumes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      isMuted: json['isMuted'] as bool? ?? false,
      bassBoost: (json['bassBoost'] as num?)?.toDouble() ?? 0.0,
      trebleBoost: (json['trebleBoost'] as num?)?.toDouble() ?? 0.0,
      loudnessCompensation: json['loudnessCompensation'] as bool? ?? false,
    );

Map<String, dynamic> _$$VolumeSettingsImplToJson(
        _$VolumeSettingsImpl instance) =>
    <String, dynamic>{
      'masterVolume': instance.masterVolume,
      'channelVolumes': instance.channelVolumes,
      'isMuted': instance.isMuted,
      'bassBoost': instance.bassBoost,
      'trebleBoost': instance.trebleBoost,
      'loudnessCompensation': instance.loudnessCompensation,
    };

_$AudioProfileImpl _$$AudioProfileImplFromJson(Map<String, dynamic> json) =>
    _$AudioProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      volumeSettings: VolumeSettings.fromJson(
          json['volumeSettings'] as Map<String, dynamic>),
      equalizerSettings: json['equalizerSettings'] as Map<String, dynamic>,
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isActive: json['isActive'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AudioProfileImplToJson(_$AudioProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'volumeSettings': instance.volumeSettings,
      'equalizerSettings': instance.equalizerSettings,
      'description': instance.description,
      'tags': instance.tags,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$FreeDomeCommandImpl _$$FreeDomeCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$FreeDomeCommandImpl(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
      targetSystemId: json['targetSystemId'] as String?,
      sessionId: json['sessionId'] as String?,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      timeout: json['timeout'] == null
          ? null
          : Duration(microseconds: (json['timeout'] as num).toInt()),
    );

Map<String, dynamic> _$$FreeDomeCommandImplToJson(
        _$FreeDomeCommandImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'targetSystemId': instance.targetSystemId,
      'sessionId': instance.sessionId,
      'priority': instance.priority,
      'timestamp': instance.timestamp?.toIso8601String(),
      'timeout': instance.timeout?.inMicroseconds,
    };

_$FreeDomeResponseImpl _$$FreeDomeResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FreeDomeResponseImpl(
      success: json['success'] as bool,
      error: json['error'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      commandId: json['commandId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$FreeDomeResponseImplToJson(
        _$FreeDomeResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
      'commandId': instance.commandId,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$FreeDomeEventImpl _$$FreeDomeEventImplFromJson(Map<String, dynamic> json) =>
    _$FreeDomeEventImpl(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
      sourceSystemId: json['sourceSystemId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$FreeDomeEventImplToJson(_$FreeDomeEventImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'sourceSystemId': instance.sourceSystemId,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
