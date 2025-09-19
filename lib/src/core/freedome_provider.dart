import 'package:flutter/foundation.dart';
import 'connection_service.dart';
import 'auth_service.dart';
import 'content_service.dart';
import '../admin/calibration_service.dart';
import '../admin/system_service.dart';
import '../models/dome_models.dart';
import '../models/content_models.dart';

/// Главный провайдер FreeDome - точка входа для всех операций
class FreeDomeProvider extends ChangeNotifier {
  static final FreeDomeProvider _instance = FreeDomeProvider._internal();
  factory FreeDomeProvider() => _instance;
  FreeDomeProvider._internal();

  // Основные сервисы
  late final FreeDomeConnectionService _connectionService;
  late final FreeDomeAuthService _authService;
  late final FreeDomeContentService _contentService;

  // Админские сервисы (ленивая инициализация)
  FreeDomeCalibrationService? _calibrationService;
  FreeDomeSystemService? _systemService;

  // Состояние инициализации
  bool _isInitialized = false;
  bool _isInitializing = false;
  String? _error;

  // Геттеры для основных сервисов
  FreeDomeConnectionService get connection => _connectionService;
  FreeDomeAuthService get auth => _authService;
  FreeDomeContentService get content => _contentService;

  // Геттеры для админских сервисов (с проверкой разрешений)
  FreeDomeCalibrationService? get calibration {
    if (!_authService.hasPermission(FreeDomePermission.calibrateAudio) &&
        !_authService.hasPermission(FreeDomePermission.calibrateProjectors)) {
      return null;
    }
    _calibrationService ??= FreeDomeCalibrationService();
    return _calibrationService;
  }

  FreeDomeSystemService? get system {
    if (!_authService.hasPermission(FreeDomePermission.systemManagement)) {
      return null;
    }
    _systemService ??= FreeDomeSystemService();
    return _systemService;
  }

  // Геттеры состояния
  bool get isInitialized => _isInitialized;
  bool get isInitializing => _isInitializing;
  String? get error => _error;
  bool get isReady => _isInitialized && !_isInitializing && _error == null;

  // Делегированные геттеры для удобства
  bool get isConnected => _connectionService.isConnected;
  bool get isAuthenticated => _authService.isAuthenticated;
  FreeDomeUserRole get currentRole => _authService.currentRole;
  DomeSystem? get activeDome => _connectionService.activeDome;
  PlaybackState get playbackState => _contentService.playbackState;

  /// Инициализация FreeDome системы
  Future<bool> initialize({
    bool autoDiscovery = true,
    FreeDomeUserRole defaultRole = FreeDomeUserRole.guest,
  }) async {
    if (_isInitialized || _isInitializing) {
      return _isInitialized;
    }

    _isInitializing = true;
    _error = null;
    notifyListeners();

    try {
      // Инициализируем основные сервисы
      _connectionService = FreeDomeConnectionService();
      _authService = FreeDomeAuthService();
      _contentService = FreeDomeContentService();

      // Инициализируем сервисы
      await Future.wait([
        _connectionService.initialize(),
        _authService.initialize(),
        _contentService.initialize(),
      ]);

      // Создаем гостевую сессию по умолчанию
      if (defaultRole == FreeDomeUserRole.guest) {
        await _authService.createGuestSession();
      }

      // Настраиваем слушатели изменений
      _setupServiceListeners();

      _isInitialized = true;
      _isInitializing = false;

      if (kDebugMode) {
        print('✅ FreeDome система инициализирована');
      }

      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isInitializing = false;
      _isInitialized = false;

      if (kDebugMode) {
        print('❌ Ошибка инициализации FreeDome: $e');
      }

      notifyListeners();
      return false;
    }
  }

  /// Настройка слушателей изменений от сервисов
  void _setupServiceListeners() {
    _connectionService.addListener(() {
      notifyListeners();
    });

    _authService.addListener(() {
      notifyListeners();
      
      // При смене роли пользователя пересоздаем админские сервисы
      _calibrationService = null;
      _systemService = null;
    });

    _contentService.addListener(() {
      notifyListeners();
    });
  }

