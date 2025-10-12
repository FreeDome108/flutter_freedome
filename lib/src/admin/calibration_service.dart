import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../core/connection_service.dart';
import '../core/auth_service.dart';
import '../models/dome_models.dart';
import '../models/calibration_models.dart';

/// Сервис калибровки FreeDome систем
class FreeDomeCalibrationService extends ChangeNotifier {
  final FreeDomeConnectionService _connectionService;
  final FreeDomeAuthService _authService;

  // Состояние калибровки
  final Map<String, CalibrationProgress> _activeCalibrations = {};
  final List<CalibrationResult> _calibrationHistory = [];
  final List<MicrophoneStatus> _microphones = [];

  // Потоки для обновлений
  final StreamController<CalibrationProgress> _progressController =
      StreamController<CalibrationProgress>.broadcast();
  final StreamController<List<MicrophoneStatus>> _microphonesController =
      StreamController<List<MicrophoneStatus>>.broadcast();

  FreeDomeCalibrationService({
    required FreeDomeConnectionService connectionService,
    required FreeDomeAuthService authService,
  })  : _connectionService = connectionService,
        _authService = authService;

  /// Получить активные калибровки
  Map<String, CalibrationProgress> get activeCalibrations =>
      Map.unmodifiable(_activeCalibrations);

  /// Получить историю калибровок
  List<CalibrationResult> get calibrationHistory =>
      List.unmodifiable(_calibrationHistory);

  /// Получить поток прогресса калибровки
  Stream<CalibrationProgress> get progressStream => _progressController.stream;

  /// Получить поток статуса микрофонов
  Stream<List<MicrophoneStatus>> get microphonesStream =>
      _microphonesController.stream;

  /// Проверить инициализацию
  bool get isInitialized =>
      _connectionService.isConnected && _authService.isAuthenticated;

  /// Проверить права на калибровку
  bool get canCalibrate =>
      _authService.currentUser?.role
          .hasPermission(FreeDomePermission.calibrateAudio) ??
      false;

  /// Инициализация сервиса
  Future<void> initialize() async {
    if (!isInitialized) {
      throw Exception(
          'Service not initialized. Connection and authentication required.');
    }
    await _loadMicrophones();
    notifyListeners();
  }

  /// Запуск аудиокалибровки
  Future<CalibrationProgress> startAudioCalibration({
    required String domeId,
    CalibrationType type = CalibrationType.auto,
    Map<String, dynamic>? settings,
  }) async {
    if (!canCalibrate) {
      throw Exception('Insufficient permissions for audio calibration');
    }

    final calibrationId = _generateCalibrationId();
    final progress = CalibrationProgress(
      id: calibrationId,
      type: type,
      status: CalibrationStatus.pending,
      progress: 0.0,
      currentStep: 'Preparing audio calibration...',
      totalSteps: _getTotalSteps(type),
      completedSteps: 0,
      startTime: DateTime.now(),
      estimatedCompletion: DateTime.now().add(type.estimatedDuration),
      stepData: settings,
    );

    _activeCalibrations[calibrationId] = progress;
    _progressController.add(progress);
    notifyListeners();

    // Запуск калибровки в фоне
    _runAudioCalibration(progress, domeId);

    return progress;
  }

  /// Запуск видеокалибровки
  Future<CalibrationProgress> startProjectorCalibration({
    required String domeId,
    required String projectorId,
    CalibrationType type = CalibrationType.auto,
    Map<String, dynamic>? settings,
  }) async {
    if (!canCalibrate) {
      throw Exception('Insufficient permissions for projector calibration');
    }

    final calibrationId = _generateCalibrationId();
    final progress = CalibrationProgress(
      id: calibrationId,
      type: type,
      status: CalibrationStatus.pending,
      progress: 0.0,
      currentStep: 'Preparing projector calibration...',
      totalSteps: _getTotalSteps(type),
      completedSteps: 0,
      startTime: DateTime.now(),
      estimatedCompletion: DateTime.now().add(type.estimatedDuration),
      stepData: settings,
    );

    _activeCalibrations[calibrationId] = progress;
    _progressController.add(progress);
    notifyListeners();

    // Запуск калибровки в фоне
    _runProjectorCalibration(progress, domeId, projectorId);

    return progress;
  }

