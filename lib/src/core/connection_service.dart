import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/dome_models.dart';
import '../models/content_models.dart';

/// Сервис для управления подключениями к FreeDome системам
class FreeDomeConnectionService extends ChangeNotifier {
  static final FreeDomeConnectionService _instance = FreeDomeConnectionService._internal();
  factory FreeDomeConnectionService() => _instance;
  FreeDomeConnectionService._internal();

  // Состояние подключения
  FreeDomeConnectionStatus _connectionStatus = const FreeDomeConnectionStatus(
    isConnected: false,
    isConnecting: false,
  );

  // Активные соединения
  final Map<String, IO.Socket> _socketConnections = {};
  final Map<String, WebSocketChannel> _wsConnections = {};
  final Map<String, http.Client> _httpClients = {};
  
  // Обнаруженные системы
  final List<DomeSystem> _discoveredSystems = [];
  DomeSystem? _activeDome;
  
  // Таймеры и подписки
  Timer? _discoveryTimer;
  Timer? _heartbeatTimer;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  
  // Контроллеры событий
  final StreamController<FreeDomeEvent> _eventController = 
      StreamController<FreeDomeEvent>.broadcast();
  final StreamController<List<DomeSystem>> _systemsController = 
      StreamController<List<DomeSystem>>.broadcast();

  // Геттеры
  FreeDomeConnectionStatus get connectionStatus => _connectionStatus;
  List<DomeSystem> get discoveredSystems => List.from(_discoveredSystems);
  DomeSystem? get activeDome => _activeDome;
  bool get isConnected => _connectionStatus.isConnected;
  bool get isConnecting => _connectionStatus.isConnecting;
  
  // Потоки событий
  Stream<FreeDomeEvent> get eventStream => _eventController.stream;
  Stream<List<DomeSystem>> get systemsStream => _systemsController.stream;

  /// Инициализация сервиса
  Future<void> initialize() async {
    try {
      // Настройка мониторинга сетевого подключения
      _setupConnectivityMonitoring();
      
      // Запуск автоматического обнаружения систем
      await startDiscovery();
      
      if (kDebugMode) {
        print('✅ FreeDomeConnectionService инициализирован');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации FreeDomeConnectionService: $e');
      }
    }
  }

