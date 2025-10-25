import 'package:flutter/material.dart';
import 'package:flutter_freedome/flutter_freedome.dart';

void main() {
  runApp(const QuantumSilenceApp());
}

class QuantumSilenceApp extends StatelessWidget {
  const QuantumSilenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Квантовая Тишина',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const QuantumSilenceExampleScreen(),
    );
  }
}

class QuantumSilenceExampleScreen extends StatefulWidget {
  const QuantumSilenceExampleScreen({super.key});

  @override
  State<QuantumSilenceExampleScreen> createState() =>
      _QuantumSilenceExampleScreenState();
}

class _QuantumSilenceExampleScreenState
    extends State<QuantumSilenceExampleScreen> {
  late QuantumSilenceService _silenceService;
  bool _isInitialized = false;
  String _status = 'Инициализация...';

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    try {
      _silenceService = QuantumSilenceService();
      await _silenceService.initialize();

      setState(() {
        _isInitialized = true;
        _status = 'Система готова к работе';
      });
    } catch (e) {
      setState(() {
        _status = 'Ошибка инициализации: $e';
      });
    }
  }

  @override
  void dispose() {
    _silenceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Квантовая Тишина'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _isInitialized ? _buildMainContent() : _buildLoadingScreen(),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Инициализация квантовой системы...'),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок и статус
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.hearing, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      const Text(
                        'Квантовая Система Поглощения Звука',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Статус: $_status',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Управление тишиной
          QuantumSilenceControl(
            service: _silenceService,
            showAdvanced: true,
          ),

          const SizedBox(height: 16),

          // Информация о системе
          _buildSystemInfo(),

          const SizedBox(height: 16),

          // Примеры использования
          _buildUsageExamples(),
        ],
      ),
    );
  }

  Widget _buildSystemInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Информация о системе',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _silenceService,
              builder: (context, child) {
                final state = _silenceService.state;
                return Column(
                  children: [
                    _buildInfoRow('Режим', _getModeName(state.mode)),
                    _buildInfoRow(
                        'Активность', state.isActive ? 'Активна' : 'Неактивна'),
                    _buildInfoRow('Уровень тишины',
                        '${(state.silenceLevel * 100).toInt()}%'),
                    _buildInfoRow('Поглощение звука',
                        '${state.soundAbsorption.toInt()}%'),
                    _buildInfoRow(
                        'Фоновый шум', '${state.ambientNoise.toInt()} дБ'),
                    _buildInfoRow(
                        'Когерентность', '${state.quantumCoherence.toInt()}%'),
                    _buildInfoRow(
                        'Стабильность', '${state.resonanceStability.toInt()}%'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildUsageExamples() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Примеры использования',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Гробовая тишина - для подготовки к проекциям в куполе FreeDome',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              '2. Медитативная тишина - для релаксации и медитации',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              '3. Фокусная тишина - для концентрации и работы',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              '4. Квантовая тишина - для экспериментов с когерентностью',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              '5. Адаптивная тишина - автоматическая настройка под окружение',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  String _getModeName(String mode) {
    switch (mode) {
      case 'idle':
        return 'Неактивен';
      case 'grave_silence':
        return 'Гробовая тишина';
      case 'meditative_silence':
        return 'Медитативная тишина';
      case 'focus_silence':
        return 'Фокусная тишина';
      case 'quantum_silence':
        return 'Квантовая тишина';
      case 'adaptive_silence':
        return 'Адаптивная тишина';
      default:
        return 'Неизвестно';
    }
  }
}
