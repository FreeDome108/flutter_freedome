import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/admin/calibration_service.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/models/calibration_models.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

void main() {
  group('FreeDomeCalibrationService', () {
    late FreeDomeCalibrationService calibrationService;
    late FreeDomeConnectionService connectionService;
    late FreeDomeAuthService authService;

    setUp(() {
      connectionService = FreeDomeConnectionService();
      authService = FreeDomeAuthService();
      calibrationService = FreeDomeCalibrationService(
        connectionService: connectionService,
        authService: authService,
      );
    });

    tearDown(() {
      calibrationService.dispose();
    });

    test('should initialize with empty state', () {
      expect(calibrationService.activeCalibrations, isEmpty);
      expect(calibrationService.calibrationHistory, isEmpty);
      expect(calibrationService.microphones, isEmpty);
    });

    test('should start calibration', () async {
      const domeId = 'test_dome_001';
      const type = CalibrationType.audioOnly;

      final result = await calibrationService.startCalibration(
        domeId: domeId,
        type: type,
      );

      expect(result, isNotNull);
      expect(result!.domeId, equals(domeId));
      expect(result.type, equals(type));
      expect(result.status, equals(CalibrationStatus.running));
    });

    test('should get calibration progress', () async {
      const domeId = 'test_dome_002';
      const type = CalibrationType.videoOnly;

      final calibrationId = await calibrationService.startCalibration(
        domeId: domeId,
        type: type,
      );

      expect(calibrationId, isNotNull);

      final progress = calibrationService.getCalibrationProgress(
        calibrationId!.id,
      );

      expect(progress, isNotNull);
      expect(progress!.domeId, equals(domeId));
      expect(progress.type, equals(type));
    });

    test('should cancel calibration', () async {
      const domeId = 'test_dome_003';
      const type = CalibrationType.audioOnly;

      final calibrationId = await calibrationService.startCalibration(
        domeId: domeId,
        type: type,
      );

      expect(calibrationId, isNotNull);

      await calibrationService.cancelCalibration(calibrationId!.id);

      final progress = calibrationService.getCalibrationProgress(
        calibrationId.id,
      );

      expect(progress, isNotNull);
      expect(progress!.status, equals(CalibrationStatus.cancelled));
    });

    test('should get microphones', () async {
      const domeId = 'test_dome_004';

      final microphones = await calibrationService.getMicrophones(domeId);

      expect(microphones, isA<List<MicrophoneStatus>>());
    });

    test('should get calibration history', () async {
      const domeId = 'test_dome_005';

      final history = await calibrationService.getCalibrationHistory(domeId);

      expect(history, isA<List<CalibrationResult>>());
    });

    test('should validate calibration', () async {
      const domeId = 'test_dome_006';
      const type = CalibrationType.audioOnly;

      final calibrationId = await calibrationService.startCalibration(
        domeId: domeId,
        type: type,
      );

      expect(calibrationId, isNotNull);

      final isValid = await calibrationService.validateCalibration(
        calibrationId!.id,
      );

      expect(isValid, isA<bool>());
    });
  });
}
