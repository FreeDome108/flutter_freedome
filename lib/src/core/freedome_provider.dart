import 'package:flutter/foundation.dart';
import 'connection_service.dart';
import 'auth_service.dart';
import 'content_service.dart';
import '../admin/calibration_service.dart';
import '../admin/system_service.dart';
import '../models/dome_models.dart';
import '../models/content_models.dart';
import '../fog/quantum_fog_service.dart';
import '../fog/quantum_silence_service.dart';

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

  // Квантовые системы (ленивая инициализация)
  QuantumFogService? _quantumFogService;
  QuantumSilenceService? _quantumSilenceService;

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
    _calibrationService ??= FreeDomeCalibrationService(
      connectionService: _connectionService,
      authService: _authService,
    );
    return _calibrationService;
  }

  FreeDomeSystemService? get system {
    if (!_authService.hasPermission(FreeDomePermission.systemManagement)) {
      return null;
    }
    _systemService ??= FreeDomeSystemService();
    return _systemService;
  }

  // Геттеры для квантовых систем
  QuantumFogService? get quantumFog {
    if (!_isInitialized) return null;
    _quantumFogService ??= QuantumFogService();
    return _quantumFogService;
  }

  QuantumSilenceService? get quantumSilence {
    if (!_isInitialized) return null;
    _quantumSilenceService ??= QuantumSilenceService();
    return _quantumSilenceService;
  }

  // Геттеры состояния
  bool get isInitialized => _isInitialized;
  bool get isInitializing => _isInitializing;
  String? get error => _error;
  bool get isReady => _isInitialized && !_isInitializing && _error == null;

  // Делегированные геттеры для удобства
  bool get isConnected => _connectionService.isConnected;
  bool get isAuthenticated => _authService.isAuthenticated;
  bool get isGuest => _authService.isGuest;
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
    return await _connectionService.connectToDome(nearestDome.id);
  }

  /// Подключение к конкретному куполу
  Future<bool> connectToDome(DomeSystem dome) async {
    if (!_isInitialized) {
      return false;
    }

    return await _connectionService.connectToDome(dome.id);
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
  Future<bool> playContent(dynamic content) async {
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

  // ═══════════════════════════════════════════════════════════
  // ПРЕДНАСТРОЙКИ FREEDOME SPHERE
  // ═══════════════════════════════════════════════════════════

  /// Инициализация квантовых систем
  Future<void> _initializeQuantumSystems() async {
    if (!_isInitialized) return;

    try {
      // Инициализируем систему тумана для купола
      if (quantumFog != null) {
        await quantumFog!.initialize(environment: FogEnvironment.dome);
      }

      // Инициализируем систему тишины
      if (quantumSilence != null) {
        await quantumSilence!.initialize();
      }

      if (kDebugMode) {
        print('✅ Квантовые системы инициализированы');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации квантовых систем: $e');
      }
    }
  }

  /// ПРЕДНАСТРОЙКА: "Гробовая тишина" перед сеансом
  /// 
  /// Создает полную тишину в куполе для подготовки к проекциям.
  /// Использует квантовые интерференционные паттерны для поглощения звука.
  Future<bool> presetGraveSilence({
    Duration? duration,
    bool applyLocally = false,
  }) async {
    if (!_isInitialized || quantumSilence == null) {
      if (kDebugMode) {
        print('❌ FreeDome не инициализирован или система тишины недоступна');
      }
      return false;
    }

    try {
      // Инициализируем квантовые системы если нужно
      await _initializeQuantumSystems();

      // Активируем гробовую тишину
      final success = await quantumSilence!.startGraveSilence();
      
      if (success) {
        if (kDebugMode) {
          print('🔇 ПРЕДНАСТРОЙКА: Гробовая тишина активирована');
          print('   • Полное поглощение звука (95-99%)');
          print('   • Частота: 7.83 Гц (Шуманн)');
          print('   • Назначение: Подготовка к проекциям');
          if (duration != null) {
            print('   • Длительность: ${duration.inMinutes} минут');
          }
          if (applyLocally) {
            print('   • Применяется локально');
          }
        }

        // Автоматическое отключение через указанное время
        if (duration != null) {
          Future.delayed(duration, () {
            quantumSilence?.stopAll();
            if (kDebugMode) {
              print('🔇 Гробовая тишина автоматически отключена');
            }
          });
        }
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации гробовой тишины: $e');
      }
      return false;
    }
  }

  /// ПРЕДНАСТРОЙКА: "Генерация тумана" для проекций
  /// 
  /// Создает оптимальную среду тумана для голографических проекций.
  /// Использует 108 квантовых паттернов для равномерного распределения.
  Future<bool> presetFogGeneration({
    Duration? duration,
    bool applyLocally = false,
  }) async {
    if (!_isInitialized || quantumFog == null) {
      if (kDebugMode) {
        print('❌ FreeDome не инициализирован или система тумана недоступна');
      }
      return false;
    }

    try {
      // Инициализируем квантовые системы если нужно
      await _initializeQuantumSystems();

      // Активируем генерацию тумана
      final success = await quantumFog!.startDomeFogGeneration();
      
      if (success) {
        if (kDebugMode) {
          print('🌫️ ПРЕДНАСТРОЙКА: Генерация тумана активирована');
          print('   • Плотность тумана: 0.4-0.6');
          print('   • Частота: 528 Гц (Солфеджио)');
          print('   • 108 квантовых паттернов');
          print('   • Назначение: Среда для голографических проекций');
          if (duration != null) {
            print('   • Длительность: ${duration.inMinutes} минут');
          }
          if (applyLocally) {
            print('   • Применяется локально');
          }
        }

        // Автоматическое отключение через указанное время
        if (duration != null) {
          Future.delayed(duration, () {
            quantumFog?.stopAll();
            if (kDebugMode) {
              print('🌫️ Генерация тумана автоматически отключена');
            }
          });
        }
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации генерации тумана: $e');
      }
      return false;
    }
  }

  /// ПРЕДНАСТРОЙКА: "Полное отсутствие тумана" - очистка купола
  /// 
  /// Полностью рассеивает туман и нормализует пространство купола.
  /// Использует частоту Шумана для естественной очистки.
  Future<bool> presetNoFog({
    Duration? duration,
    bool applyLocally = false,
  }) async {
    if (!_isInitialized || quantumFog == null) {
      if (kDebugMode) {
        print('❌ FreeDome не инициализирован или система тумана недоступна');
      }
      return false;
    }

    try {
      // Инициализируем квантовые системы если нужно
      await _initializeQuantumSystems();

      // Активируем рассеивание тумана
      final success = await quantumFog!.startDomeFogClearing();
      
      if (success) {
        if (kDebugMode) {
          print('🌤️ ПРЕДНАСТРОЙКА: Полное отсутствие тумана активировано');
          print('   • Рассеивание тумана: 100%');
          print('   • Частота: 7.83 Гц (Шуманн)');
          print('   • Видимость: максимальная');
          print('   • Назначение: Очистка купола');
          if (duration != null) {
            print('   • Длительность: ${duration.inMinutes} минут');
          }
          if (applyLocally) {
            print('   • Применяется локально');
          }
        }

        // Автоматическое отключение через указанное время
        if (duration != null) {
          Future.delayed(duration, () {
            quantumFog?.stopAll();
            if (kDebugMode) {
              print('🌤️ Очистка тумана автоматически отключена');
            }
          });
        }
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации очистки тумана: $e');
      }
      return false;
    }
  }

  /// ПРЕДНАСТРОЙКА: "Полный режим купола" - комбинированная настройка
  /// 
  /// Активирует генерацию тумана + нормализацию пространства.
  /// Оптимальная настройка для голографических проекций.
  Future<bool> presetFullDomeMode({
    Duration? duration,
    bool applyLocally = false,
  }) async {
    if (!_isInitialized || quantumFog == null) {
      if (kDebugMode) {
        print('❌ FreeDome не инициализирован или система тумана недоступна');
      }
      return false;
    }

    try {
      // Инициализируем квантовые системы если нужно
      await _initializeQuantumSystems();

      // Активируем полный режим купола
      final success = await quantumFog!.startDomeFullMode();
      
      if (success) {
        if (kDebugMode) {
          print('🎪 ПРЕДНАСТРОЙКА: Полный режим купола активирован');
          print('   • Генерация тумана для проекций');
          print('   • Нормализация пространства');
          print('   • Частота: 528 Гц + 341.3 Гц');
          print('   • Назначение: Оптимальная среда для проекций');
          if (duration != null) {
            print('   • Длительность: ${duration.inMinutes} минут');
          }
          if (applyLocally) {
            print('   • Применяется локально');
          }
        }

        // Автоматическое отключение через указанное время
        if (duration != null) {
          Future.delayed(duration, () {
            quantumFog?.stopAll();
            if (kDebugMode) {
              print('🎪 Полный режим купола автоматически отключен');
            }
          });
        }
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации полного режима купола: $e');
      }
      return false;
    }
  }

  /// ПРЕДНАСТРОЙКА: "Медитативная атмосфера" - мягкая настройка
  /// 
  /// Создает мягкую атмосферу с легким туманом и медитативной тишиной.
  /// Идеально для релаксации и медитации.
  Future<bool> presetMeditativeAtmosphere({
    Duration? duration,
    bool applyLocally = false,
  }) async {
    if (!_isInitialized || quantumFog == null || quantumSilence == null) {
      if (kDebugMode) {
        print('❌ FreeDome не инициализирован или квантовые системы недоступны');
      }
      return false;
    }

    try {
      // Инициализируем квантовые системы если нужно
      await _initializeQuantumSystems();

      // Активируем медитативную тишину
      final silenceSuccess = await quantumSilence!.startMeditativeSilence();
      
      // Активируем легкую генерацию тумана
      final fogSuccess = await quantumFog!.startDomeFogGeneration();
      
      final success = silenceSuccess && fogSuccess;
      
      if (success) {
        if (kDebugMode) {
          print('🧘 ПРЕДНАСТРОЙКА: Медитативная атмосфера активирована');
          print('   • Медитативная тишина (70-80%)');
          print('   • Легкий туман для атмосферы');
          print('   • Частота: 4.0 Гц + 528 Гц');
          print('   • Назначение: Релаксация и медитация');
          if (duration != null) {
            print('   • Длительность: ${duration.inMinutes} минут');
          }
          if (applyLocally) {
            print('   • Применяется локально');
          }
        }

        // Автоматическое отключение через указанное время
        if (duration != null) {
          Future.delayed(duration, () {
            quantumSilence?.stopAll();
            quantumFog?.stopAll();
            if (kDebugMode) {
              print('🧘 Медитативная атмосфера автоматически отключена');
            }
          });
        }
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации медитативной атмосферы: $e');
      }
      return false;
    }
  }

  /// Остановка всех квантовых систем
  Future<void> stopAllQuantumSystems() async {
    try {
      await Future.wait([
        quantumFog?.stopAll() ?? Future.value(),
        quantumSilence?.stopAll() ?? Future.value(),
      ]);

      if (kDebugMode) {
        print('✅ Все квантовые системы остановлены');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка остановки квантовых систем: $e');
      }
    }
  }

  /// Получение статуса квантовых систем
  Map<String, dynamic> getQuantumSystemsStatus() {
    return {
      'fog': {
        'available': quantumFog != null,
        'mode': quantumFog?.currentMode.name ?? 'idle',
        'state': quantumFog?.state.toJson(),
      },
      'silence': {
        'available': quantumSilence != null,
        'mode': quantumSilence?.currentMode.name ?? 'idle',
        'state': quantumSilence?.state.toJson(),
      },
    };
  }

  /// Сброс состояния
  Future<void> reset() async {
    try {
      await disconnect();
      await logout();
      
      // Останавливаем все квантовые системы
      await stopAllQuantumSystems();

      _isInitialized = false;
      _isInitializing = false;
      _error = null;

      // Очищаем админские сервисы
      _calibrationService = null;
      _systemService = null;
      
      // Очищаем квантовые системы
      _quantumFogService?.dispose();
      _quantumSilenceService?.dispose();
      _quantumFogService = null;
      _quantumSilenceService = null;

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
    
    // Очищаем квантовые системы
    _quantumFogService?.dispose();
    _quantumSilenceService?.dispose();

    super.dispose();
  }
}
