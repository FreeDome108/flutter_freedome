import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/freedome_provider.dart';
import '../models/dome_models.dart';

/// Виджет индикатора статуса подключения к FreeDome
class FreeDomeStatusIndicator extends StatelessWidget {
  final bool showDetails;
  final bool showDomeName;
  final VoidCallback? onTap;

  const FreeDomeStatusIndicator({
    super.key,
    this.showDetails = false,
    this.showDomeName = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDomeProvider>(
      builder: (context, freedome, child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _getStatusColor(freedome).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getStatusColor(freedome),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusIcon(freedome),
                const SizedBox(width: 8),
                _buildStatusText(context, freedome),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusIcon(FreeDomeProvider freedome) {
    if (freedome.isInitializing ||
        freedome.connection.connectionStatus.isConnecting) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(_getStatusColor(freedome)),
        ),
      );
    }

    return Icon(
      _getStatusIcon(freedome),
      size: 16,
      color: _getStatusColor(freedome),
    );
  }

  Widget _buildStatusText(BuildContext context, FreeDomeProvider freedome) {
    final text = _getStatusText(freedome);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _getStatusColor(freedome),
                fontWeight: FontWeight.w500,
              ),
        ),
        if (showDomeName && freedome.activeDome != null)
          Text(
            freedome.activeDome!.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontSize: 10,
                ),
          ),
        if (showDetails && freedome.error != null)
          Text(
            freedome.error!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                  fontSize: 10,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Color _getStatusColor(FreeDomeProvider freedome) {
    if (!freedome.isInitialized || freedome.error != null) {
      return Colors.red;
    }

    if (freedome.isInitializing ||
        freedome.connection.connectionStatus.isConnecting) {
      return Colors.orange;
    }

    if (freedome.isConnected) {
      return Colors.green;
    }

    return Colors.grey;
  }

  IconData _getStatusIcon(FreeDomeProvider freedome) {
    if (!freedome.isInitialized || freedome.error != null) {
      return Icons.error;
    }

    if (freedome.isConnected) {
      return Icons.wifi;
    }

    return Icons.wifi_off;
  }

  String _getStatusText(FreeDomeProvider freedome) {
    if (!freedome.isInitialized) {
      return 'Не инициализирован';
    }

    if (freedome.error != null) {
      return 'Ошибка';
    }

    if (freedome.isInitializing) {
      return 'Инициализация...';
    }

    if (freedome.connection.connectionStatus.isConnecting) {
      return 'Подключение...';
    }

    if (freedome.isConnected) {
      return 'Подключен';
    }

    return 'Не подключен';
  }
}

/// Расширенный виджет статуса с подробной информацией
class FreeDomeDetailedStatus extends StatelessWidget {
  const FreeDomeDetailedStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDomeProvider>(
      builder: (context, freedome, child) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Статус FreeDome',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildStatusRow(
                  'Инициализация',
                  freedome.isInitialized ? 'Завершена' : 'В процессе',
                  freedome.isInitialized ? Colors.green : Colors.orange,
                ),
                _buildStatusRow(
                  'Подключение',
                  freedome.isConnected ? 'Установлено' : 'Отсутствует',
                  freedome.isConnected ? Colors.green : Colors.red,
                ),
                _buildStatusRow(
                  'Аутентификация',
                  freedome.isAuthenticated
                      ? freedome.currentRole.displayName
                      : 'Не выполнена',
                  freedome.isAuthenticated ? Colors.green : Colors.grey,
                ),
                if (freedome.activeDome != null) ...[
                  const Divider(),
                  _buildDomeInfo(context, freedome.activeDome!),
                ],
                if (freedome.playbackState.currentContentId != null) ...[
                  const Divider(),
                  _buildPlaybackInfo(context, freedome.playbackState),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDomeInfo(BuildContext context, DomeSystem dome) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Информация о куполе',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        _buildInfoRow('Название', dome.name),
        _buildInfoRow('Адрес', '${dome.ipAddress}:${dome.port}'),
        _buildInfoRow('Тип', dome.type.displayName),
        _buildInfoRow('Проекторы', '${dome.projectors.length}'),
        _buildInfoRow('Аудиоканалы', '${dome.audioChannels.length}'),
        if (dome.firmwareVersion != null)
          _buildInfoRow('Версия ПО', dome.firmwareVersion!),
      ],
    );
  }

  Widget _buildPlaybackInfo(BuildContext context, PlaybackState playbackState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Воспроизведение',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        _buildInfoRow('Статус', playbackState.status.displayName),
        _buildInfoRow('Контент', playbackState.currentContentId ?? 'Не выбран'),
        _buildInfoRow('Громкость', '${(playbackState.volume * 100).round()}%'),
        if (playbackState.duration != null)
          _buildInfoRow(
              'Длительность', _formatDuration(playbackState.duration!)),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
