// Temporary stub for connectivity package during publication
library connectivity_stub;

// Stub classes to replace connectivity package imports
class FreeDomeConnectionService {
  static FreeDomeConnectionService get instance => FreeDomeConnectionService();
}

class FreeDomeConnectionStatus {
  static FreeDomeConnectionStatus get disconnected =>
      FreeDomeConnectionStatus();
  static FreeDomeConnectionStatus get connected => FreeDomeConnectionStatus();
}

class FreeDomeEvent {
  final String type;
  final Map<String, dynamic> data;

  FreeDomeEvent(this.type, this.data);
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

  FreeDomeCommand(this.type, this.data);

  FreeDomeCommand.empty()
      : type = '',
        data = {};
}

class DomeSystem {
  final String id;
  final String name;
  final DomeSystemType type;
  final DomeSystemStatus status;

  DomeSystem(this.id, this.name, this.type, this.status);
}

enum DomeSystemType {
  professional,
  mobile,
  hybrid,
}

enum DomeSystemStatus {
  online,
  offline,
  connecting,
  error,
  maintenance,
  calibrating,
}
