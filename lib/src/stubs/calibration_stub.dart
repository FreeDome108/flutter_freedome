// Temporary stub for calibration package during publication
library calibration_stub;

// Stub classes to replace calibration package imports
abstract class FreeDomeConnectionProvider {
  bool get isConnected;
  Future<FreeDomeResponse> sendCommand(FreeDomeCommand command);
}

abstract class FreeDomeAuthProvider {
  FreeDomeUser? get currentUser;
  FreeDomeSession? get currentSession;
  bool hasPermission(FreeDomePermission permission);
}

class FreeDomeUser {
  final String id;
  final String username;
  final String role;

  FreeDomeUser(this.id, this.username, this.role);
}

class FreeDomeSession {
  final String token;
  final DateTime expiresAt;

  FreeDomeSession(this.token, this.expiresAt);
}

enum FreeDomePermission {
  playContent,
  controlBasics,
  manageContent,
  calibrateAudio,
  calibrateProjectors,
  systemManagement,
  vendorManagement,
}

class FreeDomeResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  FreeDomeResponse(this.success, this.message, this.data);
}

class FreeDomeCommand {
  final String type;
  final Map<String, dynamic> data;
  final String? targetSystemId;
  final String? sessionId;
  final int? priority;
  final DateTime? timestamp;
  final Duration? timeout;

  FreeDomeCommand(
    this.type,
    this.data, {
    this.targetSystemId,
    this.sessionId,
    this.priority,
    this.timestamp,
    this.timeout,
  });

  FreeDomeCommand.empty()
      : type = '',
        data = {},
        targetSystemId = null,
        sessionId = null,
        priority = null,
        timestamp = null,
        timeout = null;
}

class FreeDomeCalibrationService {
  FreeDomeCalibrationService(
      FreeDomeConnectionProvider connection, FreeDomeAuthProvider auth);

  Map<String, CalibrationProgress> get activeCalibrations => {};
  List<CalibrationResult> get calibrationHistory => [];
  Stream<CalibrationProgress> get progressStream => Stream.empty();
  Stream<List<MicrophoneStatus>> get microphonesStream => Stream.empty();
}

class CalibrationProgress {
  final String id;
  final String type;
  final double progress;
  final String status;

  CalibrationProgress(this.id, this.type, this.progress, this.status);
}

class CalibrationResult {
  final String id;
  final String type;
  final DateTime timestamp;
  final bool success;

  CalibrationResult(this.id, this.type, this.timestamp, this.success);
}

class MicrophoneStatus {
  final String id;
  final String name;
  final bool isActive;

  MicrophoneStatus(this.id, this.name, this.isActive);
}

enum CalibrationType {
  audioOnly,
  videoOnly,
  full,
}

enum TestSignalType {
  sine,
  whiteNoise,
  pinkNoise,
}
