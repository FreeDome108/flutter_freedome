// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectionContentImpl _$$ProjectionContentImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectionContentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      filePath: json['filePath'] as String,
      type: $enumDecode(_$ContentTypeEnumMap, json['type']),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      format: $enumDecodeNullable(_$ProjectionFormatEnumMap, json['format']) ??
          ProjectionFormat.equirectangular,
      thumbnailPath: json['thumbnailPath'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastPlayed: json['lastPlayed'] == null
          ? null
          : DateTime.parse(json['lastPlayed'] as String),
      playCount: (json['playCount'] as num?)?.toInt() ?? 0,
      defaultVolume: (json['defaultVolume'] as num?)?.toDouble() ?? 1.0,
      defaultBrightness: (json['defaultBrightness'] as num?)?.toDouble() ?? 1.0,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ProjectionContentImplToJson(
        _$ProjectionContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'filePath': instance.filePath,
      'type': _$ContentTypeEnumMap[instance.type]!,
      'duration': instance.duration.inMicroseconds,
      'description': instance.description,
      'tags': instance.tags,
      'format': _$ProjectionFormatEnumMap[instance.format]!,
      'thumbnailPath': instance.thumbnailPath,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastPlayed': instance.lastPlayed?.toIso8601String(),
      'playCount': instance.playCount,
      'defaultVolume': instance.defaultVolume,
      'defaultBrightness': instance.defaultBrightness,
      'metadata': instance.metadata,
    };

const _$ContentTypeEnumMap = {
  ContentType.video: 'video',
  ContentType.image: 'image',
  ContentType.interactive: 'interactive',
  ContentType.realtime: 'realtime',
  ContentType.audio: 'audio',
  ContentType.procedural: 'procedural',
};

const _$ProjectionFormatEnumMap = {
  ProjectionFormat.equirectangular: 'equirectangular',
  ProjectionFormat.fisheye: 'fisheye',
  ProjectionFormat.cubemap: 'cubemap',
  ProjectionFormat.domemaster: 'domemaster',
  ProjectionFormat.fulldome: 'fulldome',
  ProjectionFormat.spherical: 'spherical',
  ProjectionFormat.cylindrical: 'cylindrical',
};

_$PlaybackStateImpl _$$PlaybackStateImplFromJson(Map<String, dynamic> json) =>
    _$PlaybackStateImpl(
      status: $enumDecodeNullable(_$PlaybackStatusEnumMap, json['status']) ??
          PlaybackStatus.stopped,
      currentContentId: json['currentContentId'] as String?,
      currentPlaylistId: json['currentPlaylistId'] as String?,
      position: json['position'] == null
          ? Duration.zero
          : Duration(microseconds: (json['position'] as num).toInt()),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      volume: (json['volume'] as num?)?.toDouble() ?? 0.5,
      speed: (json['speed'] as num?)?.toDouble() ?? 1.0,
      isLooping: json['isLooping'] as bool? ?? false,
      isMuted: json['isMuted'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$PlaybackStateImplToJson(_$PlaybackStateImpl instance) =>
    <String, dynamic>{
      'status': _$PlaybackStatusEnumMap[instance.status]!,
      'currentContentId': instance.currentContentId,
      'currentPlaylistId': instance.currentPlaylistId,
      'position': instance.position.inMicroseconds,
      'duration': instance.duration?.inMicroseconds,
      'volume': instance.volume,
      'speed': instance.speed,
      'isLooping': instance.isLooping,
      'isMuted': instance.isMuted,
      'error': instance.error,
    };

const _$PlaybackStatusEnumMap = {
  PlaybackStatus.stopped: 'stopped',
  PlaybackStatus.playing: 'playing',
  PlaybackStatus.paused: 'paused',
  PlaybackStatus.buffering: 'buffering',
  PlaybackStatus.error: 'error',
};

_$PlaylistImpl _$$PlaylistImplFromJson(Map<String, dynamic> json) =>
    _$PlaylistImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      contentIds: (json['contentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      currentIndex: (json['currentIndex'] as num?)?.toInt() ?? 0,
      mode: $enumDecodeNullable(_$PlaylistModeEnumMap, json['mode']) ??
          PlaylistMode.sequential,
      isLooping: json['isLooping'] as bool? ?? false,
      isShuffled: json['isShuffled'] as bool? ?? false,
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$PlaylistImplToJson(_$PlaylistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contentIds': instance.contentIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastModified': instance.lastModified?.toIso8601String(),
      'currentIndex': instance.currentIndex,
      'mode': _$PlaylistModeEnumMap[instance.mode]!,
      'isLooping': instance.isLooping,
      'isShuffled': instance.isShuffled,
      'description': instance.description,
      'tags': instance.tags,
    };

const _$PlaylistModeEnumMap = {
  PlaylistMode.sequential: 'sequential',
  PlaylistMode.shuffle: 'shuffle',
  PlaylistMode.random: 'random',
};

_$InteractiveContentImpl _$$InteractiveContentImplFromJson(
        Map<String, dynamic> json) =>
    _$InteractiveContentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      appName: json['appName'] as String,
      appData: json['appData'] as Map<String, dynamic>,
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$InteractiveContentImplToJson(
        _$InteractiveContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'appName': instance.appName,
      'appData': instance.appData,
      'description': instance.description,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$RealtimeContentImpl _$$RealtimeContentImplFromJson(
        Map<String, dynamic> json) =>
    _$RealtimeContentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      sourceType: json['sourceType'] as String,
      sourceConfig: json['sourceConfig'] as Map<String, dynamic>,
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$RealtimeContentImplToJson(
        _$RealtimeContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sourceType': instance.sourceType,
      'sourceConfig': instance.sourceConfig,
      'description': instance.description,
      'tags': instance.tags,
    };

_$ContentLibraryImpl _$$ContentLibraryImplFromJson(Map<String, dynamic> json) =>
    _$ContentLibraryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      contentIds: (json['contentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ContentLibraryImplToJson(
        _$ContentLibraryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contentIds': instance.contentIds,
      'description': instance.description,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
