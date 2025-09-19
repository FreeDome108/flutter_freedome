// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dome_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DomeSystemImpl _$$DomeSystemImplFromJson(Map<String, dynamic> json) =>
    _$DomeSystemImpl(
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

Map<String, dynamic> _$$DomeSystemImplToJson(_$DomeSystemImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'ipAddress': instance.ipAddress,
    'port': instance.port,
    'type': _$DomeSystemTypeEnumMap[instance.type]!,
    'status': _$DomeSystemStatusEnumMap[instance.status]!,
    'isConnected': instance.isConnected,
    'projectors': instance.projectors.map((e) => e.toJson()).toList(),
    'audioChannels': instance.audioChannels.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lastConnected', instance.lastConnected?.toIso8601String());
  writeNotNull('firmwareVersion', instance.firmwareVersion);
  writeNotNull('capabilities', instance.capabilities);
  writeNotNull('activeVendor', instance.activeVendor);
  val['systemVolume'] = instance.systemVolume;
  val['systemBrightness'] = instance.systemBrightness;
  val['systemRotation'] = instance.systemRotation;
  return val;
}

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

_$ProjectorConfigImpl _$$ProjectorConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectorConfigImpl(
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

Map<String, dynamic> _$$ProjectorConfigImplToJson(
    _$ProjectorConfigImpl instance) {
  final val = <String, dynamic>{
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
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('calibrationData', instance.calibrationData);
  return val;
}

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
  ProjectorStatus.warming_up: 'warming_up',
  ProjectorStatus.cooling_down: 'cooling_down',
};

_$AudioChannelImpl _$$AudioChannelImplFromJson(Map<String, dynamic> json) =>
    _$AudioChannelImpl(
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

Map<String, dynamic> _$$AudioChannelImplToJson(_$AudioChannelImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'type': _$AudioChannelTypeEnumMap[instance.type]!,
    'volume': instance.volume,
    'isMuted': instance.isMuted,
    'x': instance.x,
    'y': instance.y,
    'z': instance.z,
    'delay': instance.delay,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equalizerSettings', instance.equalizerSettings);
  writeNotNull('calibrationData', instance.calibrationData);
  return val;
}

const _$AudioChannelTypeEnumMap = {
  AudioChannelType.mono: 'mono',
  AudioChannelType.stereo: 'stereo',
  AudioChannelType.surround: 'surround',
  AudioChannelType.ambisonic: 'ambisonic',
};

_$FreeDomeConnectionStatusImpl _$$FreeDomeConnectionStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$FreeDomeConnectionStatusImpl(
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

Map<String, dynamic> _$$FreeDomeConnectionStatusImplToJson(
    _$FreeDomeConnectionStatusImpl instance) {
  final val = <String, dynamic>{
    'isConnected': instance.isConnected,
    'isConnecting': instance.isConnecting,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connectedDomeId', instance.connectedDomeId);
  writeNotNull('serverUrl', instance.serverUrl);
  writeNotNull('lastConnected', instance.lastConnected?.toIso8601String());
  writeNotNull('error', instance.error);
  val['reconnectAttempts'] = instance.reconnectAttempts;
  val['maxReconnectAttempts'] = instance.maxReconnectAttempts;
  return val;
}

_$FreeDomeUserImpl _$$FreeDomeUserImplFromJson(Map<String, dynamic> json) =>
    _$FreeDomeUserImpl(
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

Map<String, dynamic> _$$FreeDomeUserImplToJson(_$FreeDomeUserImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'role': _$FreeDomeUserRoleEnumMap[instance.role]!,
    'permissions': instance.permissions
        .map((e) => _$FreeDomePermissionEnumMap[e]!)
        .toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('lastLogin', instance.lastLogin?.toIso8601String());
  writeNotNull('preferences', instance.preferences);
  return val;
}

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

_$FreeDomeSessionImpl _$$FreeDomeSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$FreeDomeSessionImpl(
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

Map<String, dynamic> _$$FreeDomeSessionImplToJson(
    _$FreeDomeSessionImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'userId': instance.userId,
    'domeId': instance.domeId,
    'startTime': instance.startTime.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('endTime', instance.endTime?.toIso8601String());
  val['duration'] = instance.duration.inMicroseconds;
  writeNotNull('currentContentId', instance.currentContentId);
  writeNotNull('sessionData', instance.sessionData);
  return val;
}
