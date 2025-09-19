import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

/// Service for secure storage operations
/// Uses FlutterSecureStorage for sensitive data like tokens and user credentials
class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    lOptions: LinuxOptions(
      useSessionKeyring: true,
    ),
    wOptions: WindowsOptions(),
    mOptions: MacOsOptions(),
  );

  /// Initialize the secure storage service
  static Future<void> initialize() async {
    try {
      // Test if secure storage is available
      await _storage.containsKey(key: 'test');
      if (kDebugMode) {
        print('✅ Secure storage initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing secure storage: $e');
      }
      rethrow;
    }
  }

  /// Store a string value securely
  static Future<void> setString(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      if (kDebugMode) {
        print('🔐 Stored value for key: $key');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error storing value for key $key: $e');
      }
      rethrow;
    }
  }

  /// Retrieve a string value
  static Future<String?> getString(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (kDebugMode && value != null) {
        print('🔓 Retrieved value for key: $key');
      }
      return value;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error retrieving value for key $key: $e');
      }
      return null;
    }
  }

  /// Store a boolean value
  static Future<void> setBool(String key, bool value) async {
    await setString(key, value.toString());
  }

  /// Retrieve a boolean value
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final value = await getString(key);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  /// Store an integer value
  static Future<void> setInt(String key, int value) async {
    await setString(key, value.toString());
  }

  /// Retrieve an integer value
  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    final value = await getString(key);
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  /// Store a double value
  static Future<void> setDouble(String key, double value) async {
    await setString(key, value.toString());
  }

  /// Retrieve a double value
  static Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    final value = await getString(key);
    if (value == null) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }

  /// Check if a key exists
  static Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking key $key: $e');
      }
      return false;
    }
  }

  /// Remove a value by key
  static Future<void> remove(String key) async {
    try {
      await _storage.delete(key: key);
      if (kDebugMode) {
        print('🗑️ Removed value for key: $key');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error removing value for key $key: $e');
      }
      rethrow;
    }
  }

  /// Clear all stored values
  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      if (kDebugMode) {
        print('🧹 Cleared all secure storage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error clearing secure storage: $e');
      }
      rethrow;
    }
  }

  /// Get all keys
  static Future<Set<String>> getAllKeys() async {
    try {
      final map = await _storage.readAll();
      return map.keys.toSet();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting all keys: $e');
      }
      return <String>{};
    }
  }

  /// Get all key-value pairs
  static Future<Map<String, String>> getAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting all values: $e');
      }
      return <String, String>{};
    }
  }

  /// Store multiple key-value pairs
  static Future<void> setMultiple(Map<String, String> values) async {
    try {
      for (final entry in values.entries) {
        await setString(entry.key, entry.value);
      }
      if (kDebugMode) {
        print('🔐 Stored ${values.length} key-value pairs');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error storing multiple values: $e');
      }
      rethrow;
    }
  }

  /// Remove multiple keys
  static Future<void> removeMultiple(List<String> keys) async {
    try {
      for (final key in keys) {
        await remove(key);
      }
      if (kDebugMode) {
        print('🗑️ Removed ${keys.length} keys');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error removing multiple keys: $e');
      }
      rethrow;
    }
  }

  /// Check if secure storage is available on the platform
  static Future<bool> isAvailable() async {
    try {
      await _storage.containsKey(key: 'availability_test');
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Secure storage not available: $e');
      }
      return false;
    }
  }

  /// Get storage information (for debugging)
  static Future<Map<String, dynamic>> getStorageInfo() async {
    if (!kDebugMode) return {};

    try {
      final allKeys = await getAllKeys();
      return {
        'totalKeys': allKeys.length,
        'keys': allKeys.toList(),
        'isAvailable': await isAvailable(),
      };
    } catch (e) {
      return {
        'error': e.toString(),
        'isAvailable': false,
      };
    }
  }
}
