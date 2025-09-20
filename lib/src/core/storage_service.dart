import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/offline_models.dart';

/// Упрощенный сервис хранения для тестирования
class FreeDomeStorageService extends ChangeNotifier {
  static final FreeDomeStorageService _instance = FreeDomeStorageService._internal();
  factory FreeDomeStorageService() => _instance;
  FreeDomeStorageService._internal();

  SharedPreferences? _prefs;
  final Map<String, CacheEntry> _memoryCache = {};
  final List<OfflineOperation> _offlineQueue = [];

  bool get isInitialized => _prefs != null;

  /// Инициализация сервиса
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await _loadFromPrefs();
      
      if (kDebugMode) {
        print('✅ FreeDomeStorageService инициализирован');
        print('📊 Кэш записей: ${_memoryCache.length}');
        print('📊 Офлайн операций: ${_offlineQueue.length}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации FreeDomeStorageService: $e');
      }
    }
  }

  /// Сохранение данных в кэш
  Future<void> setCache(
    String key,
    String data, {
    DateTime? expiry,
    List<String> tags = const [],
  }) async {
    try {
      final entry = CacheEntry(
        key: key,
        data: data,
        expiry: expiry,
        tags: tags,
      );

      _memoryCache[key] = entry;
      await _saveToPrefs();
      
      if (kDebugMode) {
        print('💾 Кэш сохранен: $key');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сохранения кэша: $e');
      }
    }
  }

  /// Получение данных из кэша
  Future<String?> getCache(String key) async {
    try {
      final entry = _memoryCache[key];
      if (entry == null) return null;
      
      if (entry.isExpired) {
        await removeCache(key);
        return null;
      }
      
      return entry.data;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения кэша: $e');
      }
      return null;
    }
  }

  /// Удаление данных из кэша
  Future<bool> removeCache(String key) async {
    try {
      final removed = _memoryCache.remove(key) != null;
      if (removed) {
        await _saveToPrefs();
      }
      return removed;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка удаления кэша: $e');
      }
      return false;
    }
  }

  /// Очистка всего кэша
  Future<int> clearCache() async {
    try {
      final count = _memoryCache.length;
      _memoryCache.clear();
      await _saveToPrefs();
      return count;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка очистки кэша: $e');
      }
      return 0;
    }
  }

  /// Добавление офлайн операции
  Future<void> addOfflineOperation(OfflineOperation operation) async {
    try {
      _offlineQueue.add(operation);
      await _saveToPrefs();
      
      if (kDebugMode) {
        print('📝 Офлайн операция добавлена: ${operation.operationId}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка добавления офлайн операции: $e');
      }
    }
  }

  /// Получение офлайн операций
  List<OfflineOperation> getOfflineOperations({String? status}) {
    if (status == null) {
      return List.from(_offlineQueue);
    }
    return _offlineQueue.where((op) => op.status == status).toList();
  }

  /// Удаление офлайн операции
  Future<bool> removeOfflineOperation(String operationId) async {
    try {
      final initialLength = _offlineQueue.length;
      _offlineQueue.removeWhere((op) => op.operationId == operationId);
      
      if (_offlineQueue.length != initialLength) {
        await _saveToPrefs();
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка удаления офлайн операции: $e');
      }
      return false;
    }
  }

  /// Загрузка данных из SharedPreferences
  Future<void> _loadFromPrefs() async {
    try {
      // Загрузка кэша
      final cacheData = _prefs?.getString('freedome_cache');
      if (cacheData != null) {
        final cacheMap = json.decode(cacheData) as Map<String, dynamic>;
        _memoryCache.clear();
        cacheMap.forEach((key, value) {
          try {
            _memoryCache[key] = CacheEntry.fromJson(value);
          } catch (e) {
            if (kDebugMode) {
              print('❌ Ошибка загрузки кэш записи $key: $e');
            }
          }
        });
      }

      // Загрузка офлайн операций
      final queueData = _prefs?.getString('freedome_offline_queue');
      if (queueData != null) {
        final queueList = json.decode(queueData) as List;
        _offlineQueue.clear();
        for (final item in queueList) {
          try {
            _offlineQueue.add(OfflineOperation.fromJson(item));
          } catch (e) {
            if (kDebugMode) {
              print('❌ Ошибка загрузки офлайн операции: $e');
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки из SharedPreferences: $e');
      }
    }
  }

  /// Сохранение данных в SharedPreferences
  Future<void> _saveToPrefs() async {
    try {
      // Сохранение кэша
      final cacheMap = <String, dynamic>{};
      _memoryCache.forEach((key, entry) {
        cacheMap[key] = entry.toJson();
      });
      await _prefs?.setString('freedome_cache', json.encode(cacheMap));

      // Сохранение офлайн операций
      final queueList = _offlineQueue.map((op) => op.toJson()).toList();
      await _prefs?.setString('freedome_offline_queue', json.encode(queueList));
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сохранения в SharedPreferences: $e');
      }
    }
  }

  /// Получение статистики хранилища
  Map<String, dynamic> getStorageStats() {
    return {
      'totalCacheEntries': _memoryCache.length,
      'queuedOperations': _offlineQueue.length,
      'isInitialized': isInitialized,
    };
  }

  @override
  void dispose() {
    _memoryCache.clear();
    _offlineQueue.clear();
    super.dispose();
  }
}
