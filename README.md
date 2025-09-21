# Flutter FreeDome

[![pub package](https://img.shields.io/pub/v/flutter_freedome.svg)](https://pub.dev/packages/flutter_freedome)
[![License](https://img.shields.io/badge/License-NativeMindNONC-blue.svg)](LICENSE)

Унифицированная Flutter библиотека для интеграции с купольными кинотеатрами FreeDome. Поддерживает гостевой режим для воспроизведения контента и административный режим для полной настройки и калибровки купольных систем.

## 🔗 Интеграция с FreeDome Manager через deeplinks

### 📱 Схема `freedome://` - единая точка входа

Все приложения экосистемы FreeDome используют единую схему deeplinks `freedome://` для запуска калибровки и интеграции. При вызове любого deeplink со схемой `freedome://` **всегда запускается FreeDome Manager**, который затем координирует работу с другими приложениями.

#### 🎯 Преимущества централизованного подхода:
- **Единая точка калибровки** - все приложения калибруются через FreeDome Manager
- **Консистентный пользовательский опыт** - одинаковый интерфейс для всех операций
- **Упрощенная интеграция** - не нужно реализовывать собственную калибровку
- **Автоматическая синхронизация** - настройки применяются ко всем приложениям

#### 🔧 Использование deeplinks в вашем приложении:

```dart
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_freedome/flutter_freedome.dart';

// Запуск калибровки для вашего приложения
Future<void> startCalibration() async {
  await launchUrl(Uri.parse('freedome://app/calibrate?name=my_app'));
}

// Быстрая калибровка
Future<void> quickCalibrate() async {
  await launchUrl(Uri.parse('freedome://quick/calibrate'));
}

// Запуск с callback для получения результатов
Future<void> calibrateWithCallback() async {
  await launchUrl(Uri.parse(
    'freedome://calibration/start?callback=myapp://calibration_complete'
  ));
}
```

#### 📋 Поддерживаемые deeplinks:

**Калибровка:**
- `freedome://calibration/start` - Запуск полной калибровки
- `freedome://calibration/audio` - Калибровка только аудио
- `freedome://calibration/video` - Калибровка только видео
- `freedome://quick/calibrate` - Быстрая калибровка

**Управление приложениями:**
- `freedome://app/calibrate?name=my_app` - Калибровка для конкретного приложения
- `freedome://app/settings?name=my_app` - Настройки для приложения

**Купольные системы:**
- `freedome://dome/connect` - Подключение к куполу
- `freedome://dome/status` - Статус купольной системы

## 📖 Описание

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
