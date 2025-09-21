import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_freedome_calibration/flutter_freedome_calibration.dart'
    as calibration;
import 'package:flutter_freedome_connectivity/flutter_freedome_connectivity.dart'
    as connectivity;
import 'package:http/http.dart' as http;
import '../core/connection_service.dart';
import '../core/auth_service.dart';
import '../models/dome_models.dart';

/// Адаптер для подключения к FreeDome системе
class FreeDomeConnectionProviderImpl
    implements calibration.FreeDomeConnectionProvider {
  final FreeDomeConnectionService _connectionService;

  FreeDomeConnectionProviderImpl(this._connectionService);

  @override
  bool get isConnected => _connectionService.isConnected;

  @override
  String? get activeDomeId => _connectionService.activeDome?.id;

  @override
  String? get activeDomeUrl {
    final dome = _connectionService.activeDome;
    if (dome != null) {
      return 'http://${dome.ipAddress}:${dome.port}';
    }
    return null;
  }

  @override
  Future<calibration.FreeDomeResponse> sendCommand(
      calibration.FreeDomeCommand command) async {
    // Конвертируем команду из калибровочного пакета в connectivity пакет
    final connectivityCommand = connectivity.FreeDomeCommand(
      type: command.type,
      data: command.data,
      targetSystemId: command.targetSystemId,
      sessionId: command.sessionId,
      priority: command.priority,
      timestamp: command.timestamp,
      timeout: command.timeout,
    );

    final response = await _connectionService.sendCommand(connectivityCommand);

    // Конвертируем ответ обратно
    return calibration.FreeDomeResponse(
      success: response.success,
      error: response.error,
      data: response.data,
      commandId: response.commandId,
      timestamp: response.timestamp,
    );
  }

  @override
  http.Client? getHttpClient(String domeId) {
    return _connectionService.getHttpClient(domeId);
  }
}

/// Адаптер для аутентификации пользователя
class FreeDomeAuthProviderImpl implements calibration.FreeDomeAuthProvider {
  final FreeDomeAuthService _authService;

  FreeDomeAuthProviderImpl(this._authService);

  @override
  calibration.FreeDomeUser? get currentUser {
    final user = _authService.currentUser;
    if (user != null) {
      return calibration.FreeDomeUser(
        id: user.id,
        name: user.name,
        permissions:
            user.permissions.map((p) => _convertPermission(p)).toList(),
        email: user.email,
        lastLogin: user.lastLogin,
      );
    }
    return null;
  }

  @override
  calibration.FreeDomeSession? get currentSession {
    final session = _authService.currentSession;
    if (session != null) {
      return calibration.FreeDomeSession(
        id: session.id,
        userId: session.userId,
        domeId: session.domeId,
        startTime: session.startTime,
        endTime: session.endTime,
      );
    }
    return null;
  }

  @override
  bool hasPermission(calibration.FreeDomePermission permission) {
    return _authService.hasPermission(_convertPermissionBack(permission));
  }

  calibration.FreeDomePermission _convertPermission(
      FreeDomePermission permission) {
    switch (permission) {
      case FreeDomePermission.playContent:
        return calibration.FreeDomePermission.playContent;
      case FreeDomePermission.controlBasics:
        return calibration.FreeDomePermission.controlBasics;
      case FreeDomePermission.manageContent:
        return calibration.FreeDomePermission.manageContent;
      case FreeDomePermission.calibrateAudio:
        return calibration.FreeDomePermission.calibrateAudio;
      case FreeDomePermission.calibrateProjectors:
        return calibration.FreeDomePermission.calibrateProjectors;
      case FreeDomePermission.systemManagement:
        return calibration.FreeDomePermission.systemManagement;
      case FreeDomePermission.vendorManagement:
        return calibration.FreeDomePermission.vendorManagement;
    }
  }

  FreeDomePermission _convertPermissionBack(
      calibration.FreeDomePermission permission) {
    switch (permission) {
      case calibration.FreeDomePermission.playContent:
        return FreeDomePermission.playContent;
      case calibration.FreeDomePermission.controlBasics:
        return FreeDomePermission.controlBasics;
      case calibration.FreeDomePermission.manageContent:
        return FreeDomePermission.manageContent;
      case calibration.FreeDomePermission.calibrateAudio:
        return FreeDomePermission.calibrateAudio;
      case calibration.FreeDomePermission.calibrateProjectors:
        return FreeDomePermission.calibrateProjectors;
      case calibration.FreeDomePermission.systemManagement:
        return FreeDomePermission.systemManagement;
      case calibration.FreeDomePermission.vendorManagement:
        return FreeDomePermission.vendorManagement;
    }
  }
}

