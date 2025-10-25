/// Platform interface для квантовой системы поглощения звука

import 'dart:async';
import 'package:flutter/services.dart';
import 'quantum_silence_models.dart';

/// Platform interface для квантового поглощения звука
class QuantumSilencePlatform {
  static const MethodChannel _channel = MethodChannel('flutter_freedome/quantum_silence');
  static const EventChannel _stateChannel = EventChannel('flutter_freedome/quantum_silence/state');
  
  static final QuantumSilencePlatform _instance = QuantumSilencePlatform._internal();
  factory QuantumSilencePlatform() => _instance;
  QuantumSilencePlatform._internal();
  
  static QuantumSilencePlatform get instance => _instance;
  
  /// Инициализация системы
  Future<void> initialize({required QuantumSilenceConfig config}) async {
    try {
      await _channel.invokeMethod('initialize', config.toJson());
    } catch (e) {
      throw Exception('Ошибка инициализации QuantumSilence: $e');
    }
  }
  
  /// Запуск режима поглощения звука
  Future<void> startMode(QuantumSilenceMode mode) async {
    try {
      await _channel.invokeMethod('startMode', {'mode': mode.name});
    } catch (e) {
      throw Exception('Ошибка запуска режима ${mode.name}: $e');
    }
  }
  
  /// Остановка всех систем
  Future<void> stopAll() async {
    try {
      await _channel.invokeMethod('stopAll');
    } catch (e) {
      throw Exception('Ошибка остановки систем: $e');
    }
  }
  
  /// Получение паттернов поглощения звука
  Future<List<QuantumSilencePattern>> getSilencePatterns() async {
    try {
      final result = await _channel.invokeMethod('getSilencePatterns');
      final List<dynamic> patternsJson = result as List<dynamic>;
      return patternsJson
          .map((json) => QuantumSilencePattern.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Ошибка получения паттернов: $e');
    }
  }
  
  /// Установка конфигурации
  Future<void> setConfig(QuantumSilenceConfig config) async {
    try {
      await _channel.invokeMethod('setConfig', config.toJson());
    } catch (e) {
      throw Exception('Ошибка установки конфигурации: $e');
    }
  }
  
  /// Установка частоты поглощения
  Future<void> setAbsorptionFrequency(double frequency) async {
    try {
      await _channel.invokeMethod('setAbsorptionFrequency', {'frequency': frequency});
    } catch (e) {
      throw Exception('Ошибка установки частоты: $e');
    }
  }
  
  /// Установка амплитуды поглощения
  Future<void> setAbsorptionAmplitude(double amplitude) async {
    try {
      await _channel.invokeMethod('setAbsorptionAmplitude', {'amplitude': amplitude});
    } catch (e) {
      throw Exception('Ошибка установки амплитуды: $e');
    }
  }
  
  /// Активация квантовой когерентности
  Future<void> enableQuantumCoherence() async {
    try {
      await _channel.invokeMethod('enableQuantumCoherence');
    } catch (e) {
      throw Exception('Ошибка активации квантовой когерентности: $e');
    }
  }
  
  /// Деактивация квантовой когерентности
  Future<void> disableQuantumCoherence() async {
    try {
      await _channel.invokeMethod('disableQuantumCoherence');
    } catch (e) {
      throw Exception('Ошибка деактивации квантовой когерентности: $e');
    }
  }
  
  /// Получение текущего состояния
  Future<QuantumSilenceState> getCurrentState() async {
    try {
      final result = await _channel.invokeMethod('getCurrentState');
      return QuantumSilenceState.fromJson(result as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Ошибка получения состояния: $e');
    }
  }
  
  /// Stream состояния системы
  Stream<QuantumSilenceState> get stateStream {
    return _stateChannel.receiveBroadcastStream().map((data) {
      if (data is Map<String, dynamic>) {
        return QuantumSilenceState.fromJson(data);
      }
      throw Exception('Неверный формат данных состояния');
    });
  }
  
  /// Освобождение ресурсов
  void cleanup() {
    // Очистка ресурсов при необходимости
  }
}
