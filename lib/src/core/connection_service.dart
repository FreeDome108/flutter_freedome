import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as socket_io_client;
import '../models/dome_models.dart';
import '../models/calibration_models.dart';

/// Сервис для управления подключениями к FreeDome системам
class FreeDomeConnectionService extends ChangeNotifier {
  static final FreeDomeConnectionService _instance =
      FreeDomeConnectionService._internal();
  factory FreeDomeConnectionService() => _instance;
  FreeDomeConnectionService._internal();

  // Состояние подключения
  FreeDomeConnectionStatus _connectionStatus = const FreeDomeConnectionStatus(
    isConnected: false,
    isConnecting: false,
  );
  final List<DomeSystem> _discoveredSystems = [];
  DomeSystem? _activeDome;

  // HTTP клиент
  final http.Client _httpClient = http.Client();

  // Socket.IO клиент
  socket_io_client.Socket? _socket;

  // Потоки событий
  final StreamController<FreeDomeEvent> _eventController =
      StreamController<FreeDomeEvent>.broadcast();
  final StreamController<List<DomeSystem>> _systemsController =
      StreamController<List<DomeSystem>>.broadcast();

  // Таймер для периодического обнаружения
  Timer? _discoveryTimer;

  /// Получить статус подключения
  FreeDomeConnectionStatus get connectionStatus => _connectionStatus;

  /// Получить обнаруженные системы
  List<DomeSystem> get discoveredSystems =>
      List.unmodifiable(_discoveredSystems);

  /// Получить активную купольную систему
  DomeSystem? get activeDome => _activeDome;

  /// Проверить подключение
  bool get isConnected => _connectionStatus.isConnected;

  /// Проверить процесс подключения
  bool get isConnecting => _connectionStatus.isConnecting;

  /// Получить поток событий
  Stream<FreeDomeEvent> get eventStream => _eventController.stream;

  /// Получить поток систем
  Stream<List<DomeSystem>> get systemsStream => _systemsController.stream;

  /// Инициализация сервиса
  Future<void> initialize() async {
    try {
      _updateConnectionStatus(isConnecting: true);

      // Запуск обнаружения систем
      await startDiscovery();

      // Периодическое обновление систем
      _startPeriodicDiscovery();

      _updateConnectionStatus(isConnecting: false);

      if (kDebugMode) {
        print('✅ FreeDome Connection Service initialized');
      }
    } catch (e) {
      _updateConnectionStatus(isConnecting: false, error: e.toString());
      if (kDebugMode) {
        print('❌ Failed to initialize connection service: $e');
      }
      rethrow;
    }
  }

