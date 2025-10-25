/// Модели данных для квантовой системы поглощения звука

import 'package:flutter/foundation.dart';

/// Квантовый паттерн поглощения звука
@immutable
class QuantumSilencePattern {
  final int id;
  final String name;
  final double frequency; // Частота поглощения (Гц)
  final double amplitude; // Амплитуда (0.0-1.0)
  final double phase; // Фаза (радианы)
  final double absorptionRate; // Коэффициент поглощения (0.0-1.0)
  final double resonanceFactor; // Фактор резонанса
  final String description;

  const QuantumSilencePattern({
    required this.id,
    required this.name,
    required this.frequency,
    required this.amplitude,
    required this.phase,
    required this.absorptionRate,
    required this.resonanceFactor,
    required this.description,
  });

  factory QuantumSilencePattern.fromJson(Map<String, dynamic> json) {
    return QuantumSilencePattern(
      id: json['id'] as int,
      name: json['name'] as String,
      frequency: (json['frequency'] as num).toDouble(),
      amplitude: (json['amplitude'] as num).toDouble(),
      phase: (json['phase'] as num).toDouble(),
      absorptionRate: (json['absorption_rate'] as num).toDouble(),
      resonanceFactor: (json['resonance_factor'] as num).toDouble(),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
      'amplitude': amplitude,
      'phase': phase,
      'absorption_rate': absorptionRate,
      'resonance_factor': resonanceFactor,
      'description': description,
    };
  }
}

/// Состояние системы поглощения звука
@immutable
class QuantumSilenceState {
  final String mode;
  final bool isActive;
  final double silenceLevel; // Уровень тишины (0.0-1.0)
  final double soundAbsorption; // Поглощение звука (%)
  final double ambientNoise; // Фоновый шум (дБ)
  final double quantumCoherence; // Квантовая когерентность (%)
  final double resonanceStability; // Стабильность резонанса (%)
  final String? activePattern;
  final String? errorState;
  final DateTime timestamp;

  const QuantumSilenceState({
    required this.mode,
    required this.isActive,
    required this.silenceLevel,
    required this.soundAbsorption,
    required this.ambientNoise,
    required this.quantumCoherence,
    required this.resonanceStability,
    this.activePattern,
    this.errorState,
    required this.timestamp,
  });

  factory QuantumSilenceState.initial() {
    return QuantumSilenceState(
      mode: 'idle',
      isActive: false,
      silenceLevel: 0.0,
      soundAbsorption: 0.0,
      ambientNoise: 40.0, // Типичный фоновый шум
      quantumCoherence: 99.7,
      resonanceStability: 100.0,
      activePattern: null,
      errorState: null,
      timestamp: DateTime.now(),
    );
  }

