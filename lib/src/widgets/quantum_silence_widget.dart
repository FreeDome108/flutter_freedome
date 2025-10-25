/// Виджет для отображения и управления квантовой системой поглощения звука

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../fog/quantum_silence_service.dart';
import '../fog/quantum_silence_models.dart';

/// Виджет индикатора состояния тишины
class QuantumSilenceIndicator extends StatelessWidget {
  final QuantumSilenceService service;
  final double size;
  final bool showDetails;

  const QuantumSilenceIndicator({
    super.key,
    required this.service,
    this.size = 60.0,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: service,
      builder: (context, child) {
        final state = service.state;
        final isActive = state.isActive;
        final silenceLevel = state.silenceLevel;

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getIndicatorColor(silenceLevel, isActive),
            boxShadow: [
              BoxShadow(
                color:
                    _getIndicatorColor(silenceLevel, isActive).withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIndicatorIcon(silenceLevel, isActive),
                color: Colors.white,
                size: size * 0.4,
              ),
              if (showDetails) ...[
                SizedBox(height: size * 0.05),
                Text(
                  '${(silenceLevel * 100).toInt()}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Color _getIndicatorColor(double silenceLevel, bool isActive) {
    if (!isActive) return Colors.grey;

    if (silenceLevel >= 0.9) return Colors.deepPurple;
    if (silenceLevel >= 0.7) return Colors.indigo;
    if (silenceLevel >= 0.5) return Colors.blue;
    if (silenceLevel >= 0.3) return Colors.orange;
    return Colors.red;
  }

  IconData _getIndicatorIcon(double silenceLevel, bool isActive) {
    if (!isActive) return Icons.volume_up;

    if (silenceLevel >= 0.9) return Icons.volume_off;
    if (silenceLevel >= 0.7) return Icons.volume_mute;
    if (silenceLevel >= 0.5) return Icons.volume_down;
    return Icons.volume_up;
  }
}

/// Виджет управления квантовой тишиной
class QuantumSilenceControl extends StatefulWidget {
  final QuantumSilenceService service;
  final bool showAdvanced;

  const QuantumSilenceControl({
    super.key,
    required this.service,
    this.showAdvanced = false,
  });

  @override
  State<QuantumSilenceControl> createState() => _QuantumSilenceControlState();
}

class _QuantumSilenceControlState extends State<QuantumSilenceControl> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.service,
      builder: (context, child) {
        final state = widget.service.state;
        final isActive = state.isActive;
        final currentMode = widget.service.currentMode;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.hearing,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Квантовая Тишина',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    QuantumSilenceIndicator(
                      service: widget.service,
                      size: 40,
                      showDetails: false,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Статус
                _buildStatusRow('Режим', _getModeName(currentMode)),
                _buildStatusRow(
                    'Активность', isActive ? 'Активна' : 'Неактивна'),
                _buildStatusRow(
                    'Уровень тишины', '${(state.silenceLevel * 100).toInt()}%'),
                _buildStatusRow(
                    'Поглощение звука', '${state.soundAbsorption.toInt()}%'),
                _buildStatusRow(
                    'Фоновый шум', '${state.ambientNoise.toInt()} дБ'),

                const SizedBox(height: 16),

                // Управление
                if (!isActive) ...[
                  _buildModeButtons(),
                ] else ...[
                  _buildActiveControls(),
                ],

                if (widget.showAdvanced) ...[
                  const SizedBox(height: 16),
                  _buildAdvancedControls(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusRow(String label, String value) {
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

  Widget _buildModeButtons() {
    return Column(
      children: [
        Text(
          'Выберите режим тишины:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildModeButton(
              'Гробовая',
              QuantumSilenceMode.graveSilence,
              Icons.volume_off,
              Colors.deepPurple,
            ),
            _buildModeButton(
              'Медитативная',
              QuantumSilenceMode.meditativeSilence,
              Icons.self_improvement,
              Colors.indigo,
            ),
            _buildModeButton(
              'Фокусная',
              QuantumSilenceMode.focusSilence,
              Icons.center_focus_strong,
              Colors.blue,
            ),
            _buildModeButton(
              'Квантовая',
              QuantumSilenceMode.quantumSilence,
              Icons.psychology,
              Colors.purple,
            ),
            _buildModeButton(
              'Адаптивная',
              QuantumSilenceMode.adaptiveSilence,
              Icons.auto_awesome,
              Colors.teal,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModeButton(
    String label,
    QuantumSilenceMode mode,
    IconData icon,
    Color color,
  ) {
    return ElevatedButton.icon(
      onPressed: () => _startMode(mode),
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildActiveControls() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _stopAll,
                icon: const Icon(Icons.stop),
                label: const Text('Остановить'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _showConfigDialog,
                icon: const Icon(Icons.settings),
                label: const Text('Настройки'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: widget.service.state.silenceLevel,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.service.isTargetSilenceReached
                ? Colors.green
                : Colors.orange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Прогресс: ${(widget.service.state.silenceLevel * 100).toInt()}%',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildAdvancedControls() {
    return ExpansionTile(
      title: const Text('Расширенные настройки'),
      children: [
        ListTile(
          title: const Text('Целевой уровень тишины'),
          subtitle: Slider(
            value: widget.service.config.targetSilenceLevel,
            min: 0.0,
            max: 1.0,
            divisions: 20,
            label:
                '${(widget.service.config.targetSilenceLevel * 100).toInt()}%',
            onChanged: (value) {
              widget.service.setTargetSilenceLevel(value);
            },
          ),
        ),
        ListTile(
          title: const Text('Квантовая когерентность'),
          trailing: Switch(
            value: widget.service.config.quantumCoherence,
            onChanged: (value) {
              if (value) {
                widget.service.enableQuantumCoherence();
              }
            },
          ),
        ),
        ListTile(
          title: const Text('Адаптивный режим'),
          trailing: Switch(
            value: widget.service.config.adaptiveMode,
            onChanged: (value) {
              // TODO: Implement adaptive mode toggle
            },
          ),
        ),
      ],
    );
  }

  Future<void> _startMode(QuantumSilenceMode mode) async {
    try {
      bool success = false;

      switch (mode) {
        case QuantumSilenceMode.graveSilence:
          success = await widget.service.startGraveSilence();
          break;
        case QuantumSilenceMode.meditativeSilence:
          success = await widget.service.startMeditativeSilence();
          break;
        case QuantumSilenceMode.focusSilence:
          success = await widget.service.startFocusSilence();
          break;
        case QuantumSilenceMode.quantumSilence:
          success = await widget.service.startQuantumSilence();
          break;
        case QuantumSilenceMode.adaptiveSilence:
          success = await widget.service.startAdaptiveSilence();
          break;
        default:
          break;
      }

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Режим ${_getModeName(mode)} активирован'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка активации: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _stopAll() async {
    try {
      await widget.service.stopAll();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Все системы остановлены'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка остановки: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showConfigDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Настройки тишины'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Целевой уровень: ${(widget.service.config.targetSilenceLevel * 100).toInt()}%'),
            Slider(
              value: widget.service.config.targetSilenceLevel,
              min: 0.0,
              max: 1.0,
              divisions: 20,
              onChanged: (value) {
                widget.service.setTargetSilenceLevel(value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  String _getModeName(QuantumSilenceMode mode) {
    switch (mode) {
      case QuantumSilenceMode.idle:
        return 'Неактивен';
      case QuantumSilenceMode.graveSilence:
        return 'Гробовая тишина';
      case QuantumSilenceMode.meditativeSilence:
        return 'Медитативная тишина';
      case QuantumSilenceMode.focusSilence:
        return 'Фокусная тишина';
      case QuantumSilenceMode.quantumSilence:
        return 'Квантовая тишина';
      case QuantumSilenceMode.adaptiveSilence:
        return 'Адаптивная тишина';
      case QuantumSilenceMode.error:
        return 'Ошибка';
    }
  }
}
