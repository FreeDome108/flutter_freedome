import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/offline_models.dart';

/// Современный сервис локального хранилища (2025 best practices)
/// Использует Isar для NoSQL данных и SQLite для структурированных данных
class FreeDomeStorageService extends ChangeNotifier {
  static final FreeDomeStorageService _instance = FreeDomeStorageService._internal();
  factory FreeDomeStorageService() => _instance;
  FreeDomeStorageService._internal();

  /// Isar база данных для кэша и офлайн операций
  Isar? _isar;
  
  /// SQLite база данных для структурированных данных
  Database? _database;
  
  /// Настройки офлайн режима
  OfflineSettings _settings = const OfflineSettings();
  
  /// Контроллер событий
  final StreamController<OfflineEvent> _eventController =
      StreamController<OfflineEvent>.broadcast();

  /// Метрики производительности
  OfflineMetrics _metrics = const OfflineMetrics();

  /// Таймер для автоматической очистки
  Timer? _cleanupTimer;

  /// Геттеры
  Isar? get isar => _isar;
  Database? get database => _database;
  OfflineSettings get settings => _settings;
  OfflineMetrics get metrics => _metrics;
  Stream<OfflineEvent> get eventStream => _eventController.stream;
  bool get isInitialized => _isar != null && _database != null;

