# Flutter FreeDome

Унифицированная Flutter библиотека для интеграции с купольными кинотеатрами FreeDome.

## Описание

Flutter FreeDome - это мощная библиотека, которая предоставляет простой и эффективный способ интеграции ваших Flutter приложений с купольными кинотеатрами FreeDome. Библиотека поддерживает как гостевой режим для воспроизведения контента, так и административный режим для полной настройки и калибровки систем.

## Основные возможности

### 🎭 Гостевой режим
- Автоматическое обнаружение купольных систем в сети
- Воспроизведение контента любых приложений
- Базовые настройки (громкость, яркость)
- Простой API для быстрой интеграции

### 🔧 Режим администратора
- Полная калибровка аудио и видео систем
- Управление проекторами и аудиоканалами
- Системное администрирование
- Мониторинг и диагностика

## Быстрый старт

### Установка

Добавьте зависимость в ваш `pubspec.yaml`:

```yaml
dependencies:
  flutter_freedome: ^2.0.0
```

### Базовое использование

```dart
import 'package:flutter_freedome/flutter_freedome.dart';

// Инициализация FreeDome
final freedome = FreeDomeProvider();
await freedome.initialize();

// Подключение к куполу
await freedome.connectToNearestDome();

// Воспроизведение контента приложения
await freedome.playAppContent(
  appName: 'MyApp',
  contentName: 'Мой контент',
  appData: {'type': 'visualization', 'data': myData},
);
```

### Быстрый старт (одна строка)

```dart
// Быстрое воспроизведение контента
final success = await FlutterFreeDome.quickPlay(
  appName: 'MyApp',
  contentName: 'Мой контент',
  appData: {'type': 'visualization', 'data': myData},
);
```

## Архитектура

- **FreeDomeProvider** - главная точка входа и управление состоянием
- **ConnectionService** - управление подключениями к купольным системам
- **AuthService** - аутентификация и управление ролями пользователей
- **ContentService** - управление контентом и воспроизведением
- **CalibrationService** - калибровка аудио и видео (только админ)
- **SystemService** - системное управление (только админ)

## Поддерживаемые платформы

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## Лицензия

NativeMindNONC

## Автор

NativeMind Team

## Ссылки

- [Документация](doc/)
- [Примеры использования](example/)
- [GitHub](https://github.com/nativemind/flutter_freedome)
