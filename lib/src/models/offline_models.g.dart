// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheEntry _$CacheEntryFromJson(Map<String, dynamic> json) => CacheEntry(
      key: json['key'] as String,
      data: json['data'] as String,
      expiry: json['expiry'] == null
          ? null
          : DateTime.parse(json['expiry'] as String),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CacheEntryToJson(CacheEntry instance) =>
    <String, dynamic>{
      'key': instance.key,
      'data': instance.data,
      'expiry': instance.expiry?.toIso8601String(),
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

OfflineOperation _$OfflineOperationFromJson(Map<String, dynamic> json) =>
    OfflineOperation(
      operationId: json['operationId'] as String,
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'pending',
    );

Map<String, dynamic> _$OfflineOperationToJson(OfflineOperation instance) =>
    <String, dynamic>{
      'operationId': instance.operationId,
      'type': instance.type,
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
    };