  /// Запуск полной калибровки
  Future<CalibrationProgress> startFullCalibration({
    required String domeId,
    CalibrationType type = CalibrationType.full,
    Map<String, dynamic>? settings,
  }) async {
    return startAudioCalibration(
        domeId: domeId, type: type, settings: settings);
  }

  /// Запуск быстрой калибровки
  Future<CalibrationProgress> startQuickCalibration(
      {required String domeId}) async {
    return startAudioCalibration(domeId: domeId, type: CalibrationType.quick);
  }

  /// Запуск автоматической калибровки
  Future<CalibrationProgress> startAutoCalibration(
      {required String domeId}) async {
    return startAudioCalibration(domeId: domeId, type: CalibrationType.auto);
  }

  /// Приостановка калибровки
  Future<void> pauseCalibration(String calibrationId) async {
    final progress = _activeCalibrations[calibrationId];
    if (progress != null && progress.status == CalibrationStatus.running) {
      final updatedProgress =
          progress.copyWith(status: CalibrationStatus.paused);
      _activeCalibrations[calibrationId] = updatedProgress;
      _progressController.add(updatedProgress);
      notifyListeners();
    }
  }

  /// Возобновление калибровки
  Future<void> resumeCalibration(String calibrationId) async {
    final progress = _activeCalibrations[calibrationId];
    if (progress != null && progress.status == CalibrationStatus.paused) {
      final updatedProgress =
          progress.copyWith(status: CalibrationStatus.running);
      _activeCalibrations[calibrationId] = updatedProgress;
      _progressController.add(updatedProgress);
      notifyListeners();
    }
  }

  /// Отмена калибровки
  Future<void> cancelCalibration(String calibrationId) async {
    final progress = _activeCalibrations[calibrationId];
    if (progress != null) {
      final updatedProgress = progress.copyWith(
        status: CalibrationStatus.cancelled,
        estimatedCompletion: DateTime.now(),
      );
      _activeCalibrations[calibrationId] = updatedProgress;
      _progressController.add(updatedProgress);
      notifyListeners();
    }
  }

  /// Получение прогресса калибровки
  CalibrationProgress? getCalibrationProgress(String calibrationId) {
    return _activeCalibrations[calibrationId];
  }

  /// Очистка завершенных калибровок
  Future<void> clearCompletedCalibrations() async {
    _activeCalibrations.removeWhere((id, progress) =>
        progress.status == CalibrationStatus.completed ||
        progress.status == CalibrationStatus.failed ||
        progress.status == CalibrationStatus.cancelled);
    notifyListeners();
  }

  /// Обновление прогресса калибровки
  void updateCalibrationProgress(
    String calibrationId, {
    required double progress,
    required String currentStep,
    int? completedSteps,
    String? error,
    Map<String, dynamic>? stepData,
  }) {
    final calibration = _activeCalibrations[calibrationId];
    if (calibration != null) {
      final updatedCalibration = calibration.copyWith(
        progress: progress,
        currentStep: currentStep,
        completedSteps: completedSteps ?? calibration.completedSteps + 1,
        error: error,
        stepData: stepData,
      );
      _activeCalibrations[calibrationId] = updatedCalibration;
      _progressController.add(updatedCalibration);
      notifyListeners();
    }
  }

  /// Генерация тестового сигнала
  Future<void> generateTestSignal({
    required TestSignalType type,
    required double frequency,
    required Duration duration,
    double volume = 0.5,
  }) async {
    final command = FreeDomeCommand(
      type: 'generate_test_signal',
      data: {
        'signal_type': type.name,
        'frequency': frequency,
        'duration': duration.inSeconds,
        'volume': volume,
      },
    );

    final response = await _connectionService.sendCommand(command);
    if (!response.success) {
      throw Exception('Failed to generate test signal: ${response.error}');
    }
  }

  /// Получение статуса микрофонов
  List<MicrophoneStatus> getMicrophonesStatus() {
    return List.unmodifiable(_microphones);
  }

  /// Освобождение ресурсов
  @override
  void dispose() {
    _progressController.close();
    _microphonesController.close();
    super.dispose();
  }

  // Приватные методы

  String _generateCalibrationId() {
    return 'cal_${DateTime.now().millisecondsSinceEpoch}_${_activeCalibrations.length}';
  }

  int _getTotalSteps(CalibrationType type) {
    switch (type) {
      case CalibrationType.quick:
        return 5;
      case CalibrationType.auto:
        return 10;
      case CalibrationType.audio_only:
        return 8;
      case CalibrationType.video_only:
        return 12;
      case CalibrationType.full:
        return 20;
      case CalibrationType.manual:
        return 30;
    }
  }

