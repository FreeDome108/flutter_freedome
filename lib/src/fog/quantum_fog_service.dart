/// Квантовая Система Управления Туманом
///
/// Обеспечивает управление туманом для купола FreeDome и транспортных средств:
/// - Генерация тумана (для купола)
/// - Рассеивание тумана (для купола и транспорта)
/// - Нормализация пространства (для купола)
/// - Сбор водорода H₂ (developer mode)
///
/// Использует 108 квантовых интерференционных паттернов и
/// ультразвуковую модуляцию с частотой Шумана (7.83 Гц).

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'quantum_fog_models.dart';
import 'quantum_fog_platform.dart';

// FogSystemMode enum is now defined in quantum_fog_models.dart

/// Окружение работы системы
enum FogEnvironment {
  dome, // Купол FreeDome
  vehicle, // Транспортное средство
}

/// Квантовая система управления туманом
class QuantumFogService extends ChangeNotifier {
  final QuantumFogPlatform _platform = QuantumFogPlatform.instance;

  FogSystemMode _currentMode = FogSystemMode.idle;
  FogEnvironment _environment = FogEnvironment.vehicle;
  bool _developerMode = false;
  FogSystemState _state = FogSystemState.initial();

  StreamSubscription<FogSystemState>? _stateSubscription;

  /// Текущий режим работы
  FogSystemMode get currentMode => _currentMode;

  /// Текущее окружение
  FogEnvironment get environment => _environment;

  /// Включен ли режим разработчика
  bool get developerMode => _developerMode;

  /// Текущее состояние системы
  FogSystemState get state => _state;

  /// Доступные режимы для текущего окружения
  List<FogSystemMode> get availableModes {
    if (_environment == FogEnvironment.dome) {
      return [
        FogSystemMode.domeFogGeneration,
        FogSystemMode.domeFogClearing,
        FogSystemMode.domeSpaceNormalization,
        FogSystemMode.domeFull,
      ];
    } else {
      // Транспорт
      final modes = <FogSystemMode>[FogSystemMode.vehicleFogTunnel];

      if (_developerMode) {
        modes.addAll([
          FogSystemMode.devH2Harvest,
          FogSystemMode.devFogGeneration,
        ]);
      }

      return modes;
    }
  }

  /// Инициализация сервиса
  Future<void> initialize({
    required FogEnvironment environment,
    bool developerMode = false,
  }) async {
    _environment = environment;
    _developerMode = developerMode;

    try {
      await _platform.initialize(
        environment: environment == FogEnvironment.dome ? 'dome' : 'vehicle',
        developerMode: developerMode,
      );

      // Подписка на обновления состояния
      _stateSubscription = _platform.stateStream.listen((state) {
        _state = state;
        notifyListeners();
      });

      if (kDebugMode) {
        print('✅ QuantumFogService инициализирован');
        print('   Окружение: ${environment.name}');
        print('   Developer mode: $developerMode');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации QuantumFogService: $e');
      }
      rethrow;
    }
  }

