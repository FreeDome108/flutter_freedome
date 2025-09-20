import 'package:json_annotation/json_annotation.dart';
import 'package:isar/isar.dart';

part 'offline_models.g.dart';

/// Современная запись кэша с использованием Isar (2025 best practice)
@collection
@JsonSerializable()
class CacheEntry {
  /// Уникальный идентификатор для Isar
  Id id = Isar.autoIncrement;

  /// Ключ кэша
  @Index(unique: true)
  late String key;

  /// Данные в JSON формате
  late String data;

  /// Время истечения кэша (nullable)
  DateTime? expiry;

  /// Теги для группировки и быстрого поиска
  @Index()
  List<String> tags = [];

  /// Время создания записи
  @Index()
  late DateTime createdAt;

  /// Время последнего обновления
  late DateTime updatedAt;

  /// Размер данных в байтах (для управления размером кэша)
  @Index()
  int dataSize = 0;

  /// Приоритет записи (для LRU алгоритма)
  @Index()
  int priority = 0;

  /// Количество обращений к записи
  int accessCount = 0;

  /// Время последнего доступа
  DateTime? lastAccessedAt;

  /// Конструктор по умолчанию для Isar
  CacheEntry();

  /// Именованный конструктор
  CacheEntry.create({
    required this.key,
    required this.data,
    this.expiry,
    this.tags = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
    this.priority = 0,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
    this.dataSize = data.length;
    this.lastAccessedAt = DateTime.now();
  }

  /// JSON сериализация
  factory CacheEntry.fromJson(Map<String, dynamic> json) =>
      _$CacheEntryFromJson(json);

  Map<String, dynamic> toJson() => _$CacheEntryToJson(this);

  /// Проверка истечения срока действия
  bool get isExpired => expiry != null && DateTime.now().isAfter(expiry!);

  /// Обновление времени последнего доступа
  void updateAccess() {
    lastAccessedAt = DateTime.now();
    accessCount++;
  }

  /// Создание копии с обновленными данными
  CacheEntry copyWith({
    String? key,
    String? data,
    DateTime? expiry,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? priority,
  }) {
    return CacheEntry.create(
      key: key ?? this.key,
      data: data ?? this.data,
      expiry: expiry ?? this.expiry,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      priority: priority ?? this.priority,
    );
  }
}

/// Статус офлайн операции
@JsonEnum()
enum OfflineOperationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('retrying')
  retrying,
}

/// HTTP методы
@JsonEnum()
enum HttpMethod {
  @JsonValue('GET')
  get,
  @JsonValue('POST')
  post,
  @JsonValue('PUT')
  put,
  @JsonValue('PATCH')
  patch,
  @JsonValue('DELETE')
  delete,
  @JsonValue('HEAD')
  head,
  @JsonValue('OPTIONS')
  options,
}

/// Современная офлайн операция с использованием Isar
@collection
@JsonSerializable()
class OfflineOperation {
  /// Уникальный идентификатор для Isar
  Id id = Isar.autoIncrement;

  /// Уникальный идентификатор операции
  @Index(unique: true)
  late String operationId;

  /// Тип операции для группировки
  @Index()
  late String type;

  /// Эндпоинт API
  late String endpoint;

  /// HTTP метод
  @Enumerated(EnumType.name)
  late HttpMethod method;

  /// Данные запроса в JSON формате
  String? data;

  /// Заголовки запроса в JSON формате
  String? headers;

  /// Приоритет операции (чем выше, тем важнее)
  @Index()
  int priority = 0;

  /// Количество попыток выполнения
  int retryCount = 0;

  /// Максимальное количество попыток
  int maxRetries = 3;

  /// Время создания операции
  @Index()
  late DateTime createdAt;

  /// Запланированное время выполнения
  DateTime? scheduledAt;

  /// Последняя попытка выполнения
  DateTime? lastAttemptAt;

  /// Время завершения операции
  DateTime? completedAt;

  /// Статус операции
  @Enumerated(EnumType.name)
  @Index()
  OfflineOperationStatus status = OfflineOperationStatus.pending;

  /// Сообщение об ошибке
  String? errorMessage;

  /// Дополнительные метаданные
  String? metadata;

