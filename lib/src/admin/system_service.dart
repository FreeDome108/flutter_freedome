import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../core/connection_service.dart';
import '../core/auth_service.dart';
import '../models/dome_models.dart';
import '../models/content_models.dart';
import '../models/calibration_models.dart';

/// Сервис системного управления FreeDome (только для администраторов)
class FreeDomeSystemService extends ChangeNotifier {
  final FreeDomeConnectionService _connectionService =
      FreeDomeConnectionService();
  final FreeDomeAuthService _authService = FreeDomeAuthService();

  // Системная информация
  Map<String, dynamic> _systemInfo = {};
  Map<String, dynamic> _systemMetrics = {};
  List<String> _availableVendors = [];
  String? _activeVendor;

  // Таймеры
  Timer? _metricsTimer;

  // Контроллеры событий
  final StreamController<Map<String, dynamic>> _metricsController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<List<String>> _logsController =
      StreamController<List<String>>.broadcast();

  // Геттеры
  Map<String, dynamic> get systemInfo => Map.from(_systemInfo);
  Map<String, dynamic> get systemMetrics => Map.from(_systemMetrics);
  List<String> get availableVendors => List.from(_availableVendors);
  String? get activeVendor => _activeVendor;
  Stream<Map<String, dynamic>> get metricsStream => _metricsController.stream;
  Stream<List<String>> get logsStream => _logsController.stream;

  /// Проверка разрешений для системного управления
  bool get canManageSystem =>
      _authService.hasPermission(FreeDomePermission.systemManagement);

  /// Инициализация системного сервиса
  Future<void> initialize() async {
    if (!canManageSystem) {
      if (kDebugMode) {
        print('❌ Нет разрешения на системное управление');
      }
      return;
    }

    try {
      await _loadSystemInfo();
      await _loadAvailableVendors();
      await _loadActiveVendor();
      _startMetricsMonitoring();

      if (kDebugMode) {
        print('✅ FreeDomeSystemService инициализирован');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации FreeDomeSystemService: $e');
      }
    }
  }

