import 'dart:async';
import 'package:flutter/foundation.dart';
// Temporarily using stubs for publication
import '../stubs/connectivity_stub.dart' as connectivity;
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as socket_io_client;
import '../models/dome_models.dart';

/// Сервис для управления подключениями к FreeDome системам
class FreeDomeConnectionService extends ChangeNotifier {
  static final FreeDomeConnectionService _instance =
      FreeDomeConnectionService._internal();
  factory FreeDomeConnectionService() => _instance;
  FreeDomeConnectionService._internal();

  // Используем новый сервис подключений
  final connectivity.FreeDomeConnectionService _connectivityService =
      connectivity.FreeDomeConnectionService.instance;

  // Геттеры делегируют к сервису подключений
  connectivity.FreeDomeConnectionStatus get connectionStatus =>
      _connectivityService.connectionStatus;
  List<DomeSystem> get discoveredSystems =>
      _connectivityService.discoveredSystems
          .map((system) => _convertToDomeSystem(system))
          .toList();
  DomeSystem? get activeDome => _connectivityService.activeDome != null
      ? _convertToDomeSystem(_connectivityService.activeDome!)
      : null;
  bool get isConnected => _connectivityService.isConnected;
  bool get isConnecting => _connectivityService.isConnecting;

  // Потоки событий
  Stream<connectivity.FreeDomeEvent> get eventStream =>
      _connectivityService.eventStream;
  Stream<List<DomeSystem>> get systemsStream =>
      _connectivityService.systemsStream.map((systems) =>
          systems.map((system) => _convertToDomeSystem(system)).toList());

  /// Инициализация сервиса
  Future<void> initialize() async {
    try {
      await _connectivityService.initialize();

      // Прослушиваем изменения в сервисе подключений
      _connectivityService.addListener(() {
        notifyListeners();
      });

      if (kDebugMode) {
        print('✅ FreeDomeConnectionService инициализирован');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации FreeDomeConnectionService: $e');
      }
    }
  }

  /// Запуск автоматического обнаружения систем
  Future<void> startDiscovery() async {
    await _connectivityService.startDiscovery();
  }

  /// Остановка обнаружения систем
  void stopDiscovery() {
    _connectivityService.stopDiscovery();
  }

  /// Обновление списка систем
  Future<void> refreshSystems() async {
    await _connectivityService.refreshSystems();
  }

  /// Подключение к купольной системе
  Future<bool> connectToDome(DomeSystem dome) async {
    final connectivityDome = _convertToConnectivitySystem(dome);
    return await _connectivityService.connectToDome(connectivityDome);
  }

  /// Отключение от купольной системы
  Future<void> disconnectFromDome() async {
    await _connectivityService.disconnectFromDome();
  }

  /// Отправка команды купольной системе
  Future<connectivity.FreeDomeResponse> sendCommand(
      connectivity.FreeDomeCommand command) async {
    return await _connectivityService.sendCommand(command);
  }

  /// Получение HTTP клиента для системы
  http.Client? getHttpClient(String domeId) {
    return _connectivityService.getHttpClient(domeId);
  }

  /// Получение Socket.IO для системы
  socket_io_client.Socket? getSocket(String domeId) {
    return _connectivityService.getSocket(domeId);
  }

  /// Конвертация из connectivity.DomeSystem в локальную DomeSystem
  DomeSystem _convertToDomeSystem(connectivity.DomeSystem connectivitySystem) {
    return DomeSystem(
      id: connectivitySystem.id,
      name: connectivitySystem.name,
      ipAddress: connectivitySystem.ipAddress,
      port: connectivitySystem.port,
      type: _convertSystemType(connectivitySystem.type),
      status: _convertSystemStatus(connectivitySystem.status),
      isConnected: connectivitySystem.isConnected,
      lastConnected: connectivitySystem.lastConnected,
      firmwareVersion: connectivitySystem.firmwareVersion,
      capabilities: connectivitySystem.capabilities,
      activeVendor: connectivitySystem.activeVendor,
      projectors: [], // Эти данные будут загружаться отдельно
      audioChannels: [], // Эти данные будут загружаться отдельно
      systemVolume: 0.5,
      systemBrightness: 0.8,
      systemRotation: 0.0,
    );
  }

  /// Конвертация из локальной DomeSystem в connectivity.DomeSystem
  connectivity.DomeSystem _convertToConnectivitySystem(DomeSystem localSystem) {
    return connectivity.DomeSystem(
      id: localSystem.id,
      name: localSystem.name,
      ipAddress: localSystem.ipAddress,
      port: localSystem.port,
      type: _convertToConnectivitySystemType(localSystem.type),
      status: _convertToConnectivitySystemStatus(localSystem.status),
      isConnected: localSystem.isConnected,
      lastConnected: localSystem.lastConnected,
      firmwareVersion: localSystem.firmwareVersion,
      capabilities: localSystem.capabilities,
      activeVendor: localSystem.activeVendor,
    );
  }

  /// Конвертация типов системы
  DomeSystemType _convertSystemType(
      connectivity.DomeSystemType connectivityType) {
    switch (connectivityType) {
      case connectivity.DomeSystemType.professional:
        return DomeSystemType.professional;
      case connectivity.DomeSystemType.mobile:
        return DomeSystemType.mobile;
      case connectivity.DomeSystemType.hybrid:
        return DomeSystemType.hybrid;
    }
  }

  connectivity.DomeSystemType _convertToConnectivitySystemType(
      DomeSystemType localType) {
    switch (localType) {
      case DomeSystemType.professional:
        return connectivity.DomeSystemType.professional;
      case DomeSystemType.mobile:
        return connectivity.DomeSystemType.mobile;
      case DomeSystemType.hybrid:
        return connectivity.DomeSystemType.hybrid;
    }
  }

  /// Конвертация статусов системы
  DomeSystemStatus _convertSystemStatus(
      connectivity.DomeSystemStatus connectivityStatus) {
    switch (connectivityStatus) {
      case connectivity.DomeSystemStatus.online:
        return DomeSystemStatus.online;
      case connectivity.DomeSystemStatus.offline:
        return DomeSystemStatus.offline;
      case connectivity.DomeSystemStatus.connecting:
        return DomeSystemStatus.connecting;
      case connectivity.DomeSystemStatus.error:
        return DomeSystemStatus.error;
      case connectivity.DomeSystemStatus.maintenance:
        return DomeSystemStatus.maintenance;
      case connectivity.DomeSystemStatus.calibrating:
        return DomeSystemStatus.calibrating;
    }
  }

  connectivity.DomeSystemStatus _convertToConnectivitySystemStatus(
      DomeSystemStatus localStatus) {
    switch (localStatus) {
      case DomeSystemStatus.online:
        return connectivity.DomeSystemStatus.online;
      case DomeSystemStatus.offline:
        return connectivity.DomeSystemStatus.offline;
      case DomeSystemStatus.connecting:
        return connectivity.DomeSystemStatus.connecting;
      case DomeSystemStatus.error:
        return connectivity.DomeSystemStatus.error;
      case DomeSystemStatus.maintenance:
        return connectivity.DomeSystemStatus.maintenance;
      case DomeSystemStatus.calibrating:
        return connectivity.DomeSystemStatus.calibrating;
    }
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }
}
