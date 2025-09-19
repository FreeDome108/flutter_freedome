import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/localization_models.dart';

/// Сервис локализации с поддержкой 20+ языков
class LocalizationService extends ChangeNotifier {
  static const String _languageKey = 'magento_selected_language';
  static const String _countryKey = 'magento_selected_country';

  // Поддерживаемые языки
  static const Map<String, LocaleInfo> _supportedLocales = {
    'en': LocaleInfo('en', 'US', 'English', 'English'),
    'ru': LocaleInfo('ru', 'RU', 'Русский', 'Russian'),
    'zh': LocaleInfo('zh', 'CN', '中文', 'Chinese'),
    'es': LocaleInfo('es', 'ES', 'Español', 'Spanish'),
    'fr': LocaleInfo('fr', 'FR', 'Français', 'French'),
    'de': LocaleInfo('de', 'DE', 'Deutsch', 'German'),
    'it': LocaleInfo('it', 'IT', 'Italiano', 'Italian'),
    'pt': LocaleInfo('pt', 'PT', 'Português', 'Portuguese'),
    'ja': LocaleInfo('ja', 'JP', '日本語', 'Japanese'),
    'ko': LocaleInfo('ko', 'KR', '한국어', 'Korean'),
    'ar': LocaleInfo('ar', 'SA', 'العربية', 'Arabic'),
    'hi': LocaleInfo('hi', 'IN', 'हिन्दी', 'Hindi'),
    'th': LocaleInfo('th', 'TH', 'ไทย', 'Thai'),
    'vi': LocaleInfo('vi', 'VN', 'Tiếng Việt', 'Vietnamese'),
    'tr': LocaleInfo('tr', 'TR', 'Türkçe', 'Turkish'),
    'pl': LocaleInfo('pl', 'PL', 'Polski', 'Polish'),
    'nl': LocaleInfo('nl', 'NL', 'Nederlands', 'Dutch'),
    'sv': LocaleInfo('sv', 'SE', 'Svenska', 'Swedish'),
    'da': LocaleInfo('da', 'DK', 'Dansk', 'Danish'),
    'no': LocaleInfo('no', 'NO', 'Norsk', 'Norwegian'),
    'fi': LocaleInfo('fi', 'FI', 'Suomi', 'Finnish'),
    'he': LocaleInfo('he', 'IL', 'עברית', 'Hebrew'),
    'uk': LocaleInfo('uk', 'UA', 'Українська', 'Ukrainian'),
    'cs': LocaleInfo('cs', 'CZ', 'Čeština', 'Czech'),
    'hu': LocaleInfo('hu', 'HU', 'Magyar', 'Hungarian'),
    'ro': LocaleInfo('ro', 'RO', 'Română', 'Romanian'),
    'bg': LocaleInfo('bg', 'BG', 'Български', 'Bulgarian'),
    'hr': LocaleInfo('hr', 'HR', 'Hrvatski', 'Croatian'),
    'sk': LocaleInfo('sk', 'SK', 'Slovenčina', 'Slovak'),
    'et': LocaleInfo('et', 'EE', 'Eesti', 'Estonian'),
    'lv': LocaleInfo('lv', 'LV', 'Latviešu', 'Latvian'),
    'lt': LocaleInfo('lt', 'LT', 'Lietuvių', 'Lithuanian'),
    'sl': LocaleInfo('sl', 'SI', 'Slovenščina', 'Slovenian'),
    'id': LocaleInfo('id', 'ID', 'Bahasa Indonesia', 'Indonesian'),
    'ms': LocaleInfo('ms', 'MY', 'Bahasa Melayu', 'Malay'),
    'tl': LocaleInfo('tl', 'PH', 'Filipino', 'Filipino'),
    'sw': LocaleInfo('sw', 'KE', 'Kiswahili', 'Swahili'),
    'am': LocaleInfo('am', 'ET', 'አማርኛ', 'Amharic'),
    'bn': LocaleInfo('bn', 'BD', 'বাংলা', 'Bengali'),
    'gu': LocaleInfo('gu', 'IN', 'ગુજરાતી', 'Gujarati'),
    'kn': LocaleInfo('kn', 'IN', 'ಕನ್ನಡ', 'Kannada'),
    'ml': LocaleInfo('ml', 'IN', 'മലയാളം', 'Malayalam'),
    'mr': LocaleInfo('mr', 'IN', 'मराठी', 'Marathi'),
    'pa': LocaleInfo('pa', 'IN', 'ਪੰਜਾਬੀ', 'Punjabi'),
    'ta': LocaleInfo('ta', 'IN', 'தமிழ்', 'Tamil'),
    'te': LocaleInfo('te', 'IN', 'తెలుగు', 'Telugu'),
    'ur': LocaleInfo('ur', 'PK', 'اردو', 'Urdu'),
    'fa': LocaleInfo('fa', 'IR', 'فارسی', 'Persian'),
    'my': LocaleInfo('my', 'MM', 'မြန်မာ', 'Myanmar'),
    'km': LocaleInfo('km', 'KH', 'ខ្មែរ', 'Khmer'),
    'lo': LocaleInfo('lo', 'LA', 'ລາວ', 'Lao'),
    'si': LocaleInfo('si', 'LK', 'සිංහල', 'Sinhala'),
    'ne': LocaleInfo('ne', 'NP', 'नेपाली', 'Nepali'),
  };

