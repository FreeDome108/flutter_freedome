/// Пример использования Quantum Fog System

import 'package:flutter/material.dart';
import 'package:flutter_freedome/flutter_freedome.dart';

class QuantumFogExampleScreen extends StatefulWidget {
  const QuantumFogExampleScreen({super.key});

  @override
  State<QuantumFogExampleScreen> createState() =>
      _QuantumFogExampleScreenState();
}

class _QuantumFogExampleScreenState extends State<QuantumFogExampleScreen> {
  final QuantumFogService _fogService = QuantumFogService();
  bool _isInitialized = false;
  FogEnvironment _environment = FogEnvironment.vehicle;
  bool _developerMode = false;

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    try {
      await _fogService.initialize(
        environment: _environment,
        developerMode: _developerMode,
      );
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка инициализации: $e')));
    }
  }

  @override
  void dispose() {
    _fogService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quantum Fog System'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : ListenableBuilder(
              listenable: _fogService,
              builder: (context, _) {
                final state = _fogService.state;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Выбор окружения
                      _buildEnvironmentSelector(),
                      const SizedBox(height: 20),

                      // Текущее состояние
                      _buildStateCard(state),
                      const SizedBox(height: 20),

                      // Режимы для купола
                      if (_environment == FogEnvironment.dome)
                        _buildDomeModes(),

                      // Режимы для транспорта
                      if (_environment == FogEnvironment.vehicle)
                        _buildVehicleModes(),

                      const SizedBox(height: 20),

                      // Кнопка остановки
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _fogService.stopAll(),
                          icon: const Icon(Icons.stop),
                          label: const Text('ОСТАНОВИТЬ ВСЁ'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEnvironmentSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🌍 Окружение',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<FogEnvironment>(
                    title: const Text('🎪 Купол'),
                    value: FogEnvironment.dome,
                    groupValue: _environment,
                    onChanged: (value) {
                      setState(() {
                        _environment = value!;
                        _isInitialized = false;
                      });
                      _initializeService();
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<FogEnvironment>(
                    title: const Text('🚗 Транспорт'),
                    value: FogEnvironment.vehicle,
                    groupValue: _environment,
                    onChanged: (value) {
                      setState(() {
                        _environment = value!;
                        _isInitialized = false;
                      });
                      _initializeService();
                    },
                  ),
                ),
              ],
            ),
            if (_environment == FogEnvironment.vehicle)
              SwitchListTile(
                title: const Text('🔐 Developer Mode'),
                subtitle: const Text('Доступ к H₂ и генерации тумана'),
                value: _developerMode,
                onChanged: (value) {
                  setState(() {
                    _developerMode = value;
                    _isInitialized = false;
                  });
                  _initializeService();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateCard(FogSystemState state) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📊 Состояние Системы',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const Divider(),
            _buildStateRow('📍 Режим', state.mode.toUpperCase()),
            _buildStateRow(
              '🌫️ Плотность тумана',
              '${(state.fogDensity * 100).toStringAsFixed(1)}%',
            ),
            _buildStateRow(
              '👁️ Видимость',
              '${state.visibility.toStringAsFixed(1)} м',
            ),
            if (_environment == FogEnvironment.dome)
              _buildStateRow(
                '🔮 Качество пространства',
                '${state.spaceQuality.toStringAsFixed(1)}%',
              ),
            _buildStateRow(
              '⚡ Производство H₂',
              '${state.h2ProductionRate.toStringAsFixed(3)} л/час',
            ),
            _buildStateRow(
              '📦 Бак H₂',
              '${state.h2TankLevel.toStringAsFixed(1)}% (${state.h2TankPressure.toStringAsFixed(1)} bar)',
            ),
            _buildStateRow(
              '🔋 Потребление',
              '${state.powerConsumption.toStringAsFixed(1)} W',
            ),
            _buildStateRow(
              '🔬 Когерентность',
              '${state.quantumCoherence.toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDomeModes() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎪 Режимы Купола',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildModeButton(
              icon: Icons.cloud,
              label: 'Генерация Тумана',
              subtitle: 'Для голографических проекций',
              color: Colors.blue,
              onPressed: () => _fogService.startDomeFogGeneration(),
            ),
            const SizedBox(height: 8),
            _buildModeButton(
              icon: Icons.air,
              label: 'Рассеивание Тумана',
              subtitle: 'Очистка купола',
              color: Colors.green,
              onPressed: () => _fogService.startDomeFogClearing(),
            ),
            const SizedBox(height: 8),
            _buildModeButton(
              icon: Icons.tune,
              label: 'Нормализация Пространства',
              subtitle: 'Оптимизация акустики и оптики',
              color: Colors.purple,
              onPressed: () => _fogService.startDomeSpaceNormalization(),
            ),
            const SizedBox(height: 8),
            _buildModeButton(
              icon: Icons.auto_awesome,
              label: 'Полный Режим',
              subtitle: 'Всё одновременно',
              color: Colors.orange,
              onPressed: () => _fogService.startDomeFullMode(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleModes() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🚗 Режимы Транспорта',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildModeButton(
              icon: Icons.visibility,
              label: 'FOG TUNNEL',
              subtitle: 'Рассеивание тумана на дороге ✅ БЕЗОПАСНЫЙ',
              color: Colors.green,
              onPressed: () => _fogService.startVehicleFogTunnel(),
            ),
            if (_developerMode) ...[
              const SizedBox(height: 16),
              const Text(
                '🔓 Режимы Разработчика',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              _buildModeButton(
                icon: Icons.battery_charging_full,
                label: '[DEV] Сбор Водорода',
                subtitle: 'H₂ HARVEST ⚠️ Экспериментальный',
                color: Colors.orange,
                onPressed: () => _fogService.startDevH2Harvest(),
              ),
              const SizedBox(height: 8),
              _buildModeButton(
                icon: Icons.warning,
                label: '[DEV] Генерация Тумана',
                subtitle: '⛔ ОПАСНО на дороге!',
                color: Colors.red,
                onPressed: () => _showDangerConfirmation(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDangerConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⛔ ОПАСНО!'),
        content: const Text(
          'Генерация тумана на дороге создает опасность!\n\n'
          'Используйте только для тестов в безопасных условиях.\n\n'
          'Продолжить?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Да, я понимаю риск'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _fogService.startDevFogGeneration(confirmed: true);
    }
  }
}
