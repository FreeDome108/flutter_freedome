import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dome_models.dart';
import 'content_models.dart';

part 'calibration_models.freezed.dart';
part 'calibration_models.g.dart';

/// Типы калибровки
enum CalibrationType {
  auto, // Автоматическая калибровка
  manual, // Ручная калибровка
  quick, // Быстрая калибровка
  full, // Полная калибровка
  audio_only, // Только аудио
  video_only, // Только видео
}

/// Статусы калибровки
enum CalibrationStatus {
  pending, // Ожидает запуска
  running, // Выполняется
  completed, // Завершена успешно
  failed, // Завершена с ошибкой
  cancelled, // Отменена
  paused, // Приостановлена
}

/// Типы тестовых сигналов
enum TestSignalType {
  tone, // Тональный сигнал
  sweep, // Свип
  noise, // Шум
  impulse, // Импульс
  music, // Музыкальный сигнал
}

/// Прогресс калибровки
@freezed
class CalibrationProgress with _$CalibrationProgress {
  const factory CalibrationProgress({
    required String id,
    required CalibrationType type,
    required CalibrationStatus status,
    required double progress,
    required String currentStep,
    @Default(0) int totalSteps,
    @Default(0) int completedSteps,
    DateTime? startTime,
    DateTime? estimatedCompletion,
    String? error,
    Map<String, dynamic>? stepData,
  }) = _CalibrationProgress;

  factory CalibrationProgress.fromJson(Map<String, dynamic> json) =>
      _$CalibrationProgressFromJson(json);
}

/// Результат калибровки
@freezed
class CalibrationResult with _$CalibrationResult {
  const factory CalibrationResult({
    required String id,
    required CalibrationType type,
    required CalibrationStatus status,
    required DateTime startTime,
    DateTime? endTime,
    @Default([]) List<ChannelResult> channelResults,
    @Default([]) List<ProjectorResult> projectorResults,
    Map<String, dynamic>? systemResults,
    String? error,
    @Default(0.0) double overallQuality,
  }) = _CalibrationResult;

  factory CalibrationResult.fromJson(Map<String, dynamic> json) =>
      _$CalibrationResultFromJson(json);
}

/// Результат калибровки аудиоканала
@freezed
class ChannelResult with _$ChannelResult {
  const factory ChannelResult({
    required String channelId,
    required String channelName,
    required String channelType,
    @Default([]) List<FrequencyPoint> frequencyResponse,
    @Default(0.0) double delay,
    @Default(0.0) double distortion,
    @Default(0.0) double noiseFloor,
    @Default(1.0) double gain,
    @Default(0.0) double phase,
    @Default(100.0) double quality,
    Map<String, dynamic>? equalizerSettings,
  }) = _ChannelResult;

  factory ChannelResult.fromJson(Map<String, dynamic> json) =>
      _$ChannelResultFromJson(json);
}

/// Точка частотной характеристики
@freezed
class FrequencyPoint with _$FrequencyPoint {
  const factory FrequencyPoint({
    required double frequency,
    required double magnitude,
    required double phase,
  }) = _FrequencyPoint;

  factory FrequencyPoint.fromJson(Map<String, dynamic> json) =>
      _$FrequencyPointFromJson(json);
}

/// Результат калибровки проектора
@freezed
class ProjectorResult with _$ProjectorResult {
  const factory ProjectorResult({
    required String projectorId,
    required String projectorName,
    @Default([]) List<CalibrationPoint> calibrationPoints,
    @Default(0.0) double brightness,
    @Default(0.0) double contrast,
    @Default(0.0) double gamma,
    @Default([]) List<double> colorMatrix,
    @Default(0.0) double geometryAccuracy,
    @Default(100.0) double quality,
    Map<String, dynamic>? lensCorrection,
  }) = _ProjectorResult;

  factory ProjectorResult.fromJson(Map<String, dynamic> json) =>
      _$ProjectorResultFromJson(json);
}

/// Точка калибровки проектора
@freezed
class CalibrationPoint with _$CalibrationPoint {
  const factory CalibrationPoint({
    required double x,
    required double y,
    required double targetX,
    required double targetY,
    required double error,
  }) = _CalibrationPoint;

  factory CalibrationPoint.fromJson(Map<String, dynamic> json) =>
      _$CalibrationPointFromJson(json);
}

