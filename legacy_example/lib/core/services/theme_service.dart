import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

/// Service for managing app theme preferences
class ThemeService {
  static SharedPreferences? _prefs;

  /// Initialize the theme service
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Get the current theme mode
  static Future<ThemeMode> getThemeMode() async {
    await initialize();
    
    final themeString = _prefs!.getString(AppConstants.keyThemeMode);
    
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Set the theme mode
  static Future<void> setThemeMode(ThemeMode themeMode) async {
    await initialize();
    
    String themeString;
    switch (themeMode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }
    
    await _prefs!.setString(AppConstants.keyThemeMode, themeString);
  }

  /// Toggle between light and dark theme
  static Future<ThemeMode> toggleTheme() async {
    final currentTheme = await getThemeMode();
    final newTheme = currentTheme == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    
    await setThemeMode(newTheme);
    return newTheme;
  }

  /// Check if dark mode is enabled
  static Future<bool> isDarkMode() async {
    final themeMode = await getThemeMode();
    return themeMode == ThemeMode.dark;
  }

  /// Check if system theme is being used
  static Future<bool> isSystemTheme() async {
    final themeMode = await getThemeMode();
    return themeMode == ThemeMode.system;
  }

  /// Reset theme to system default
  static Future<void> resetToSystemTheme() async {
    await setThemeMode(ThemeMode.system);
  }

  /// Get theme mode as string
  static Future<String> getThemeModeString() async {
    final themeMode = await getThemeMode();
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}
