import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/offline_models.dart';
import '../exceptions/magento_exception.dart';

/// Сервис для работы в офлайн режиме
class OfflineService extends ChangeNotifier {
  static const String _cacheBoxName = 'magento_cache';
  static const String _queueBoxName = 'magento_queue';
  static const String _settingsKey = 'offline_settings';

  Database? _database;
  Box<dynamic>? _cacheBox;
  Box<dynamic>? _queueBox;

  bool _isInitialized = false;
  bool _isOfflineMode = false;
  OfflineSettings _settings = const OfflineSettings();
  final List<OfflineOperation> _pendingOperations = [];

  Timer? _syncTimer;
  StreamController<OfflineEvent>? _eventController;

  // Геттеры
  bool get isInitialized => _isInitialized;
  bool get isOfflineMode => _isOfflineMode;
  OfflineSettings get settings => _settings;
  List<OfflineOperation> get pendingOperations => List.from(_pendingOperations);
  int get pendingOperationsCount => _pendingOperations.length;
  Stream<OfflineEvent>? get eventStream => _eventController?.stream;

  /// Инициализация офлайн сервиса
  Future<bool> initialize() async {
    try {
      // Инициализация Hive для кэширования
      await _initializeHive();

      // Инициализация SQLite для сложных данных
      await _initializeDatabase();

      // Загрузка настроек
      await _loadSettings();

      // Загрузка отложенных операций
      await _loadPendingOperations();

      // Настройка контроллера событий
      _eventController = StreamController<OfflineEvent>.broadcast();

      // Настройка автоматической синхронизации
      _setupAutoSync();

      _isInitialized = true;

      if (kDebugMode) {
        print('✅ OfflineService инициализирован');
      }

      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации OfflineService: $e');
      }
      return false;
    }
  }

  /// Инициализация Hive
  Future<void> _initializeHive() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CacheEntryAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(OfflineOperationAdapter());
    }

    _cacheBox = await Hive.openBox(_cacheBoxName);
    _queueBox = await Hive.openBox(_queueBoxName);
  }

  /// Инициализация SQLite базы данных
  Future<void> _initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = '${documentsDirectory.path}/magento_offline.db';

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createTables,
      onUpgrade: _upgradeDatabase,
    );
  }

  /// Создание таблиц в базе данных
  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cache_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        data TEXT NOT NULL,
        expiry INTEGER,
        tags TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE offline_operations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        operation_id TEXT UNIQUE NOT NULL,
        type TEXT NOT NULL,
        endpoint TEXT NOT NULL,
        method TEXT NOT NULL,
        data TEXT,
        headers TEXT,
        priority INTEGER DEFAULT 0,
        retry_count INTEGER DEFAULT 0,
        max_retries INTEGER DEFAULT 3,
        created_at INTEGER NOT NULL,
        scheduled_at INTEGER,
        status TEXT DEFAULT 'pending'
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_cache_key ON cache_entries(key);
    ''');

    await db.execute('''
      CREATE INDEX idx_cache_expiry ON cache_entries(expiry);
    ''');

    await db.execute('''
      CREATE INDEX idx_operations_status ON offline_operations(status);
    ''');
  }

  /// Обновление схемы базы данных
  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    // Здесь будут миграции для будущих версий
  }

  /// Загрузка настроек
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_settingsKey);

      if (settingsJson != null) {
        final settingsMap = jsonDecode(settingsJson) as Map<String, dynamic>;
        _settings = OfflineSettings.fromJson(settingsMap);
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки настроек офлайн режима: $e');
      }
    }
  }

  /// Сохранение настроек
  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_settingsKey, jsonEncode(_settings.toJson()));
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сохранения настроек офлайн режима: $e');
      }
    }
  }

  /// Загрузка отложенных операций
  Future<void> _loadPendingOperations() async {
    try {
      if (_database != null) {
        final results = await _database!.query(
          'offline_operations',
          where: 'status = ?',
          whereArgs: ['pending'],
          orderBy: 'priority DESC, created_at ASC',
        );

        _pendingOperations.clear();
        for (final row in results) {
          _pendingOperations.add(OfflineOperation.fromDatabaseRow(row));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки отложенных операций: $e');
      }
    }
  }

  /// Кэширование данных
  Future<void> cacheData<T>({
    required String key,
    required T data,
    Duration? ttl,
    List<String>? tags,
  }) async {
    if (!_isInitialized) return;

    try {
      final entry = CacheEntry(
        key: key,
        data: jsonEncode(data),
        expiry: ttl != null ? DateTime.now().add(ttl) : null,
        tags: tags ?? [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Сохраняем в Hive для быстрого доступа
      await _cacheBox?.put(key, entry);

      // Сохраняем в SQLite для постоянного хранения
      if (_database != null) {
        await _database!.insert(
          'cache_entries',
          entry.toDatabaseRow(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      _emitEvent(OfflineEvent.dataCached(key, data));

      if (kDebugMode) {
        print('📦 Данные кэширован: $key');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка кэширования данных: $e');
      }
    }
  }

  /// Получение данных из кэша
  Future<T?> getCachedData<T>(String key,
      {T Function(Map<String, dynamic>)? fromJson}) async {
    if (!_isInitialized) return null;

    try {
      CacheEntry? entry;

      // Сначала проверяем Hive
      entry = _cacheBox?.get(key);

      // Если не найдено, проверяем SQLite
      if (entry == null && _database != null) {
        final results = await _database!.query(
          'cache_entries',
          where: 'key = ?',
          whereArgs: [key],
          limit: 1,
        );

        if (results.isNotEmpty) {
          entry = CacheEntry.fromDatabaseRow(results.first);
          // Кэшируем в Hive для быстрого доступа
          await _cacheBox?.put(key, entry);
        }
      }

      if (entry == null) return null;

      // Проверяем срок действия
      if (entry.expiry != null && DateTime.now().isAfter(entry.expiry!)) {
        await removeCachedData(key);
        return null;
      }

      // Десериализуем данные
      final dataMap = jsonDecode(entry.data) as Map<String, dynamic>;

      if (fromJson != null) {
        return fromJson(dataMap);
      } else {
        return dataMap as T;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения кэшированных данных: $e');
      }
      return null;
    }
  }

  /// Удаление данных из кэша
  Future<void> removeCachedData(String key) async {
    if (!_isInitialized) return;

    try {
      await _cacheBox?.delete(key);

      if (_database != null) {
        await _database!.delete(
          'cache_entries',
          where: 'key = ?',
          whereArgs: [key],
        );
      }

      _emitEvent(OfflineEvent.dataRemoved(key));
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка удаления кэшированных данных: $e');
      }
    }
  }

  /// Очистка кэша
  Future<void> clearCache({List<String>? tags}) async {
    if (!_isInitialized) return;

    try {
      if (tags == null) {
        // Очищаем весь кэш
        await _cacheBox?.clear();
        if (_database != null) {
          await _database!.delete('cache_entries');
        }
      } else {
        // Очищаем по тегам
        if (_database != null) {
          for (final tag in tags) {
            await _database!.delete(
              'cache_entries',
              where: 'tags LIKE ?',
              whereArgs: ['%$tag%'],
            );
          }
        }
      }

      _emitEvent(OfflineEvent.cacheCleared(tags));

      if (kDebugMode) {
        print('🧹 Кэш очищен');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка очистки кэша: $e');
      }
    }
  }

  /// Добавление операции в очередь
  Future<void> queueOperation(OfflineOperation operation) async {
    if (!_isInitialized) return;

    try {
      _pendingOperations.add(operation);

      // Сохраняем в базу данных
      if (_database != null) {
        await _database!.insert(
          'offline_operations',
          operation.toDatabaseRow(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      _emitEvent(OfflineEvent.operationQueued(operation));

      if (kDebugMode) {
        print('📤 Операция добавлена в очередь: ${operation.type}');
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка добавления операции в очередь: $e');
      }
    }
  }

  /// Выполнение отложенных операций
  Future<void> processPendingOperations() async {
    if (!_isInitialized || _pendingOperations.isEmpty) return;

    final operationsToProcess = List<OfflineOperation>.from(_pendingOperations);

    for (final operation in operationsToProcess) {
      try {
        await _processOperation(operation);
      } catch (e) {
        if (kDebugMode) {
          print('❌ Ошибка выполнения операции ${operation.operationId}: $e');
        }
      }
    }
  }

  /// Выполнение одной операции
  Future<void> _processOperation(OfflineOperation operation) async {
    try {
      // Здесь должна быть логика выполнения HTTP запроса
      // Для демонстрации просто помечаем как выполненную

      _pendingOperations
          .removeWhere((op) => op.operationId == operation.operationId);

      if (_database != null) {
        await _database!.update(
          'offline_operations',
          {
            'status': 'completed',
            'updated_at': DateTime.now().millisecondsSinceEpoch
          },
          where: 'operation_id = ?',
          whereArgs: [operation.operationId],
        );
      }

      _emitEvent(OfflineEvent.operationCompleted(operation));

      if (kDebugMode) {
        print('✅ Операция выполнена: ${operation.operationId}');
      }
    } catch (e) {
      // Увеличиваем счетчик повторов
      final updatedOperation = operation.copyWith(
        retryCount: operation.retryCount + 1,
        status: operation.retryCount >= operation.maxRetries
            ? OfflineOperationStatus.failed
            : OfflineOperationStatus.pending,
      );

      if (_database != null) {
        await _database!.update(
          'offline_operations',
          updatedOperation.toDatabaseRow(),
          where: 'operation_id = ?',
          whereArgs: [operation.operationId],
        );
      }

      if (updatedOperation.status == OfflineOperationStatus.failed) {
        _pendingOperations
            .removeWhere((op) => op.operationId == operation.operationId);
        _emitEvent(OfflineEvent.operationFailed(operation, e.toString()));
      }

      rethrow;
    }
  }

  /// Настройка автоматической синхронизации
  void _setupAutoSync() {
    _syncTimer?.cancel();

    if (_settings.autoSyncEnabled && _settings.autoSyncInterval != null) {
      _syncTimer = Timer.periodic(_settings.autoSyncInterval!, (_) async {
        if (!_isOfflineMode) {
          await processPendingOperations();
        }
      });
    }
  }

  /// Включение/выключение офлайн режима
  Future<void> setOfflineMode(bool enabled) async {
    _isOfflineMode = enabled;

    _settings = _settings.copyWith(forceOfflineMode: enabled);
    await _saveSettings();

    _emitEvent(OfflineEvent.offlineModeChanged(enabled));

    if (kDebugMode) {
      print(enabled ? '📵 Офлайн режим включен' : '🌐 Офлайн режим выключен');
    }

    notifyListeners();
  }

  /// Обновление настроек
  Future<void> updateSettings(OfflineSettings newSettings) async {
    _settings = newSettings;
    await _saveSettings();
    _setupAutoSync();
    notifyListeners();
  }

  /// Получение статистики кэша
  Future<Map<String, dynamic>> getCacheStats() async {
    if (!_isInitialized || _database == null) {
      return {'error': 'Service not initialized'};
    }

    try {
      final totalEntries = await _database!
          .rawQuery('SELECT COUNT(*) as count FROM cache_entries');
      final expiredEntries = await _database!.rawQuery(
        'SELECT COUNT(*) as count FROM cache_entries WHERE expiry < ?',
        [DateTime.now().millisecondsSinceEpoch],
      );

      return {
        'totalEntries': totalEntries.first['count'],
        'expiredEntries': expiredEntries.first['count'],
        'pendingOperations': _pendingOperations.length,
        'cacheSize': _cacheBox?.length ?? 0,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  /// Очистка истекших записей кэша
  Future<void> cleanupExpiredCache() async {
    if (!_isInitialized || _database == null) return;

    try {
      final deletedCount = await _database!.delete(
        'cache_entries',
        where: 'expiry < ?',
        whereArgs: [DateTime.now().millisecondsSinceEpoch],
      );

      if (kDebugMode && deletedCount > 0) {
        print('🧹 Удалено $deletedCount истекших записей кэша');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка очистки истекшего кэша: $e');
      }
    }
  }

  /// Получение статуса сервиса
  Map<String, dynamic> get status => {
        'isInitialized': _isInitialized,
        'isOfflineMode': _isOfflineMode,
        'pendingOperationsCount': _pendingOperations.length,
        'cacheSize': _cacheBox?.length ?? 0,
        'autoSyncEnabled': _settings.autoSyncEnabled,
        'autoSyncInterval': _settings.autoSyncInterval?.inMinutes,
      };

  /// Отправка события
  void _emitEvent(OfflineEvent event) {
    _eventController?.add(event);
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    _eventController?.close();
    _cacheBox?.close();
    _queueBox?.close();
    _database?.close();
    super.dispose();
  }
}
