import 'package:flutter/foundation.dart';

/// Application configuration for different environments
class AppConfig {
  static const String _prodApiUrl = 'https://taxlien.online';
  static const String _stagingApiUrl = 'https://staging.taxlien.online';
  static const String _devApiUrl = 'https://dev.taxlien.online';

  /// Get API base URL based on build mode
  static String get apiBaseUrl {
    if (kReleaseMode) {
      return _prodApiUrl;
    } else if (kProfileMode) {
      return _stagingApiUrl;
    } else {
      return _devApiUrl;
    }
  }

  /// GraphQL endpoint
  static String get graphqlUrl => '$apiBaseUrl/graphql';

  /// REST API v1 endpoint
  static String get restApiUrl => '$apiBaseUrl/rest/V1';

  /// WebSocket URL for real-time updates
  static String get websocketUrl => apiBaseUrl.replaceFirst('http', 'ws');

  /// Firebase configuration
  static const Map<String, dynamic> firebaseConfig = {
    'prod': {
      'projectId': 'taxlien-prod',
      'apiKey': 'prod-api-key',
      'appId': 'prod-app-id',
    },
    'staging': {
      'projectId': 'taxlien-staging',
      'apiKey': 'staging-api-key',
      'appId': 'staging-app-id',
    },
    'dev': {
      'projectId': 'taxlien-dev',
      'apiKey': 'dev-api-key',
      'appId': 'dev-app-id',
    },
  };

  /// Sentry DSN for error tracking
  static const String sentryDsn = kReleaseMode 
      ? 'https://your-prod-sentry-dsn@sentry.io/project-id'
      : 'https://your-dev-sentry-dsn@sentry.io/project-id';

  /// Feature flags
  static const Map<String, bool> featureFlags = {
    'enableAnalytics': true,
    'enableCrashlytics': kReleaseMode,
    'enablePushNotifications': true,
    'enableBiometrics': true,
    'enableOfflineMode': true,
    'enableAI': true,
    'enableNFT': false, // Disabled for initial release
    'enableCrypto': false, // Disabled for initial release
  };

  /// API timeouts (in milliseconds)
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  /// Cache configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100; // MB

  /// Pagination defaults
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  /// Security configuration
  static const List<String> certificatePins = [
    'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=', // Replace with actual pins
    'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=',
  ];

  /// Rate limiting
  static const int maxRequestsPerMinute = 60;

  /// Supported locales
  static const List<String> supportedLocales = [
    'en', 'es', 'fr', 'de', 'ru', 'zh', 'ja', 'ko', 'ar', 'hi'
  ];

  /// App store URLs
  static const String appStoreUrl = 'https://apps.apple.com/app/taxlien-online/id123456789';
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.taxlien.marketplace';

  /// Support contact
  static const String supportEmail = 'support@taxlien.online';
  static const String supportPhone = '+1-800-TAXLIEN';

  /// Legal URLs
  static const String privacyPolicyUrl = '$_prodApiUrl/privacy-policy';
  static const String termsOfServiceUrl = '$_prodApiUrl/terms-of-service';
  static const String licenseUrl = '$_prodApiUrl/license';

  /// Social media links
  static const Map<String, String> socialLinks = {
    'twitter': 'https://twitter.com/taxlienonline',
    'facebook': 'https://facebook.com/taxlienonline',
    'linkedin': 'https://linkedin.com/company/taxlienonline',
    'youtube': 'https://youtube.com/taxlienonline',
  };

  /// Check if feature is enabled
  static bool isFeatureEnabled(String feature) {
    return featureFlags[feature] ?? false;
  }

  /// Get environment name
  static String get environment {
    if (kReleaseMode) return 'production';
    if (kProfileMode) return 'staging';
    return 'development';
  }

  /// Get Firebase config for current environment
  static Map<String, dynamic> get currentFirebaseConfig {
    return firebaseConfig[environment] ?? firebaseConfig['dev']!;
  }

  /// Version and build info
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  static const String appName = 'TaxLien.online';
  static const String packageName = 'com.taxlien.marketplace';

  /// Minimum supported versions
  static const String minAndroidVersion = '23'; // Android 6.0
  static const String minIOSVersion = '12.0';

  /// Performance thresholds
  static const Duration maxStartupTime = Duration(seconds: 3);
  static const Duration maxScreenTransition = Duration(milliseconds: 300);
  static const double targetFPS = 60.0;

  /// Memory limits
  static const int maxMemoryUsage = 150; // MB
  static const int warningMemoryUsage = 120; // MB

  /// Logging configuration
  static const bool enableDetailedLogging = !kReleaseMode;
  static const bool enableNetworkLogging = !kReleaseMode;
  static const bool enableAnalyticsLogging = !kReleaseMode;
}