  /// Быстрое подключение к ближайшему куполу
  Future<bool> connectToNearestDome() async {
    if (!_isInitialized) {
      return false;
    }

    final systems = _connectionService.discoveredSystems;
    if (systems.isEmpty) {
      if (kDebugMode) {
        print('❌ Купольные системы не найдены');
      }
      return false;
    }

    // Выбираем первую доступную систему
    final nearestDome = systems.first;
    return await _connectionService.connectToDome(nearestDome);
  }

  /// Подключение к конкретному куполу
  Future<bool> connectToDome(DomeSystem dome) async {
    if (!_isInitialized) {
      return false;
    }

    return await _connectionService.connectToDome(dome);
  }

  /// Отключение от купола
  Future<void> disconnect() async {
    if (!_isInitialized) {
      return;
    }

    await _connectionService.disconnectFromDome();
  }

  /// Аутентификация как администратор
  Future<bool> authenticateAsAdmin({
    required String username,
    required String password,
  }) async {
    if (!_isInitialized) {
      return false;
    }

    final success = await _authService.authenticateAdmin(
      username: username,
      password: password,
      domeId: activeDome?.id,
    );

    if (success) {
      // Пересоздаем админские сервисы
      _calibrationService = null;
      _systemService = null;
      notifyListeners();
    }

    return success;
  }

  /// Переключение в гостевой режим
  Future<bool> switchToGuestMode() async {
    if (!_isInitialized) {
      return false;
    }

    final success = await _authService.switchToGuestMode();
    
    if (success) {
      // Очищаем админские сервисы
      _calibrationService = null;
      _systemService = null;
      notifyListeners();
    }

    return success;
  }

  /// Выход из системы
  Future<void> logout() async {
    if (!_isInitialized) {
      return;
    }

    await _authService.logout();
    
    // Очищаем админские сервисы
    _calibrationService = null;
    _systemService = null;
    
    notifyListeners();
  }

  /// Воспроизведение контента (упрощенный API)
  Future<bool> playContent(FreeDomeContent content) async {
    if (!_isInitialized) {
      return false;
    }

    return await _contentService.playContent(content);
  }

  /// Воспроизведение интерактивного контента от приложения
  Future<bool> playAppContent({
    required String appName,
    required String contentName,
    required Map<String, dynamic> appData,
  }) async {
    if (!_isInitialized) {
      return false;
    }

    return await _contentService.playInteractiveContent(
      appName: appName,
      contentName: contentName,
      appData: appData,
    );
  }

  /// Управление воспроизведением
  Future<bool> pausePlayback() async => 
      _isInitialized ? await _contentService.pausePlayback() : false;

  Future<bool> resumePlayback() async => 
      _isInitialized ? await _contentService.resumePlayback() : false;

  Future<bool> stopPlayback() async => 
      _isInitialized ? await _contentService.stopPlayback() : false;

  /// Базовые настройки (доступны гостям)
  Future<bool> setVolume(double volume) async =>
      _isInitialized ? await _contentService.setVolume(volume) : false;

  Future<bool> setBrightness(double brightness) async =>
      _isInitialized ? await _contentService.setBrightness(brightness) : false;

  /// Проверка разрешений
  bool hasPermission(FreeDomePermission permission) {
    return _authService.hasPermission(permission);
  }

  bool hasRole(FreeDomeUserRole role) {
    return _authService.hasRole(role);
  }

  /// Получение статуса системы
  Map<String, dynamic> getSystemStatus() {
    return {
      'isInitialized': _isInitialized,
      'isInitializing': _isInitializing,
      'isReady': isReady,
      'error': _error,
      'connection': _connectionService.connectionStatus.toJson(),
      'auth': _authService.getSessionInfo(),
      'content': _contentService.getUsageStats(),
      'activeDome': activeDome?.toJson(),
    };
  }

  /// Сброс состояния
  Future<void> reset() async {
    try {
      await disconnect();
      await logout();
      
      _isInitialized = false;
      _isInitializing = false;
      _error = null;
      
      // Очищаем админские сервисы
      _calibrationService = null;
      _systemService = null;
      
      notifyListeners();
      
      if (kDebugMode) {
        print('🔄 FreeDome система сброшена');
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        print('❌ Ошибка сброса FreeDome: $e');
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _connectionService.removeListener(() {});
    _authService.removeListener(() {});
    _contentService.removeListener(() {});
    
    _calibrationService?.dispose();
    _systemService?.dispose();
    
    super.dispose();
  }
}
