import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../core/connection_service.dart';
import '../core/auth_service.dart';
import '../models/calibration_models.dart';
import '../models/dome_models.dart';

/// Сервис калибровки FreeDome (только для администраторов)
class FreeDomeCalibrationService extends ChangeNotifier {
  final FreeDomeConnectionService _connectionService =
      FreeDomeConnectionService();
  final FreeDomeAuthService _authService = FreeDomeAuthService();

  // Состояние калибровки
  CalibrationProgress? _currentCalibration;
  final List<CalibrationResult> _calibrationHistory = [];

  // Таймеры
  Timer? _progressTimer;

  // Контроллеры событий
  final StreamController<CalibrationProgress> _progressController =
      StreamController<CalibrationProgress>.broadcast();
  final StreamController<List<MicrophoneStatus>> _microphonesController =
      StreamController<List<MicrophoneStatus>>.broadcast();

  // Геттеры
  CalibrationProgress? get currentCalibration => _currentCalibration;
  List<CalibrationResult> get calibrationHistory =>
      List.from(_calibrationHistory);
  Stream<CalibrationProgress> get progressStream => _progressController.stream;
  Stream<List<MicrophoneStatus>> get microphonesStream =>
      _microphonesController.stream;

  /// Проверка разрешений для калибровки
  bool get canCalibrate =>
      _authService.hasPermission(FreeDomePermission.calibrateAudio) ||
      _authService.hasPermission(FreeDomePermission.calibrateProjectors);

  /// Запуск автоматической калибровки
  Future<String?> startAutoCalibration({
    CalibrationType type = CalibrationType.auto,
    List<int>? channels,
  }) async {
    if (!canCalibrate) {
      if (kDebugMode) {
        print('❌ Нет разрешения на калибровку');
      }
      return null;
    }

    if (!_connectionService.isConnected) {
      if (kDebugMode) {
        print('❌ Нет подключения к FreeDome системе');
      }
      return null;
    }

    try {
      final calibrationId =
          'calibration_${DateTime.now().millisecondsSinceEpoch}';

      // Создаем объект прогресса калибровки
      _currentCalibration = CalibrationProgress(
        id: calibrationId,
        type: type,
        status: CalibrationStatus.pending,
        progress: 0.0,
        currentStep: 'Инициализация калибровки',
        totalSteps: _getCalibrationSteps(type),
        startTime: DateTime.now(),
        estimatedCompletion: DateTime.now().add(type.estimatedDuration),
      );

      _progressController.add(_currentCalibration!);
      notifyListeners();

      // Отправляем команду начала калибровки
      final command = FreeDomeCommand(
        type: 'start_calibration',
        data: {
          'calibrationId': calibrationId,
          'type': type.name,
          'channels': channels,
          'sessionId': _authService.currentSession?.id,
        },
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _currentCalibration = _currentCalibration!.copyWith(
          status: CalibrationStatus.running,
          currentStep: 'Калибровка запущена',
        );

        _progressController.add(_currentCalibration!);
        _startProgressMonitoring(calibrationId);

        if (kDebugMode) {
          print('✅ Калибровка запущена: $calibrationId');
        }

        return calibrationId;
      } else {
        _currentCalibration = _currentCalibration!.copyWith(
          status: CalibrationStatus.failed,
          error: response.error,
        );
        _progressController.add(_currentCalibration!);
        return null;
      }
    } catch (e) {
      _currentCalibration = _currentCalibration?.copyWith(
        status: CalibrationStatus.failed,
        error: e.toString(),
      );

      if (_currentCalibration != null) {
        _progressController.add(_currentCalibration!);
      }

      if (kDebugMode) {
        print('❌ Ошибка запуска калибровки: $e');
      }

      return null;
    }
  }