  Locale _currentLocale = const Locale('en', 'US');
  Map<String, String> _localizedStrings = {};
  bool _isInitialized = false;
  List<String> _availableLanguages = [];

  // Геттеры
  Locale get currentLocale => _currentLocale;
  String get currentLanguage => _currentLocale.languageCode;
  String get currentCountry => _currentLocale.countryCode ?? '';
  bool get isInitialized => _isInitialized;
  List<String> get availableLanguages => List.from(_availableLanguages);
  List<LocaleInfo> get supportedLocales => _supportedLocales.values.toList();

  /// Проверка поддержки RTL
  bool get isRTL {
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(_currentLocale.languageCode);
  }

  /// Инициализация сервиса локализации
  Future<bool> initialize([List<String>? supportedLanguages]) async {
    try {
      _availableLanguages =
          supportedLanguages ?? _supportedLocales.keys.toList();

      // Загружаем сохраненную локаль
      await _loadSavedLocale();

      // Загружаем строки локализации
      await _loadLocalizedStrings();

      _isInitialized = true;

      if (kDebugMode) {
        print(
            '✅ LocalizationService инициализирован: ${_currentLocale.toString()}');
      }

      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка инициализации LocalizationService: $e');
      }
      return false;
    }
  }

  /// Загрузка сохраненной локали
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);
      final savedCountry = prefs.getString(_countryKey);

      if (savedLanguage != null) {
        _currentLocale = Locale(savedLanguage, savedCountry);
      } else {
        // Используем системную локаль если доступна
        final systemLocale = PlatformDispatcher.instance.locale;
        if (_availableLanguages.contains(systemLocale.languageCode)) {
          _currentLocale = systemLocale;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка загрузки сохраненной локали: $e');
      }
    }
  }

  /// Загрузка локализованных строк
  Future<void> _loadLocalizedStrings() async {
    try {
      final assetPath =
          'packages/flutter_magento/assets/localization/${_currentLocale.languageCode}.json';
      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(
            '❌ Не удалось загрузить локализацию для ${_currentLocale.languageCode}: $e');
      }

      // Загружаем английский как fallback
      if (_currentLocale.languageCode != 'en') {
        try {
          final fallbackPath =
              'packages/flutter_magento/assets/localization/en.json';
          final jsonString = await rootBundle.loadString(fallbackPath);
          final Map<String, dynamic> jsonMap = json.decode(jsonString);
          _localizedStrings =
              jsonMap.map((key, value) => MapEntry(key, value.toString()));
        } catch (fallbackError) {
          if (kDebugMode) {
            print(
                '❌ Не удалось загрузить fallback локализацию: $fallbackError');
          }
        }
      }
    }
  }

  /// Изменение языка
  Future<bool> changeLanguage(String languageCode,
      [String? countryCode]) async {
    if (!_availableLanguages.contains(languageCode)) {
      if (kDebugMode) {
        print('❌ Язык $languageCode не поддерживается');
      }
      return false;
    }

    try {
      final localeInfo = _supportedLocales[languageCode];
      final newLocale =
          Locale(languageCode, countryCode ?? localeInfo?.countryCode);

      _currentLocale = newLocale;

      // Загружаем новые строки локализации
      await _loadLocalizedStrings();

      // Сохраняем выбор
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
      if (countryCode != null) {
        await prefs.setString(_countryKey, countryCode);
      }

      if (kDebugMode) {
        print('✅ Язык изменен на: ${_currentLocale.toString()}');
      }

      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Ошибка изменения языка: $e');
      }
      return false;
    }
  }

  /// Получение локализованной строки
  String translate(String key, {Map<String, String>? params}) {
    String translation = _localizedStrings[key] ?? key;

    // Подстановка параметров
    if (params != null) {
      params.forEach((paramKey, paramValue) {
        translation = translation.replaceAll('{$paramKey}', paramValue);
      });
    }

    return translation;
  }

  /// Получение локализованной строки с множественным числом
  String translatePlural(String key, int count, {Map<String, String>? params}) {
    final pluralKey = _getPluralKey(key, count);
    return translate(pluralKey, params: params);
  }

  /// Определение ключа для множественного числа
  String _getPluralKey(String key, int count) {
    final language = _currentLocale.languageCode;

    switch (language) {
      case 'ru':
      case 'uk':
        if (count % 10 == 1 && count % 100 != 11) {
          return '${key}_one';
        } else if (count % 10 >= 2 &&
            count % 10 <= 4 &&
            (count % 100 < 10 || count % 100 >= 20)) {
          return '${key}_few';
        } else {
          return '${key}_many';
        }

      case 'pl':
        if (count == 1) {
          return '${key}_one';
        } else if (count % 10 >= 2 &&
            count % 10 <= 4 &&
            (count % 100 < 10 || count % 100 >= 20)) {
          return '${key}_few';
        } else {
          return '${key}_many';
        }

      case 'ar':
        if (count == 0) {
          return '${key}_zero';
        } else if (count == 1) {
          return '${key}_one';
        } else if (count == 2) {
          return '${key}_two';
        } else if (count % 100 >= 3 && count % 100 <= 10) {
          return '${key}_few';
        } else if (count % 100 >= 11) {
          return '${key}_many';
        } else {
          return '${key}_other';
        }

      default:
        return count == 1 ? '${key}_one' : '${key}_other';
    }
  }

  /// Получение информации о текущей локали
  LocaleInfo? get currentLocaleInfo {
    return _supportedLocales[_currentLocale.languageCode];
  }

  /// Получение списка доступных языков с информацией
  List<LocaleInfo> get availableLocaleInfos {
    return _availableLanguages
        .map((lang) => _supportedLocales[lang])
        .where((info) => info != null)
        .cast<LocaleInfo>()
        .toList();
  }

  /// Форматирование даты согласно локали
  String formatDate(DateTime date, {String? pattern}) {
    // Базовая реализация, можно расширить с помощью intl пакета
    switch (_currentLocale.languageCode) {
      case 'ru':
      case 'uk':
        return '${date.day}.${date.month.toString().padLeft(2, '0')}.${date.year}';
      case 'en':
        return '${date.month}/${date.day}/${date.year}';
      case 'de':
      case 'fr':
        return '${date.day}/${date.month}/${date.year}';
      default:
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  /// Форматирование числа согласно локали
  String formatNumber(num number, {int? decimalPlaces}) {
    final formatted = decimalPlaces != null
        ? number.toStringAsFixed(decimalPlaces)
        : number.toString();

    switch (_currentLocale.languageCode) {
      case 'ru':
      case 'de':
      case 'fr':
        return formatted.replaceAll('.', ',');
      default:
        return formatted;
    }
  }

  /// Форматирование валюты
  String formatCurrency(double amount, String currencyCode) {
    final formattedAmount = formatNumber(amount, decimalPlaces: 2);

    switch (_currentLocale.languageCode) {
      case 'ru':
        return '$formattedAmount $currencyCode';
      case 'de':
        return '$formattedAmount $currencyCode';
      case 'fr':
        return '$formattedAmount $currencyCode';
      default:
        return '$currencyCode $formattedAmount';
    }
  }

  /// Получение статуса локализации
  Map<String, dynamic> get status => {
        'isInitialized': _isInitialized,
        'currentLocale': _currentLocale.toString(),
        'currentLanguage': _currentLocale.languageCode,
        'currentCountry': _currentLocale.countryCode,
        'isRTL': isRTL,
        'availableLanguages': _availableLanguages,
        'loadedStringsCount': _localizedStrings.length,
      };

  /// Сброс к системной локали
  Future<void> resetToSystemLocale() async {
    final systemLocale = PlatformDispatcher.instance.locale;
    if (_availableLanguages.contains(systemLocale.languageCode)) {
      await changeLanguage(systemLocale.languageCode, systemLocale.countryCode);
    } else {
      await changeLanguage('en', 'US');
    }
  }
}
