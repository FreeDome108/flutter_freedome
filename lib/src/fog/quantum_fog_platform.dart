/// Platform interface для квантовой системы тумана
/// Связывает Dart код с C++ реализацией

import 'dart:async';
import 'package:flutter/services.dart';
import 'quantum_fog_models.dart';

class QuantumFogPlatform {
  static const MethodChannel _channel = MethodChannel(
    'flutter_freedome/quantum_fog',
  );
  static const EventChannel _stateChannel = EventChannel(
    'flutter_freedome/quantum_fog/state',
  );

  static QuantumFogPlatform? _instance;

  static QuantumFogPlatform get instance {
    _instance ??= QuantumFogPlatform._();
    return _instance!;
  }

  QuantumFogPlatform._();

  Stream<FogSystemState>? _stateStream;

  /// Поток обновлений состояния
  Stream<FogSystemState> get stateStream {
    _stateStream ??= _stateChannel.receiveBroadcastStream().map((
      dynamic event,
    ) {
      if (event is Map) {
        return FogSystemState.fromJson(Map<String, dynamic>.from(event));
      }
      return FogSystemState.initial();
    });

    return _stateStream!;
  }

  /// Инициализация системы
  Future<void> initialize({
    required String environment,
    required bool developerMode,
  }) async {
    try {
      await _channel.invokeMethod('initialize', {
        'environment': environment,
        'developer_mode': developerMode,
      });
    } on PlatformException catch (e) {
      throw Exception('Failed to initialize: ${e.message}');
    }
  }

  /// Запуск режима
  Future<void> startMode(FogSystemMode mode) async {
    try {
      await _channel.invokeMethod('startMode', {'mode': _modeToString(mode)});
    } on PlatformException catch (e) {
      throw Exception('Failed to start mode: ${e.message}');
    }
  }

  /// Остановка всех систем
  Future<void> stopAll() async {
    try {
      await _channel.invokeMethod('stopAll');
    } on PlatformException catch (e) {
      throw Exception('Failed to stop: ${e.message}');
    }
  }

  /// Получение квантовых паттернов
  Future<List<QuantumPattern>> getQuantumPatterns() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'getQuantumPatterns',
      );
      return result
          .map(
            (json) => QuantumPattern.fromJson(Map<String, dynamic>.from(json)),
          )
          .toList();
    } on PlatformException catch (e) {
      throw Exception('Failed to get patterns: ${e.message}');
    }
  }

  /// Установка частоты модуляции
  Future<void> setModulationFrequency(double frequency) async {
    try {
      await _channel.invokeMethod('setModulationFrequency', {
        'frequency': frequency,
      });
    } on PlatformException catch (e) {
      throw Exception('Failed to set frequency: ${e.message}');
    }
  }

  /// Аварийный сброс H₂
  Future<void> emergencyH2Vent() async {
    try {
      await _channel.invokeMethod('emergencyH2Vent');
    } on PlatformException catch (e) {
      throw Exception('Failed to emergency vent: ${e.message}');
    }
  }

  /// Очистка ресурсов
  Future<void> cleanup() async {
    try {
      await _channel.invokeMethod('cleanup');
    } on PlatformException catch (e) {
      throw Exception('Failed to cleanup: ${e.message}');
    }
  }

  // Преобразование enum в string
  String _modeToString(FogSystemMode mode) {
    switch (mode) {
      case FogSystemMode.idle:
        return 'idle';
      case FogSystemMode.domeFogGeneration:
        return 'dome_fog_generation';
      case FogSystemMode.domeFogClearing:
        return 'dome_fog_clearing';
      case FogSystemMode.domeSpaceNormalization:
        return 'dome_normalization';
      case FogSystemMode.domeFull:
        return 'dome_full';
      case FogSystemMode.vehicleFogTunnel:
        return 'vehicle_fog_tunnel';
      case FogSystemMode.devH2Harvest:
        return 'dev_h2_harvest';
      case FogSystemMode.devFogGeneration:
        return 'dev_fog_generation';
      case FogSystemMode.error:
        return 'error';
    }
  }
}
