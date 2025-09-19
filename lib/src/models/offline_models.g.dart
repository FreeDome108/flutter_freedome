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
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
      endpoint: json['endpoint'] as String,
      method: $enumDecode(_$HttpMethodEnumMap, json['method']),
      data: json['data'] as Map<String, dynamic>?,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      priority: json['priority'] as int? ?? 0,
      retryCount: json['retryCount'] as int? ?? 0,
      maxRetries: json['maxRetries'] as int? ?? 3,
      createdAt: DateTime.parse(json['createdAt'] as String),
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      status: $enumDecodeNullable(
              _$OfflineOperationStatusEnumMap, json['status']) ??
          OfflineOperationStatus.pending,
    );

Map<String, dynamic> _$OfflineOperationToJson(OfflineOperation instance) =>
    <String, dynamic>{
      'operationId': instance.operationId,
      'type': instance.type,
      'endpoint': instance.endpoint,
      'method': _$HttpMethodEnumMap[instance.method]!,
      'data': instance.data,
      'headers': instance.headers,
      'priority': instance.priority,
      'retryCount': instance.retryCount,
      'maxRetries': instance.maxRetries,
      'createdAt': instance.createdAt.toIso8601String(),
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'status': _$OfflineOperationStatusEnumMap[instance.status]!,
    };

const _$HttpMethodEnumMap = {
  HttpMethod.get: 'get',
  HttpMethod.post: 'post',
  HttpMethod.put: 'put',
  HttpMethod.patch: 'patch',
  HttpMethod.delete: 'delete',
};

const _$OfflineOperationStatusEnumMap = {
  OfflineOperationStatus.pending: 'pending',
  OfflineOperationStatus.processing: 'processing',
  OfflineOperationStatus.completed: 'completed',
  OfflineOperationStatus.failed: 'failed',
  OfflineOperationStatus.cancelled: 'cancelled',
};

OfflineSettings _$OfflineSettingsFromJson(Map<String, dynamic> json) =>
    OfflineSettings(
      autoSyncEnabled: json['autoSyncEnabled'] as bool? ?? true,
      autoSyncInterval: json['autoSyncInterval'] == null
          ? const Duration(minutes: 15)
          : Duration(microseconds: json['autoSyncInterval'] as int),
      forceOfflineMode: json['forceOfflineMode'] as bool? ?? false,
      maxCacheSize: json['maxCacheSize'] as int? ?? 104857600,
      defaultCacheTtl: json['defaultCacheTtl'] == null
          ? const Duration(hours: 24)
          : Duration(microseconds: json['defaultCacheTtl'] as int),
      maxRetries: json['maxRetries'] as int? ?? 3,
      retryDelay: json['retryDelay'] == null
          ? const Duration(seconds: 5)
          : Duration(microseconds: json['retryDelay'] as int),
      compressData: json['compressData'] as bool? ?? true,
      encryptSensitiveData: json['encryptSensitiveData'] as bool? ?? true,
    );

Map<String, dynamic> _$OfflineSettingsToJson(OfflineSettings instance) =>
    <String, dynamic>{
      'autoSyncEnabled': instance.autoSyncEnabled,
      'autoSyncInterval': instance.autoSyncInterval?.inMicroseconds,
      'forceOfflineMode': instance.forceOfflineMode,
      'maxCacheSize': instance.maxCacheSize,
      'defaultCacheTtl': instance.defaultCacheTtl.inMicroseconds,
      'maxRetries': instance.maxRetries,
      'retryDelay': instance.retryDelay.inMicroseconds,
      'compressData': instance.compressData,
      'encryptSensitiveData': instance.encryptSensitiveData,
    };
