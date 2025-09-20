import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_freedome/src/admin/calibration_service.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/models/calibration_models.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

import 'calibration_service_test.mocks.dart';

@GenerateMocks([
  FreeDomeConnectionService,
  FreeDomeAuthService,
])
void main() {
  group('FreeDomeCalibrationService', () {
    late FreeDomeCalibrationService calibrationService;
    late MockFreeDomeConnectionService mockConnectionService;
    late MockFreeDomeAuthService mockAuthService;

    setUp(() {
      calibrationService = FreeDomeCalibrationService();
      mockConnectionService = MockFreeDomeConnectionService();
      mockAuthService = MockFreeDomeAuthService();
    });

    tearDown(() {
      calibrationService.dispose();
    });

    group('Initialization', () {
      test('should initialize successfully', () async {
        await calibrationService.initialize();

        expect(calibrationService.isInitialized, true);
        expect(calibrationService.activeCalibrations, isEmpty);
      });

      test('should handle initialization errors gracefully', () async {
        // This should not throw even if there are issues
        expect(
            () async => await calibrationService.initialize(), returnsNormally);
      });
    });

    group('Audio Calibration', () {
      setUp(() async {
        await calibrationService.initialize();
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockConnectionService.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(true);
      });

      test('should start audio calibration successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration();

        expect(calibrationId, isNotNull);
        expect(calibrationService.activeCalibrations.length, 1);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(calibration, isNotNull);
        expect(calibration!.type, CalibrationType.audio_only);
        expect(calibration.status, CalibrationStatus.running);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should start quick audio calibration', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration(
          type: CalibrationType.quick,
        );

        expect(calibrationId, isNotNull);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(calibration!.type, CalibrationType.quick);
      });

      test('should start manual audio calibration with parameters', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration(
          type: CalibrationType.manual,
          parameters: {
            'channels': [0, 1, 2, 3, 4, 5],
            'testSignal': 'tone',
            'frequency': 1000,
            'amplitude': 0.5,
          },
        );

        expect(calibrationId, isNotNull);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(calibration!.type, CalibrationType.manual);
      });

      test('should fail audio calibration without permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(false);

        final calibrationId = await calibrationService.startAudioCalibration();

        expect(calibrationId, null);
        expect(calibrationService.activeCalibrations, isEmpty);
        verifyNever(mockConnectionService.sendCommand(any));
      });

      test('should fail audio calibration without connection', () async {
        when(mockConnectionService.isConnected).thenReturn(false);

        final calibrationId = await calibrationService.startAudioCalibration();

        expect(calibrationId, null);
        expect(calibrationService.activeCalibrations, isEmpty);
        verifyNever(mockConnectionService.sendCommand(any));
      });

      test('should handle audio calibration command failure', () async {
        when(mockConnectionService.sendCommand(any))
            .thenAnswer((_) async => const FreeDomeResponse(
                  success: false,
                  error: 'Calibration failed',
                  timestamp: DateTime.now(),
                ));

        final calibrationId = await calibrationService.startAudioCalibration();

        expect(calibrationId, null);
        expect(calibrationService.activeCalibrations, isEmpty);
      });
    });

    group('Projector Calibration', () {
      setUp(() async {
        await calibrationService.initialize();
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockConnectionService.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockAuthService
                .hasPermission(FreeDomePermission.calibrateProjectors))
            .thenReturn(true);
      });

      test('should start projector calibration successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId =
            await calibrationService.startProjectorCalibration();

        expect(calibrationId, isNotNull);
        expect(calibrationService.activeCalibrations.length, 1);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(calibration, isNotNull);
        expect(calibration!.type, CalibrationType.video_only);
        expect(calibration.status, CalibrationStatus.running);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should start full projector calibration', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId =
            await calibrationService.startProjectorCalibration(
          type: CalibrationType.full,
        );

        expect(calibrationId, isNotNull);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(calibration!.type, CalibrationType.full);
      });

      test('should start manual projector calibration with parameters',
          () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId =
            await calibrationService.startProjectorCalibration(
          type: CalibrationType.manual,
          parameters: {
            'projectors': [0, 1, 2],
            'pattern': 'grid',
            'brightness': 0.8,
            'contrast': 0.7,
          },
        );

        expect(calibrationId, isNotNull);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(calibration!.type, CalibrationType.manual);
      });

      test('should fail projector calibration without permission', () async {
        when(mockAuthService
                .hasPermission(FreeDomePermission.calibrateProjectors))
            .thenReturn(false);

        final calibrationId =
            await calibrationService.startProjectorCalibration();

        expect(calibrationId, null);
        expect(calibrationService.activeCalibrations, isEmpty);
        verifyNever(mockConnectionService.sendCommand(any));
      });
    });

    group('Full System Calibration', () {
      setUp(() async {
        await calibrationService.initialize();
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockConnectionService.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(true);
        when(mockAuthService
                .hasPermission(FreeDomePermission.calibrateProjectors))
            .thenReturn(true);
      });

      test('should start full system calibration successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startFullCalibration();

        expect(calibrationId, isNotNull);
        expect(calibrationService.activeCalibrations.length, 1);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(calibration, isNotNull);
        expect(calibration!.type, CalibrationType.full);
        expect(calibration.status, CalibrationStatus.running);

        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should fail full calibration without audio permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(false);

        final calibrationId = await calibrationService.startFullCalibration();

        expect(calibrationId, null);
        expect(calibrationService.activeCalibrations, isEmpty);
      });

      test('should fail full calibration without projector permission',
          () async {
        when(mockAuthService
                .hasPermission(FreeDomePermission.calibrateProjectors))
            .thenReturn(false);

        final calibrationId = await calibrationService.startFullCalibration();

        expect(calibrationId, null);
        expect(calibrationService.activeCalibrations, isEmpty);
      });
    });

    group('Calibration Management', () {
      setUp(() async {
        await calibrationService.initialize();
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockConnectionService.activeDome).thenReturn(const DomeSystem(
          id: 'test-dome',
          name: 'Test Dome',
          ipAddress: '192.168.1.100',
          port: 8080,
          type: DomeSystemType.professional,
          status: DomeSystemStatus.online,
        ));
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(true);
      });

      test('should pause calibration successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration();
        expect(calibrationId, isNotNull);

        final result =
            await calibrationService.pauseCalibration(calibrationId!);

        expect(result, true);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId);
        expect(calibration!.status, CalibrationStatus.paused);
      });

      test('should resume calibration successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration();
        expect(calibrationId, isNotNull);

        await calibrationService.pauseCalibration(calibrationId!);
        final result =
            await calibrationService.resumeCalibration(calibrationId);

        expect(result, true);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId);
        expect(calibration!.status, CalibrationStatus.running);
      });

      test('should cancel calibration successfully', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration();
        expect(calibrationId, isNotNull);

        final result =
            await calibrationService.cancelCalibration(calibrationId!);

        expect(result, true);

        final calibration =
            calibrationService.getCalibrationProgress(calibrationId);
        expect(calibration!.status, CalibrationStatus.cancelled);
      });

      test('should handle calibration not found', () async {
        final result = await calibrationService.pauseCalibration('nonexistent');

        expect(result, false);
      });

      test('should get all active calibrations', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId1 = await calibrationService.startAudioCalibration();
        final calibrationId2 =
            await calibrationService.startProjectorCalibration();

        expect(calibrationId1, isNotNull);
        expect(calibrationId2, isNotNull);
        expect(calibrationService.activeCalibrations.length, 2);
      });

      test('should clear completed calibrations', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration();
        expect(calibrationId, isNotNull);

        // Simulate completion
        calibrationService.updateCalibrationProgress(
          calibrationId!,
          const CalibrationProgress(
            id: 'test-id',
            type: CalibrationType.audio_only,
            status: CalibrationStatus.completed,
            progress: 1.0,
            currentStep: 'Completed',
            totalSteps: 5,
            completedSteps: 5,
          ),
        );

        await calibrationService.clearCompletedCalibrations();

        expect(calibrationService.activeCalibrations, isEmpty);
      });
    });

    group('Calibration Progress Tracking', () {
      setUp(() async {
        await calibrationService.initialize();
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(true);
      });

      test('should provide progress stream', () {
        expect(calibrationService.progressStream,
            isA<Stream<CalibrationProgress>>());
      });

      test('should emit progress updates', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final progressUpdates = <CalibrationProgress>[];
        final subscription =
            calibrationService.progressStream.listen((progress) {
          progressUpdates.add(progress);
        });

        final calibrationId = await calibrationService.startAudioCalibration();
        expect(calibrationId, isNotNull);

        // Simulate progress updates
        calibrationService.updateCalibrationProgress(
          calibrationId!,
          CalibrationProgress(
            id: calibrationId,
            type: CalibrationType.audio_only,
            status: CalibrationStatus.running,
            progress: 0.5,
            currentStep: 'Testing channels',
            totalSteps: 5,
            completedSteps: 2,
          ),
        );

        await subscription.cancel();

        expect(progressUpdates.isNotEmpty, true);
        expect(progressUpdates.last.progress, 0.5);
        expect(progressUpdates.last.currentStep, 'Testing channels');
      });

      test('should calculate estimated completion time', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final calibrationId = await calibrationService.startAudioCalibration();
        expect(calibrationId, isNotNull);

        final progress =
            calibrationService.getCalibrationProgress(calibrationId!);
        expect(progress!.estimatedCompletion, isNotNull);
      });
    });

    group('Test Signal Generation', () {
      setUp(() async {
        await calibrationService.initialize();
        when(mockConnectionService.isConnected).thenReturn(true);
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(true);
      });

      test('should generate test tone', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await calibrationService.generateTestSignal(
          type: TestSignalType.tone,
          frequency: 1000,
          amplitude: 0.5,
          duration: const Duration(seconds: 5),
        );

        expect(result, true);
        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should generate frequency sweep', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await calibrationService.generateTestSignal(
          type: TestSignalType.sweep,
          frequency: 20,
          endFrequency: 20000,
          amplitude: 0.3,
          duration: const Duration(seconds: 10),
        );

        expect(result, true);
        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should generate noise signal', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await calibrationService.generateTestSignal(
          type: TestSignalType.noise,
          amplitude: 0.2,
          duration: const Duration(seconds: 3),
        );

        expect(result, true);
        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should stop test signal', () async {
        when(mockConnectionService.sendCommand(any)).thenAnswer((_) async =>
            const FreeDomeResponse(success: true, timestamp: DateTime.now()));

        final result = await calibrationService.stopTestSignal();

        expect(result, true);
        verify(mockConnectionService.sendCommand(any)).called(1);
      });

      test('should fail test signal without permission', () async {
        when(mockAuthService.hasPermission(FreeDomePermission.calibrateAudio))
            .thenReturn(false);

        final result = await calibrationService.generateTestSignal(
          type: TestSignalType.tone,
          frequency: 1000,
          amplitude: 0.5,
          duration: const Duration(seconds: 5),
        );

        expect(result, false);
        verifyNever(mockConnectionService.sendCommand(any));
      });
    });

    group('Calibration Results', () {
      setUp(() async {
        await calibrationService.initialize();
      });

      test('should get calibration result', () {
        const testResult = CalibrationResult(
          id: 'test-result',
          calibrationId: 'test-calibration',
          type: CalibrationType.audio_only,
          status: CalibrationStatus.completed,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          settings: {'volume': 0.8, 'balance': 0.0},
          measurements: {'snr': 85.5, 'thd': 0.02},
          success: true,
        );

        calibrationService.saveCalibrationResult(testResult);

        final result = calibrationService.getCalibrationResult('test-result');
        expect(result, isNotNull);
        expect(result!.id, 'test-result');
        expect(result.success, true);
      });

      test('should get calibration history', () {
        const testResult1 = CalibrationResult(
          id: 'result-1',
          calibrationId: 'calibration-1',
          type: CalibrationType.audio_only,
          status: CalibrationStatus.completed,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          success: true,
        );

        const testResult2 = CalibrationResult(
          id: 'result-2',
          calibrationId: 'calibration-2',
          type: CalibrationType.video_only,
          status: CalibrationStatus.completed,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          success: true,
        );

        calibrationService.saveCalibrationResult(testResult1);
        calibrationService.saveCalibrationResult(testResult2);

        final history = calibrationService.getCalibrationHistory();
        expect(history.length, 2);
        expect(
            history[0].type, CalibrationType.video_only); // Most recent first
        expect(history[1].type, CalibrationType.audio_only);
      });

      test('should filter history by type', () {
        const testResult1 = CalibrationResult(
          id: 'result-1',
          calibrationId: 'calibration-1',
          type: CalibrationType.audio_only,
          status: CalibrationStatus.completed,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          success: true,
        );

        const testResult2 = CalibrationResult(
          id: 'result-2',
          calibrationId: 'calibration-2',
          type: CalibrationType.video_only,
          status: CalibrationStatus.completed,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          success: true,
        );

        calibrationService.saveCalibrationResult(testResult1);
        calibrationService.saveCalibrationResult(testResult2);

        final audioHistory = calibrationService.getCalibrationHistory(
          type: CalibrationType.audio_only,
        );
        expect(audioHistory.length, 1);
        expect(audioHistory.first.type, CalibrationType.audio_only);
      });

      test('should clear old calibration results', () async {
        const testResult = CalibrationResult(
          id: 'old-result',
          calibrationId: 'old-calibration',
          type: CalibrationType.audio_only,
          status: CalibrationStatus.completed,
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          success: true,
        );

        calibrationService.saveCalibrationResult(testResult);
        expect(calibrationService.getCalibrationHistory().length, 1);

        await calibrationService.clearOldResults(
          olderThan: const Duration(seconds: 1),
        );

        // Wait a moment then clear
        await Future.delayed(const Duration(milliseconds: 1100));
        await calibrationService.clearOldResults(
          olderThan: const Duration(seconds: 1),
        );

        expect(calibrationService.getCalibrationHistory().length, 0);
      });
    });

    group('Error Handling', () {
      test('should handle disposal gracefully', () {
        expect(() => calibrationService.dispose(), returnsNormally);
      });

      test('should handle multiple disposal calls', () {
        calibrationService.dispose();
        expect(() => calibrationService.dispose(), returnsNormally);
      });

      test('should handle operations after disposal', () async {
        calibrationService.dispose();

        final calibrationId = await calibrationService.startAudioCalibration();
        expect(calibrationId, null);
      });
    });

    group('Memory Management', () {
      test('should clean up resources on dispose', () {
        calibrationService.dispose();

        // After disposal, should be in clean state
        expect(calibrationService.activeCalibrations, isEmpty);
        expect(() => calibrationService.progressStream, returnsNormally);
      });

      test('should limit number of stored results', () {
        // Add many results
        for (int i = 0; i < 150; i++) {
          final result = CalibrationResult(
            id: 'result-$i',
            calibrationId: 'calibration-$i',
            type: CalibrationType.audio_only,
            status: CalibrationStatus.completed,
            startTime: DateTime.now().subtract(Duration(days: i)),
            endTime: DateTime.now().subtract(Duration(days: i)),
            success: true,
          );
          calibrationService.saveCalibrationResult(result);
        }

        final history = calibrationService.getCalibrationHistory();
        expect(history.length, lessThanOrEqualTo(100)); // Should be limited
      });
    });
  });
}
