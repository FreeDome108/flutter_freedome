# 🔄 Руководство по миграции на flutter_freedome 1.0

## 🚀 Обзор изменений

Flutter FreeDome - это специализированная библиотека для интеграции с купольными кинотеатрами FreeDome. Она предоставляет унифицированный API для управления купольными системами и воспроизведения контента.

### ✨ Основные возможности
- **Гостевой режим** для простого воспроизведения контента
- **Режим администратора** для полной настройки и калибровки
- **Автоматическое обнаружение** купольных систем в сети
- **Поддержка множественных форматов** контента (360°, Fulldome, Fisheye)
- **Система ролей и разрешений** для безопасного доступа
- **Реактивное программирование** с Provider pattern

## 🚀 Быстрая миграция

### 1. Установите зависимости

```yaml
dependencies:
  flutter_freedome: ^1.0.0
  provider: ^6.1.1
```

### 2. Базовая настройка

#### Оберните приложение в Provider:
```dart
import 'package:flutter_freedome/flutter_freedome.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FreeDomeProvider(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}
```

#### Инициализация FreeDome:
```dart
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Consumer<FreeDomeProvider>(
      builder: (context, freedome, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('FreeDome App'),
            actions: [
              FreeDomeStatusIndicator(),
            ],
          ),
          body: Column(
            children: [
              FreeDomeConnectionWidget(),
              FreeDomeContentPlayer(),
              ElevatedButton(
                onPressed: () => _playContent(),
                child: Text('Воспроизвести контент'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _playContent() async {
    final freedome = context.read<FreeDomeProvider>();
    await freedome.playAppContent(
      appName: 'MyApp',
      contentName: 'Мой контент',
      appData: {
        'type': 'visualization',
        'data': myContentData,
      },
    );
  }
}
```

### 3. Быстрое воспроизведение

```dart
// Самый простой способ
final success = await FlutterFreeDome.quickPlay(
  appName: 'MyApp',
  contentName: 'Звездное небо',
  appData: {
    'type': 'starfield',
    'constellation': 'all',
  },
);
```

## 🎮 Примеры использования

### Звездное небо
```dart
await freedome.playAppContent(
  appName: 'StarryApp',
  contentName: 'Созвездия',
  appData: {
    'type': 'starfield',
    'constellation': 'ursa_major',
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
    'speed': 1.5,
    'focusPlanet': 'mars',
  },
);
```

### Медитативный контент
```dart
await freedome.playAppContent(
  appName: 'MeditationApp',
  contentName: 'Релаксация',
  appData: {
    'type': 'meditation',
    'duration': 600,
    'background': 'ocean',
    'sounds': ['waves', 'birds'],
  },
);
```

## 🔧 Режим администратора

```dart
// Аутентификация как администратор
final success = await freedome.authenticateAsAdmin(
  username: 'admin',
  password: 'secure_password',
);

if (success) {
  // Доступ к административным функциям
  final calibration = freedome.calibration;
  final system = freedome.system;
  
  // Калибровка аудио
  await calibration?.startAudioCalibration();
  
  // Системная диагностика
  final health = await system?.getSystemHealth();
}
```

## 📱 Готовые виджеты

### FreeDomeConnectionWidget
```dart
FreeDomeConnectionWidget(
  autoConnect: true,
  showDiscoveredSystems: true,
  onConnected: () => print('Подключен!'),
  onDisconnected: () => print('Отключен'),
)
```

### FreeDomeContentPlayer
```dart
FreeDomeContentPlayer(
  content: myContent,
  showControls: true,
  showVolumeSlider: true,
  onPlayStarted: () => print('Воспроизведение началось'),
  onPlayStopped: () => print('Воспроизведение остановлено'),
)
```

## 🔒 Безопасность

FreeDome поддерживает систему ролей:
- **Guest**: Базовое воспроизведение контента
- **Operator**: Расширенное управление воспроизведением
- **Admin**: Полный доступ к настройкам системы
- **Superadmin**: Системное администрирование

## 🛠️ Отладка

### Логирование
```dart
// Включить подробные логи
await freedome.initialize(
  debugMode: true,
  logLevel: FreeDomeLogLevel.verbose,
);
```

### Диагностика подключения
```dart
final diagnostics = await freedome.runConnectionDiagnostics();
print('Статус подключения: ${diagnostics.status}');
print('Обнаруженные системы: ${diagnostics.discoveredSystems.length}');
```

## 🆘 Поддержка

- 📧 Email: support@nativemind.ru
- 💬 Telegram: @nativemind_support
- 🐛 Issues: [GitHub Issues](https://github.com/nativemind/flutter_freedome/issues)
- 📚 Docs: [Documentation](https://docs.nativemind.ru/flutter_freedome)

---

Сделано с ❤️ командой [NativeMind](https://nativemind.ru)