/// Сервис калибровки FreeDome (только для администраторов)
class FreeDomeCalibrationService extends ChangeNotifier {
  final calibration.FreeDomeCalibrationService _calibrationService;

  FreeDomeCalibrationService({
    required FreeDomeConnectionService connectionService,
    required FreeDomeAuthService authService,
  }) : _calibrationService = calibration.FreeDomeCalibrationService(
          connectionProvider: FreeDomeConnectionProviderImpl(connectionService),
          authProvider: FreeDomeAuthProviderImpl(authService),
        ) {
    // Прослушиваем изменения в сервисе калибровки
    _calibrationService.addListener(() {
      notifyListeners();
    });
  }

  // Делегируем все методы к сервису калибровки
  Map<String, calibration.CalibrationProgress> get activeCalibrations =>
      _calibrationService.activeCalibrations;
  List<calibration.CalibrationResult> get calibrationHistory =>
      _calibrationService.calibrationHistory;
  Stream<calibration.CalibrationProgress> get progressStream =>
      _calibrationService.progressStream;
  Stream<List<calibration.MicrophoneStatus>> get microphonesStream =>
      _calibrationService.microphonesStream;
  bool get isInitialized => _calibrationService.isInitialized;
  bool get canCalibrate => _calibrationService.canCalibrate;

  Future<void> initialize() => _calibrationService.initialize();

  Future<String?> startAudioCalibration({
    calibration.CalibrationType type = calibration.CalibrationType.audioOnly,
    List<int>? channels,
    double? frequency,
    double? duration,
    double? targetLevel,
  }) =>
      _calibrationService.startAudioCalibration(
        type: type,
        channels: channels,
        frequency: frequency,
        duration: duration,
        targetLevel: targetLevel,
      );

  Future<String?> startProjectorCalibration({
    calibration.CalibrationType type = calibration.CalibrationType.videoOnly,
    List<String>? projectorIds,
    int? brightness,
    int? contrast,
    double? gamma,
  }) =>
      _calibrationService.startProjectorCalibration(
        type: type,
        projectorIds: projectorIds,
        brightness: brightness,
        contrast: contrast,
        gamma: gamma,
      );

  Future<String?> startFullCalibration() =>
      _calibrationService.startFullCalibration();
  Future<String?> startQuickCalibration() =>
      _calibrationService.startQuickCalibration();
  Future<String?> startAutoCalibration() =>
      _calibrationService.startAutoCalibration();

  Future<bool> pauseCalibration(String calibrationId) =>
      _calibrationService.pauseCalibration(calibrationId);
  Future<bool> resumeCalibration(String calibrationId) =>
      _calibrationService.resumeCalibration(calibrationId);
  Future<bool> cancelCalibration(String calibrationId) =>
      _calibrationService.cancelCalibration(calibrationId);

  calibration.CalibrationProgress? getCalibrationProgress(
          String calibrationId) =>
      _calibrationService.getCalibrationProgress(calibrationId);

  Future<void> clearCompletedCalibrations() =>
      _calibrationService.clearCompletedCalibrations();

  void updateCalibrationProgress(
          String calibrationId, calibration.CalibrationProgress progress) =>
      _calibrationService.updateCalibrationProgress(calibrationId, progress);

  Future<calibration.FreeDomeResponse> generateTestSignal({
    required calibration.TestSignalType type,
    double frequency = 1000.0,
    double duration = 2.0,
    double amplitude = 0.5,
    List<int>? channels,
  }) =>
      _calibrationService.generateTestSignal(
        type: type,
        frequency: frequency,
        duration: duration,
        amplitude: amplitude,
        channels: channels,
      );

  Future<List<calibration.MicrophoneStatus>> getMicrophonesStatus() =>
      _calibrationService.getMicrophonesStatus();

  @override
  void dispose() {
    _calibrationService.dispose();
    super.dispose();
  }
}
