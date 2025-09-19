import 'package:freezed_annotation/freezed_annotation.dart';

part 'dome_models.freezed.dart';
part 'dome_models.g.dart';

/// Типы купольных систем
enum DomeSystemType {
  professional, // Профессиональная стационарная система
  mobile, // Мобильная портативная система
  hybrid, // Гибридная система
}

/// Статусы купольной системы
enum DomeSystemStatus {
  online, // В сети и готова к работе
  offline, // Не в сети
  connecting, // Процесс подключения
  error, // Ошибка системы
  maintenance, // Режим обслуживания
  calibrating, // Процесс калибровки
}

/// Типы проекторов
enum ProjectorType {
  laser, // Лазерный проектор
  led, // LED проектор
  dlp, // DLP проектор
  lcd, // LCD проектор
}

/// Статусы проектора
enum ProjectorStatus {
  active, // Активен
  standby, // В режиме ожидания
  error, // Ошибка
  calibrating, // Калибровка
  warmingUp, // Прогрев
  coolingDown, // Охлаждение
}

/// Типы аудиоканалов
enum AudioChannelType {
  mono, // Моно
  stereo, // Стерео
  surround, // Объемный звук
  ambisonic, // Амбисонический
}

/// Роли пользователей FreeDome
enum FreeDomeUserRole {
  guest, // Гость - только воспроизведение
  operator, // Оператор - базовые настройки
  admin, // Администратор - калибровка
  superadmin, // Суперадминистратор - системные настройки
}

/// Разрешения FreeDome
enum FreeDomePermission {
  playContent, // Воспроизведение контента
  controlBasics, // Базовые настройки (громкость, яркость)
  manageContent, // Управление библиотекой контента
  calibrateAudio, // Калибровка аудио
  calibrateProjectors, // Калибровка проекторов
  systemManagement, // Управление системой
  vendorManagement, // Управление вендорами
}

/// Основная модель купольной системы
@freezed
class DomeSystem with _$DomeSystem {
  const factory DomeSystem({
    required String id,
    required String name,
    required String ipAddress,
    required int port,
    required DomeSystemType type,
    required DomeSystemStatus status,
    @Default(false) bool isConnected,
    @Default([]) List<ProjectorConfig> projectors,
    @Default([]) List<AudioChannel> audioChannels,
    DateTime? lastConnected,
    String? firmwareVersion,
    Map<String, dynamic>? capabilities,
    String? activeVendor,
    @Default(0.5) double systemVolume,
    @Default(0.8) double systemBrightness,
    @Default(0.0) double systemRotation,
  }) = _DomeSystem;

  factory DomeSystem.fromJson(Map<String, dynamic> json) =>
      _$DomeSystemFromJson(json);
}

/// Конфигурация проектора
@freezed
class ProjectorConfig with _$ProjectorConfig {
  const factory ProjectorConfig({
    required String id,
    required String name,
    required ProjectorType type,
    required int brightness,
    required int contrast,
    required ProjectorStatus status,
    @Default(0.0) double x,
    @Default(0.0) double y,
    @Default(0.0) double z,
    @Default(0.0) double pitch,
    @Default(0.0) double yaw,
    @Default(0.0) double roll,
    @Default(1920) int resolutionWidth,
    @Default(1080) int resolutionHeight,
    @Default(60.0) double refreshRate,
    Map<String, dynamic>? calibrationData,
  }) = _ProjectorConfig;

  factory ProjectorConfig.fromJson(Map<String, dynamic> json) =>
      _$ProjectorConfigFromJson(json);
}

/// Аудиоканал
@freezed
class AudioChannel with _$AudioChannel {
  const factory AudioChannel({
    required String id,
    required String name,
    required AudioChannelType type,
    @Default(0.5) double volume,
    @Default(false) bool isMuted,
    @Default(0.0) double x,
    @Default(0.0) double y,
    @Default(0.0) double z,
    @Default(0.0) double delay,
    Map<String, dynamic>? equalizerSettings,
    Map<String, dynamic>? calibrationData,
  }) = _AudioChannel;

  factory AudioChannel.fromJson(Map<String, dynamic> json) =>
      _$AudioChannelFromJson(json);
}

/// Статус подключения к FreeDome
@freezed
class FreeDomeConnectionStatus with _$FreeDomeConnectionStatus {
  const factory FreeDomeConnectionStatus({
    required bool isConnected,
    required bool isConnecting,
    String? connectedDomeId,
    String? serverUrl,
    DateTime? lastConnected,
    String? error,
    @Default(0) int reconnectAttempts,
    @Default(5) int maxReconnectAttempts,
  }) = _FreeDomeConnectionStatus;

