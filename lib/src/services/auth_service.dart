import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'network_service.dart';
import '../models/auth_models.dart';
import '../models/customer.dart';
import '../exceptions/magento_exception.dart';

/// Улучшенный сервис аутентификации с JWT и SharedPreferences
class AuthService extends ChangeNotifier {
  static const String _tokenKey = 'magento_auth_token';
  static const String _refreshTokenKey = 'magento_refresh_token';
  static const String _customerKey = 'magento_customer';
  static const String _tokenExpiryKey = 'magento_token_expiry';
  static const String _rememberMeKey = 'magento_remember_me';

  final NetworkService _networkService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  Customer? _currentCustomer;
  String? _customerToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;
  Timer? _tokenRefreshTimer;

  AuthService() : _networkService = NetworkService();

  // Геттеры
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Customer? get currentCustomer => _currentCustomer;
  String? get customerToken => _customerToken;
  DateTime? get tokenExpiry => _tokenExpiry;

  /// Проверка валидности токена
  bool get isTokenValid {
    if (_tokenExpiry == null) return false;
    return DateTime.now()
        .isBefore(_tokenExpiry!.subtract(const Duration(minutes: 5)));
  }

  /// Время до истечения токена
  Duration? get timeToTokenExpiry {
    if (_tokenExpiry == null) return null;
    return _tokenExpiry!.difference(DateTime.now());
  }

  /// Инициализация сервиса аутентификации
  Future<bool> initialize() async {
    try {
      await _loadStoredCredentials();

      if (_isAuthenticated && !isTokenValid && _refreshToken != null) {
        await refreshToken();
      }

      if (_isAuthenticated) {
        _setupTokenRefreshTimer();
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ AuthService initialization failed: $e');
      }
      return false;
    }
  }

  /// Загрузка сохраненных учетных данных
  Future<void> _loadStoredCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      _customerToken = await _secureStorage.read(key: _tokenKey);
      _refreshToken = await _secureStorage.read(key: _refreshTokenKey);

      final customerJson = prefs.getString(_customerKey);
      if (customerJson != null) {
        _currentCustomer = Customer.fromJson(jsonDecode(customerJson));
      }

      final expiryString = prefs.getString(_tokenExpiryKey);
      if (expiryString != null) {
        _tokenExpiry = DateTime.parse(expiryString);
      }

      _isAuthenticated =
          _customerToken != null && _currentCustomer != null && isTokenValid;

      if (_isAuthenticated && _customerToken != null) {
        _networkService.setAuthToken(_customerToken!);
      }