  /// Зависимости от других операций
  List<String> dependencies = [];

  /// Конструктор по умолчанию для Isar
  OfflineOperation();

  /// Именованный конструктор
  OfflineOperation.create({
    required this.operationId,
    required this.type,
    required this.endpoint,
    required this.method,
    Map<String, dynamic>? requestData,
    Map<String, String>? requestHeaders,
    this.priority = 0,
    this.retryCount = 0,
    this.maxRetries = 3,
    DateTime? createdAt,
    this.scheduledAt,
    this.status = OfflineOperationStatus.pending,
    this.dependencies = const [],
    Map<String, dynamic>? requestMetadata,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.data = requestData != null ? _encodeJson(requestData) : null;
    this.headers = requestHeaders != null ? _encodeJson(requestHeaders) : null;
    this.metadata = requestMetadata != null ? _encodeJson(requestMetadata) : null;
  }

  /// JSON сериализация
  factory OfflineOperation.fromJson(Map<String, dynamic> json) =>
      _$OfflineOperationFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineOperationToJson(this);

  /// Получение данных запроса
  Map<String, dynamic>? get requestData {
    return data != null ? _decodeJson(data!) : null;
  }

  /// Получение заголовков запроса
  Map<String, String>? get requestHeaders {
    if (headers == null) return null;
    final decoded = _decodeJson(headers!);
    return decoded?.cast<String, String>();
  }

  /// Получение метаданных
  Map<String, dynamic>? get requestMetadata {
    return metadata != null ? _decodeJson(metadata!) : null;
  }

  /// Проверка готовности к выполнению
  bool get isReadyToExecute {
    if (status != OfflineOperationStatus.pending && 
        status != OfflineOperationStatus.retrying) {
      return false;
    }
    
    final now = DateTime.now();
    if (scheduledAt != null && now.isBefore(scheduledAt!)) {
      return false;
    }

    return retryCount < maxRetries;
  }

  /// Проверка возможности повтора
  bool get canRetry {
    return retryCount < maxRetries && 
           status == OfflineOperationStatus.failed;
  }

  /// Создание копии с обновленным статусом
  OfflineOperation copyWith({
    String? operationId,
    String? type,
    String? endpoint,
    HttpMethod? method,
    Map<String, dynamic>? requestData,
    Map<String, String>? requestHeaders,
    int? priority,
    int? retryCount,
    int? maxRetries,
    DateTime? createdAt,
    DateTime? scheduledAt,
    DateTime? lastAttemptAt,
    DateTime? completedAt,
    OfflineOperationStatus? status,
    String? errorMessage,
    Map<String, dynamic>? requestMetadata,
    List<String>? dependencies,
  }) {
    final operation = OfflineOperation.create(
      operationId: operationId ?? this.operationId,
      type: type ?? this.type,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      requestData: requestData ?? this.requestData,
      requestHeaders: requestHeaders ?? this.requestHeaders,
      priority: priority ?? this.priority,
      retryCount: retryCount ?? this.retryCount,
      maxRetries: maxRetries ?? this.maxRetries,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      dependencies: dependencies ?? this.dependencies,
      requestMetadata: requestMetadata ?? this.requestMetadata,
    );
    
    operation.id = id;
    operation.lastAttemptAt = lastAttemptAt ?? this.lastAttemptAt;
    operation.completedAt = completedAt ?? this.completedAt;
    operation.errorMessage = errorMessage ?? this.errorMessage;
    
    return operation;
  }

  /// Вспомогательные методы для JSON кодирования
  static String _encodeJson(Map<String, dynamic> data) {
    try {
      return Uri.encodeComponent(data.toString());
    } catch (e) {
      return '';
    }
  }

  static Map<String, dynamic>? _decodeJson(String encoded) {
    try {
      final decoded = Uri.decodeComponent(encoded);
      // Простая реализация для демонстрации
      // В реальном проекте используйте json.decode
      return <String, dynamic>{};
    } catch (e) {
      return null;
    }
  }
}

/// Современные настройки офлайн режима
@JsonSerializable()
class OfflineSettings {
  /// Автоматическая синхронизация включена
  final bool autoSyncEnabled;

  /// Интервал автоматической синхронизации
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration? autoSyncInterval;