  factory FreeDomeConnectionStatus.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeConnectionStatusFromJson(json);
}

/// Пользователь FreeDome
@freezed
class FreeDomeUser with _$FreeDomeUser {
  const factory FreeDomeUser({
    required String id,
    required String name,
    required FreeDomeUserRole role,
    required List<FreeDomePermission> permissions,
    String? email,
    DateTime? lastLogin,
    Map<String, dynamic>? preferences,
  }) = _FreeDomeUser;

  factory FreeDomeUser.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeUserFromJson(json);
}

/// Сессия FreeDome
@freezed
class FreeDomeSession with _$FreeDomeSession {
  const factory FreeDomeSession({
    required String id,
    required String userId,
    required String domeId,
    required DateTime startTime,
    DateTime? endTime,
    @Default(Duration.zero) Duration duration,
    String? currentContentId,
    Map<String, dynamic>? sessionData,
  }) = _FreeDomeSession;

  factory FreeDomeSession.fromJson(Map<String, dynamic> json) =>
      _$FreeDomeSessionFromJson(json);
}

/// Расширения для ролей
extension FreeDomeUserRoleExtension on FreeDomeUserRole {
  String get displayName {
    switch (this) {
      case FreeDomeUserRole.guest:
        return 'Гость';
      case FreeDomeUserRole.operator:
        return 'Оператор';
      case FreeDomeUserRole.admin:
        return 'Администратор';
      case FreeDomeUserRole.superadmin:
        return 'Суперадминистратор';
    }
  }

  String get description {
    switch (this) {
      case FreeDomeUserRole.guest:
        return 'Может воспроизводить контент и изменять базовые настройки';
      case FreeDomeUserRole.operator:
        return 'Может управлять библиотекой контента и расширенными настройками';
      case FreeDomeUserRole.admin:
        return 'Может выполнять калибровку и системное администрирование';
      case FreeDomeUserRole.superadmin:
        return 'Полный доступ ко всем функциям системы';
    }
  }

  List<FreeDomePermission> get defaultPermissions {
    switch (this) {
      case FreeDomeUserRole.guest:
        return [
          FreeDomePermission.playContent,
          FreeDomePermission.controlBasics,
        ];
      case FreeDomeUserRole.operator:
        return [
          FreeDomePermission.playContent,
          FreeDomePermission.controlBasics,
          FreeDomePermission.manageContent,
        ];
      case FreeDomeUserRole.admin:
        return [
          FreeDomePermission.playContent,
          FreeDomePermission.controlBasics,
          FreeDomePermission.manageContent,
          FreeDomePermission.calibrateAudio,
          FreeDomePermission.calibrateProjectors,
          FreeDomePermission.systemManagement,
        ];
      case FreeDomeUserRole.superadmin:
        return FreeDomePermission.values;
    }
  }

  bool hasPermission(FreeDomePermission permission) {
    return defaultPermissions.contains(permission);
  }
}

/// Расширения для типов купольных систем
extension DomeSystemTypeExtension on DomeSystemType {
  String get displayName {
    switch (this) {
      case DomeSystemType.professional:
        return 'Профессиональная';
      case DomeSystemType.mobile:
        return 'Мобильная';
      case DomeSystemType.hybrid:
        return 'Гибридная';
    }
  }

  String get description {
    switch (this) {
      case DomeSystemType.professional:
        return 'Стационарная профессиональная система';
      case DomeSystemType.mobile:
        return 'Портативная мобильная система';
      case DomeSystemType.hybrid:
        return 'Гибридная система (стационарная + мобильная)';
    }
  }
}

/// Расширения для статусов
extension DomeSystemStatusExtension on DomeSystemStatus {
  String get displayName {
    switch (this) {
      case DomeSystemStatus.online:
        return 'В сети';
      case DomeSystemStatus.offline:
        return 'Не в сети';
      case DomeSystemStatus.connecting:
        return 'Подключение...';
      case DomeSystemStatus.error:
        return 'Ошибка';
      case DomeSystemStatus.maintenance:
        return 'Обслуживание';
      case DomeSystemStatus.calibrating:
        return 'Калибровка';
    }
  }

  bool get isOperational => this == DomeSystemStatus.online;
  bool get canConnect => this == DomeSystemStatus.offline;
  bool get requiresAttention =>
      this == DomeSystemStatus.error || this == DomeSystemStatus.maintenance;
}
