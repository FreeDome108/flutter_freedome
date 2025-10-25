// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dome_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DomeSystem _$DomeSystemFromJson(Map<String, dynamic> json) => _DomeSystem(
      id: json['id'] as String,
      name: json['name'] as String,
      ipAddress: json['ipAddress'] as String,
      port: (json['port'] as num).toInt(),
      type: $enumDecode(_$DomeSystemTypeEnumMap, json['type']),
      status: $enumDecode(_$DomeSystemStatusEnumMap, json['status']),
      isConnected: json['isConnected'] as bool? ?? false,
      projectors: (json['projectors'] as List<dynamic>?)
              ?.map((e) => ProjectorConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      audioChannels: (json['audioChannels'] as List<dynamic>?)
              ?.map((e) => AudioChannel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastConnected: json['lastConnected'] == null
          ? null
          : DateTime.parse(json['lastConnected'] as String),
      firmwareVersion: json['firmwareVersion'] as String?,
      capabilities: json['capabilities'] as Map<String, dynamic>?,
      activeVendor: json['activeVendor'] as String?,
      systemVolume: (json['systemVolume'] as num?)?.toDouble() ?? 0.5,
      systemBrightness: (json['systemBrightness'] as num?)?.toDouble() ?? 0.8,
      systemRotation: (json['systemRotation'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$DomeSystemToJson(_DomeSystem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ipAddress': instance.ipAddress,
      'port': instance.port,
      'type': _$DomeSystemTypeEnumMap[instance.type]!,
      'status': _$DomeSystemStatusEnumMap[instance.status]!,
      'isConnected': instance.isConnected,
      'projectors': instance.projectors,
      'audioChannels': instance.audioChannels,
      'lastConnected': instance.lastConnected?.toIso8601String(),
      'firmwareVersion': instance.firmwareVersion,
      'capabilities': instance.capabilities,
      'activeVendor': instance.activeVendor,
      'systemVolume': instance.systemVolume,
      'systemBrightness': instance.systemBrightness,
      'systemRotation': instance.systemRotation,
    };

const _$DomeSystemTypeEnumMap = {
  DomeSystemType.professional: 'professional',
  DomeSystemType.mobile: 'mobile',
  DomeSystemType.hybrid: 'hybrid',
};

const _$DomeSystemStatusEnumMap = {
  DomeSystemStatus.online: 'online',
  DomeSystemStatus.offline: 'offline',
  DomeSystemStatus.connecting: 'connecting',
  DomeSystemStatus.error: 'error',
  DomeSystemStatus.maintenance: 'maintenance',
  DomeSystemStatus.calibrating: 'calibrating',
};

_ProjectorConfig _$ProjectorConfigFromJson(Map<String, dynamic> json) =>
    _ProjectorConfig(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$ProjectorTypeEnumMap, json['type']),
      brightness: (json['brightness'] as num).toInt(),
      contrast: (json['contrast'] as num).toInt(),
      status: $enumDecode(_$ProjectorStatusEnumMap, json['status']),
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
      z: (json['z'] as num?)?.toDouble() ?? 0.0,
      pitch: (json['pitch'] as num?)?.toDouble() ?? 0.0,
      yaw: (json['yaw'] as num?)?.toDouble() ?? 0.0,
      roll: (json['roll'] as num?)?.toDouble() ?? 0.0,
      resolutionWidth: (json['resolutionWidth'] as num?)?.toInt() ?? 1920,
      resolutionHeight: (json['resolutionHeight'] as num?)?.toInt() ?? 1080,
      refreshRate: (json['refreshRate'] as num?)?.toDouble() ?? 60.0,
      calibrationData: json['calibrationData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProjectorConfigToJson(_ProjectorConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ProjectorTypeEnumMap[instance.type]!,
      'brightness': instance.brightness,
      'contrast': instance.contrast,
      'status': _$ProjectorStatusEnumMap[instance.status]!,
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'pitch': instance.pitch,
      'yaw': instance.yaw,
      'roll': instance.roll,
      'resolutionWidth': instance.resolutionWidth,
      'resolutionHeight': instance.resolutionHeight,
      'refreshRate': instance.refreshRate,
      'calibrationData': instance.calibrationData,
    };

const _$ProjectorTypeEnumMap = {
  ProjectorType.laser: 'laser',
  ProjectorType.led: 'led',
  ProjectorType.dlp: 'dlp',
  ProjectorType.lcd: 'lcd',
};

const _$ProjectorStatusEnumMap = {
  ProjectorStatus.active: 'active',
  ProjectorStatus.standby: 'standby',
  ProjectorStatus.error: 'error',
  ProjectorStatus.calibrating: 'calibrating',
  ProjectorStatus.warmingUp: 'warmingUp',
  ProjectorStatus.coolingDown: 'coolingDown',
};

_AudioChannel _$AudioChannelFromJson(Map<String, dynamic> json) =>
    _AudioChannel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$AudioChannelTypeEnumMap, json['type']),
      volume: (json['volume'] as num?)?.toDouble() ?? 0.5,
      isMuted: json['isMuted'] as bool? ?? false,
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
      z: (json['z'] as num?)?.toDouble() ?? 0.0,
      delay: (json['delay'] as num?)?.toDouble() ?? 0.0,
      equalizerSettings: json['equalizerSettings'] as Map<String, dynamic>?,
      calibrationData: json['calibrationData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AudioChannelToJson(_AudioChannel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AudioChannelTypeEnumMap[instance.type]!,
      'volume': instance.volume,
      'isMuted': instance.isMuted,
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'delay': instance.delay,
      'equalizerSettings': instance.equalizerSettings,
      'calibrationData': instance.calibrationData,
    };

const _$AudioChannelTypeEnumMap = {
  AudioChannelType.mono: 'mono',
  AudioChannelType.stereo: 'stereo',
  AudioChannelType.surround: 'surround',
  AudioChannelType.ambisonic: 'ambisonic',
};

_FreeDomeConnectionStatus _$FreeDomeConnectionStatusFromJson(
        Map<String, dynamic> json) =>
    _FreeDomeConnectionStatus(
      isConnected: json['isConnected'] as bool,
      isConnecting: json['isConnecting'] as bool,
      connectedDomeId: json['connectedDomeId'] as String?,
      serverUrl: json['serverUrl'] as String?,
      lastConnected: json['lastConnected'] == null
          ? null
          : DateTime.parse(json['lastConnected'] as String),
      error: json['error'] as String?,
      reconnectAttempts: (json['reconnectAttempts'] as num?)?.toInt() ?? 0,
      maxReconnectAttempts:
          (json['maxReconnectAttempts'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$FreeDomeConnectionStatusToJson(
        _FreeDomeConnectionStatus instance) =>
    <String, dynamic>{
      'isConnected': instance.isConnected,
      'isConnecting': instance.isConnecting,
      'connectedDomeId': instance.connectedDomeId,
      'serverUrl': instance.serverUrl,
      'lastConnected': instance.lastConnected?.toIso8601String(),
      'error': instance.error,
      'reconnectAttempts': instance.reconnectAttempts,
      'maxReconnectAttempts': instance.maxReconnectAttempts,
    };

_FreeDomeUser _$FreeDomeUserFromJson(Map<String, dynamic> json) =>
    _FreeDomeUser(
      id: json['id'] as String,
      name: json['name'] as String,
      role: $enumDecode(_$FreeDomeUserRoleEnumMap, json['role']),
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => $enumDecode(_$FreeDomePermissionEnumMap, e))
          .toList(),
      email: json['email'] as String?,
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      preferences: json['preferences'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FreeDomeUserToJson(_FreeDomeUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': _$FreeDomeUserRoleEnumMap[instance.role]!,
      'permissions': instance.permissions
          .map((e) => _$FreeDomePermissionEnumMap[e]!)
          .toList(),
      'email': instance.email,
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'preferences': instance.preferences,
    };

const _$FreeDomeUserRoleEnumMap = {
  FreeDomeUserRole.guest: 'guest',
  FreeDomeUserRole.operator: 'operator',
  FreeDomeUserRole.admin: 'admin',
  FreeDomeUserRole.superadmin: 'superadmin',
};

const _$FreeDomePermissionEnumMap = {
  FreeDomePermission.playContent: 'playContent',
  FreeDomePermission.controlBasics: 'controlBasics',
  FreeDomePermission.manageContent: 'manageContent',
  FreeDomePermission.calibrateAudio: 'calibrateAudio',
  FreeDomePermission.calibrateProjectors: 'calibrateProjectors',
  FreeDomePermission.systemManagement: 'systemManagement',
  FreeDomePermission.vendorManagement: 'vendorManagement',
};

_FreeDomeSession _$FreeDomeSessionFromJson(Map<String, dynamic> json) =>
    _FreeDomeSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      domeId: json['domeId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      duration: json['duration'] == null
          ? Duration.zero
          : Duration(microseconds: (json['duration'] as num).toInt()),
      currentContentId: json['currentContentId'] as String?,
      sessionData: json['sessionData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FreeDomeSessionToJson(_FreeDomeSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'domeId': instance.domeId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration.inMicroseconds,
      'currentContentId': instance.currentContentId,
      'sessionData': instance.sessionData,
    };