  /// Освобождение ресурсов
  @override
  void dispose() {
    _stateSubscription?.cancel();
    _platform.cleanup();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════
  // РЕЖИМЫ ДЛЯ КУПОЛА FREEDOME
  // ═══════════════════════════════════════════════════════════

  /// Запуск генерации тумана (только для купола)
  Future<bool> startDomeFogGeneration() async {
    if (_environment != FogEnvironment.dome) {
      if (kDebugMode) {
        print('⚠️ Генерация тумана доступна только в куполе FreeDome!');
      }
      return false;
    }

    try {
      await _platform.startMode(FogSystemMode.domeFogGeneration);
      _currentMode = FogSystemMode.domeFogGeneration;
      notifyListeners();

      if (kDebugMode) {
        print('✅ Генерация тумана активна');
        print('   Частота: 528 Гц (Солфеджио)');
        print('   Назначение: Среда для голографических проекций');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка запуска генерации тумана: $e');
      }
      return false;
    }
  }

  /// Запуск рассеивания тумана в куполе
  Future<bool> startDomeFogClearing() async {
    if (_environment != FogEnvironment.dome) {
      if (kDebugMode) {
        print('⚠️ Этот режим доступен только в куполе FreeDome!');
      }
      return false;
    }

    try {
      await _platform.startMode(FogSystemMode.domeFogClearing);
      _currentMode = FogSystemMode.domeFogClearing;
      notifyListeners();

      if (kDebugMode) {
        print('✅ Очистка купола активна');
        print('   Частота: 7.83 Гц (Шуманн)');
        print('   Время очистки: ~5-10 минут');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка запуска рассеивания: $e');
      }
      return false;
    }
  }

  /// Запуск нормализации пространства (только для купола)
  Future<bool> startDomeSpaceNormalization() async {
    if (_environment != FogEnvironment.dome) {
      if (kDebugMode) {
        print('⚠️ Нормализация доступна только в куполе FreeDome!');
      }
      return false;
    }

    try {
      await _platform.startMode(FogSystemMode.domeSpaceNormalization);
      _currentMode = FogSystemMode.domeSpaceNormalization;
      notifyListeners();

      if (kDebugMode) {
        print('✅ Нормализация пространства активна');
        print('   Частота: 341.3 Гц (Сердечная чакра)');
        print('   108 квантовых паттернов для гармонизации');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка запуска нормализации: $e');
      }
      return false;
    }
  }

  /// Запуск полного режима купола
  Future<bool> startDomeFullMode() async {
    if (_environment != FogEnvironment.dome) {
      if (kDebugMode) {
        print('⚠️ Полный режим доступен только в куполе FreeDome!');
      }
      return false;
    }

    try {
      await _platform.startMode(FogSystemMode.domeFull);
      _currentMode = FogSystemMode.domeFull;
      notifyListeners();

      if (kDebugMode) {
        print('✅ Полный режим купола активен');
        print('   • Генерация тумана для проекций');
        print('   • Нормализация пространства');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка запуска полного режима: $e');
      }
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // РЕЖИМЫ ДЛЯ ТРАНСПОРТА
  // ═══════════════════════════════════════════════════════════

  /// Запуск рассеивания тумана на дороге (безопасный режим)
  Future<bool> startVehicleFogTunnel() async {
    try {
      await _platform.startMode(FogSystemMode.vehicleFogTunnel);
      _currentMode = FogSystemMode.vehicleFogTunnel;
      notifyListeners();

      if (kDebugMode) {
        print('✅ Режим Fog Tunnel активен');
        print('   • Частота: 7.83 Гц (Шуманн)');
        print('   • Туннель: 1.5-2 м');
        print('   • Видимость: +30-50%');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка запуска Fog Tunnel: $e');
      }
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // РЕЖИМЫ РАЗРАБОТЧИКА
  // ═══════════════════════════════════════════════════════════

  /// Запуск сбора водорода (требует developer_mode)
  Future<bool> startDevH2Harvest() async {
    if (!_developerMode) {
      if (kDebugMode) {
        print('⛔ ДОСТУП ЗАПРЕЩЕН: H₂ HARVEST');
        print('   Требуется developer_mode!');
      }
      return false;
    }

    try {
      await _platform.startMode(FogSystemMode.devH2Harvest);
      _currentMode = FogSystemMode.devH2Harvest;
      notifyListeners();

      if (kDebugMode) {
        print('✅ [DEV] Режим H₂ Harvest активен');
        print('   ⚠️ ВНИМАНИЕ: Экспериментальный режим!');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка запуска H₂ Harvest: $e');
      }
      return false;
    }
  }

  /// Запуск генерации тумана на транспорте (ОПАСНО!)
  Future<bool> startDevFogGeneration({bool confirmed = false}) async {
    if (!_developerMode) {
      if (kDebugMode) {
        print('⛔ ДОСТУП ЗАПРЕЩЕН: FOG GENERATION');
        print('   Требуется developer_mode!');
      }
      return false;
    }

    if (_environment == FogEnvironment.vehicle && !confirmed) {
      if (kDebugMode) {
        print('⚠️ ПРЕДУПРЕЖДЕНИЕ: Генерация тумана на дороге ОПАСНА!');
        print('   Используйте только для тестов в безопасных условиях!');
        print('   Для активации вызовите с confirmed: true');
      }
      return false;
    }

    try {
      await _platform.startMode(FogSystemMode.devFogGeneration);
      _currentMode = FogSystemMode.devFogGeneration;
      notifyListeners();

      if (kDebugMode) {
        print('✅ [DEV] Генерация тумана активна');
        print('   ⚠️ ОСТОРОЖНО: Не используйте во время движения!');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка запуска генерации тумана: $e');
      }
      return false;
    }
  }

  /// Остановка всех систем
  Future<void> stopAll() async {
    try {
      await _platform.stopAll();
      _currentMode = FogSystemMode.idle;
      notifyListeners();

      if (kDebugMode) {
        print('✅ Все системы тумана остановлены');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка остановки систем: $e');
      }
    }
  }

  /// Получение списка 108 квантовых паттернов
  Future<List<QuantumPattern>> getQuantumPatterns() async {
    try {
      return await _platform.getQuantumPatterns();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения паттернов: $e');
      }
      return [];
    }
  }

  /// Установка частоты модуляции
  Future<void> setModulationFrequency(double frequency) async {
    try {
      await _platform.setModulationFrequency(frequency);
      if (kDebugMode) {
        print('✅ Частота модуляции: $frequency Гц');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки частоты: $e');
      }
    }
  }

  /// Аварийный сброс давления H₂
  Future<void> emergencyH2Vent() async {
    try {
      await _platform.emergencyH2Vent();
      if (kDebugMode) {
        print('⚠️ Аварийный сброс H₂ выполнен!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка аварийного сброса: $e');
      }
    }
  }
}
