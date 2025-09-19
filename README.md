# Flutter FreeDome

[![pub package](https://img.shields.io/pub/v/flutter_freedome.svg)](https://pub.dev/packages/flutter_freedome)
[![License](https://img.shields.io/badge/License-NativeMindNONC-blue.svg)](LICENSE)

Унифицированная Flutter библиотека для интеграции с купольными кинотеатрами FreeDome. Поддерживает гостевой режим для воспроизведения контента и административный режим для полной настройки и калибровки купольных систем.

## 🌟 Основные возможности

### 🎭 Гостевой режим
- **Автоматическое обнаружение** купольных систем в локальной сети
- **Воспроизведение контента** любых приложений на купольном экране
- **Базовые настройки** (громкость, яркость, ротация)
- **Простой API** для быстрой интеграции
- **Готовые UI виджеты** для управления

### 🔧 Режим администратора
- **Полная калибровка** аудио и видео систем
- **Управление проекторами** и аудиоканалами
- **Системное администрирование** и мониторинг
- **Поддержка множественных вендоров** (Digistar, DomeMaster, IMAX Dome)
- **Диагностика и метрики** системы

### 🏗️ Архитектура
- **Модульная структура** с разделением на гостевой и административный режимы
- **Система ролей и разрешений** для безопасного доступа
- **Поддержка множественных форматов** контента (360°, Fulldome, Fisheye)
- **Реактивное программирование** с Provider pattern

## 🚀 Быстрый старт

### Установка

```yaml
dependencies:
  flutter_freedome: ^1.0.0
```

### Базовое использование

```dart
import 'package:flutter_freedome/flutter_freedome.dart';
import 'package:provider/provider.dart';

// 1. Оберните приложение в Provider
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FreeDomeProvider(),
      child: MaterialApp(
        home: FreeDomeExampleScreen(),
      ),
    );
  }
}

// 2. Используйте FreeDome в виджетах
class FreeDomeExampleScreen extends StatefulWidget {
  @override
  _FreeDomeExampleScreenState createState() => _FreeDomeExampleScreenState();
}

class _FreeDomeExampleScreenState extends State<FreeDomeExampleScreen> {
  @override
  void initState() {
    super.initState();
    _initializeFreeDome();
  }

  Future<void> _initializeFreeDome() async {
    final freedome = context.read<FreeDomeProvider>();
    await freedome.initialize();
    await freedome.connectToNearestDome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FreeDome Example'),
        actions: [
          FreeDomeStatusIndicator(), // Готовый виджет статуса
        ],
      ),
      body: Column(
        children: [
          FreeDomeConnectionWidget(), // Виджет управления подключением
          FreeDomeContentPlayer(),    // Плеер контента
          
          // Кнопка воспроизведения вашего контента
          ElevatedButton(
            onPressed: () => _playMyContent(),
            child: Text('Показать мой контент'),
          ),
        ],
      ),
    );
  }

  Future<void> _playMyContent() async {
    final freedome = context.read<FreeDomeProvider>();
    
    await freedome.playAppContent(
      appName: 'MyApp',
      contentName: 'Звездное небо',
      appData: {
        'type': 'starfield',
        'constellation': 'all',
        'time': DateTime.now().toIso8601String(),
      },
    );
  }
}
```

### Быстрое воспроизведение

```dart
// Самый простой способ - одной командой
final success = await FlutterFreeDome.quickPlay(
  appName: 'MyApp',
  contentName: 'Мой контент',
  appData: {'type': 'visualization', 'data': myData},
);

if (success) {
  print('Контент воспроизводится на куполе!');
}
```

## 🎮 Примеры интеграции

### Звездное небо
```dart
await freedome.playAppContent(
  appName: 'StarrySkr',
  contentName: 'Звездное небо',
  appData: {
    'type': 'starfield',
    'constellation': 'all',
    'time': DateTime.now().toIso8601String(),
  },
);
```

### Солнечная система
```dart
await freedome.playAppContent(
  appName: 'SolarSystem',
  contentName: 'Планеты',
  appData: {
    'type': 'solar_system',
    'showOrbits': true,
    'speed': 1.0,
  },
);
```

### Медитация
```dart
await freedome.playAppContent(
  appName: 'MeditationApp',
  contentName: 'Релаксация',
  appData: {
    'type': 'meditation',
    'duration': 300,
    'background': 'nature',
  },
);
```

## 🔧 Режим администратора

```dart
// Аутентификация как администратор
final success = await freedome.authenticateAsAdmin(
  username: 'admin',
  password: 'your_password',
);

if (success) {
  // Доступ к административным функциям
  final calibrationService = freedome.calibration;
  final systemService = freedome.system;
  
  // Запуск калибровки аудио
  await calibrationService?.startAudioCalibration();
  
  // Мониторинг системы
  final metrics = await systemService?.getSystemHealth();
}
```

## 📱 Готовые виджеты

### FreeDomeConnectionWidget
Виджет для управления подключением к купольным системам:

```dart
FreeDomeConnectionWidget(
  autoConnect: true,
  showDiscoveredSystems: true,
  onConnected: () => print('Подключен к FreeDome!'),
  onDisconnected: () => print('Отключен от FreeDome'),
)
```

### FreeDomeContentPlayer
Плеер для управления воспроизведением контента:

```dart
FreeDomeContentPlayer(
  content: myContent,
  showControls: true,
  showVolumeSlider: true,
  showBrightnessSlider: true,
  onPlayStarted: () => print('Воспроизведение началось'),
  onPlayStopped: () => print('Воспроизведение остановлено'),
)
```

### FreeDomeStatusIndicator
Индикатор статуса подключения:

```dart
FreeDomeStatusIndicator(
  showDetails: true,
  showDomeName: true,
  onTap: () => showStatusDialog(),
)
```

## 🌐 Поддерживаемые платформы

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **Web** (Chrome, Firefox, Safari)
- ✅ **Windows** (Windows 10+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Linux** (Ubuntu 18.04+)

## 🎯 Поддерживаемые форматы контента

- **360° видео** (Equirectangular)
- **Fulldome** контент
- **Fisheye** проекция
- **Кубические карты** (Cubemap)
- **Интерактивный контент**
- **Контент в реальном времени**

## 📋 Системные требования

### Минимальные требования
- Flutter 3.10.0+
- Dart 3.0.0+
- FreeDome Core 2.0+

### Рекомендуемые требования
- Flutter 3.16.0+
- Dart 3.2.0+
- FreeDome Core 2.5+

## 🔒 Безопасность

- **Система ролей**: Guest, Operator, Admin, Superadmin
- **Разрешения**: Детальный контроль доступа к функциям
- **Безопасное хранение**: Токены в FlutterSecureStorage
- **Аутентификация**: JWT токены и хэширование паролей

## 🛠️ Разработка

### Сборка из исходников

```bash
git clone https://github.com/nativemind/flutter_freedome.git
cd flutter_freedome
flutter pub get
flutter packages pub run build_runner build
```

### Запуск примера

```bash
cd example
flutter run
```

### Тестирование

```bash
flutter test
```

## 📖 API Документация

### FreeDomeProvider
Главный класс для управления FreeDome системой:

```dart
class FreeDomeProvider extends ChangeNotifier {
  // Инициализация
  Future<bool> initialize({
    bool autoDiscovery = true,
    FreeDomeUserRole defaultRole = FreeDomeUserRole.guest,
  });
  
  // Подключение
  Future<bool> connectToNearestDome();
  Future<bool> connectToDome(DomeSystem dome);
  Future<void> disconnect();
  
  // Воспроизведение
  Future<bool> playContent(FreeDomeContent content);
  Future<bool> playAppContent({
    required String appName,
    required String contentName,
    required Map<String, dynamic> appData,
  });
  
  // Управление
  Future<bool> pausePlayback();
  Future<bool> resumePlayback();
  Future<bool> stopPlayback();
  Future<bool> setVolume(double volume);
  Future<bool> setBrightness(double brightness);
  
  // Аутентификация
  Future<bool> authenticateAsAdmin({
    required String username,
    required String password,
  });
  Future<bool> switchToGuestMode();
  Future<void> logout();
}
```

### FreeDomeGuestService
Упрощенный API для гостевого режима:

```dart
class FreeDomeGuestService extends ChangeNotifier {
  Future<bool> initialize();
  Future<bool> connectToNearestDome();
  Future<bool> playAppContent({
    required String appName,
    required String contentName,
    required Map<String, dynamic> appData,
  });
  Future<bool> pause();
  Future<bool> resume();
  Future<bool> stop();
  Future<bool> setVolume(double volume);
  Future<bool> setBrightness(double brightness);
}
```

## 🤝 Участие в разработке

Мы приветствуем вклад в развитие проекта! Пожалуйста:

1. Форкните репозиторий
2. Создайте ветку для новой функции (`git checkout -b feature/amazing-feature`)
3. Зафиксируйте изменения (`git commit -m 'Add amazing feature'`)
4. Отправьте в ветку (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

## 📄 Лицензия

Этот проект лицензирован под NativeMindNONC License - см. файл [LICENSE](LICENSE) для деталей.

## 🆘 Поддержка

- 📧 Email: support@nativemind.ru
- 💬 Telegram: @nativemind_support
- 🐛 Issues: [GitHub Issues](https://github.com/nativemind/flutter_freedome/issues)
- 📚 Docs: [Documentation](https://docs.nativemind.ru/flutter_freedome)

## 📈 Статистика

- ⭐ **GitHub Stars**: Поставьте звезду, если проект полезен!
- 📦 **Pub Points**: Следите за качеством на pub.dev
- 🏆 **Популярность**: Используется в купольных планетариях по всему миру

---

Сделано с ❤️ командой [NativeMind](https://nativemind.ru)