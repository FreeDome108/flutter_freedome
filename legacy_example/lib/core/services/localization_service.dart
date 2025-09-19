import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

/// Service for managing app localization preferences
class LocalizationService {
  static SharedPreferences? _prefs;

  /// Initialize the localization service
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Get the current locale
  static Future<Locale> getLocale() async {
    await initialize();
    
    final languageCode = _prefs!.getString(AppConstants.keyLanguage);
    
    if (languageCode != null && AppConstants.supportedLanguages.containsKey(languageCode)) {
      return Locale(languageCode);
    }
    
    // Return default locale if not set or invalid
    return const Locale('en', 'US');
  }

  /// Set the locale
  static Future<void> setLocale(Locale locale) async {
    await initialize();
    await _prefs!.setString(AppConstants.keyLanguage, locale.languageCode);
  }

  /// Get supported locales
  static List<Locale> getSupportedLocales() {
    return AppConstants.supportedLanguages.keys
        .map((languageCode) => Locale(languageCode))
        .toList();
  }

  /// Get supported languages map
  static Map<String, String> getSupportedLanguages() {
    return AppConstants.supportedLanguages;
  }

  /// Get language name by code
  static String getLanguageName(String languageCode) {
    return AppConstants.supportedLanguages[languageCode] ?? 'Unknown';
  }

  /// Check if a language is supported
  static bool isLanguageSupported(String languageCode) {
    return AppConstants.supportedLanguages.containsKey(languageCode);
  }

  /// Get current language code
  static Future<String> getCurrentLanguageCode() async {
    final locale = await getLocale();
    return locale.languageCode;
  }

  /// Get current language name
  static Future<String> getCurrentLanguageName() async {
    final languageCode = await getCurrentLanguageCode();
    return getLanguageName(languageCode);
  }

  /// Reset to system locale
  static Future<void> resetToSystemLocale() async {
    // Get system locale
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    
    // Check if system language is supported
    if (isLanguageSupported(systemLocale.languageCode)) {
      await setLocale(systemLocale);
    } else {
      // Fall back to English if system language is not supported
      await setLocale(const Locale('en', 'US'));
    }
  }

  /// Get locale display name
  static String getLocaleDisplayName(Locale locale) {
    final languageName = getLanguageName(locale.languageCode);
    if (locale.countryCode != null) {
      return '$languageName (${locale.countryCode})';
    }
    return languageName;
  }

  /// Check if current locale is RTL (Right-to-Left)
  static Future<bool> isRTL() async {
    final locale = await getLocale();
    // Add RTL language codes here
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(locale.languageCode);
  }

  /// Get locale from language code
  static Locale getLocaleFromLanguageCode(String languageCode) {
    // Handle special cases with country codes
    switch (languageCode) {
      case 'en':
        return const Locale('en', 'US');
      case 'es':
        return const Locale('es', 'ES');
      case 'fr':
        return const Locale('fr', 'FR');
      case 'de':
        return const Locale('de', 'DE');
      case 'zh':
        return const Locale('zh', 'CN');
      default:
        return Locale(languageCode);
    }
  }

  /// Get available locales for the app
  static List<Locale> getAvailableLocales() {
    return AppConstants.supportedLanguages.keys
        .map((code) => getLocaleFromLanguageCode(code))
        .toList();
  }
}