      if (kDebugMode && _isAuthenticated) {
        print(
            '✅ Пользователь автоматически аутентифицирован: ${_currentCustomer?.email}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки сохраненных данных: $e');
      }
    }
  }

  /// Сохранение учетных данных
  Future<void> _saveCredentials({
    required String token,
    required Customer customer,
    String? refreshToken,
    DateTime? expiry,
    bool rememberMe = false,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await _secureStorage.write(key: _tokenKey, value: token);
      if (refreshToken != null) {
        await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
      }

      await prefs.setString(_customerKey, jsonEncode(customer.toJson()));
      if (expiry != null) {
        await prefs.setString(_tokenExpiryKey, expiry.toIso8601String());
      }
      await prefs.setBool(_rememberMeKey, rememberMe);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сохранения учетных данных: $e');
      }
    }
  }

  /// Очистка сохраненных учетных данных
  Future<void> _clearStoredCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await _secureStorage.delete(key: _tokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await prefs.remove(_customerKey);
      await prefs.remove(_tokenExpiryKey);
      await prefs.remove(_rememberMeKey);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка очистки учетных данных: $e');
      }
    }
  }

  /// Аутентификация пользователя
  Future<bool> authenticate({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _networkService.post(
        '/rest/V1/integration/customer/token',
        data: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data as String;

        // Получаем информацию о клиенте
        _networkService.setAuthToken(token);
        final customerResponse =
            await _networkService.get('/rest/V1/customers/me');

        if (customerResponse.statusCode == 200) {
          final customerData = customerResponse.data as Map<String, dynamic>;
          final customer = Customer.fromJson(customerData);

          // Вычисляем время истечения токена (обычно 1 час)
          final expiry = DateTime.now().add(const Duration(hours: 1));

          _customerToken = token;
          _currentCustomer = customer;
          _tokenExpiry = expiry;
          _isAuthenticated = true;

          await _saveCredentials(
            token: token,
            customer: customer,
            expiry: expiry,
            rememberMe: rememberMe,
          );

          _setupTokenRefreshTimer();

          if (kDebugMode) {
            print('✅ Пользователь аутентифицирован: $email');
          }

          _setLoading(false);
          return true;
        }
      }

      _setError('Неверные учетные данные');
      return false;
    } catch (e) {
      _setError(_parseError(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Создание нового аккаунта
  Future<bool> createAccount({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    Map<String, dynamic>? additionalData,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final customerData = {
        'customer': {
          'email': email,
          'firstname': firstName,
          'lastname': lastName,
          ...?additionalData,
        },
        'password': password,
      };

      final response = await _networkService.post(
        '/rest/V1/customers',
        data: customerData,
      );

      if (response.statusCode == 200) {
        // Автоматически аутентифицируем после регистрации
        return await authenticate(email: email, password: password);
      }

      _setError('Не удалось создать аккаунт');
      return false;
    } catch (e) {
      _setError(_parseError(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Обновление токена
  Future<bool> refreshToken() async {
    if (_refreshToken == null) return false;

    try {
      final response = await _networkService.post(
        '/rest/V1/integration/customer/token/refresh',
        data: {'refreshToken': _refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data as String;
        final expiry = DateTime.now().add(const Duration(hours: 1));

        _customerToken = newToken;
        _tokenExpiry = expiry;

        _networkService.setAuthToken(newToken);

        if (_currentCustomer != null) {
          await _saveCredentials(
            token: newToken,
            customer: _currentCustomer!,
            refreshToken: _refreshToken,
            expiry: expiry,
          );
        }

        _setupTokenRefreshTimer();

        if (kDebugMode) {
          print('✅ Токен обновлен');
        }

        notifyListeners();
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления токена: $e');
      }
    }

    return false;
  }

  /// Восстановление пароля
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _networkService.post(
        '/rest/V1/customers/password',
        data: {'email': email, 'template': 'email_reset'},
      );

      _setLoading(false);
      return response.statusCode == 200;
    } catch (e) {
      _setError(_parseError(e));
      _setLoading(false);
      return false;
    }
  }

  /// Изменение пароля
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!_isAuthenticated) return false;

    _setLoading(true);
    _clearError();

    try {
      final response = await _networkService.put(
        '/rest/V1/customers/me/password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );

      _setLoading(false);
      return response.statusCode == 200;
    } catch (e) {
      _setError(_parseError(e));
      _setLoading(false);
      return false;
    }
  }

  /// Обновление профиля
  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    if (!_isAuthenticated) return false;

    _setLoading(true);
    _clearError();

    try {
      final response = await _networkService.put(
        '/rest/V1/customers/me',
        data: {'customer': profileData},
      );

      if (response.statusCode == 200) {
        final updatedCustomer = Customer.fromJson(response.data);
        _currentCustomer = updatedCustomer;

        if (_customerToken != null) {
          await _saveCredentials(
            token: _customerToken!,
            customer: updatedCustomer,
            refreshToken: _refreshToken,
            expiry: _tokenExpiry,
          );
        }

        _setLoading(false);
        return true;
      }

      return false;
    } catch (e) {
      _setError(_parseError(e));
      _setLoading(false);
      return false;
    }
  }

  /// Выход из аккаунта
  Future<void> logout() async {
    try {
      if (_isAuthenticated) {
        await _networkService.post('/rest/V1/customers/logout');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка выхода: $e');
      }
    } finally {
      _tokenRefreshTimer?.cancel();
      _networkService.clearAuthToken();

      await _clearStoredCredentials();

      _isAuthenticated = false;
      _currentCustomer = null;
      _customerToken = null;
      _refreshToken = null;
      _tokenExpiry = null;
      _clearError();

      notifyListeners();

      if (kDebugMode) {
        print('✅ Пользователь вышел из аккаунта');
      }
    }
  }

  /// Настройка таймера для автоматического обновления токена
  void _setupTokenRefreshTimer() {
    _tokenRefreshTimer?.cancel();

    if (_tokenExpiry != null) {
      final refreshTime = _tokenExpiry!.subtract(const Duration(minutes: 10));
      final timeToRefresh = refreshTime.difference(DateTime.now());

      if (timeToRefresh.isNegative) {
        // Токен уже истек или скоро истечет, обновляем немедленно
        refreshToken();
      } else {
        _tokenRefreshTimer = Timer(timeToRefresh, () async {
          await refreshToken();
        });
      }
    }
  }

  /// Парсинг ошибок
  String _parseError(dynamic error) {
    if (error is MagentoException) {
      return error.message;
    } else if (error.toString().contains('401')) {
      return 'Неверные учетные данные';
    } else if (error.toString().contains('403')) {
      return 'Доступ запрещен';
    } else if (error.toString().contains('404')) {
      return 'Пользователь не найден';
    } else if (error.toString().contains('timeout')) {
      return 'Превышено время ожидания';
    }
    return 'Произошла ошибка аутентификации';
  }

  /// Получение статуса аутентификации
  Map<String, dynamic> get status => {
        'isAuthenticated': _isAuthenticated,
        'isLoading': _isLoading,
        'error': _error,
        'customerEmail': _currentCustomer?.email,
        'isTokenValid': isTokenValid,
        'tokenExpiry': _tokenExpiry?.toIso8601String(),
        'timeToExpiry': timeToTokenExpiry?.inMinutes,
      };

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _tokenRefreshTimer?.cancel();
    super.dispose();
  }
}
