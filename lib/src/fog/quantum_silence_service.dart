/// Квантовая Система Поглощения Звука
///
/// Обеспечивает генерацию "гробовой тишины" для поглощения звука
/// перед сеансами отображения проекций в куполе FreeDome.
///
/// Использует квантовые интерференционные паттерны и
/// резонансные частоты для создания области полной тишины.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'quantum_silence_models.dart';
import 'quantum_silence_platform.dart';

/// Квантовая система поглощения звука
class QuantumSilenceService extends ChangeNotifier {
  final QuantumSilencePlatform _platform = QuantumSilencePlatform.instance;
  
  QuantumSilenceMode _currentMode = QuantumSilenceMode.idle;
  QuantumSilenceState _state = QuantumSilenceState.initial();
  QuantumSilenceConfig _config = const QuantumSilenceConfig();
  
  StreamSubscription<QuantumSilenceState>? _stateSubscription;
  
  /// Текущий режим работы
  QuantumSilenceMode get currentMode => _currentMode;
  
  /// Текущее состояние системы
  QuantumSilenceState get state => _state;
  
  /// Текущая конфигурация
  QuantumSilenceConfig get config => _config;
  
  /// Доступные режимы
  List<QuantumSilenceMode> get availableModes => [
    QuantumSilenceMode.graveSilence,
    QuantumSilenceMode.meditativeSilence,
    QuantumSilenceMode.focusSilence,
    QuantumSilenceMode.quantumSilence,
    QuantumSilenceMode.adaptiveSilence,
  ];
  
