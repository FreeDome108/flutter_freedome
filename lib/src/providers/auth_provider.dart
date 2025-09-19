import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/auth_models.dart';

/// Провайдер для управления состоянием аутентификации
class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService) {
    _authService.addListener(_onAuthServiceChanged);
  }

  // Состояние аутентификации
  bool get isAuthenticated => _authService.isAuthenticated;
  bool get isLoading => _authService.isLoading;
  String? get error => _authService.error;
  Customer? get currentCustomer => _authService.currentCustomer;
  String? get customerToken => _authService.customerToken;
  DateTime? get tokenExpiry => _authService.tokenExpiry;

  /// Аутентификация пользователя
  Future<bool> authenticate({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final success = await _authService.authenticate(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      if (success && kDebugMode) {
        print('✅ Пользователь аутентифицирован: $email');
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка аутентификации: $e');
      }
      return false;
    }
  }

  /// Регистрация нового пользователя
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final success = await _authService.createAccount(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        additionalData: additionalData,
      );

      if (success && kDebugMode) {
        print('✅ Пользователь зарегистрирован: $email');
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка регистрации: $e');
      }
      return false;
    }
  }

  /// Выход из аккаунта
  Future<void> logout() async {
    try {
      await _authService.logout();
      if (kDebugMode) {
        print('✅ Пользователь вышел из аккаунта');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка выхода из аккаунта: $e');
      }
    }
  }

  /// Обновление токена
  Future<bool> refreshToken() async {
    try {
      return await _authService.refreshToken();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления токена: $e');
      }
      return false;
    }
  }

  /// Восстановление пароля
  Future<bool> resetPassword(String email) async {
    try {
      return await _authService.resetPassword(email);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка восстановления пароля: $e');
      }
      return false;
    }
  }

  /// Изменение пароля
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      return await _authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка изменения пароля: $e');
      }
      return false;
    }
  }

  /// Обновление профиля пользователя
  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    try {
      return await _authService.updateProfile(profileData);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления профиля: $e');
      }
      return false;
    }
  }

  /// Проверка валидности токена
  bool get isTokenValid => _authService.isTokenValid;

  /// Время до истечения токена
  Duration? get timeToTokenExpiry => _authService.timeToTokenExpiry;

  /// Автоматическое обновление токена при приближении к истечению
  Future<void> autoRefreshToken() async {
    if (isAuthenticated && !isTokenValid) {
      await refreshToken();
    }
  }

  /// Обработчик изменений в AuthService
  void _onAuthServiceChanged() {
    notifyListeners();
  }

  /// Получение статуса аутентификации
  Map<String, dynamic> get authStatus => {
        'isAuthenticated': isAuthenticated,
        'isLoading': isLoading,
        'error': error,
        'customerEmail': currentCustomer?.email,
        'customerName': currentCustomer != null
            ? '${currentCustomer!.firstName} ${currentCustomer!.lastName}'
            : null,
        'tokenExpiry': tokenExpiry?.toIso8601String(),
        'isTokenValid': isTokenValid,
        'timeToExpiry': timeToTokenExpiry?.inMinutes,
      };

  @override
  void dispose() {
    _authService.removeListener(_onAuthServiceChanged);
    super.dispose();
  }
}
