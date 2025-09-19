import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/localization_manager.dart';

/// Провайдер для управления локализацией
class LocalizationProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  
  String _currentLanguage = 'en';
  Locale _currentLocale = const Locale('en');

  String get currentLanguage => _currentLanguage;
  Locale get currentLocale => _currentLocale;

  LocalizationProvider() {
    _loadSavedLanguage();
  }

  /// Загрузить сохраненный язык
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);
      if (savedLanguage != null) {
        await changeLanguage(savedLanguage);
      }
    } catch (e) {
      debugPrint('Ошибка загрузки языка: $e');
    }
  }

  /// Изменить язык
  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage == languageCode) return;

    _currentLanguage = languageCode;
    _currentLocale = LocalizationManager.getLocaleFromCode(languageCode);

    // Сохранить выбор в SharedPreferences
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      debugPrint('Ошибка сохранения языка: $e');
    }

    notifyListeners();
  }

  /// Получить название текущего языка
  String getCurrentLanguageName(BuildContext context) {
    return LocalizationManager.getLanguageName(_currentLanguage, context);
  }

  /// Получить описание текущего языка
  String getCurrentLanguageDescription() {
    return LocalizationManager.getLanguageDescription(_currentLanguage);
  }

  /// Получить иконку текущего языка
  IconData getCurrentLanguageIcon() {
    return LocalizationManager.getLanguageIcon(_currentLanguage);
  }

  /// Получить цвет темы для текущего языка
  Color getCurrentLanguageThemeColor() {
    return LocalizationManager.getLanguageThemeColor(_currentLanguage);
  }

  /// Проверить, является ли текущий язык Харконнским
  bool get isHarkonnenLanguage {
    return LocalizationManager.isHarkonnenLanguage(_currentLanguage);
  }

  /// Проверить, является ли текущий язык Атрейдским
  bool get isAtreidesLanguage {
    return LocalizationManager.isAtreidesLanguage(_currentLanguage);
  }

  /// Получить список доступных языков
  List<Map<String, dynamic>> getAvailableLanguages(BuildContext context) {
    return LocalizationManager.supportedLocales.map((locale) {
      final languageCode = locale.languageCode;
      return {
        'code': languageCode,
        'name': LocalizationManager.getLanguageName(languageCode, context),
        'description': LocalizationManager.getLanguageDescription(languageCode),
        'icon': LocalizationManager.getLanguageIcon(languageCode),
        'themeColor': LocalizationManager.getLanguageThemeColor(languageCode),
        'isSelected': languageCode == _currentLanguage,
      };
    }).toList();
  }

  /// Сбросить язык на английский
  Future<void> resetToEnglish() async {
    await changeLanguage('en');
  }

  /// Получить информацию о текущем языке
  Map<String, dynamic> getCurrentLanguageInfo(BuildContext context) {
    return {
      'code': _currentLanguage,
      'name': getCurrentLanguageName(context),
      'description': getCurrentLanguageDescription(),
      'icon': getCurrentLanguageIcon(),
      'themeColor': getCurrentLanguageThemeColor(),
      'isHarkonnen': isHarkonnenLanguage,
      'isAtreides': isAtreidesLanguage,
    };
  }
}