  /// Инициализация сервиса
  Future<void> initialize({
    QuantumSilenceConfig? config,
  }) async {
    if (config != null) {
      _config = config;
    }
    
    try {
      await _platform.initialize(config: _config);
      
      // Подписка на обновления состояния
      _stateSubscription = _platform.stateStream.listen((state) {
        _state = state;
        notifyListeners();
      });
      
      if (kDebugMode) {
        print('✅ QuantumSilenceService инициализирован');
        print('   Целевой уровень тишины: ${_config.targetSilenceLevel * 100}%');
        print('   Адаптивный режим: ${_config.adaptiveMode}');
        print('   Квантовая когерентность: ${_config.quantumCoherence}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации QuantumSilenceService: $e');
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
  // РЕЖИМЫ ПОГЛОЩЕНИЯ ЗВУКА
  // ═══════════════════════════════════════════════════════════
  
  /// Запуск "гробовой тишины" - полное поглощение звука
  Future<bool> startGraveSilence() async {
    try {
      await _platform.startMode(QuantumSilenceMode.graveSilence);
      _currentMode = QuantumSilenceMode.graveSilence;
      notifyListeners();
      
      if (kDebugMode) {
        print('🔇 Гробовая тишина активирована');
        print('   • Полное поглощение звука');
        print('   • Частота: 7.83 Гц (Шуманн)');
        print('   • Уровень тишины: 95-99%');
        print('   • Назначение: Подготовка к проекциям');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации гробовой тишины: $e');
      }
      return false;
    }
  }
  
  /// Запуск медитативной тишины - мягкое поглощение
  Future<bool> startMeditativeSilence() async {
    try {
      await _platform.startMode(QuantumSilenceMode.meditativeSilence);
      _currentMode = QuantumSilenceMode.meditativeSilence;
      notifyListeners();
      
      if (kDebugMode) {
        print('🧘 Медитативная тишина активирована');
        print('   • Мягкое поглощение звука');
        print('   • Частота: 4.0 Гц (Тета-волны)');
        print('   • Уровень тишины: 70-80%');
        print('   • Назначение: Медитация и релаксация');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации медитативной тишины: $e');
      }
      return false;
    }
  }
  
  /// Запуск фокусной тишины - поглощение отвлекающих звуков
  Future<bool> startFocusSilence() async {
    try {
      await _platform.startMode(QuantumSilenceMode.focusSilence);
      _currentMode = QuantumSilenceMode.focusSilence;
      notifyListeners();
      
      if (kDebugMode) {
        print('🎯 Фокусная тишина активирована');
        print('   • Поглощение отвлекающих звуков');
        print('   • Частота: 20.0 Гц (Бета-волны)');
        print('   • Уровень тишины: 60-70%');
        print('   • Назначение: Концентрация и работа');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации фокусной тишины: $e');
      }
      return false;
    }
  }
  
  /// Запуск квантовой тишины - максимальная когерентность
  Future<bool> startQuantumSilence() async {
    try {
      await _platform.startMode(QuantumSilenceMode.quantumSilence);
      _currentMode = QuantumSilenceMode.quantumSilence;
      notifyListeners();
      
      if (kDebugMode) {
        print('⚛️ Квантовая тишина активирована');
        print('   • Максимальная когерентность');
        print('   • Частота: 528 Гц (Солфеджио)');
        print('   • Уровень тишины: 90-95%');
        print('   • Назначение: Квантовые эксперименты');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации квантовой тишины: $e');
      }
      return false;
    }
  }
  
  /// Запуск адаптивной тишины - автоматическая настройка
  Future<bool> startAdaptiveSilence() async {
    try {
      await _platform.startMode(QuantumSilenceMode.adaptiveSilence);
      _currentMode = QuantumSilenceMode.adaptiveSilence;
      notifyListeners();
      
      if (kDebugMode) {
        print('🔄 Адаптивная тишина активирована');
        print('   • Автоматическая настройка');
        print('   • Анализ окружающих звуков');
        print('   • Динамическое поглощение');
        print('   • Назначение: Универсальное использование');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации адаптивной тишины: $e');
      }
      return false;
    }
  }
  
  /// Остановка всех систем поглощения звука
  Future<void> stopAll() async {
    try {
      await _platform.stopAll();
      _currentMode = QuantumSilenceMode.idle;
      notifyListeners();
      
      if (kDebugMode) {
        print('✅ Все системы поглощения звука остановлены');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка остановки систем: $e');
      }
    }
  }
  
  /// Получение списка паттернов поглощения звука
  Future<List<QuantumSilencePattern>> getSilencePatterns() async {
    try {
      return await _platform.getSilencePatterns();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения паттернов: $e');
      }
      return [];
    }
  }
  
  /// Установка конфигурации
  Future<void> setConfig(QuantumSilenceConfig config) async {
    try {
      await _platform.setConfig(config);
      _config = config;
      notifyListeners();
      
      if (kDebugMode) {
        print('✅ Конфигурация обновлена');
        print('   Целевой уровень тишины: ${config.targetSilenceLevel * 100}%');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления конфигурации: $e');
      }
    }
  }
  
  /// Установка целевого уровня тишины
  Future<void> setTargetSilenceLevel(double level) async {
    final newConfig = QuantumSilenceConfig(
      targetSilenceLevel: level.clamp(0.0, 1.0),
      maxAmplitude: _config.maxAmplitude,
      resonanceBandwidth: _config.resonanceBandwidth,
      adaptiveMode: _config.adaptiveMode,
      quantumCoherence: _config.quantumCoherence,
      fadeInDuration: _config.fadeInDuration,
      fadeOutDuration: _config.fadeOutDuration,
    );
    
    await setConfig(newConfig);
  }
  
  /// Активация квантовой когерентности
  Future<void> enableQuantumCoherence() async {
    final newConfig = QuantumSilenceConfig(
      targetSilenceLevel: _config.targetSilenceLevel,
      maxAmplitude: _config.maxAmplitude,
      resonanceBandwidth: _config.resonanceBandwidth,
      adaptiveMode: _config.adaptiveMode,
      quantumCoherence: true,
      fadeInDuration: _config.fadeInDuration,
      fadeOutDuration: _config.fadeOutDuration,
    );
    
    await setConfig(newConfig);
  }
  
  /// Получение текущего уровня тишины
  double get currentSilenceLevel => _state.silenceLevel;
  
  /// Получение уровня поглощения звука
  double get soundAbsorptionLevel => _state.soundAbsorption;
  
  /// Получение уровня фонового шума
  double get ambientNoiseLevel => _state.ambientNoise;
  
  /// Проверка активности системы
  bool get isActive => _state.isActive;
  
  /// Проверка достижения целевого уровня тишины
  bool get isTargetSilenceReached => 
      _state.silenceLevel >= _config.targetSilenceLevel;
}
