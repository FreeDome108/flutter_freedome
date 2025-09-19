import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/freedome_provider.dart';
import '../models/content_models.dart';
import '../models/dome_models.dart';

/// Упрощенный сервис для гостевого режима
/// Предоставляет только базовый функционал без административных возможностей
class FreeDomeGuestService extends ChangeNotifier {
  final FreeDomeProvider _provider = FreeDomeProvider();

  // Геттеры состояния (только для чтения)
  bool get isConnected => _provider.isConnected;
  bool get isReady => _provider.isReady;
  DomeSystem? get activeDome => _provider.activeDome;
  PlaybackState get playbackState => _provider.playbackState;
  List<ProjectionContent> get availableContent =>
      _provider.content.contentLibrary;

  /// Инициализация гостевого режима
  Future<bool> initialize() async {
    try {
      final success = await _provider.initialize(
        defaultRole: FreeDomeUserRole.guest,
        autoDiscovery: true,
      );

      if (success) {
        _provider.addListener(_onProviderChanged);

        if (kDebugMode) {
          print('✅ Гостевой режим FreeDome инициализирован');
        }
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации гостевого режима: $e');
      }
      return false;
    }
  }

  /// Обработчик изменений провайдера
  void _onProviderChanged() {
    notifyListeners();
  }

  /// Автоматическое подключение к ближайшему куполу
  Future<bool> connectToNearestDome() async {
    return await _provider.connectToNearestDome();
  }

  /// Подключение к конкретному куполу
  Future<bool> connectToDome(DomeSystem dome) async {
    return await _provider.connectToDome(dome);
  }

  /// Отключение от купола
  Future<void> disconnect() async {
    await _provider.disconnect();
  }

  /// Воспроизведение контента
  Future<bool> playContent(FreeDomeContent content) async {
    return await _provider.playContent(content);
  }

  /// Воспроизведение контента приложения
  Future<bool> playAppContent({
    required String appName,
    required String contentName,
    required Map<String, dynamic> appData,
  }) async {
    return await _provider.playAppContent(
      appName: appName,
      contentName: contentName,
      appData: appData,
    );
  }

  /// Управление воспроизведением
  Future<bool> pause() async {
    return await _provider.pausePlayback();
  }

  Future<bool> resume() async {
    return await _provider.resumePlayback();
  }

  Future<bool> stop() async {
    return await _provider.stopPlayback();
  }

  /// Базовые настройки
  Future<bool> setVolume(double volume) async {
    return await _provider.setVolume(volume);
  }

  Future<bool> setBrightness(double brightness) async {
    return await _provider.setBrightness(brightness);
  }

  /// Поиск доступных куполов
  List<DomeSystem> getDiscoveredDomes() {
    return _provider.connection.discoveredSystems;
  }

  /// Получение доступного контента
  List<ProjectionContent> searchContent({
    String? query,
    ContentType? type,
    List<String>? tags,
  }) {
    return _provider.content.searchContent(
      query: query,
      type: type,
      tags: tags,
    );
  }

  /// Получение статуса подключения
  FreeDomeConnectionStatus getConnectionStatus() {
    return _provider.connection.connectionStatus;
  }

  /// Получение информации о текущей сессии
  Map<String, dynamic> getSessionInfo() {
    return _provider.auth.getSessionInfo();
  }

  /// Проверка возможности выполнения действия
  bool canPerformAction(String action) {
    switch (action.toLowerCase()) {
      case 'play':
      case 'pause':
      case 'stop':
      case 'volume':
      case 'brightness':
        return _provider.hasPermission(FreeDomePermission.playContent) ||
            _provider.hasPermission(FreeDomePermission.controlBasics);
      default:
        return false;
    }
  }

  /// Получение списка доступных действий
  List<String> getAvailableActions() {
    final actions = <String>[];

    if (_provider.hasPermission(FreeDomePermission.playContent)) {
      actions.addAll(['play', 'pause', 'stop']);
    }

    if (_provider.hasPermission(FreeDomePermission.controlBasics)) {
      actions.addAll(['volume', 'brightness']);
    }

    return actions;
  }

  /// Создание простого контента для воспроизведения
  InteractiveContent createSimpleContent({
    required String name,
    required String appName,
    required Map<String, dynamic> data,
  }) {
    return InteractiveContent(
      id: 'guest_content_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      appName: appName,
      appData: data,
      description: 'Контент от гостевого приложения $appName',
      tags: ['guest', 'interactive', appName.toLowerCase()],
      createdAt: DateTime.now(),
    );
  }

  /// Быстрое воспроизведение данных приложения
  Future<bool> quickPlay({
    required String appName,
    required Map<String, dynamic> data,
    String? contentName,
  }) async {
    final content = createSimpleContent(
      name: contentName ?? 'Контент из $appName',
      appName: appName,
      data: data,
    );

    return await playContent(content);
  }

  /// Получение упрощенного статуса для гостей
  Map<String, dynamic> getGuestStatus() {
    return {
      'isConnected': isConnected,
      'isReady': isReady,
      'domeName': activeDome?.name,
      'domeType': activeDome?.type.name,
      'playbackStatus': playbackState.status.name,
      'currentContent': playbackState.currentContentId,
      'volume': playbackState.volume,
      'availableContent': availableContent.length,
      'availableActions': getAvailableActions(),
      'sessionInfo': getSessionInfo(),
    };
  }

  @override
  void dispose() {
    _provider.removeListener(_onProviderChanged);
    super.dispose();
  }
}
