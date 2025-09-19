import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/freedome_provider.dart';
import '../models/dome_models.dart';

/// Виджет для управления подключением к FreeDome
class FreeDomeConnectionWidget extends StatefulWidget {
  final Widget Function(BuildContext context, bool isConnected)? builder;
  final VoidCallback? onConnected;
  final VoidCallback? onDisconnected;
  final bool autoConnect;
  final bool showDiscoveredSystems;

  const FreeDomeConnectionWidget({
    super.key,
    this.builder,
    this.onConnected,
    this.onDisconnected,
    this.autoConnect = true,
    this.showDiscoveredSystems = true,
  });

  @override
  State<FreeDomeConnectionWidget> createState() =>
      _FreeDomeConnectionWidgetState();
}

class _FreeDomeConnectionWidgetState extends State<FreeDomeConnectionWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.autoConnect) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tryAutoConnect();
      });
    }
  }

  Future<void> _tryAutoConnect() async {
    final freedome = context.read<FreeDomeProvider>();

    if (!freedome.isInitialized) {
      await freedome.initialize();
    }

    if (!freedome.isConnected) {
      final success = await freedome.connectToNearestDome();
      if (success && widget.onConnected != null) {
        widget.onConnected!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDomeProvider>(
      builder: (context, freedome, child) {
        if (widget.builder != null) {
          return widget.builder!(context, freedome.isConnected);
        }

        return _buildDefaultUI(context, freedome);
      },
    );
  }

  Widget _buildDefaultUI(BuildContext context, FreeDomeProvider freedome) {
    if (!freedome.isInitialized) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Инициализация FreeDome...'),
          ],
        ),
      );
    }

    if (freedome.isConnected) {
      return _buildConnectedUI(context, freedome);
    }

    return _buildDisconnectedUI(context, freedome);
  }

  Widget _buildConnectedUI(BuildContext context, FreeDomeProvider freedome) {
    final dome = freedome.activeDome!;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Подключен к FreeDome',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDomeInfo(context, dome),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await freedome.disconnect();
                    if (widget.onDisconnected != null) {
                      widget.onDisconnected!();
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Отключиться'),
                ),
                if (freedome.hasRole(FreeDomeUserRole.admin))
                  ElevatedButton.icon(
                    onPressed: () => _showAdminPanel(context, freedome),
                    icon: const Icon(Icons.settings),
                    label: const Text('Настройки'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisconnectedUI(BuildContext context, FreeDomeProvider freedome) {
    final discoveredSystems = freedome.connection.discoveredSystems;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Не подключен к FreeDome',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            if (freedome.error != null) ...[
              const SizedBox(height: 8),
              Text(
                'Ошибка: ${freedome.error}',
                style: TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 16),
            if (widget.showDiscoveredSystems &&
                discoveredSystems.isNotEmpty) ...[
              Text(
                'Обнаруженные системы:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ...discoveredSystems
                  .map((system) => _buildSystemTile(context, system, freedome)),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: freedome.isInitializing
                      ? null
                      : () async {
                          await freedome.connectToNearestDome();
                        },
                  icon: const Icon(Icons.search),
                  label: const Text('Найти купол'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showManualConnection(context, freedome),
                  icon: const Icon(Icons.add),
                  label: const Text('Ручное подключение'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomeInfo(BuildContext context, DomeSystem dome) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Название', dome.name),
        _buildInfoRow('IP адрес', '${dome.ipAddress}:${dome.port}'),
        _buildInfoRow('Тип', dome.type.displayName),
        _buildInfoRow('Статус', dome.status.displayName),
        if (dome.firmwareVersion != null)
          _buildInfoRow('Версия ПО', dome.firmwareVersion!),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildSystemTile(
      BuildContext context, DomeSystem system, FreeDomeProvider freedome) {
    return ListTile(
      dense: true,
      leading: Icon(
        system.status.isOperational ? Icons.circle : Icons.circle_outlined,
        color: system.status.isOperational ? Colors.green : Colors.grey,
        size: 16,
      ),
      title: Text(system.name),
      subtitle: Text(
          '${system.ipAddress}:${system.port} • ${system.type.displayName}'),
      trailing: TextButton(
        onPressed: () async {
          final success = await freedome.connectToDome(system);
          if (success && widget.onConnected != null) {
            widget.onConnected!();
          }
        },
        child: const Text('Подключить'),
      ),
    );
  }

  void _showManualConnection(BuildContext context, FreeDomeProvider freedome) {
    showDialog(
      context: context,
      builder: (context) => _ManualConnectionDialog(
        onConnect: (ip, port) async {
          final system = DomeSystem(
            id: '$ip:$port',
            name: 'Ручное подключение',
            ipAddress: ip,
            port: port,
            type: DomeSystemType.professional,
            status: DomeSystemStatus.offline,
          );

          final success = await freedome.connectToDome(system);
          if (success && widget.onConnected != null) {
            widget.onConnected!();
          }

          return success;
        },
      ),
    );
  }

  void _showAdminPanel(BuildContext context, FreeDomeProvider freedome) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Панель администратора'),
        content: const Text(
            'Функции администратора будут доступны в полной версии.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}

/// Диалог ручного подключения
class _ManualConnectionDialog extends StatefulWidget {
  final Future<bool> Function(String ip, int port) onConnect;

  const _ManualConnectionDialog({required this.onConnect});

  @override
  State<_ManualConnectionDialog> createState() =>
      _ManualConnectionDialogState();
}

class _ManualConnectionDialogState extends State<_ManualConnectionDialog> {
  final _ipController = TextEditingController(text: '192.168.1.100');
  final _portController = TextEditingController(text: '8080');
  bool _isConnecting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ручное подключение'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _ipController,
            decoration: const InputDecoration(
              labelText: 'IP адрес',
              hintText: '192.168.1.100',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _portController,
            decoration: const InputDecoration(
              labelText: 'Порт',
              hintText: '8080',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isConnecting ? null : () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _isConnecting ? null : _connect,
          child: _isConnecting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Подключить'),
        ),
      ],
    );
  }

  Future<void> _connect() async {
    final ip = _ipController.text.trim();
    final portText = _portController.text.trim();

    if (ip.isEmpty || portText.isEmpty) {
      return;
    }

    final port = int.tryParse(portText);
    if (port == null) {
      return;
    }

    setState(() => _isConnecting = true);

    try {
      final success = await widget.onConnect(ip, port);

      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Успешно подключен к FreeDome')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Не удалось подключиться к FreeDome'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка подключения: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isConnecting = false);
      }
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }
}