  /// Запуск обнаружения систем
  Future<void> startDiscovery() async {
    try {
      if (kDebugMode) {
        print('🔍 Starting FreeDome systems discovery...');
      }

      // Здесь должна быть логика обнаружения систем в сети
      // Пока что симулируем обнаружение
      await _simulateSystemDiscovery();

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Discovery failed: $e');
      }
      rethrow;
    }
  }

  /// Остановка обнаружения
  Future<void> stopDiscovery() async {
    _discoveryTimer?.cancel();
    _discoveryTimer = null;

    if (kDebugMode) {
      print('🛑 Discovery stopped');
    }
  }

  /// Обновление списка систем
  Future<void> refreshSystems() async {
    await startDiscovery();
  }

  /// Подключение к купольной системе
  Future<bool> connectToDome(String domeId) async {
    try {
      final system = _discoveredSystems.firstWhere((s) => s.id == domeId);

      _updateConnectionStatus(isConnecting: true);

      // Здесь должна быть логика подключения к системе
      // Пока что симулируем подключение
      await _simulateConnection(system);

      _activeDome =
          system.copyWith(isConnected: true, lastConnected: DateTime.now());
      _updateConnectionStatus(
        isConnected: true,
        isConnecting: false,
        connectedDomeId: domeId,
        serverUrl: 'http://${system.ipAddress}:${system.port}',
        lastConnected: DateTime.now(),
      );

      // Подключение к WebSocket
      await _connectSocket(system);

      _eventController.add(FreeDomeEvent(
        type: 'system_connected',
        data: {'domeId': domeId, 'system': system.toJson()},
      ));

      notifyListeners();

      if (kDebugMode) {
        print('✅ Connected to FreeDome system: ${system.name}');
      }

      return true;
    } catch (e) {
      _updateConnectionStatus(isConnecting: false, error: e.toString());

      if (kDebugMode) {
        print('❌ Failed to connect to dome $domeId: $e');
      }

      return false;
    }
  }

  /// Отключение от купольной системы
  Future<void> disconnectFromDome() async {
    try {
      if (_activeDome != null) {
        final domeId = _activeDome!.id;

        // Отключение от WebSocket
        await _disconnectSocket();

        _activeDome = null;
        _updateConnectionStatus(
          isConnected: false,
          connectedDomeId: null,
          serverUrl: null,
        );

        _eventController.add(FreeDomeEvent(
          type: 'system_disconnected',
          data: {'domeId': domeId},
        ));

        notifyListeners();

        if (kDebugMode) {
          print('✅ Disconnected from FreeDome system');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error disconnecting from dome: $e');
      }
    }
  }

  /// Отправка команды к системе
  Future<FreeDomeResponse> sendCommand(FreeDomeCommand command) async {
    try {
      if (!isConnected || _activeDome == null) {
        return FreeDomeResponse(
          success: false,
          error: 'Not connected to any FreeDome system',
        );
      }

      // Отправка команды через HTTP или WebSocket
      if (_socket?.connected == true) {
        return await _sendCommandViaSocket(command);
      } else {
        return await _sendCommandViaHttp(command);
      }
    } catch (e) {
      return FreeDomeResponse(
        success: false,
        error: 'Failed to send command: $e',
      );
    }
  }

  /// Получение HTTP клиента
  http.Client getHttpClient() => _httpClient;

  /// Получение Socket.IO клиента
  socket_io_client.Socket? getSocket() => _socket;

  /// Освобождение ресурсов
  @override
  void dispose() {
    _discoveryTimer?.cancel();
    _disconnectSocket();
    _httpClient.close();
    _eventController.close();
    _systemsController.close();
    super.dispose();
  }

  // Приватные методы

  void _updateConnectionStatus({
    bool? isConnected,
    bool? isConnecting,
    String? connectedDomeId,
    String? serverUrl,
    DateTime? lastConnected,
    String? error,
  }) {
    _connectionStatus = _connectionStatus.copyWith(
      isConnected: isConnected ?? _connectionStatus.isConnected,
      isConnecting: isConnecting ?? _connectionStatus.isConnecting,
      connectedDomeId: connectedDomeId,
      serverUrl: serverUrl,
      lastConnected: lastConnected,
      error: error,
    );
    notifyListeners();
  }

  void _startPeriodicDiscovery() {
    _discoveryTimer?.cancel();
    _discoveryTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      startDiscovery();
    });
  }

  Future<void> _simulateSystemDiscovery() async {
    // Симуляция обнаружения систем
    await Future.delayed(const Duration(seconds: 2));

    final systems = [
      DomeSystem(
        id: 'dome_001',
        name: 'Main Dome Theater',
        ipAddress: '192.168.1.100',
        port: 8080,
        type: DomeSystemType.professional,
        status: DomeSystemStatus.online,
        isConnected: false,
        projectors: [
          ProjectorConfig(
            id: 'proj_001',
            name: 'Main Projector',
            type: ProjectorType.laser,
            brightness: 100,
            contrast: 100,
            status: ProjectorStatus.active,
          ),
        ],
        audioChannels: [
          AudioChannel(
            id: 'audio_001',
            name: 'Main Audio',
            type: AudioChannelType.surround,
            volume: 0.8,
          ),
        ],
        systemVolume: 0.8,
        systemBrightness: 0.9,
      ),
      DomeSystem(
        id: 'dome_002',
        name: 'Mobile Dome Unit',
        ipAddress: '192.168.1.101',
        port: 8080,
        type: DomeSystemType.mobile,
        status: DomeSystemStatus.online,
        isConnected: false,
        projectors: [
          ProjectorConfig(
            id: 'proj_002',
            name: 'Mobile Projector',
            type: ProjectorType.led,
            brightness: 90,
            contrast: 95,
            status: ProjectorStatus.active,
          ),
        ],
        audioChannels: [
          AudioChannel(
            id: 'audio_002',
            name: 'Mobile Audio',
            type: AudioChannelType.stereo,
            volume: 0.7,
          ),
        ],
        systemVolume: 0.7,
        systemBrightness: 0.8,
      ),
    ];

    _discoveredSystems.clear();
    _discoveredSystems.addAll(systems);
    _systemsController.add(_discoveredSystems);
  }

  Future<void> _simulateConnection(DomeSystem system) async {
    // Симуляция подключения
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _connectSocket(DomeSystem system) async {
    try {
      final url = 'http://${system.ipAddress}:${system.port}';

      _socket = socket_io_client.io(
          url,
          socket_io_client.OptionBuilder()
              .setTransports(['websocket'])
              .enableAutoConnect()
              .build());

      _socket!.onConnect((_) {
        if (kDebugMode) {
          print('✅ WebSocket connected to ${system.name}');
        }
      });

      _socket!.onDisconnect((_) {
        if (kDebugMode) {
          print('❌ WebSocket disconnected from ${system.name}');
        }
      });

      _socket!.onError((error) {
        if (kDebugMode) {
          print('❌ WebSocket error: $error');
        }
      });

      _socket!.on('system_event', (data) {
        _eventController.add(FreeDomeEvent(
          type: 'system_event',
          data: data as Map<String, dynamic>,
        ));
      });

      await _socket!.connect();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to connect WebSocket: $e');
      }
    }
  }

  Future<void> _disconnectSocket() async {
    _socket?.disconnect();
    _socket = null;
  }

  Future<FreeDomeResponse> _sendCommandViaSocket(
      FreeDomeCommand command) async {
    final completer = Completer<FreeDomeResponse>();

    _socket!.emit('command', command.toJson());

    _socket!.on('command_response', (data) {
      final response = FreeDomeResponse.fromJson(data as Map<String, dynamic>);
      completer.complete(response);
    });

    // Таймаут для команды
    Timer(const Duration(seconds: 5), () {
      if (!completer.isCompleted) {
        completer.complete(FreeDomeResponse(
          success: false,
          error: 'Command timeout',
        ));
      }
    });

    return completer.future;
  }

  Future<FreeDomeResponse> _sendCommandViaHttp(FreeDomeCommand command) async {
    try {
      final url =
          'http://${_activeDome!.ipAddress}:${_activeDome!.port}/api/command';

      final response = await _httpClient
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: command.toJson(),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = response.body.isNotEmpty
            ? Map<String, dynamic>.from(response.body as Map<String, dynamic>)
            : <String, dynamic>{};

        return FreeDomeResponse(
          success: true,
          data: data,
          timestamp: DateTime.now(),
        );
      } else {
        return FreeDomeResponse(
          success: false,
          error: 'HTTP ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      return FreeDomeResponse(
        success: false,
        error: 'HTTP request failed: $e',
      );
    }
  }
}