  /// Остановка калибровки
  Future<bool> stopCalibration() async {
    if (!canCalibrate || _currentCalibration == null) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'stop_calibration',
        data: {'calibrationId': _currentCalibration!.id},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _currentCalibration = _currentCalibration!.copyWith(
          status: CalibrationStatus.cancelled,
          currentStep: 'Калибровка отменена',
        );

        _progressController.add(_currentCalibration!);
        _stopProgressMonitoring();

        if (kDebugMode) {
          print('✅ Калибровка остановлена');
        }

        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка остановки калибровки: $e');
      }
    }

    return false;
  }

  /// Быстрая калибровка
  Future<String?> startQuickCalibration() async {
    return await startAutoCalibration(type: CalibrationType.quick);
  }

  /// Полная калибровка
  Future<String?> startFullCalibration() async {
    return await startAutoCalibration(type: CalibrationType.full);
  }

  /// Калибровка только аудио
  Future<String?> startAudioCalibration() async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateAudio)) {
      return null;
    }

    return await startAutoCalibration(type: CalibrationType.audio_only);
  }

  /// Калибровка только проекторов
  Future<String?> startProjectorCalibration() async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateProjectors)) {
      return null;
    }

    return await startAutoCalibration(type: CalibrationType.video_only);
  }

  /// Тестирование аудиоканала
  Future<bool> testAudioChannel({
    required int channelId,
    TestSignalType testType = TestSignalType.tone,
    double frequency = 1000.0,
    double duration = 2.0,
  }) async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateAudio)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'test_audio_channel',
        data: {
          'channelId': channelId,
          'testType': testType.name,
          'frequency': frequency,
          'duration': duration,
        },
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Тест канала $channelId запущен'
            : '❌ Ошибка теста канала: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка тестирования канала: $e');
      }
      return false;
    }
  }

  /// Калибровка конкретного микрофона
  Future<bool> calibrateMicrophone(String microphoneId) async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateAudio)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'calibrate_microphone',
        data: {'microphoneId': microphoneId},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        // Обновляем статус микрофонов
        await _updateMicrophonesStatus();
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка калибровки микрофона: $e');
      }
      return false;
    }
  }

  /// Получение статуса микрофонов
  Future<List<MicrophoneStatus>> getMicrophonesStatus() async {
    if (!canCalibrate) {
      return [];
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return [];

      final client = _connectionService.getHttpClient(dome.id);
      if (client == null) return [];

      final response = await client.get(
        Uri.parse(
            'http://${dome.ipAddress}:${dome.port}/api/audio/microphones'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final microphones =
            data.map((item) => MicrophoneStatus.fromJson(item)).toList();

        _microphonesController.add(microphones);
        return microphones;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения статуса микрофонов: $e');
      }
    }

    return [];
  }

  /// Получение результатов калибровки
  Future<CalibrationResult?> getCalibrationResult(String calibrationId) async {
    if (!canCalibrate) {
      return null;
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return null;

      final client = _connectionService.getHttpClient(dome.id);
      if (client == null) return null;

      final response = await client.get(
        Uri.parse(
            'http://${dome.ipAddress}:${dome.port}/api/calibration/results/$calibrationId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = CalibrationResult.fromJson(data);

        // Добавляем в историю если еще нет
        if (!_calibrationHistory.any((r) => r.id == result.id)) {
          _calibrationHistory.add(result);
        }

        return result;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения результатов калибровки: $e');
      }
    }

    return null;
  }

  /// Запуск мониторинга прогресса калибровки
  void _startProgressMonitoring(String calibrationId) {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      await _updateCalibrationProgress(calibrationId);
    });
  }

  /// Остановка мониторинга прогресса
  void _stopProgressMonitoring() {
    _progressTimer?.cancel();
    _progressTimer = null;
  }

  /// Обновление прогресса калибровки
  Future<void> _updateCalibrationProgress(String calibrationId) async {
    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return;

      final client = _connectionService.getHttpClient(dome.id);
      if (client == null) return;

      final response = await client.get(
        Uri.parse(
            'http://${dome.ipAddress}:${dome.port}/api/calibration/progress/$calibrationId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _currentCalibration = CalibrationProgress.fromJson(data);

        _progressController.add(_currentCalibration!);
        notifyListeners();

        // Останавливаем мониторинг если калибровка завершена
        if (_currentCalibration!.status == CalibrationStatus.completed ||
            _currentCalibration!.status == CalibrationStatus.failed ||
            _currentCalibration!.status == CalibrationStatus.cancelled) {
          _stopProgressMonitoring();

          // Загружаем результаты калибровки
          if (_currentCalibration!.status == CalibrationStatus.completed) {
            await getCalibrationResult(calibrationId);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления прогресса калибровки: $e');
      }
    }
  }

  /// Обновление статуса микрофонов
  Future<void> _updateMicrophonesStatus() async {
    try {
      await getMicrophonesStatus();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления статуса микрофонов: $e');
      }
    }
  }

  /// Получение количества шагов для типа калибровки
  int _getCalibrationSteps(CalibrationType type) {
    switch (type) {
      case CalibrationType.quick:
        return 3;
      case CalibrationType.auto:
        return 5;
      case CalibrationType.audio_only:
        return 4;
      case CalibrationType.video_only:
        return 4;
      case CalibrationType.full:
        return 10;
      case CalibrationType.manual:
        return 15;
    }
  }

  /// Установка настроек громкости
  Future<bool> setVolumeSettings(VolumeSettings settings) async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateAudio)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_volume_settings',
        data: settings.toJson(),
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);
      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки настроек громкости: $e');
      }
      return false;
    }
  }

  /// Активация аудиопрофиля
  Future<bool> activateAudioProfile(String profileId) async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateAudio)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'activate_audio_profile',
        data: {'profileId': profileId},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);
      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка активации аудиопрофиля: $e');
      }
      return false;
    }
  }

  /// Калибровка проектора
  Future<bool> calibrateProjector(String projectorId) async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateProjectors)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'calibrate_projector',
        data: {'projectorId': projectorId},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Калибровка проектора $projectorId запущена'
            : '❌ Ошибка калибровки проектора: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка калибровки проектора: $e');
      }
      return false;
    }
  }

  /// Настройка яркости проектора
  Future<bool> setProjectorBrightness(
      String projectorId, int brightness) async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateProjectors)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_projector_brightness',
        data: {
          'projectorId': projectorId,
          'brightness': brightness.clamp(0, 100),
        },
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);
      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки яркости проектора: $e');
      }
      return false;
    }
  }

  /// Настройка контрастности проектора
  Future<bool> setProjectorContrast(String projectorId, int contrast) async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateProjectors)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_projector_contrast',
        data: {
          'projectorId': projectorId,
          'contrast': contrast.clamp(0, 100),
        },
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);
      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки контрастности проектора: $e');
      }
      return false;
    }
  }

  /// Выравнивание проекторов
  Future<bool> alignProjectors() async {
    if (!_authService.hasPermission(FreeDomePermission.calibrateProjectors)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'align_projectors',
        data: {},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Выравнивание проекторов запущено'
            : '❌ Ошибка выравнивания проекторов: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка выравнивания проекторов: $e');
      }
      return false;
    }
  }

  /// Получение статистики калибровки
  Map<String, dynamic> getCalibrationStats() {
    final completedCalibrations = _calibrationHistory
        .where((r) => r.status == CalibrationStatus.completed)
        .length;

    final failedCalibrations = _calibrationHistory
        .where((r) => r.status == CalibrationStatus.failed)
        .length;

    final lastCalibration =
        _calibrationHistory.isNotEmpty ? _calibrationHistory.last : null;

    return {
      'totalCalibrations': _calibrationHistory.length,
      'completedCalibrations': completedCalibrations,
      'failedCalibrations': failedCalibrations,
      'successRate': _calibrationHistory.isNotEmpty
          ? (completedCalibrations / _calibrationHistory.length * 100).round()
          : 0,
      'lastCalibration': lastCalibration?.toJson(),
      'currentCalibration': _currentCalibration?.toJson(),
      'canCalibrate': canCalibrate,
    };
  }

  /// Экспорт результатов калибровки
  Future<String?> exportCalibrationResults(String calibrationId) async {
    if (!canCalibrate) {
      return null;
    }

    try {
      final result = await getCalibrationResult(calibrationId);
      if (result != null) {
        final exportData = {
          'calibration': result.toJson(),
          'exportedAt': DateTime.now().toIso8601String(),
          'exportedBy': _authService.currentUser?.name,
        };

        return json.encode(exportData);
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка экспорта результатов: $e');
      }
    }

    return null;
  }

  @override
  void dispose() {
    _stopProgressMonitoring();
    _progressController.close();
    _microphonesController.close();
    super.dispose();
  }
}