  /// Загрузка информации о системе
  Future<void> _loadSystemInfo() async {
    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return;

      final client = _connectionService.getHttpClient();
      if (client == null) return;

      final response = await client.get(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/system/info'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _systemInfo = json.decode(response.body);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки информации о системе: $e');
      }
    }
  }

  /// Загрузка доступных вендоров
  Future<void> _loadAvailableVendors() async {
    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return;

      final client = _connectionService.getHttpClient();
      if (client == null) return;

      final response = await client.get(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/vendor/adapters'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _availableVendors = List<String>.from(data['vendors'] ?? []);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки вендоров: $e');
      }
    }
  }

  /// Загрузка активного вендора
  Future<void> _loadActiveVendor() async {
    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return;

      final client = _connectionService.getHttpClient();
      if (client == null) return;

      final response = await client.get(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/vendor/active'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _activeVendor = data['vendor'];
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки активного вендора: $e');
      }
    }
  }

  /// Установка активного вендора
  Future<bool> setActiveVendor(String vendor) async {
    if (!canManageSystem) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_active_vendor',
        data: {'vendor': vendor},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success) {
        _activeVendor = vendor;
        notifyListeners();

        if (kDebugMode) {
          print('✅ Активный вендор установлен: $vendor');
        }
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки активного вендора: $e');
      }
      return false;
    }
  }

  /// Тестирование вендорского адаптера
  Future<Map<String, dynamic>?> testVendorAdapter(String vendor) async {
    if (!canManageSystem) {
      return null;
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return null;

      final client = _connectionService.getHttpClient();
      if (client == null) return null;

      final response = await client.post(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/vendor/test'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'vendor': vendor}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка тестирования адаптера: $e');
      }
    }

    return null;
  }

  /// Перезагрузка системы
  Future<bool> rebootSystem() async {
    if (!_authService.hasRole(FreeDomeUserRole.superadmin)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'system_reboot',
        data: {'reason': 'admin_initiated'},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Перезагрузка системы запущена'
            : '❌ Ошибка перезагрузки: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка перезагрузки системы: $e');
      }
      return false;
    }
  }

  /// Обновление прошивки
  Future<bool> updateFirmware(String firmwarePath) async {
    if (!_authService.hasRole(FreeDomeUserRole.superadmin)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'update_firmware',
        data: {'firmwarePath': firmwarePath},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Обновление прошивки запущено'
            : '❌ Ошибка обновления прошивки: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления прошивки: $e');
      }
      return false;
    }
  }

  /// Получение системных логов
  Future<List<String>> getSystemLogs({int limit = 100}) async {
    if (!canManageSystem) {
      return [];
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return [];

      final client = _connectionService.getHttpClient();
      if (client == null) return [];

      final response = await client.get(
        Uri.parse(
            'http://${dome.ipAddress}:${dome.port}/api/system/logs?limit=$limit'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final logs = List<String>.from(data['logs'] ?? []);
        _logsController.add(logs);
        return logs;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения логов: $e');
      }
    }

    return [];
  }

  /// Очистка системных логов
  Future<bool> clearSystemLogs() async {
    if (!_authService.hasRole(FreeDomeUserRole.superadmin)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'clear_logs',
        data: {},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);
      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка очистки логов: $e');
      }
      return false;
    }
  }

  /// Создание резервной копии конфигурации
  Future<Map<String, dynamic>?> backupConfiguration() async {
    if (!canManageSystem) {
      return null;
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return null;

      final client = _connectionService.getHttpClient();
      if (client == null) return null;

      final response = await client.post(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/system/backup'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final backup = json.decode(response.body);

        if (kDebugMode) {
          print('✅ Резервная копия создана');
        }

        return backup;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка создания резервной копии: $e');
      }
    }

    return null;
  }

  /// Восстановление конфигурации
  Future<bool> restoreConfiguration(Map<String, dynamic> backup) async {
    if (!_authService.hasRole(FreeDomeUserRole.superadmin)) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'restore_configuration',
        data: {'backup': backup},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Конфигурация восстановлена'
            : '❌ Ошибка восстановления: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка восстановления конфигурации: $e');
      }
      return false;
    }
  }

  /// Запуск мониторинга метрик
  void _startMetricsMonitoring() {
    _metricsTimer?.cancel();
    _metricsTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await _updateSystemMetrics();
    });
  }

  /// Остановка мониторинга метрик
  void _stopMetricsMonitoring() {
    _metricsTimer?.cancel();
    _metricsTimer = null;
  }

  /// Обновление системных метрик
  Future<void> _updateSystemMetrics() async {
    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return;

      final client = _connectionService.getHttpClient();
      if (client == null) return;

      final response = await client.get(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/system/metrics'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _systemMetrics = json.decode(response.body);
        _metricsController.add(_systemMetrics);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка обновления метрик: $e');
      }
    }
  }

  /// Получение состояния системы
  Future<Map<String, dynamic>?> getSystemHealth() async {
    if (!canManageSystem) {
      return null;
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return null;

      final client = _connectionService.getHttpClient();
      if (client == null) return null;

      final response = await client.get(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/system/health'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения состояния системы: $e');
      }
    }

    return null;
  }

  /// Установка типа проекции
  Future<bool> setProjectionType(String projectionType) async {
    if (!canManageSystem) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_projection_type',
        data: {'projectionType': projectionType},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Тип проекции установлен: $projectionType'
            : '❌ Ошибка установки типа проекции: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки типа проекции: $e');
      }
      return false;
    }
  }

  /// Установка типа инсталляции
  Future<bool> setInstallationType(String installationType) async {
    if (!canManageSystem) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_installation_type',
        data: {'installationType': installationType},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Тип инсталляции установлен: $installationType'
            : '❌ Ошибка установки типа инсталляции: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки типа инсталляции: $e');
      }
      return false;
    }
  }

  /// Установка вычислительного бэкенда
  Future<bool> setComputeBackend(String backend) async {
    if (!canManageSystem) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_compute_backend',
        data: {'backend': backend},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ Вычислительный бэкенд установлен: $backend'
            : '❌ Ошибка установки бэкенда: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка установки вычислительного бэкенда: $e');
      }
      return false;
    }
  }

  /// Включение/выключение NDI
  Future<bool> setNDIEnabled(bool enabled) async {
    if (!canManageSystem) {
      return false;
    }

    try {
      final command = FreeDomeCommand(
        type: 'set_ndi_enabled',
        data: {'enabled': enabled},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (kDebugMode) {
        print(response.success
            ? '✅ NDI ${enabled ? "включен" : "выключен"}'
            : '❌ Ошибка настройки NDI: ${response.error}');
      }

      return response.success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка настройки NDI: $e');
      }
      return false;
    }
  }

  /// Получение списка поддерживаемых команд
  Future<List<String>> getSupportedCommands() async {
    if (!canManageSystem) {
      return [];
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return [];

      final client = _connectionService.getHttpClient();
      if (client == null) return [];

      final response = await client.get(
        Uri.parse('http://${dome.ipAddress}:${dome.port}/api/system/commands'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<String>.from(data['commands'] ?? []);
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения поддерживаемых команд: $e');
      }
    }

    return [];
  }

  /// Выполнение произвольной команды
  Future<FreeDomeResponse> executeCommand({
    required String command,
    Map<String, dynamic>? parameters,
  }) async {
    if (!canManageSystem) {
      return const FreeDomeResponse(
        success: false,
        error: 'Нет разрешения на выполнение команд',
      );
    }

    try {
      final freedomeCommand = FreeDomeCommand(
        type: command,
        data: parameters ?? {},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      return await _connectionService.sendCommand(freedomeCommand);
    } catch (e) {
      return FreeDomeResponse(
        success: false,
        error: e.toString(),
        timestamp: DateTime.now(),
      );
    }
  }

  /// Диагностика системы
  Future<Map<String, dynamic>?> runDiagnostics() async {
    if (!canManageSystem) {
      return null;
    }

    try {
      final command = FreeDomeCommand(
        type: 'run_diagnostics',
        data: {},
        targetSystemId: _connectionService.activeDome?.id,
        timestamp: DateTime.now(),
      );

      final response = await _connectionService.sendCommand(command);

      if (response.success && response.data != null) {
        if (kDebugMode) {
          print('✅ Диагностика системы завершена');
        }
        return response.data;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка диагностики системы: $e');
      }
    }

    return null;
  }

  /// Получение температурных показателей
  Future<Map<String, double>?> getTemperatureReadings() async {
    if (!canManageSystem) {
      return null;
    }

    try {
      final dome = _connectionService.activeDome;
      if (dome == null) return null;

      final client = _connectionService.getHttpClient();
      if (client == null) return null;

      final response = await client.get(
        Uri.parse(
            'http://${dome.ipAddress}:${dome.port}/api/system/temperature'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Map<String, double>.from(data['temperatures'] ?? {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка получения температурных показателей: $e');
      }
    }

    return null;
  }

  /// Получение статистики производительности
  Map<String, dynamic> getPerformanceStats() {
    final hasMetrics = _systemMetrics.isNotEmpty;

    return {
      'hasMetrics': hasMetrics,
      'systemInfo': _systemInfo,
      'currentMetrics': _systemMetrics,
      'activeVendor': _activeVendor,
      'availableVendors': _availableVendors,
      'canManageSystem': canManageSystem,
      'monitoringActive': _metricsTimer?.isActive ?? false,
    };
  }

  @override
  void dispose() {
    _stopMetricsMonitoring();
    _metricsController.close();
    _logsController.close();
    super.dispose();
  }
}
