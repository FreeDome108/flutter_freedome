// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalibrationProgress _$CalibrationProgressFromJson(Map<String, dynamic> json) =>
    _CalibrationProgress(
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

Map<String, dynamic> _$CalibrationProgressToJson(
        _CalibrationProgress instance) =>
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

_CalibrationResult _$CalibrationResultFromJson(Map<String, dynamic> json) =>
    _CalibrationResult(
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

Map<String, dynamic> _$CalibrationResultToJson(_CalibrationResult instance) =>
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

_ChannelResult _$ChannelResultFromJson(Map<String, dynamic> json) =>
    _ChannelResult(
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

Map<String, dynamic> _$ChannelResultToJson(_ChannelResult instance) =>
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

_FrequencyPoint _$FrequencyPointFromJson(Map<String, dynamic> json) =>
    _FrequencyPoint(
      frequency: (json['frequency'] as num).toDouble(),
      magnitude: (json['magnitude'] as num).toDouble(),
      phase: (json['phase'] as num).toDouble(),
    );

Map<String, dynamic> _$FrequencyPointToJson(_FrequencyPoint instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'magnitude': instance.magnitude,
      'phase': instance.phase,
    };

_ProjectorResult _$ProjectorResultFromJson(Map<String, dynamic> json) =>
    _ProjectorResult(
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

Map<String, dynamic> _$ProjectorResultToJson(_ProjectorResult instance) =>
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

_CalibrationPoint _$CalibrationPointFromJson(Map<String, dynamic> json) =>
    _CalibrationPoint(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      targetX: (json['targetX'] as num).toDouble(),
      targetY: (json['targetY'] as num).toDouble(),
      error: (json['error'] as num).toDouble(),
    );

Map<String, dynamic> _$CalibrationPointToJson(_CalibrationPoint instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'targetX': instance.targetX,
      'targetY': instance.targetY,
      'error': instance.error,
    };

_MicrophoneStatus _$MicrophoneStatusFromJson(Map<String, dynamic> json) =>
    _MicrophoneStatus(
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

Map<String, dynamic> _$MicrophoneStatusToJson(_MicrophoneStatus instance) =>
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

_VolumeSettings _$VolumeSettingsFromJson(Map<String, dynamic> json) =>
    _VolumeSettings(
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

Map<String, dynamic> _$VolumeSettingsToJson(_VolumeSettings instance) =>
    <String, dynamic>{
      'masterVolume': instance.masterVolume,
      'channelVolumes': instance.channelVolumes,
      'isMuted': instance.isMuted,
      'bassBoost': instance.bassBoost,
      'trebleBoost': instance.trebleBoost,
      'loudnessCompensation': instance.loudnessCompensation,
    };

_AudioProfile _$AudioProfileFromJson(Map<String, dynamic> json) =>
    _AudioProfile(
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

Map<String, dynamic> _$AudioProfileToJson(_AudioProfile instance) =>
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

_FreeDomeCommand _$FreeDomeCommandFromJson(Map<String, dynamic> json) =>
    _FreeDomeCommand(
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

Map<String, dynamic> _$FreeDomeCommandToJson(_FreeDomeCommand instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'targetSystemId': instance.targetSystemId,
      'sessionId': instance.sessionId,
      'priority': instance.priority,
      'timestamp': instance.timestamp?.toIso8601String(),
      'timeout': instance.timeout?.inMicroseconds,
    };

_FreeDomeResponse _$FreeDomeResponseFromJson(Map<String, dynamic> json) =>
    _FreeDomeResponse(
      success: json['success'] as bool,
      error: json['error'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      commandId: json['commandId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$FreeDomeResponseToJson(_FreeDomeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
      'commandId': instance.commandId,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_FreeDomeEvent _$FreeDomeEventFromJson(Map<String, dynamic> json) =>
    _FreeDomeEvent(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
      sourceSystemId: json['sourceSystemId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$FreeDomeEventToJson(_FreeDomeEvent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'sourceSystemId': instance.sourceSystemId,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
