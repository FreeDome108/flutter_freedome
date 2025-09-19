/// Flutter FreeDome Plugin
///
/// Унифицированная библиотека для интеграции с купольными кинотеатрами FreeDome.
/// Поддерживает гостевой режим для воспроизведения контента и административный
/// режим для полной настройки и калибровки купольных систем.
///
/// ## Основные возможности
///
/// ### 🎭 Гостевой режим
/// - Автоматическое обнаружение купольных систем
/// - Воспроизведение контента любых приложений
/// - Базовые настройки (громкость, яркость)
/// - Простой API для интеграции
///
/// ### 🔧 Режим администратора
/// - Полная калибровка аудио и видео систем
/// - Управление проекторами и аудиоканалами
/// - Системное администрирование
/// - Мониторинг и диагностика
///
/// ## Быстрый старт
///
/// ```dart
/// // Инициализация FreeDome
/// final freedome = FreeDomeProvider();
/// await freedome.initialize();
///
/// // Подключение к куполу
/// await freedome.connectToNearestDome();
///
/// // Воспроизведение контента приложения
/// await freedome.playAppContent(
///   appName: 'MyApp',
///   contentName: 'Мой контент',
///   appData: {'type': 'visualization', 'data': myData},
/// );
/// ```
///
/// ## Архитектура
///
/// - **FreeDomeProvider** - главная точка входа
/// - **ConnectionService** - управление подключениями
/// - **AuthService** - аутентификация и роли
/// - **ContentService** - управление контентом
/// - **CalibrationService** - калибровка (только админ)
/// - **SystemService** - системное управление (только админ)
library flutter_freedome;

// Экспорт основных классов
export 'src/core/freedome_provider.dart';
export 'src/core/connection_service.dart';
export 'src/core/auth_service.dart';
export 'src/core/content_service.dart';

// Экспорт гостевого режима
export 'src/guest/guest_service.dart';

// Экспорт админских сервисов
export 'src/admin/calibration_service.dart';
export 'src/admin/system_service.dart';

// Экспорт моделей
export 'src/models/dome_models.dart';
export 'src/models/content_models.dart';
export 'src/models/calibration_models.dart';

// Экспорт виджетов
export 'src/widgets/freedome_connection_widget.dart';
export 'src/widgets/freedome_content_player.dart';
export 'src/widgets/freedome_status_indicator.dart';

/// Главный класс библиотеки FreeDome
class FlutterFreeDome {
  static FlutterFreeDome? _instance;

  /// Получение singleton экземпляра
  static FlutterFreeDome get instance {
    _instance ??= FlutterFreeDome._();
    return _instance!;
  }

  FlutterFreeDome._();

  /// Быстрая инициализация для гостевого режима
  static Future<FreeDomeProvider> initializeGuest() async {
    final provider = FreeDomeProvider();
    await provider.initialize(defaultRole: FreeDomeUserRole.guest);
    return provider;
  }

  /// Инициализация с аутентификацией администратора
  static Future<FreeDomeProvider?> initializeAdmin({
    required String username,
    required String password,
  }) async {
    final provider = FreeDomeProvider();
    await provider.initialize(defaultRole: FreeDomeUserRole.guest);

    final success = await provider.authenticateAsAdmin(
      username: username,
      password: password,
    );

    return success ? provider : null;
  }

  /// Быстрое подключение и воспроизведение контента
  static Future<bool> quickPlay({
    required String appName,
    required String contentName,
    required Map<String, dynamic> appData,
  }) async {
    try {
      final provider = await initializeGuest();

      // Подключаемся к ближайшему куполу
      final connected = await provider.connectToNearestDome();
      if (!connected) return false;

      // Воспроизводим контент
      return await provider.playAppContent(
        appName: appName,
        contentName: contentName,
        appData: appData,
      );
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка быстрого воспроизведения: $e');
      }
      return false;
    }
  }

  /// Проверка доступности FreeDome систем в сети
  static Future<bool> isFreeDomeAvailable() async {
    try {
      final provider = FreeDomeProvider();
      await provider.initialize();

      // Даем время на обнаружение систем
      await Future.delayed(const Duration(seconds: 3));

      return provider.connection.discoveredSystems.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Получение версии библиотеки
  static String get version => '1.0.0';

  /// Получение информации о библиотеке
  static Map<String, dynamic> get info => {
        'name': 'flutter_freedome',
        'version': version,
        'description':
            'Унифицированная библиотека для интеграции с купольными кинотеатрами FreeDome',
        'author': 'NativeMind Team',
        'license': 'NativeMindNONC',
        'supportedPlatforms': [
          'Android',
          'iOS',
          'Web',
          'Windows',
          'macOS',
          'Linux'
        ],
        'features': [
          'Автоматическое обнаружение куполов',
          'Гостевой и административный режимы',
          'Система ролей и разрешений',
          'Аудио и видео калибровка',
          'Поддержка множественных форматов контента',
          'Готовые UI виджеты',
        ],
      };
}