  /// Принудительный офлайн режим
  final bool forceOfflineMode;

  /// Максимальный размер кэша в байтах
  final int maxCacheSize;

  /// TTL кэша по умолчанию
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration defaultCacheTtl;

  /// Максимальное количество попыток
  final int maxRetries;

  /// Задержка между попытками
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration retryDelay;

  /// Сжатие данных
  final bool compressData;

  /// Шифрование чувствительных данных
  final bool encryptSensitiveData;

  /// Использование LRU алгоритма для кэша
  final bool useLruCache;

  /// Максимальное количество операций в очереди
  final int maxQueueSize;

  /// Включение метрик производительности
  final bool enableMetrics;

  /// Автоматическая очистка истекшего кэша
  final bool autoCleanExpiredCache;

  /// Интервал очистки кэша
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration cacheCleanupInterval;

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
    this.useLruCache = true,
    this.maxQueueSize = 1000,
    this.enableMetrics = false,
    this.autoCleanExpiredCache = true,
    this.cacheCleanupInterval = const Duration(hours: 6),
  });

  factory OfflineSettings.fromJson(Map<String, dynamic> json) =>
      _$OfflineSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineSettingsToJson(this);

  /// Настройки для разработки
  factory OfflineSettings.development() {
    return const OfflineSettings(
      autoSyncEnabled = true,
      autoSyncInterval = Duration(minutes: 5),
      forceOfflineMode = false,
      maxCacheSize = 50 * 1024 * 1024, // 50MB
      defaultCacheTtl = Duration(hours: 1),
      maxRetries = 5,
      retryDelay = Duration(seconds: 2),
      enableMetrics = true,
      cacheCleanupInterval = Duration(minutes: 30),
    );
  }

  /// Настройки для продакшена
  factory OfflineSettings.production() {
    return const OfflineSettings(
      autoSyncEnabled = true,
      autoSyncInterval = Duration(minutes: 30),
      forceOfflineMode = false,
      maxCacheSize = 200 * 1024 * 1024, // 200MB
      defaultCacheTtl = Duration(hours: 48),
      maxRetries = 3,
      retryDelay = Duration(seconds: 10),
      enableMetrics = false,
      cacheCleanupInterval = Duration(hours: 12),
    );
  }

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
    bool? useLruCache,
    int? maxQueueSize,
    bool? enableMetrics,
    bool? autoCleanExpiredCache,
    Duration? cacheCleanupInterval,
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
      useLruCache: useLruCache ?? this.useLruCache,
      maxQueueSize: maxQueueSize ?? this.maxQueueSize,
      enableMetrics: enableMetrics ?? this.enableMetrics,
      autoCleanExpiredCache: autoCleanExpiredCache ?? this.autoCleanExpiredCache,
      cacheCleanupInterval: cacheCleanupInterval ?? this.cacheCleanupInterval,
    );
  }

  /// Вспомогательные методы для сериализации Duration
  static Duration? _durationFromJson(int? milliseconds) {
    return milliseconds != null ? Duration(milliseconds: milliseconds) : null;
  }

  static int? _durationToJson(Duration? duration) {
    return duration?.inMilliseconds;
  }
}

/// Метрики производительности офлайн сервиса
@JsonSerializable()
class OfflineMetrics {
  /// Общее количество операций в кэше
  final int totalCacheEntries;

  /// Размер кэша в байтах
  final int cacheSize;

  /// Количество операций в очереди
  final int queuedOperations;

  /// Количество выполненных операций
  final int completedOperations;

  /// Количество неудачных операций
  final int failedOperations;

  /// Процент попаданий в кэш
  final double cacheHitRate;

  /// Среднее время выполнения операции
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration averageOperationTime;

  /// Время последней синхронизации
  final DateTime? lastSyncTime;

  /// Количество автоматических очисток кэша
  final int cacheCleanupCount;

  /// Время создания метрик
  final DateTime createdAt;