  /// Инициализация сервиса хранилища
  Future<void> initialize({OfflineSettings? customSettings}) async {
    if (isInitialized) return;

    try {
      _settings = customSettings ?? const OfflineSettings();
      
      // Инициализация Isar для NoSQL данных
      await _initializeIsar();
      
      // Инициализация SQLite для структурированных данных
      await _initializeSQLite();
      
      // Настройка автоматической очистки
      _setupCleanupTimer();
      
      // Обновление метрик
      await _updateMetrics();

      if (kDebugMode) {
        print('✅ FreeDomeStorageService инициализирован');
        print('📊 Isar коллекции: ${_isar?.schemas.length}');
        print('🗄️  SQLite версия: ${await _database?.getVersion()}');
      }

      _emitEvent(OfflineModeChangedEvent(true, 'Storage initialized'));
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации хранилища: $e');
      }
      rethrow;
    }
  }

  /// Инициализация Isar базы данных
  Future<void> _initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open([
      CacheEntrySchema,
      OfflineOperationSchema,
    ], 
    directory: dir.path,
    name: 'freedome_cache',
    );
  }

  /// Инициализация SQLite базы данных
  Future<void> _initializeSQLite() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'freedome_structured.db');

    _database = await openDatabase(
      path,
      version: 2,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    );
  }

  /// Создание таблиц SQLite
  Future<void> _createTables(Database db, int version) async {
    // Таблица для системных настроек
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        value TEXT NOT NULL,
        type TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Таблица для пользовательских сессий
    await db.execute('''
      CREATE TABLE user_sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id TEXT UNIQUE NOT NULL,
        user_id TEXT NOT NULL,
        dome_id TEXT,
        role TEXT NOT NULL,
        permissions TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        expires_at INTEGER,
        is_active INTEGER NOT NULL DEFAULT 1
      )
    ''');

    // Таблица для системных логов
    await db.execute('''
      CREATE TABLE system_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level TEXT NOT NULL,
        message TEXT NOT NULL,
        category TEXT NOT NULL,
        metadata TEXT,
        created_at INTEGER NOT NULL
      )
    ''');

    // Создание индексов для производительности
    await db.execute('CREATE INDEX idx_settings_key ON settings(key)');
    await db.execute('CREATE INDEX idx_sessions_user ON user_sessions(user_id)');
    await db.execute('CREATE INDEX idx_logs_level ON system_logs(level)');
    await db.execute('CREATE INDEX idx_logs_category ON system_logs(category)');
    await db.execute('CREATE INDEX idx_logs_created ON system_logs(created_at)');
  }

  /// Обновление схемы базы данных
  Future<void> _upgradeTables(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Добавляем новые поля в версии 2
      await db.execute('ALTER TABLE user_sessions ADD COLUMN last_activity INTEGER');
      await db.execute('ALTER TABLE system_logs ADD COLUMN source TEXT');
    }
  }

  /// Настройка таймера автоматической очистки
  void _setupCleanupTimer() {
    if (!_settings.autoCleanExpiredCache) return;

    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(_settings.cacheCleanupInterval, (_) {
      _performAutomaticCleanup();
    });
  }

  // === CACHE OPERATIONS ===

  /// Сохранение данных в кэш
  Future<void> cacheData({
    required String key,
    required dynamic data,
    Duration? ttl,
    List<String> tags = const [],
    int priority = 0,
  }) async {
    if (_isar == null) throw StateError('Storage not initialized');

    try {
      final jsonData = json.encode(data);
      final expiry = ttl != null ? DateTime.now().add(ttl) : null;
      
      final entry = CacheEntry.create(
        key: key,
        data: jsonData,
        expiry: expiry,
        tags: tags,
        priority: priority,
      );

      await _isar!.writeTxn(() async {
        await _isar!.cacheEntrys.put(entry);
      });

      _emitEvent(DataCachedEvent(key, jsonData.length, tags));
      await _updateMetrics();

      if (kDebugMode) {
        print('💾 Кэширован: $key (${jsonData.length} байт)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка кэширования $key: $e');
      }
      rethrow;
    }
  }

  /// Получение данных из кэша
  Future<T?> getCachedData<T>(String key) async {
    if (_isar == null) return null;

    try {
      final entry = await _isar!.cacheEntrys.filter().keyEqualTo(key).findFirst();
      
      if (entry == null) {
        _emitEvent(CacheMissEvent(key));
        return null;
      }

      if (entry.isExpired) {
        await _removeCacheEntry(key);
        _emitEvent(CacheMissEvent(key));
        return null;
      }

      // Обновляем статистику доступа
      entry.updateAccess();
      await _isar!.writeTxn(() async {
        await _isar!.cacheEntrys.put(entry);
      });

      final data = json.decode(entry.data);
      _emitEvent(CacheHitEvent(key, Duration.zero));
      
      return data as T?;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения из кэша $key: $e');
      }
      return null;
    }
  }

  /// Удаление записи из кэша
  Future<bool> removeCacheEntry(String key) async {
    return await _removeCacheEntry(key);
  }

  Future<bool> _removeCacheEntry(String key) async {
    if (_isar == null) return false;

    try {
      final deleted = await _isar!.writeTxn(() async {
        return await _isar!.cacheEntrys.filter().keyEqualTo(key).deleteFirst();
      });

      if (deleted) {
        _emitEvent(DataRemovedEvent(key, 'Manual removal'));
        await _updateMetrics();
      }

      return deleted;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка удаления из кэша $key: $e');
      }
      return false;
    }
  }

  /// Очистка кэша по тегам
  Future<int> clearCacheByTags(List<String> tags) async {
    if (_isar == null) return 0;

    try {
      int removedCount = 0;
      
      await _isar!.writeTxn(() async {
        for (final tag in tags) {
          final count = await _isar!.cacheEntrys
              .filter()
              .tagsElementContains(tag)
              .deleteAll();
          removedCount += count;
        }
      });

      _emitEvent(CacheClearedEvent(tags, removedCount));
      await _updateMetrics();
      
      return removedCount;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка очистки кэша по тегам: $e');
      }
      return 0;
    }
  }

  /// Полная очистка кэша
  Future<int> clearAllCache() async {
    if (_isar == null) return 0;

    try {
      final count = await _isar!.writeTxn(() async {
        return await _isar!.cacheEntrys.clear();
      });

      _emitEvent(CacheClearedEvent(null, count));
      await _updateMetrics();
      
      return count;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка полной очистки кэша: $e');
      }
      return 0;
    }
  }

  // === OFFLINE OPERATIONS ===

  /// Добавление операции в очередь
  Future<void> queueOperation(OfflineOperation operation) async {
    if (_isar == null) throw StateError('Storage not initialized');

    try {
      await _isar!.writeTxn(() async {
        await _isar!.offlineOperations.put(operation);
      });

      _emitEvent(OperationQueuedEvent(operation));
      await _updateMetrics();

      if (kDebugMode) {
        print('📤 Операция добавлена в очередь: ${operation.type}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка добавления операции в очередь: $e');
      }
      rethrow;
    }
  }

  /// Получение операций из очереди
  Future<List<OfflineOperation>> getPendingOperations({int? limit}) async {
    if (_isar == null) return [];

    try {
      var query = _isar!.offlineOperations
          .filter()
          .statusEqualTo(OfflineOperationStatus.pending)
          .or()
          .statusEqualTo(OfflineOperationStatus.retrying)
          .sortByPriorityDesc()
          .thenByCreatedAt();

      if (limit != null) {
        query = query.limit(limit);
      }

      return await query.findAll();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения операций из очереди: $e');
      }
      return [];
    }
  }

  /// Обновление статуса операции
  Future<void> updateOperationStatus(
    String operationId,
    OfflineOperationStatus status, {
    String? errorMessage,
  }) async {
    if (_isar == null) return;

    try {
      final operation = await _isar!.offlineOperations
          .filter()
          .operationIdEqualTo(operationId)
          .findFirst();

      if (operation != null) {
        final updatedOperation = operation.copyWith(
          status: status,
          errorMessage: errorMessage,
          lastAttemptAt: DateTime.now(),
          completedAt: status == OfflineOperationStatus.completed 
              ? DateTime.now() 
              : null,
        );

        await _isar!.writeTxn(() async {
          await _isar!.offlineOperations.put(updatedOperation);
        });

        // Эмитируем соответствующее событие
        switch (status) {
          case OfflineOperationStatus.completed:
            _emitEvent(OperationCompletedEvent(updatedOperation, Duration.zero));
            break;
          case OfflineOperationStatus.failed:
            _emitEvent(OperationFailedEvent(
              updatedOperation, 
              errorMessage ?? 'Unknown error',
              updatedOperation.canRetry,
            ));
            break;
          case OfflineOperationStatus.processing:
            _emitEvent(OperationStartedEvent(updatedOperation));
            break;
          default:
            break;
        }

        await _updateMetrics();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления статуса операции $operationId: $e');
      }
    }
  }

  // === STRUCTURED DATA OPERATIONS ===

  /// Сохранение настройки в SQLite
  Future<void> saveSetting(String key, dynamic value) async {
    if (_database == null) throw StateError('Database not initialized');

    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      
      await _database!.insert(
        'settings',
        {
          'key': key,
          'value': json.encode(value),
          'type': value.runtimeType.toString(),
          'created_at': now,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (kDebugMode) {
        print('⚙️ Настройка сохранена: $key');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сохранения настройки $key: $e');
      }
      rethrow;
    }
  }

  /// Получение настройки из SQLite
  Future<T?> getSetting<T>(String key) async {
    if (_database == null) return null;

    try {
      final result = await _database!.query(
        'settings',
        where: 'key = ?',
        whereArgs: [key],
        limit: 1,
      );

      if (result.isEmpty) return null;

      final value = json.decode(result.first['value'] as String);
      return value as T?;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения настройки $key: $e');
      }
      return null;
    }
  }

  /// Логирование в SQLite
  Future<void> logMessage({
    required String level,
    required String message,
    required String category,
    Map<String, dynamic>? metadata,
    String? source,
  }) async {
    if (_database == null) return;

    try {
      await _database!.insert('system_logs', {
        'level': level,
        'message': message,
        'category': category,
        'metadata': metadata != null ? json.encode(metadata) : null,
        'source': source,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка логирования: $e');
      }
    }
  }

  // === MAINTENANCE OPERATIONS ===

  /// Автоматическая очистка истекших данных
  Future<void> _performAutomaticCleanup() async {
    try {
      int removedCount = 0;

      // Очистка истекшего кэша
      if (_isar != null) {
        final now = DateTime.now();
        removedCount = await _isar!.writeTxn(() async {
          return await _isar!.cacheEntrys
              .filter()
              .expiryIsNotNull()
              .expiryLessThan(now)
              .deleteAll();
        });
      }

      // Очистка старых логов (старше 30 дней)
      if (_database != null) {
        final thirtyDaysAgo = DateTime.now()
            .subtract(const Duration(days: 30))
            .millisecondsSinceEpoch;
            
        await _database!.delete(
          'system_logs',
          where: 'created_at < ?',
          whereArgs: [thirtyDaysAgo],
        );
      }

      if (removedCount > 0) {
        _emitEvent(CacheClearedEvent(['expired'], removedCount));
        await _updateMetrics();
        
        if (kDebugMode) {
          print('🧹 Автоматическая очистка: удалено $removedCount записей');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка автоматической очистки: $e');
      }
    }
  }

  /// Обновление метрик производительности
  Future<void> _updateMetrics() async {
    try {
      int totalCacheEntries = 0;
      int cacheSize = 0;
      int queuedOperations = 0;
      int completedOperations = 0;
      int failedOperations = 0;

      if (_isar != null) {
        totalCacheEntries = await _isar!.cacheEntrys.count();
        
        final cacheEntries = await _isar!.cacheEntrys.findAll();
        cacheSize = cacheEntries.fold<int>(0, (sum, entry) => sum + entry.dataSize);

        queuedOperations = await _isar!.offlineOperations
            .filter()
            .statusEqualTo(OfflineOperationStatus.pending)
            .count();

        completedOperations = await _isar!.offlineOperations
            .filter()
            .statusEqualTo(OfflineOperationStatus.completed)
            .count();

        failedOperations = await _isar!.offlineOperations
            .filter()
            .statusEqualTo(OfflineOperationStatus.failed)
            .count();
      }

      _metrics = OfflineMetrics(
        totalCacheEntries: totalCacheEntries,
        cacheSize: cacheSize,
        queuedOperations: queuedOperations,
        completedOperations: completedOperations,
        failedOperations: failedOperations,
        cacheHitRate: _calculateCacheHitRate(),
        lastSyncTime: DateTime.now(),
        createdAt: DateTime.now(),
      );

      _emitEvent(MetricsUpdatedEvent(_metrics));
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления метрик: $e');
      }
    }
  }

  /// Расчет процента попаданий в кэш
  double _calculateCacheHitRate() {
    // Упрощенная реализация - в реальном проекте нужно отслеживать статистику
    return 85.0; // Заглушка
  }

  /// Эмитирование события
  void _emitEvent(OfflineEvent event) {
    _eventController.add(event);
    
    if (_settings.enableMetrics) {
      // Логируем важные события
      if (event is OperationFailedEvent || event is StorageQuotaExceededEvent) {
        logMessage(
          level: 'ERROR',
          message: 'Storage event: ${event.eventType}',
          category: 'storage',
          metadata: {'event': event.toString()},
        );
      }
    }
  }

  /// Получение статистики хранилища
  Map<String, dynamic> getStorageStats() {
    return {
      'isInitialized': isInitialized,
      'settings': _settings.toJson(),
      'metrics': _metrics.toJson(),
      'isar': {
        'isOpen': _isar?.isOpen ?? false,
        'schemas': _isar?.schemas.length ?? 0,
      },
      'sqlite': {
        'isOpen': _database?.isOpen ?? false,
        'path': _database?.path,
      },
    };
  }

  /// Закрытие соединений и очистка ресурсов
  @override
  void dispose() {
    _cleanupTimer?.cancel();
    _eventController.close();
    _isar?.close();
    _database?.close();
    super.dispose();
  }
}