  Future<void> _loadMicrophones() async {
    final command = FreeDomeCommand(
      type: 'get_microphones',
      data: {},
    );

    final response = await _connectionService.sendCommand(command);
    if (response.success && response.data != null) {
      final microphonesData =
          response.data!['microphones'] as List<dynamic>? ?? [];
      _microphones.clear();
      _microphones.addAll(microphonesData.map(
          (data) => MicrophoneStatus.fromJson(data as Map<String, dynamic>)));
      _microphonesController.add(_microphones);
    }
  }

  Future<void> _runAudioCalibration(
      CalibrationProgress progress, String domeId) async {
    try {
      final updatedProgress =
          progress.copyWith(status: CalibrationStatus.running);
      _activeCalibrations[progress.id] = updatedProgress;
      _progressController.add(updatedProgress);
      notifyListeners();

      // Симуляция калибровки
      for (int step = 1; step <= progress.totalSteps; step++) {
        if (_activeCalibrations[progress.id]?.status ==
            CalibrationStatus.cancelled) {
          return;
        }

        await Future.delayed(const Duration(seconds: 2));

        final stepProgress = step / progress.totalSteps;
        final currentStep =
            'Audio calibration step $step of ${progress.totalSteps}';

        updateCalibrationProgress(
          progress.id,
          progress: stepProgress,
          currentStep: currentStep,
          completedSteps: step,
        );
      }

      // Завершение калибровки
      final completedProgress = progress.copyWith(
        status: CalibrationStatus.completed,
        progress: 1.0,
        currentStep: 'Audio calibration completed',
        completedSteps: progress.totalSteps,
      );

      _activeCalibrations[progress.id] = completedProgress;
      _progressController.add(completedProgress);

      // Сохранение результата
      await _saveCalibrationResult(completedProgress);

      notifyListeners();
    } catch (e) {
      final failedProgress = progress.copyWith(
        status: CalibrationStatus.failed,
        error: e.toString(),
      );
      _activeCalibrations[progress.id] = failedProgress;
      _progressController.add(failedProgress);
      notifyListeners();
    }
  }

  Future<void> _runProjectorCalibration(
      CalibrationProgress progress, String domeId, String projectorId) async {
    try {
      final updatedProgress =
          progress.copyWith(status: CalibrationStatus.running);
      _activeCalibrations[progress.id] = updatedProgress;
      _progressController.add(updatedProgress);
      notifyListeners();

      // Симуляция калибровки проектора
      for (int step = 1; step <= progress.totalSteps; step++) {
        if (_activeCalibrations[progress.id]?.status ==
            CalibrationStatus.cancelled) {
          return;
        }

        await Future.delayed(const Duration(seconds: 3));

        final stepProgress = step / progress.totalSteps;
        final currentStep =
            'Projector calibration step $step of ${progress.totalSteps}';

        updateCalibrationProgress(
          progress.id,
          progress: stepProgress,
          currentStep: currentStep,
          completedSteps: step,
        );
      }

      // Завершение калибровки
      final completedProgress = progress.copyWith(
        status: CalibrationStatus.completed,
        progress: 1.0,
        currentStep: 'Projector calibration completed',
        completedSteps: progress.totalSteps,
      );

      _activeCalibrations[progress.id] = completedProgress;
      _progressController.add(completedProgress);

      // Сохранение результата
      await _saveCalibrationResult(completedProgress);

      notifyListeners();
    } catch (e) {
      final failedProgress = progress.copyWith(
        status: CalibrationStatus.failed,
        error: e.toString(),
      );
      _activeCalibrations[progress.id] = failedProgress;
      _progressController.add(failedProgress);
      notifyListeners();
    }
  }

  Future<void> _saveCalibrationResult(CalibrationProgress progress) async {
    final result = CalibrationResult(
      id: progress.id,
      type: progress.type,
      status: progress.status,
      startTime: progress.startTime ?? DateTime.now(),
      endTime: progress.status == CalibrationStatus.completed
          ? DateTime.now()
          : null,
      channelResults: [],
      projectorResults: [],
      overallQuality:
          progress.status == CalibrationStatus.completed ? 95.0 : 0.0,
    );

    _calibrationHistory.add(result);
    notifyListeners();
  }
}
