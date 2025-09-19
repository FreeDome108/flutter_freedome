import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'offline_models.g.dart';

/// Запись кэша
@JsonSerializable()
@HiveType(typeId: 0)
class CacheEntry {
  @HiveField(0)
  final String key;

  @HiveField(1)
  final String data;

  @HiveField(2)
  final DateTime? expiry;

  @HiveField(3)
  final List<String> tags;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime updatedAt;

  const CacheEntry({
    required this.key,
    required this.data,
    this.expiry,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory CacheEntry.fromJson(Map<String, dynamic> json) =>
      _$CacheEntryFromJson(json);

  Map<String, dynamic> toJson() => _$CacheEntryToJson(this);

  /// Создание из строки базы данных
  factory CacheEntry.fromDatabaseRow(Map<String, dynamic> row) {
    return CacheEntry(
      key: row['key'] as String,
      data: row['data'] as String,
      expiry: row['expiry'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['expiry'] as int)
          : null,
      tags: (row['tags'] as String?)?.split(',') ?? [],
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row['updated_at'] as int),
    );
  }

  /// Преобразование в строку для базы данных
  Map<String, dynamic> toDatabaseRow() {
    return {
      'key': key,
      'data': data,
      'expiry': expiry?.millisecondsSinceEpoch,
      'tags': tags.join(','),
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  bool get isExpired => expiry != null && DateTime.now().isAfter(expiry!);
}

/// Адаптер для Hive
class CacheEntryAdapter extends TypeAdapter<CacheEntry> {
  @override
  final int typeId = 0;

  @override
  CacheEntry read(BinaryReader reader) {
    return CacheEntry(
      key: reader.readString(),
      data: reader.readString(),
      expiry: reader.readBool()
          ? DateTime.fromMillisecondsSinceEpoch(reader.readInt())
          : null,
      tags: reader.readStringList(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, CacheEntry obj) {
    writer.writeString(obj.key);
    writer.writeString(obj.data);
    writer.writeBool(obj.expiry != null);
    if (obj.expiry != null) {
      writer.writeInt(obj.expiry!.millisecondsSinceEpoch);
    }
    writer.writeStringList(obj.tags);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeInt(obj.updatedAt.millisecondsSinceEpoch);
  }
}

/// Статус офлайн операции
enum OfflineOperationStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled
}

/// HTTP методы
enum HttpMethod { get, post, put, patch, delete }

/// Офлайн операция
@JsonSerializable()
@HiveType(typeId: 1)
class OfflineOperation {
  @HiveField(0)
  final String operationId;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String endpoint;

  @HiveField(3)
  final HttpMethod method;

  @HiveField(4)
  final Map<String, dynamic>? data;

  @HiveField(5)
  final Map<String, String>? headers;

  @HiveField(6)
  final int priority;

  @HiveField(7)
  final int retryCount;

  @HiveField(8)
  final int maxRetries;

  @HiveField(9)
  final DateTime createdAt;

  @HiveField(10)
  final DateTime? scheduledAt;

  @HiveField(11)
  final OfflineOperationStatus status;

  const OfflineOperation({
    required this.operationId,
    required this.type,
    required this.endpoint,
    required this.method,
    this.data,
    this.headers,
    this.priority = 0,
    this.retryCount = 0,
    this.maxRetries = 3,
    required this.createdAt,
    this.scheduledAt,
    this.status = OfflineOperationStatus.pending,
  });

  factory OfflineOperation.fromJson(Map<String, dynamic> json) =>
      _$OfflineOperationFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineOperationToJson(this);

  /// Создание из строки базы данных
  factory OfflineOperation.fromDatabaseRow(Map<String, dynamic> row) {
    return OfflineOperation(
      operationId: row['operation_id'] as String,
      type: row['type'] as String,
      endpoint: row['endpoint'] as String,
      method: HttpMethod.values.firstWhere(
        (m) => m.name == row['method'],
        orElse: () => HttpMethod.get,
      ),
      data: row['data'] != null
          ? Map<String, dynamic>.from(
              Map.from(Uri.splitQueryString(row['data'] as String)))
          : null,
      headers: row['headers'] != null
          ? Map<String, String>.from(
              Map.from(Uri.splitQueryString(row['headers'] as String)))
          : null,
      priority: row['priority'] as int? ?? 0,
      retryCount: row['retry_count'] as int? ?? 0,
      maxRetries: row['max_retries'] as int? ?? 3,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
      scheduledAt: row['scheduled_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['scheduled_at'] as int)
          : null,
      status: OfflineOperationStatus.values.firstWhere(
        (s) => s.name == row['status'],
        orElse: () => OfflineOperationStatus.pending,
      ),
    );
  }

  /// Преобразование в строку для базы данных
  Map<String, dynamic> toDatabaseRow() {
    return {
      'operation_id': operationId,
      'type': type,
      'endpoint': endpoint,
      'method': method.name,
      'data': data?.toString(),
      'headers': headers?.toString(),
      'priority': priority,
      'retry_count': retryCount,
      'max_retries': maxRetries,
      'created_at': createdAt.millisecondsSinceEpoch,
      'scheduled_at': scheduledAt?.millisecondsSinceEpoch,
      'status': status.name,
    };
  }

  OfflineOperation copyWith({
    String? operationId,
    String? type,
    String? endpoint,
    HttpMethod? method,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    int? priority,
    int? retryCount,
    int? maxRetries,
    DateTime? createdAt,
    DateTime? scheduledAt,
    OfflineOperationStatus? status,
  }) {
    return OfflineOperation(
      operationId: operationId ?? this.operationId,
      type: type ?? this.type,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      data: data ?? this.data,
      headers: headers ?? this.headers,
      priority: priority ?? this.priority,
      retryCount: retryCount ?? this.retryCount,
      maxRetries: maxRetries ?? this.maxRetries,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
    );
  }
}

/// Адаптер для Hive
class OfflineOperationAdapter extends TypeAdapter<OfflineOperation> {
  @override
  final int typeId = 1;

  @override
  OfflineOperation read(BinaryReader reader) {
    return OfflineOperation(
      operationId: reader.readString(),
      type: reader.readString(),
      endpoint: reader.readString(),
      method: HttpMethod.values[reader.readInt()],
      data: reader.readBool() ? reader.readMap().cast<String, dynamic>() : null,
      headers:
          reader.readBool() ? reader.readMap().cast<String, String>() : null,
      priority: reader.readInt(),
      retryCount: reader.readInt(),
      maxRetries: reader.readInt(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      scheduledAt: reader.readBool()
          ? DateTime.fromMillisecondsSinceEpoch(reader.readInt())
          : null,
      status: OfflineOperationStatus.values[reader.readInt()],
    );
  }

  @override
  void write(BinaryWriter writer, OfflineOperation obj) {
    writer.writeString(obj.operationId);
    writer.writeString(obj.type);
    writer.writeString(obj.endpoint);
    writer.writeInt(obj.method.index);
    writer.writeBool(obj.data != null);
    if (obj.data != null) {
      writer.writeMap(obj.data!);
    }
    writer.writeBool(obj.headers != null);
    if (obj.headers != null) {
      writer.writeMap(obj.headers!);
    }
    writer.writeInt(obj.priority);
    writer.writeInt(obj.retryCount);
    writer.writeInt(obj.maxRetries);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeBool(obj.scheduledAt != null);
    if (obj.scheduledAt != null) {
      writer.writeInt(obj.scheduledAt!.millisecondsSinceEpoch);
    }
    writer.writeInt(obj.status.index);
  }
}

/// Настройки офлайн режима
@JsonSerializable()
class OfflineSettings {
  final bool autoSyncEnabled;
  final Duration? autoSyncInterval;
  final bool forceOfflineMode;
  final int maxCacheSize;
  final Duration defaultCacheTtl;
  final int maxRetries;
  final Duration retryDelay;
  final bool compressData;
  final bool encryptSensitiveData;

  const OfflineSettings({
    this.autoSyncEnabled = true,
    this.autoSyncInterval = const Duration(minutes: 15),
    this.forceOfflineMode = false,
    this.maxCacheSize = 100 * 1024 * 1024, // 100MB
    this.defaultCacheTtl = const Duration(hours: 24),
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 5),
    this.compressData = true,
    this.encryptSensitiveData = true,
  });

  factory OfflineSettings.fromJson(Map<String, dynamic> json) =>
      _$OfflineSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineSettingsToJson(this);

  OfflineSettings copyWith({
    bool? autoSyncEnabled,
    Duration? autoSyncInterval,
    bool? forceOfflineMode,
    int? maxCacheSize,
    Duration? defaultCacheTtl,
    int? maxRetries,
    Duration? retryDelay,
    bool? compressData,
    bool? encryptSensitiveData,
  }) {
    return OfflineSettings(
      autoSyncEnabled: autoSyncEnabled ?? this.autoSyncEnabled,
      autoSyncInterval: autoSyncInterval ?? this.autoSyncInterval,
      forceOfflineMode: forceOfflineMode ?? this.forceOfflineMode,
      maxCacheSize: maxCacheSize ?? this.maxCacheSize,
      defaultCacheTtl: defaultCacheTtl ?? this.defaultCacheTtl,
      maxRetries: maxRetries ?? this.maxRetries,
      retryDelay: retryDelay ?? this.retryDelay,
      compressData: compressData ?? this.compressData,
      encryptSensitiveData: encryptSensitiveData ?? this.encryptSensitiveData,
    );
  }
}

/// События офлайн сервиса
abstract class OfflineEvent {
  const OfflineEvent();

  factory OfflineEvent.dataCached(String key, dynamic data) = DataCachedEvent;
  factory OfflineEvent.dataRemoved(String key) = DataRemovedEvent;
  factory OfflineEvent.cacheCleared(List<String>? tags) = CacheClearedEvent;
  factory OfflineEvent.operationQueued(OfflineOperation operation) =
      OperationQueuedEvent;
  factory OfflineEvent.operationCompleted(OfflineOperation operation) =
      OperationCompletedEvent;
  factory OfflineEvent.operationFailed(
      OfflineOperation operation, String error) = OperationFailedEvent;
  factory OfflineEvent.offlineModeChanged(bool enabled) =
      OfflineModeChangedEvent;
  factory OfflineEvent.syncStarted() = SyncStartedEvent;
  factory OfflineEvent.syncCompleted(int processedCount) = SyncCompletedEvent;
}

class DataCachedEvent extends OfflineEvent {
  final String key;
  final dynamic data;

  const DataCachedEvent(this.key, this.data);
}

class DataRemovedEvent extends OfflineEvent {
  final String key;

  const DataRemovedEvent(this.key);
}

class CacheClearedEvent extends OfflineEvent {
  final List<String>? tags;

  const CacheClearedEvent(this.tags);
}

class OperationQueuedEvent extends OfflineEvent {
  final OfflineOperation operation;

  const OperationQueuedEvent(this.operation);
}

class OperationCompletedEvent extends OfflineEvent {
  final OfflineOperation operation;

  const OperationCompletedEvent(this.operation);
}

class OperationFailedEvent extends OfflineEvent {
  final OfflineOperation operation;
  final String error;

  const OperationFailedEvent(this.operation, this.error);
}

class OfflineModeChangedEvent extends OfflineEvent {
  final bool enabled;

  const OfflineModeChangedEvent(this.enabled);
}

class SyncStartedEvent extends OfflineEvent {
  const SyncStartedEvent();
}

class SyncCompletedEvent extends OfflineEvent {
  final int processedCount;

  const SyncCompletedEvent(this.processedCount);
}