  const OfflineMetrics({
    this.totalCacheEntries = 0,
    this.cacheSize = 0,
    this.queuedOperations = 0,
    this.completedOperations = 0,
    this.failedOperations = 0,
    this.cacheHitRate = 0.0,
    this.averageOperationTime = Duration.zero,
    this.lastSyncTime,
    this.cacheCleanupCount = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? const Duration(milliseconds: 0) as DateTime;

  factory OfflineMetrics.fromJson(Map<String, dynamic> json) =>
      _$OfflineMetricsFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineMetricsToJson(this);

  /// Общее количество операций
  int get totalOperations => completedOperations + failedOperations;

  /// Процент успешных операций
  double get successRate {
    if (totalOperations == 0) return 0.0;
    return completedOperations / totalOperations * 100;
  }

  /// Процент неудачных операций
  double get failureRate {
    if (totalOperations == 0) return 0.0;
    return failedOperations / totalOperations * 100;
  }

  static Duration? _durationFromJson(int? milliseconds) {
    return milliseconds != null ? Duration(milliseconds: milliseconds) : null;
  }

  static int? _durationToJson(Duration? duration) {
    return duration?.inMilliseconds;
  }
}

/// Современные события офлайн сервиса с типизацией
abstract class OfflineEvent {
  const OfflineEvent();

  /// Время события
  DateTime get timestamp => DateTime.now();

  /// Тип события для логирования
  String get eventType => runtimeType.toString();
}

/// События кэша
class DataCachedEvent extends OfflineEvent {
  final String key;
  final int dataSize;
  final List<String> tags;

  const DataCachedEvent(this.key, this.dataSize, this.tags);
}

class DataRemovedEvent extends OfflineEvent {
  final String key;
  final String reason;

  const DataRemovedEvent(this.key, this.reason);
}

class CacheClearedEvent extends OfflineEvent {
  final List<String>? tags;
  final int removedCount;

  const CacheClearedEvent(this.tags, this.removedCount);
}

class CacheHitEvent extends OfflineEvent {
  final String key;
  final Duration accessTime;

  const CacheHitEvent(this.key, this.accessTime);
}

class CacheMissEvent extends OfflineEvent {
  final String key;

  const CacheMissEvent(this.key);
}

/// События операций
class OperationQueuedEvent extends OfflineEvent {
  final OfflineOperation operation;

  const OperationQueuedEvent(this.operation);
}

class OperationStartedEvent extends OfflineEvent {
  final OfflineOperation operation;

  const OperationStartedEvent(this.operation);
}

class OperationCompletedEvent extends OfflineEvent {
  final OfflineOperation operation;
  final Duration executionTime;

  const OperationCompletedEvent(this.operation, this.executionTime);
}

class OperationFailedEvent extends OfflineEvent {
  final OfflineOperation operation;
  final String error;
  final bool willRetry;

  const OperationFailedEvent(this.operation, this.error, this.willRetry);
}

class OperationRetryEvent extends OfflineEvent {
  final OfflineOperation operation;
  final int attemptNumber;

  const OperationRetryEvent(this.operation, this.attemptNumber);
}

/// События синхронизации
class SyncStartedEvent extends OfflineEvent {
  final int operationsCount;

  const SyncStartedEvent(this.operationsCount);
}

class SyncProgressEvent extends OfflineEvent {
  final int processed;
  final int total;

  const SyncProgressEvent(this.processed, this.total);

  double get progress => total > 0 ? processed / total : 0.0;
}

class SyncCompletedEvent extends OfflineEvent {
  final int processedCount;
  final int successCount;
  final int failedCount;
  final Duration totalTime;

  const SyncCompletedEvent(
    this.processedCount,
    this.successCount,
    this.failedCount,
    this.totalTime,
  );
}

/// Системные события
class OfflineModeChangedEvent extends OfflineEvent {
  final bool enabled;
  final String reason;

  const OfflineModeChangedEvent(this.enabled, this.reason);
}

class NetworkStatusChangedEvent extends OfflineEvent {
  final bool isOnline;

  const NetworkStatusChangedEvent(this.isOnline);
}

class StorageQuotaExceededEvent extends OfflineEvent {
  final int currentSize;
  final int maxSize;

  const StorageQuotaExceededEvent(this.currentSize, this.maxSize);
}

class MetricsUpdatedEvent extends OfflineEvent {
  final OfflineMetrics metrics;

  const MetricsUpdatedEvent(this.metrics);
}