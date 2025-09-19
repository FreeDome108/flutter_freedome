import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/freedome_provider.dart';
import '../models/content_models.dart';
import '../models/dome_models.dart';

/// Виджет для управления воспроизведением контента FreeDome
class FreeDomeContentPlayer extends StatefulWidget {
  final FreeDomeContent? content;
  final bool showControls;
  final bool showVolumeSlider;
  final bool showBrightnessSlider;
  final VoidCallback? onPlayStarted;
  final VoidCallback? onPlayStopped;

  const FreeDomeContentPlayer({
    super.key,
    this.content,
    this.showControls = true,
    this.showVolumeSlider = true,
    this.showBrightnessSlider = true,
    this.onPlayStarted,
    this.onPlayStopped,
  });

  @override
  State<FreeDomeContentPlayer> createState() => _FreeDomeContentPlayerState();
}

class _FreeDomeContentPlayerState extends State<FreeDomeContentPlayer> {
  double _volume = 0.5;
  double _brightness = 0.8;

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDomeProvider>(
      builder: (context, freedome, child) {
        if (!freedome.isConnected) {
          return _buildNotConnectedUI(context);
        }

        return _buildPlayerUI(context, freedome);
      },
    );
  }

  Widget _buildNotConnectedUI(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              'Нет подключения к FreeDome',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Подключитесь к купольной системе для воспроизведения контента',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerUI(BuildContext context, FreeDomeProvider freedome) {
    final playbackState = freedome.playbackState;
    final canControl = freedome.hasPermission(FreeDomePermission.playContent);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Информация о текущем контенте
            _buildCurrentContentInfo(context, playbackState),

            if (widget.showControls && canControl) ...[
              const SizedBox(height: 16),
              _buildPlaybackControls(context, freedome, playbackState),
            ],

            if (widget.showVolumeSlider &&
                freedome.hasPermission(FreeDomePermission.controlBasics)) ...[
              const SizedBox(height: 16),
              _buildVolumeControl(context, freedome),
            ],

            if (widget.showBrightnessSlider &&
                freedome.hasPermission(FreeDomePermission.controlBasics)) ...[
              const SizedBox(height: 12),
              _buildBrightnessControl(context, freedome),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentContentInfo(
      BuildContext context, PlaybackState playbackState) {
    if (playbackState.currentContentId == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Контент не выбран',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Выберите контент для воспроизведения на куполе',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildStatusIcon(playbackState.status),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.content?.name ??
                    'Контент ${playbackState.currentContentId}',
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          playbackState.status.displayName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _getStatusColor(playbackState.status),
              ),
        ),
        if (playbackState.duration != null) ...[
          const SizedBox(height: 8),
          _buildProgressBar(playbackState),
        ],
      ],
    );
  }

  Widget _buildStatusIcon(PlaybackStatus status) {
    switch (status) {
      case PlaybackStatus.playing:
        return const Icon(Icons.play_circle_filled, color: Colors.green, size: 24);
      case PlaybackStatus.paused:
        return const Icon(Icons.pause_circle_filled, color: Colors.orange, size: 24);
      case PlaybackStatus.stopped:
        return const Icon(Icons.stop_circle, color: Colors.grey, size: 24);
      case PlaybackStatus.buffering:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case PlaybackStatus.error:
        return const Icon(Icons.error, color: Colors.red, size: 24);
    }
  }

  Color _getStatusColor(PlaybackStatus status) {
    switch (status) {
      case PlaybackStatus.playing:
        return Colors.green;
      case PlaybackStatus.paused:
        return Colors.orange;
      case PlaybackStatus.stopped:
        return Colors.grey;
      case PlaybackStatus.buffering:
        return Colors.blue;
      case PlaybackStatus.error:
        return Colors.red;
    }
  }

  Widget _buildProgressBar(PlaybackState playbackState) {
    if (playbackState.duration == null) {
      return const SizedBox.shrink();
    }

    final progress = playbackState.duration!.inMilliseconds > 0
        ? playbackState.position.inMilliseconds /
            playbackState.duration!.inMilliseconds
        : 0.0;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(playbackState.position),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              _formatDuration(playbackState.duration!),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaybackControls(BuildContext context, FreeDomeProvider freedome,
      PlaybackState playbackState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: playbackState.canStop
              ? () async {
                  await freedome.stopPlayback();
                  if (widget.onPlayStopped != null) {
                    widget.onPlayStopped!();
                  }
                }
              : null,
          icon: const Icon(Icons.stop),
          tooltip: 'Остановить',
        ),
        if (playbackState.canPause)
          IconButton(
            onPressed: () => freedome.pausePlayback(),
            icon: const Icon(Icons.pause),
            tooltip: 'Пауза',
          )
        else if (playbackState.canResume)
          IconButton(
            onPressed: () => freedome.resumePlayback(),
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Воспроизвести',
          )
        else
          IconButton(
            onPressed: widget.content != null
                ? () async {
                    final success = await freedome.playContent(widget.content!);
                    if (success && widget.onPlayStarted != null) {
                      widget.onPlayStarted!();
                    }
                  }
                : null,
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Воспроизвести',
          ),
      ],
    );
  }

  Widget _buildVolumeControl(BuildContext context, FreeDomeProvider freedome) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.volume_up, size: 20),
            const SizedBox(width: 8),
            Text('Громкость', style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            Text('${(_volume * 100).round()}%'),
          ],
        ),
        Slider(
          value: _volume,
          onChanged: (value) {
            setState(() => _volume = value);
          },
          onChangeEnd: (value) async {
            await freedome.setVolume(value);
          },
          min: 0.0,
          max: 1.0,
          divisions: 20,
        ),
      ],
    );
  }

  Widget _buildBrightnessControl(
      BuildContext context, FreeDomeProvider freedome) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.brightness_6, size: 20),
            const SizedBox(width: 8),
            Text('Яркость', style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            Text('${(_brightness * 100).round()}%'),
          ],
        ),
        Slider(
          value: _brightness,
          onChanged: (value) {
            setState(() => _brightness = value);
          },
          onChangeEnd: (value) async {
            await freedome.setBrightness(value);
          },
          min: 0.0,
          max: 1.0,
          divisions: 20,
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