  factory QuantumSilenceState.fromJson(Map<String, dynamic> json) {
    return QuantumSilenceState(
      mode: json['mode'] as String,
      isActive: json['is_active'] as bool,
      silenceLevel: (json['silence_level'] as num).toDouble(),
      soundAbsorption: (json['sound_absorption'] as num).toDouble(),
      ambientNoise: (json['ambient_noise'] as num).toDouble(),
      quantumCoherence: (json['quantum_coherence'] as num).toDouble(),
      resonanceStability: (json['resonance_stability'] as num).toDouble(),
      activePattern: json['active_pattern'] as String?,
      errorState: json['error_state'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode,
      'is_active': isActive,
      'silence_level': silenceLevel,
      'sound_absorption': soundAbsorption,
      'ambient_noise': ambientNoise,
      'quantum_coherence': quantumCoherence,
      'resonance_stability': resonanceStability,
      'active_pattern': activePattern,
      'error_state': errorState,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  QuantumSilenceState copyWith({
    String? mode,
    bool? isActive,
    double? silenceLevel,
    double? soundAbsorption,
    double? ambientNoise,
    double? quantumCoherence,
    double? resonanceStability,
    String? activePattern,
    String? errorState,
    DateTime? timestamp,
  }) {
    return QuantumSilenceState(
      mode: mode ?? this.mode,
      isActive: isActive ?? this.isActive,
      silenceLevel: silenceLevel ?? this.silenceLevel,
      soundAbsorption: soundAbsorption ?? this.soundAbsorption,
      ambientNoise: ambientNoise ?? this.ambientNoise,
      quantumCoherence: quantumCoherence ?? this.quantumCoherence,
      resonanceStability: resonanceStability ?? this.resonanceStability,
      activePattern: activePattern,
      errorState: errorState,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

/// Режимы поглощения звука
enum QuantumSilenceMode {
  idle,

  /// Гробовая тишина - полное поглощение звука
  graveSilence,

  /// Медитативная тишина - мягкое поглощение
  meditativeSilence,

  /// Фокусная тишина - поглощение отвлекающих звуков
  focusSilence,

  /// Квантовая тишина - максимальная когерентность
  quantumSilence,

  /// Адаптивная тишина - автоматическая настройка
  adaptiveSilence,

  error,
}

/// Частоты для поглощения звука
class QuantumSilenceFrequencies {
  // Основные частоты поглощения
  static const double schumann = 7.83; // Частота Шумана
  static const double theta = 4.0; // Тета-волны (медитация)
  static const double alpha = 10.0; // Альфа-волны (расслабление)
  static const double beta = 20.0; // Бета-волны (фокус)
  static const double gamma = 40.0; // Гамма-волны (когниция)

  // Резонансные частоты для поглощения
  static const double humanVoice = 200.0; // Человеческий голос
  static const double trafficNoise = 1000.0; // Дорожный шум
  static const double constructionNoise = 2000.0; // Строительный шум
  static const double electronicNoise = 5000.0; // Электронный шум

  // Квантовые частоты
  static const double quantumResonance = 528.0; // Солфеджио 528
  static const double heartCoherence = 341.3; // Сердечная когерентность
  static const double goldenRatio = 432.0; // Золотое сечение
  static const double sacredGeometry = 963.0; // Сакральная геометрия
}

/// Конфигурация системы поглощения звука
@immutable
class QuantumSilenceConfig {
  final double targetSilenceLevel; // Целевой уровень тишины (0.0-1.0)
  final double maxAmplitude; // Максимальная амплитуда
  final double resonanceBandwidth; // Полоса резонанса
  final bool adaptiveMode; // Адаптивный режим
  final bool quantumCoherence; // Квантовая когерентность
  final Duration fadeInDuration; // Время нарастания
  final Duration fadeOutDuration; // Время затухания

  const QuantumSilenceConfig({
    this.targetSilenceLevel = 0.95,
    this.maxAmplitude = 0.8,
    this.resonanceBandwidth = 0.1,
    this.adaptiveMode = true,
    this.quantumCoherence = true,
    this.fadeInDuration = const Duration(seconds: 5),
    this.fadeOutDuration = const Duration(seconds: 3),
  });

  factory QuantumSilenceConfig.fromJson(Map<String, dynamic> json) {
    return QuantumSilenceConfig(
      targetSilenceLevel: (json['target_silence_level'] as num).toDouble(),
      maxAmplitude: (json['max_amplitude'] as num).toDouble(),
      resonanceBandwidth: (json['resonance_bandwidth'] as num).toDouble(),
      adaptiveMode: json['adaptive_mode'] as bool,
      quantumCoherence: json['quantum_coherence'] as bool,
      fadeInDuration: Duration(milliseconds: json['fade_in_duration'] as int),
      fadeOutDuration: Duration(milliseconds: json['fade_out_duration'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target_silence_level': targetSilenceLevel,
      'max_amplitude': maxAmplitude,
      'resonance_bandwidth': resonanceBandwidth,
      'adaptive_mode': adaptiveMode,
      'quantum_coherence': quantumCoherence,
      'fade_in_duration': fadeInDuration.inMilliseconds,
      'fade_out_duration': fadeOutDuration.inMilliseconds,
    };
  }
}
