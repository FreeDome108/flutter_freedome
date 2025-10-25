/// Модели данных для квантовой системы тумана

import 'package:flutter/foundation.dart';

/// Режимы работы системы тумана
enum FogSystemMode {
  idle,
  domeFogGeneration,
  domeFogClearing,
  domeSpaceNormalization,
  domeFull,
  vehicleFogTunnel,
  devH2Harvest,
  devFogGeneration,
  error,
}

/// Квантовый интерференционный паттерн
@immutable
class QuantumPattern {
  final int id;
  final int face; // Грань пирамиды (0-3)
  final double angle; // Угол наблюдения (градусы)
  final double azimuth; // Азимут (градусы)
  final double intensity; // Интенсивность (0.0-1.0)
  final double phaseShift; // Фазовый сдвиг (радианы)
  final double frequency; // Резонансная частота (Гц)

  const QuantumPattern({
    required this.id,
    required this.face,
    required this.angle,
    required this.azimuth,
    required this.intensity,
    required this.phaseShift,
    required this.frequency,
  });

  factory QuantumPattern.fromJson(Map<String, dynamic> json) {
    return QuantumPattern(
      id: json['id'] as int,
      face: json['face'] as int,
      angle: (json['angle'] as num).toDouble(),
      azimuth: (json['azimuth'] as num).toDouble(),
      intensity: (json['intensity'] as num).toDouble(),
      phaseShift: (json['phase_shift'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'face': face,
      'angle': angle,
      'azimuth': azimuth,
      'intensity': intensity,
      'phase_shift': phaseShift,
      'frequency': frequency,
    };
  }
}

/// Состояние системы тумана
@immutable
class FogSystemState {
  final String mode;
  final String environment;
  final bool developerMode;
  final double fogDensity; // 0.0-1.0
  final double visibility; // метры
  final double h2ProductionRate; // л/час
  final double h2TankPressure; // bar
  final double h2TankLevel; // %
  final double powerConsumption; // W
  final double quantumCoherence; // %
  final double spaceQuality; // % (для купола)
  final String? errorState;
  final DateTime timestamp;

  const FogSystemState({
    required this.mode,
    required this.environment,
    required this.developerMode,
    required this.fogDensity,
    required this.visibility,
    required this.h2ProductionRate,
    required this.h2TankPressure,
    required this.h2TankLevel,
    required this.powerConsumption,
    required this.quantumCoherence,
    required this.spaceQuality,
    this.errorState,
    required this.timestamp,
  });

  factory FogSystemState.initial() {
    return FogSystemState(
      mode: 'idle',
      environment: 'vehicle',
      developerMode: false,
      fogDensity: 0.0,
      visibility: 100.0,
      h2ProductionRate: 0.0,
      h2TankPressure: 0.0,
      h2TankLevel: 0.0,
      powerConsumption: 0.0,
      quantumCoherence: 99.7,
      spaceQuality: 100.0,
      errorState: null,
      timestamp: DateTime.now(),
    );
  }

  factory FogSystemState.fromJson(Map<String, dynamic> json) {
    return FogSystemState(
      mode: json['mode'] as String,
      environment: json['environment'] as String,
      developerMode: json['developer_mode'] as bool,
      fogDensity: (json['fog_density'] as num).toDouble(),
      visibility: (json['visibility'] as num).toDouble(),
      h2ProductionRate: (json['h2_production_rate'] as num).toDouble(),
      h2TankPressure: (json['h2_tank_pressure'] as num).toDouble(),
      h2TankLevel: (json['h2_tank_level'] as num).toDouble(),
      powerConsumption: (json['power_consumption'] as num).toDouble(),
      quantumCoherence: (json['quantum_coherence'] as num).toDouble(),
      spaceQuality: (json['space_quality'] as num).toDouble(),
      errorState: json['error_state'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode,
      'environment': environment,
      'developer_mode': developerMode,
      'fog_density': fogDensity,
      'visibility': visibility,
      'h2_production_rate': h2ProductionRate,
      'h2_tank_pressure': h2TankPressure,
      'h2_tank_level': h2TankLevel,
      'power_consumption': powerConsumption,
      'quantum_coherence': quantumCoherence,
      'space_quality': spaceQuality,
      'error_state': errorState,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  FogSystemState copyWith({
    String? mode,
    String? environment,
    bool? developerMode,
    double? fogDensity,
    double? visibility,
    double? h2ProductionRate,
    double? h2TankPressure,
    double? h2TankLevel,
    double? powerConsumption,
    double? quantumCoherence,
    double? spaceQuality,
    String? errorState,
    DateTime? timestamp,
  }) {
    return FogSystemState(
      mode: mode ?? this.mode,
      environment: environment ?? this.environment,
      developerMode: developerMode ?? this.developerMode,
      fogDensity: fogDensity ?? this.fogDensity,
      visibility: visibility ?? this.visibility,
      h2ProductionRate: h2ProductionRate ?? this.h2ProductionRate,
      h2TankPressure: h2TankPressure ?? this.h2TankPressure,
      h2TankLevel: h2TankLevel ?? this.h2TankLevel,
      powerConsumption: powerConsumption ?? this.powerConsumption,
      quantumCoherence: quantumCoherence ?? this.quantumCoherence,
      spaceQuality: spaceQuality ?? this.spaceQuality,
      errorState: errorState,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

/// Квантовые частоты
class QuantumFrequencies {
  static const double schumann = 7.83; // Частота Шумана
  static const double solfeggio528 = 528.0; // Солфеджио
  static const double solfeggio741 = 741.0;
  static const double solfeggio852 = 852.0;
  static const double solfeggio963 = 963.0;
  static const double chakraRoot = 256.0; // Чакры
  static const double chakraSacral = 288.0;
  static const double chakraSolar = 320.0;
  static const double chakraHeart = 341.3;
  static const double chakraThroat = 384.0;
  static const double chakraThirdEye = 426.7;
  static const double chakraCrown = 480.0;
  static const double ultrasonicCarrier = 1000000.0; // 1 МГц
}
