import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import '../models/dome_models.dart';

/// Сервис аутентификации и управления ролями FreeDome
class FreeDomeAuthService extends ChangeNotifier {
  static final FreeDomeAuthService _instance = FreeDomeAuthService._internal();
  factory FreeDomeAuthService() => _instance;
  FreeDomeAuthService._internal();

  static const String _userKey = 'freedome_user';
  static const String _sessionKey = 'freedome_session';
  static const String _guestSessionKey = 'freedome_guest_session';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  FreeDomeUser? _currentUser;
  FreeDomeSession? _currentSession;
  bool _isAuthenticated = false;
  bool _isGuest = false;

  // Геттеры
  FreeDomeUser? get currentUser => _currentUser;
  FreeDomeSession? get currentSession => _currentSession;
  bool get isAuthenticated => _isAuthenticated;
  bool get isGuest => _isGuest;
  FreeDomeUserRole get currentRole =>
      _currentUser?.role ?? FreeDomeUserRole.guest;

  /// Инициализация сервиса
  Future<void> initialize() async {
    try {
      await _loadStoredSession();

      if (kDebugMode) {
        print('✅ FreeDomeAuthService инициализирован');
        if (_isAuthenticated) {
          print(
              '👤 Пользователь: ${_currentUser?.name} (${currentRole.displayName})');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации FreeDomeAuthService: $e');
      }
    }
  }

  /// Загрузка сохраненной сессии
  Future<void> _loadStoredSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Проверяем гостевую сессию
      final guestSessionJson = prefs.getString(_guestSessionKey);
      if (guestSessionJson != null) {
        final sessionData = json.decode(guestSessionJson);
        _currentSession = FreeDomeSession.fromJson(sessionData);
        _isGuest = true;
        _isAuthenticated = true;

        // Создаем временного пользователя-гостя
        _currentUser = FreeDomeUser(
          id: 'guest_${_currentSession!.id}',
          name: 'Гость',
          role: FreeDomeUserRole.guest,
          permissions: FreeDomeUserRole.guest.defaultPermissions,
        );

        return;
      }

      // Проверяем аутентифицированную сессию
      final userJson = await _secureStorage.read(key: _userKey);
      final sessionJson = await _secureStorage.read(key: _sessionKey);

      if (userJson != null && sessionJson != null) {
        _currentUser = FreeDomeUser.fromJson(json.decode(userJson));
        _currentSession = FreeDomeSession.fromJson(json.decode(sessionJson));
        _isAuthenticated = true;
        _isGuest = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки сессии: $e');
      }
    }
  }

  /// Аутентификация администратора
  Future<bool> authenticateAdmin({
    required String username,
    required String password,
    String? domeId,
  }) async {
    try {
      // Хэшируем пароль
      final passwordHash = _hashPassword(password);

      // В реальной реализации здесь должен быть запрос к серверу аутентификации
      // Для демонстрации используем предопределенные учетные данные
      final isValid = await _validateCredentials(username, passwordHash);

      if (isValid) {
        final user = FreeDomeUser(
          id: 'admin_${DateTime.now().millisecondsSinceEpoch}',
          name: username,
          role: FreeDomeUserRole.admin,
          permissions: FreeDomeUserRole.admin.defaultPermissions,
          email: '$username@freedome.local',
          lastLogin: DateTime.now(),
        );

        final session = FreeDomeSession(
          id: 'session_${DateTime.now().millisecondsSinceEpoch}',
          userId: user.id,
          domeId: domeId ?? 'default',
          startTime: DateTime.now(),
        );

        await _saveAuthenticatedSession(user, session);

        _currentUser = user;
        _currentSession = session;
        _isAuthenticated = true;
        _isGuest = false;

        notifyListeners();

        if (kDebugMode) {
          print('✅ Администратор аутентифицирован: $username');
        }

        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка аутентификации: $e');
      }
    }

    return false;
  }

  /// Создание гостевой сессии
  Future<bool> createGuestSession({String? domeId}) async {
    try {
      final session = FreeDomeSession(
        id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'guest',
        domeId: domeId ?? 'default',
        startTime: DateTime.now(),
      );

      final user = FreeDomeUser(
        id: 'guest_${session.id}',
        name: 'Гость',
        role: FreeDomeUserRole.guest,
        permissions: FreeDomeUserRole.guest.defaultPermissions,
      );

      await _saveGuestSession(session);

      _currentUser = user;
      _currentSession = session;
      _isAuthenticated = true;
      _isGuest = true;

      notifyListeners();

      if (kDebugMode) {
        print('✅ Гостевая сессия создана');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка создания гостевой сессии: $e');
      }
      return false;
    }
  }

  /// Выход из системы
  Future<void> logout() async {
    try {
      // Завершаем текущую сессию
      if (_currentSession != null) {
        final endedSession = _currentSession!.copyWith(
          endTime: DateTime.now(),
          duration: DateTime.now().difference(_currentSession!.startTime),
        );

        // В реальной реализации отправляем на сервер
        if (kDebugMode) {
          print('📊 Сессия завершена: ${endedSession.duration}');
        }
      }

      // Очищаем сохраненные данные
      await _clearStoredSession();

      _currentUser = null;
      _currentSession = null;
      _isAuthenticated = false;
      _isGuest = false;

      notifyListeners();

      if (kDebugMode) {
        print('✅ Выход из системы выполнен');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка выхода из системы: $e');
      }
    }
  }

  /// Проверка разрешения
  bool hasPermission(FreeDomePermission permission) {
    if (!_isAuthenticated || _currentUser == null) {
      return false;
    }

    return _currentUser!.permissions.contains(permission);
  }

  /// Проверка роли
  bool hasRole(FreeDomeUserRole role) {
    if (!_isAuthenticated || _currentUser == null) {
      return false;
    }

    return _currentUser!.role.index >= role.index;
  }

  /// Получение доступных действий для текущего пользователя
  List<FreeDomePermission> getAvailablePermissions() {
    if (!_isAuthenticated || _currentUser == null) {
      return [];
    }

    return _currentUser!.permissions;
  }

  /// Валидация учетных данных
  Future<bool> _validateCredentials(
      String username, String passwordHash) async {
    // Предопределенные учетные данные для демонстрации
    final validCredentials = {
      'admin': _hashPassword('admin123'),
      'operator': _hashPassword('operator123'),
      'technician': _hashPassword('tech123'),
    };

    return validCredentials[username] == passwordHash;
  }

  /// Хэширование пароля
  String _hashPassword(String password) {
    final bytes = utf8.encode(password + 'freedome_salt');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Сохранение аутентифицированной сессии
  Future<void> _saveAuthenticatedSession(
      FreeDomeUser user, FreeDomeSession session) async {
    await _secureStorage.write(
        key: _userKey, value: json.encode(user.toJson()));
    await _secureStorage.write(
        key: _sessionKey, value: json.encode(session.toJson()));
  }

  /// Сохранение гостевой сессии
  Future<void> _saveGuestSession(FreeDomeSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_guestSessionKey, json.encode(session.toJson()));
  }

  /// Очистка сохраненной сессии
  Future<void> _clearStoredSession() async {
    await _secureStorage.delete(key: _userKey);
    await _secureStorage.delete(key: _sessionKey);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_guestSessionKey);
  }

  /// Получение информации о текущей сессии
  Map<String, dynamic> getSessionInfo() {
    return {
      'isAuthenticated': _isAuthenticated,
      'isGuest': _isGuest,
      'user': _currentUser?.toJson(),
      'session': _currentSession?.toJson(),
      'permissions': getAvailablePermissions().map((p) => p.name).toList(),
      'role': currentRole.name,
    };
  }

  /// Продление сессии
  Future<bool> extendSession() async {
    if (_currentSession == null) return false;

    try {
      // В реальной реализации отправляем запрос на сервер
      // Для демонстрации просто обновляем локальные данные

      if (_isGuest) {
        await _saveGuestSession(_currentSession!);
      } else {
        await _saveAuthenticatedSession(_currentUser!, _currentSession!);
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка продления сессии: $e');
      }
      return false;
    }
  }

  /// Переключение в гостевой режим
  Future<bool> switchToGuestMode() async {
    if (_isGuest) return true;

    await logout();
    return await createGuestSession();
  }
}
