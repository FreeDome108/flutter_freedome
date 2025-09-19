// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheEntryAdapter extends TypeAdapter<CacheEntry> {
  @override
  final int typeId = 0;

  @override
  CacheEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheEntry(
      key: fields[0] as String,
      data: fields[1] as String,
      expiry: fields[2] as DateTime?,
      tags: (fields[3] as List).cast<String>(),
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CacheEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.expiry)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OfflineOperationAdapter extends TypeAdapter<OfflineOperation> {
  @override
  final int typeId = 1;

  @override
  OfflineOperation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineOperation(
      operationId: fields[0] as String,
      type: fields[1] as String,
      endpoint: fields[2] as String,
      method: fields[3] as HttpMethod,
      data: (fields[4] as Map?)?.cast<String, dynamic>(),
      headers: (fields[5] as Map?)?.cast<String, String>(),
      priority: fields[6] as int,
      retryCount: fields[7] as int,
      maxRetries: fields[8] as int,
      createdAt: fields[9] as DateTime,
      scheduledAt: fields[10] as DateTime?,
      status: fields[11] as OfflineOperationStatus,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineOperation obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.operationId)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.endpoint)
      ..writeByte(3)
      ..write(obj.method)
      ..writeByte(4)
      ..write(obj.data)
      ..writeByte(5)
      ..write(obj.headers)
      ..writeByte(6)
      ..write(obj.priority)
      ..writeByte(7)
      ..write(obj.retryCount)
      ..writeByte(8)
      ..write(obj.maxRetries)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.scheduledAt)
      ..writeByte(11)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineOperationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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

Map<String, dynamic> _$CacheEntryToJson(CacheEntry instance) {
  final val = <String, dynamic>{
    'key': instance.key,
    'data': instance.data,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expiry', instance.expiry?.toIso8601String());
  val['tags'] = instance.tags;
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['updatedAt'] = instance.updatedAt.toIso8601String();
  return val;
}

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
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
      createdAt: DateTime.parse(json['createdAt'] as String),
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      status: $enumDecodeNullable(
              _$OfflineOperationStatusEnumMap, json['status']) ??
          OfflineOperationStatus.pending,
    );

Map<String, dynamic> _$OfflineOperationToJson(OfflineOperation instance) {
  final val = <String, dynamic>{
    'operationId': instance.operationId,
    'type': instance.type,
    'endpoint': instance.endpoint,
    'method': _$HttpMethodEnumMap[instance.method]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  writeNotNull('headers', instance.headers);
  val['priority'] = instance.priority;
  val['retryCount'] = instance.retryCount;
  val['maxRetries'] = instance.maxRetries;
  val['createdAt'] = instance.createdAt.toIso8601String();
  writeNotNull('scheduledAt', instance.scheduledAt?.toIso8601String());
  val['status'] = _$OfflineOperationStatusEnumMap[instance.status]!;
  return val;
}

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
          : Duration(microseconds: (json['autoSyncInterval'] as num).toInt()),
      forceOfflineMode: json['forceOfflineMode'] as bool? ?? false,
      maxCacheSize:
          (json['maxCacheSize'] as num?)?.toInt() ?? 100 * 1024 * 1024,
      defaultCacheTtl: json['defaultCacheTtl'] == null
          ? const Duration(hours: 24)
          : Duration(microseconds: (json['defaultCacheTtl'] as num).toInt()),
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
      retryDelay: json['retryDelay'] == null
          ? const Duration(seconds: 5)
          : Duration(microseconds: (json['retryDelay'] as num).toInt()),
      compressData: json['compressData'] as bool? ?? true,
      encryptSensitiveData: json['encryptSensitiveData'] as bool? ?? true,
    );

Map<String, dynamic> _$OfflineSettingsToJson(OfflineSettings instance) {
  final val = <String, dynamic>{
    'autoSyncEnabled': instance.autoSyncEnabled,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('autoSyncInterval', instance.autoSyncInterval?.inMicroseconds);
  val['forceOfflineMode'] = instance.forceOfflineMode;
  val['maxCacheSize'] = instance.maxCacheSize;
  val['defaultCacheTtl'] = instance.defaultCacheTtl.inMicroseconds;
  val['maxRetries'] = instance.maxRetries;
  val['retryDelay'] = instance.retryDelay.inMicroseconds;
  val['compressData'] = instance.compressData;
  val['encryptSensitiveData'] = instance.encryptSensitiveData;
  return val;
}