/// Статус микрофона
@freezed
class MicrophoneStatus with _$MicrophoneStatus {
  const factory MicrophoneStatus({
    required String id,
    required String name,
    required bool isConnected,
    required bool isCalibrated,
    @Default(0.0) double sensitivity,
    @Default(0.0) double noiseLevel,
    @Default('unknown') String type,
    DateTime? lastCalibrated,
    Map<String, dynamic>? calibrationData,
  }) = _MicrophoneStatus;

  factory MicrophoneStatus.fromJson(Map<String, dynamic> json) =>
      _$MicrophoneStatusFromJson(json);
}

/// Настройки громкости
@freezed
class VolumeSettings with _$VolumeSettings {
  const factory VolumeSettings({
    @Default(0.5) double masterVolume,
    @Default({}) Map<String, double> channelVolumes,
    @Default(false) bool isMuted,
    @Default(0.0) double bassBoost,
    @Default(0.0) double trebleBoost,
    @Default(false) bool loudnessCompensation,
  }) = _VolumeSettings;

  factory VolumeSettings.fromJson(Map<String, dynamic> json) =>
      _$VolumeSettingsFromJson(json);
}

/// Аудиопрофиль
@freezed
class AudioProfile with _$AudioProfile {
  const factory AudioProfile({
    required String id,
    required String name,
    required VolumeSettings volumeSettings,
    required Map<String, dynamic> equalizerSettings,
    String? description,
    @Default([]) List<String> tags,
    @Default(false) bool isActive,
    DateTime? createdAt,
  }) = _AudioProfile;

  factory AudioProfile.fromJson(Map<String, dynamic> json) =>
      _$AudioProfileFromJson(json);
}

/// Команда FreeDome
@freezed
class FreeDomeCommand with _$FreeDomeCommand {
  const factory FreeDomeCommand({
    required String type,
    required Map<String, dynamic> data,
    String? targetSystemId,
    String? sessionId,
    @Default(0) int priority,
    DateTime? timestamp,
    Duration? timeout,
  }) = _FreeDomeCommand;

  factory FreeDomeCommand.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeCommandFromJson(json);
}

/// Ответ от FreeDome системы
@freezed
class FreeDomeResponse with _$FreeDomeResponse {
  const factory FreeDomeResponse({
    required bool success,
    String? error,
    Map<String, dynamic>? data,
    String? commandId,
    DateTime? timestamp,
  }) = _FreeDomeResponse;

  factory FreeDomeResponse.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeResponseFromJson(json);
}

/// Событие FreeDome
@freezed
class FreeDomeEvent with _$FreeDomeEvent {
  const factory FreeDomeEvent({
    required String type,
    required Map<String, dynamic> data,
    String? sourceSystemId,
    DateTime? timestamp,
  }) = _FreeDomeEvent;

  factory FreeDomeEvent.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeEventFromJson(json);
}

/// Расширения для типов калибровки
extension CalibrationTypeExtension on CalibrationType {
  String get displayName {
    switch (this) {
      case CalibrationType.auto:
        return 'Автоматическая';
      case CalibrationType.manual:
        return 'Ручная';
      case CalibrationType.quick:
        return 'Быстрая';
      case CalibrationType.full:
        return 'Полная';
      case CalibrationType.audio_only:
        return 'Только аудио';
      case CalibrationType.video_only:
        return 'Только видео';
    }
  }

  Duration get estimatedDuration {
    switch (this) {
      case CalibrationType.quick:
        return const Duration(minutes: 2);
      case CalibrationType.auto:
        return const Duration(minutes: 5);
      case CalibrationType.audio_only:
        return const Duration(minutes: 3);
      case CalibrationType.video_only:
        return const Duration(minutes: 4);
      case CalibrationType.full:
        return const Duration(minutes: 15);
      case CalibrationType.manual:
        return const Duration(minutes: 30);
    }
  }
}

/// Расширения для статусов воспроизведения
extension PlaybackStatusExtension on PlaybackStatus {
  String get displayName {
    switch (this) {
      case PlaybackStatus.stopped:
        return 'Остановлено';
      case PlaybackStatus.playing:
        return 'Воспроизводится';
      case PlaybackStatus.paused:
        return 'Пауза';
      case PlaybackStatus.buffering:
        return 'Буферизация';
      case PlaybackStatus.error:
        return 'Ошибка';
    }
  }

  bool get isActive =>
      this == PlaybackStatus.playing || this == PlaybackStatus.buffering;
  bool get canPause => this == PlaybackStatus.playing;
  bool get canResume => this == PlaybackStatus.paused;
  bool get canStop => isActive || this == PlaybackStatus.paused;
}
