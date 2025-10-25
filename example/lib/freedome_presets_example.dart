/// Пример использования FreeDome Sphere преднастроек
///
/// Демонстрирует все доступные методы преднастройки:
/// - Гробовая тишина
/// - Генерация тумана
/// - Полное отсутствие тумана
/// - Полный режим купола
/// - Медитативная атмосфера

import 'package:flutter/material.dart';
import 'package:flutter_freedome/flutter_freedome.dart';

class FreeDomePresetsExample extends StatefulWidget {
  const FreeDomePresetsExample({super.key});

  @override
  State<FreeDomePresetsExample> createState() => _FreeDomePresetsExampleState();
}

class _FreeDomePresetsExampleState extends State<FreeDomePresetsExample> {
  final FreeDomeProvider _freedome = FreeDomeProvider();

  bool _isInitialized = false;
  bool _isConnected = false;
  String _status = 'Не инициализирован';
  Map<String, dynamic>? _quantumStatus;

  @override
  void initState() {
    super.initState();
    _initializeFreeDome();
  }

  Future<void> _initializeFreeDome() async {
    try {
      setState(() {
        _status = 'Инициализация...';
      });

      // Инициализация FreeDome
      final initialized = await _freedome.initialize();
      if (!initialized) {
        setState(() {
          _status = 'Ошибка инициализации';
        });
        return;
      }

      // Подключение к куполу
      final connected = await _freedome.connectToNearestDome();

      setState(() {
        _isInitialized = true;
        _isConnected = connected;
        _status = connected ? 'Подключен к куполу' : 'Купол не найден';
      });

      // Получение статуса квантовых систем
      _updateQuantumStatus();
    } catch (e) {
      setState(() {
        _status = 'Ошибка: $e';
      });
    }
  }

  void _updateQuantumStatus() {
    if (_isInitialized) {
      setState(() {
        _quantumStatus = _freedome.getQuantumSystemsStatus();
      });
    }
  }

  Future<void> _activatePreset(
      String presetName, Future<bool> Function() presetFunction) async {
    try {
      setState(() {
        _status = 'Активация $presetName...';
      });

      final success = await presetFunction();

      setState(() {
        _status = success
            ? '$presetName активирован'
            : 'Ошибка активации $presetName';
      });

      _updateQuantumStatus();
    } catch (e) {
      setState(() {
        _status = 'Ошибка: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FreeDome Sphere - Преднастройки'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Статус системы
            Card(
              color: _isConnected ? Colors.green.shade50 : Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Статус системы',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text('Состояние: $_status'),
                    Text('Инициализирован: ${_isInitialized ? "Да" : "Нет"}'),
                    Text('Подключен: ${_isConnected ? "Да" : "Нет"}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Статус квантовых систем
            if (_quantumStatus != null) ...[
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Квантовые системы',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text('Туман: ${_quantumStatus!['fog']['mode']}'),
                      Text('Тишина: ${_quantumStatus!['silence']['mode']}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Кнопки преднастроек
            Text(
              'Преднастройки',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Гробовая тишина
            _buildPresetButton(
              '🔇 Гробовая тишина',
              'Полное поглощение звука (95-99%)',
              () => _activatePreset(
                'Гробовая тишина',
                () => _freedome.presetGraveSilence(
                  duration: const Duration(minutes: 5),
                  applyLocally: true,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Генерация тумана
            _buildPresetButton(
              '🌫️ Генерация тумана',
              'Среда для голографических проекций',
              () => _activatePreset(
                'Генерация тумана',
                () => _freedome.presetFogGeneration(
                  duration: const Duration(minutes: 30),
                  applyLocally: true,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Полное отсутствие тумана
            _buildPresetButton(
              '🌤️ Полное отсутствие тумана',
              'Очистка купола (100% рассеивание)',
              () => _activatePreset(
                'Полное отсутствие тумана',
                () => _freedome.presetNoFog(
                  duration: const Duration(minutes: 10),
                  applyLocally: true,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Полный режим купола
            _buildPresetButton(
              '🎪 Полный режим купола',
              'Генерация тумана + нормализация',
              () => _activatePreset(
                'Полный режим купола',
                () => _freedome.presetFullDomeMode(
                  duration: const Duration(minutes: 45),
                  applyLocally: true,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Медитативная атмосфера
            _buildPresetButton(
              '🧘 Медитативная атмосфера',
              'Мягкая атмосфера для релаксации',
              () => _activatePreset(
                'Медитативная атмосфера',
                () => _freedome.presetMeditativeAtmosphere(
                  duration: const Duration(minutes: 60),
                  applyLocally: true,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Управление
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isInitialized
                        ? () async {
                            await _freedome.stopAllQuantumSystems();
                            _updateQuantumStatus();
                            setState(() {
                              _status = 'Все системы остановлены';
                            });
                          }
                        : null,
                    icon: const Icon(Icons.stop),
                    label: const Text('Остановить все'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _updateQuantumStatus,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Обновить статус'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Информация
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ℹ️ Информация',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Все преднастройки применяются локально для демонстрации\n'
                      '• В реальном куполе системы будут физически активированы\n'
                      '• Автоматическое отключение через указанное время\n'
                      '• Используйте "Остановить все" для принудительной остановки',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetButton(
      String title, String description, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: _isInitialized ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        backgroundColor: _isInitialized ? Colors.deepPurple : Colors.grey,
        foregroundColor: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _freedome.dispose();
    super.dispose();
  }
}

/// Главная функция для запуска примера
void main() {
  runApp(
    MaterialApp(
      title: 'FreeDome Sphere - Преднастройки',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const FreeDomePresetsExample(),
    ),
  );
}