  /// Настройка мониторинга сетевого подключения
  void _setupConnectivityMonitoring() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          _handleNetworkDisconnected();
        } else {
          _handleNetworkConnected();
        }
      },
    );
  }

  /// Обработка потери сетевого подключения
  void _handleNetworkDisconnected() {
    if (kDebugMode) {
      print('📵 Сетевое подключение потеряно');
    }
    
    // Отключаем все активные соединения
    for (final systemId in _socketConnections.keys.toList()) {
      _disconnectSocket(systemId);
    }
    
    _updateConnectionStatus(isConnected: false, error: 'Нет сетевого подключения');
  }

  /// Обработка восстановления сетевого подключения
  void _handleNetworkConnected() {
    if (kDebugMode) {
      print('🌐 Сетевое подключение восстановлено');
    }
    
    // Попытка переподключения к активному куполу
    if (_activeDome != null) {
      connectToDome(_activeDome!);
    }
  }

  /// Запуск автоматического обнаружения систем
  Future<void> startDiscovery() async {
    _discoveryTimer?.cancel();
    
    await _scanForSystems();
    
    // Периодическое обновление списка систем
    _discoveryTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _scanForSystems();
    });
  }

  /// Остановка обнаружения систем
  void stopDiscovery() {
    _discoveryTimer?.cancel();
    _discoveryTimer = null;
  }

  /// Сканирование локальной сети на наличие FreeDome систем
  Future<void> _scanForSystems() async {
    try {
      final List<DomeSystem> foundSystems = [];
      
      // Получаем локальную подсеть
      final subnet = await _getLocalSubnet();
      final List<int> commonPorts = [8080, 8081, 3000, 5000, 9000];
      
      // Сканируем IP адреса в подсети
      final List<Future<DomeSystem?>> scanTasks = [];
      
      for (int i = 1; i <= 254; i++) {
        final ip = '$subnet.$i';
        for (final port in commonPorts) {
          scanTasks.add(_checkSystemAtAddress(ip, port));
        }
      }
      
      // Выполняем сканирование параллельно
      final results = await Future.wait(scanTasks);
      
      for (final system in results) {
        if (system != null) {
          foundSystems.add(system);
        }
      }
      
      // Обновляем список обнаруженных систем
      _discoveredSystems.clear();
      _discoveredSystems.addAll(foundSystems);
      _systemsController.add(_discoveredSystems);
      
      if (kDebugMode) {
        print('🔍 Найдено ${foundSystems.length} FreeDome систем');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка сканирования систем: $e');
      }
    }
  }

  /// Проверка наличия FreeDome системы по адресу
  Future<DomeSystem?> _checkSystemAtAddress(String ip, int port) async {
    try {
      final client = http.Client();
      
      final response = await client.get(
        Uri.parse('http://$ip:$port/api/dome/info'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 2));
      
      client.close();
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        return DomeSystem(
          id: data['id'] ?? '$ip:$port',
          name: data['name'] ?? 'FreeDome System',
          ipAddress: ip,
          port: port,
          type: _parseSystemType(data['type']),
          status: DomeSystemStatus.offline,
          firmwareVersion: data['firmware_version'],
          capabilities: data['capabilities'],
        );
      }
    } catch (e) {
      // Игнорируем ошибки - система недоступна
    }
    
    return null;
  }

  /// Подключение к купольной системе
  Future<bool> connectToDome(DomeSystem dome) async {
    if (_connectionStatus.isConnecting) {
      return false;
    }

    _updateConnectionStatus(isConnecting: true);
    
    try {
      // Проверяем доступность системы
      final isAvailable = await _testSystemAvailability(dome);
      if (!isAvailable) {
        throw Exception('Система недоступна');
      }

      // Устанавливаем Socket.IO соединение
      final socket = await _createSocketConnection(dome);
      _socketConnections[dome.id] = socket;

      // Устанавливаем WebSocket соединение для команд
      final wsChannel = await _createWebSocketConnection(dome);
      _wsConnections[dome.id] = wsChannel;

      // Создаем HTTP клиент для API запросов
      _httpClients[dome.id] = http.Client();

      _activeDome = dome.copyWith(
        status: DomeSystemStatus.online,
        isConnected: true,
        lastConnected: DateTime.now(),
      );

      _updateConnectionStatus(
        isConnected: true,
        isConnecting: false,
        connectedDomeId: dome.id,
        serverUrl: 'http://${dome.ipAddress}:${dome.port}',
        lastConnected: DateTime.now(),
      );

      // Запускаем heartbeat для мониторинга соединения
      _startHeartbeat(dome.id);

      _emitEvent(FreeDomeEvent(
        type: 'dome_connected',
        data: {'domeId': dome.id, 'domeName': dome.name},
        sourceSystemId: dome.id,
        timestamp: DateTime.now(),
      ));

      if (kDebugMode) {
        print('✅ Подключен к FreeDome: ${dome.name}');
      }

      return true;
    } catch (e) {
      _updateConnectionStatus(
        isConnected: false,
        isConnecting: false,
        error: e.toString(),
      );

      if (kDebugMode) {
        print('❌ Ошибка подключения к FreeDome: $e');
      }

      return false;
    }
  }

  /// Отключение от купольной системы
  Future<void> disconnectFromDome() async {
    if (_activeDome == null) return;

    try {
      final domeId = _activeDome!.id;
      
      // Отправляем команду отключения
      await sendCommand(FreeDomeCommand(
        type: 'disconnect',
        data: {'reason': 'user_initiated'},
        targetSystemId: domeId,
        timestamp: DateTime.now(),
      ));

      // Закрываем все соединения
      _disconnectSocket(domeId);
      _disconnectWebSocket(domeId);
      _disconnectHttp(domeId);

      _stopHeartbeat();

      _activeDome = null;
      _updateConnectionStatus(isConnected: false, isConnecting: false);

      _emitEvent(FreeDomeEvent(
        type: 'dome_disconnected',
        data: {'domeId': domeId},
        sourceSystemId: domeId,
        timestamp: DateTime.now(),
      ));

      if (kDebugMode) {
        print('✅ Отключен от FreeDome');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка отключения от FreeDome: $e');
      }
    }
  }

  /// Отправка команды купольной системе
  Future<FreeDomeResponse> sendCommand(FreeDomeCommand command) async {
    if (!isConnected || _activeDome == null) {
      return const FreeDomeResponse(
        success: false,
        error: 'Нет подключения к FreeDome системе',
      );
    }

    try {
      final domeId = _activeDome!.id;
      final wsChannel = _wsConnections[domeId];
      
      if (wsChannel == null) {
        throw Exception('WebSocket соединение не найдено');
      }

      final message = json.encode(command.toJson());
      wsChannel.sink.add(message);

      // Для простоты возвращаем успешный ответ
      // В реальной реализации нужно ждать ответ от системы
      return FreeDomeResponse(
        success: true,
        commandId: command.type,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return FreeDomeResponse(
        success: false,
        error: e.toString(),
        commandId: command.type,
        timestamp: DateTime.now(),
      );
    }
  }

  /// Создание Socket.IO соединения
  Future<IO.Socket> _createSocketConnection(DomeSystem dome) async {
    final socket = IO.io('http://${dome.ipAddress}:${dome.port}', {
      'transports': ['websocket'],
      'autoConnect': true,
      'timeout': 10000,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
    });

    final completer = Completer<IO.Socket>();

    socket.onConnect((_) {
      if (kDebugMode) {
        print('🔌 Socket.IO подключен к ${dome.name}');
      }
      
      _setupSocketListeners(socket, dome.id);
      
      if (!completer.isCompleted) {
        completer.complete(socket);
      }
    });

    socket.onConnectError((error) {
      if (!completer.isCompleted) {
        completer.completeError(Exception('Socket.IO ошибка: $error'));
      }
    });

    return completer.future.timeout(const Duration(seconds: 10));
  }

  /// Создание WebSocket соединения
  Future<WebSocketChannel> _createWebSocketConnection(DomeSystem dome) async {
    final wsUrl = 'ws://${dome.ipAddress}:${dome.port}/ws/commands';
    final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    // Настройка обработчиков
    channel.stream.listen(
      (message) => _handleWebSocketMessage(dome.id, message),
      onError: (error) => _handleWebSocketError(dome.id, error),
      onDone: () => _handleWebSocketClosed(dome.id),
    );

    return channel;
  }

  /// Настройка слушателей Socket.IO
  void _setupSocketListeners(IO.Socket socket, String domeId) {
    socket.on('dome-state', (data) {
      _emitEvent(FreeDomeEvent(
        type: 'dome_state_update',
        data: Map<String, dynamic>.from(data),
        sourceSystemId: domeId,
        timestamp: DateTime.now(),
      ));
    });

    socket.on('integration-event', (data) {
      _emitEvent(FreeDomeEvent(
        type: 'integration_event',
        data: Map<String, dynamic>.from(data),
        sourceSystemId: domeId,
        timestamp: DateTime.now(),
      ));
    });

    socket.onDisconnect((reason) {
      if (kDebugMode) {
        print('🔌 Socket.IO отключен: $reason');
      }
      _handleSocketDisconnect(domeId, reason);
    });
  }

  /// Обработка отключения Socket.IO
  void _handleSocketDisconnect(String domeId, dynamic reason) {
    if (_activeDome?.id == domeId) {
      _updateConnectionStatus(
        isConnected: false,
        error: 'Соединение потеряно: $reason',
      );
      
      // Попытка переподключения
      _attemptReconnect();
    }
  }

  /// Попытка переподключения
  void _attemptReconnect() async {
    if (_activeDome == null || _connectionStatus.reconnectAttempts >= _connectionStatus.maxReconnectAttempts) {
      return;
    }

    await Future.delayed(Duration(seconds: 2 * (_connectionStatus.reconnectAttempts + 1)));
    
    _updateConnectionStatus(
      reconnectAttempts: _connectionStatus.reconnectAttempts + 1,
    );

    final success = await connectToDome(_activeDome!);
    if (success) {
      _updateConnectionStatus(reconnectAttempts: 0);
    }
  }

  /// Тестирование доступности системы
  Future<bool> _testSystemAvailability(DomeSystem dome) async {
    try {
      final client = http.Client();
      final response = await client.get(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/dome/status'),
      ).timeout(const Duration(seconds: 5));
      
      client.close();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Получение локальной подсети
  Future<String> _getLocalSubnet() async {
    try {
      final interfaces = await NetworkInterface.list();
      for (final interface in interfaces) {
        for (final address in interface.addresses) {
          if (address.type == InternetAddressType.IPv4 && 
              !address.isLoopback && 
              (address.address.startsWith('192.168.') || 
               address.address.startsWith('10.') ||
               address.address.startsWith('172.'))) {
            final parts = address.address.split('.');
            return '${parts[0]}.${parts[1]}.${parts[2]}';
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения подсети: $e');
      }
    }
    return '192.168.1'; // Fallback
  }

  /// Парсинг типа системы
  DomeSystemType _parseSystemType(String? type) {
    switch (type?.toLowerCase()) {
      case 'professional':
        return DomeSystemType.professional;
      case 'mobile':
        return DomeSystemType.mobile;
      case 'hybrid':
        return DomeSystemType.hybrid;
      default:
        return DomeSystemType.professional;
    }
  }

  /// Запуск heartbeat мониторинга
  void _startHeartbeat(String domeId) {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _sendHeartbeat(domeId);
    });
  }

  /// Остановка heartbeat мониторинга
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// Отправка heartbeat
  void _sendHeartbeat(String domeId) async {
    try {
      final socket = _socketConnections[domeId];
      if (socket != null && socket.connected) {
        socket.emit('heartbeat', {'timestamp': DateTime.now().toIso8601String()});
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка heartbeat: $e');
      }
    }
  }

  /// Обработка WebSocket сообщений
  void _handleWebSocketMessage(String domeId, dynamic message) {
    try {
      final data = json.decode(message);
      _emitEvent(FreeDomeEvent(
        type: data['type'] ?? 'unknown',
        data: data['data'] ?? {},
        sourceSystemId: domeId,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обработки WebSocket сообщения: $e');
      }
    }
  }

  /// Обработка ошибок WebSocket
  void _handleWebSocketError(String domeId, dynamic error) {
    if (kDebugMode) {
      print('❌ WebSocket ошибка для $domeId: $error');
    }
  }

  /// Обработка закрытия WebSocket
  void _handleWebSocketClosed(String domeId) {
    if (kDebugMode) {
      print('🔌 WebSocket закрыт для $domeId');
    }
  }

  /// Отключение Socket.IO соединения
  void _disconnectSocket(String domeId) {
    final socket = _socketConnections[domeId];
    if (socket != null) {
      socket.disconnect();
      _socketConnections.remove(domeId);
    }
  }

  /// Отключение WebSocket соединения
  void _disconnectWebSocket(String domeId) {
    final channel = _wsConnections[domeId];
    if (channel != null) {
      channel.sink.close();
      _wsConnections.remove(domeId);
    }
  }

  /// Отключение HTTP клиента
  void _disconnectHttp(String domeId) {
    final client = _httpClients[domeId];
    if (client != null) {
      client.close();
      _httpClients.remove(domeId);
    }
  }

  /// Обновление статуса подключения
  void _updateConnectionStatus({
    bool? isConnected,
    bool? isConnecting,
    String? connectedDomeId,
    String? serverUrl,
    DateTime? lastConnected,
    String? error,
    int? reconnectAttempts,
  }) {
    _connectionStatus = _connectionStatus.copyWith(
      isConnected: isConnected ?? _connectionStatus.isConnected,
      isConnecting: isConnecting ?? _connectionStatus.isConnecting,
      connectedDomeId: connectedDomeId ?? _connectionStatus.connectedDomeId,
      serverUrl: serverUrl ?? _connectionStatus.serverUrl,
      lastConnected: lastConnected ?? _connectionStatus.lastConnected,
      error: error,
      reconnectAttempts: reconnectAttempts ?? _connectionStatus.reconnectAttempts,
    );
    
    notifyListeners();
  }

  /// Отправка события
  void _emitEvent(FreeDomeEvent event) {
    _eventController.add(event);
  }

  /// Получение HTTP клиента для системы
  http.Client? getHttpClient(String domeId) {
    return _httpClients[domeId];
  }

  /// Получение Socket.IO для системы
  IO.Socket? getSocket(String domeId) {
    return _socketConnections[domeId];
  }

  @override
  void dispose() {
    stopDiscovery();
    _stopHeartbeat();
    _connectivitySubscription?.cancel();
    
    // Закрываем все соединения
    for (final socket in _socketConnections.values) {
      socket.disconnect();
    }
    for (final channel in _wsConnections.values) {
      channel.sink.close();
    }
    for (final client in _httpClients.values) {
      client.close();
    }
    
    _eventController.close();
    _systemsController.close();
    
    super.dispose();
  }
}
