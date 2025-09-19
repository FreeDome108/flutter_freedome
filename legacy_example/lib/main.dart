import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Core imports
import 'core/constants/app_constants.dart';
import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/services/api_service.dart';
import 'core/services/network_service.dart';
import 'core/services/theme_service.dart';
import 'core/services/localization_service.dart';
import 'core/services/analytics_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/secure_storage_service.dart';
import 'core/services/biometric_auth_service.dart';
import 'core/providers/app_providers.dart';
import 'core/providers/theme_provider.dart';

// Widgets
import 'core/widgets/loading_screen.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Sentry for error tracking
    await SentryFlutter.init(
      (options) {
        options.dsn = AppConfig.sentryDsn;
        options.environment = AppConfig.environment;
        options.release = '${AppConfig.appVersion}+${AppConfig.buildNumber}';
        options.tracesSampleRate = kDebugMode ? 1.0 : 0.1;
        options.beforeSend = (event, hint) {
          if (kDebugMode) {
            print('📊 Sentry Event: ${event.message ?? event.exception}');
          }
          return event;
        };
      },
    );

    await _initializeApp();

    runApp(
      const ProviderScope(
        child: NativeMarketplaceApp(),
      ),
    );
  }, (error, stack) {
    // Global error handler
    if (kDebugMode) {
      print('❌ Global Error: $error');
      print('Stack: $stack');
    }
    
    // Report to Sentry in production
    if (kReleaseMode) {
      Sentry.captureException(error, stackTrace: stack);
    }
  });
}

Future<void> _initializeApp() async {
  try {
    // Show splash screen while initializing
    _showSplashScreen();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize Firebase
    if (AppConfig.isFeatureEnabled('enableAnalytics') || 
        AppConfig.isFeatureEnabled('enableCrashlytics')) {
      await Firebase.initializeApp();
      
      if (AppConfig.isFeatureEnabled('enableCrashlytics') && kReleaseMode) {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      }
    }

    // Get device and app information
    await _initializeDeviceInfo();

    // Initialize core services
    await _initializeServices();

    if (kDebugMode) {
      print('✅ App initialization completed successfully');
    }
  } catch (e, stack) {
    if (kDebugMode) {
      print('❌ App initialization failed: $e');
      print('Stack: $stack');
    }
    
    // Report initialization errors
    if (kReleaseMode) {
      await Sentry.captureException(e, stackTrace: stack);
    }
    
    rethrow;
  }
}

Future<void> _initializeDeviceInfo() async {
  try {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    
    if (kDebugMode) {
      print('📱 App Version: ${packageInfo.version}+${packageInfo.buildNumber}');
      
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        print('📱 Android: ${androidInfo.model} (API ${androidInfo.version.sdkInt})');
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        print('📱 iOS: ${iosInfo.model} (${iosInfo.systemVersion})');
      }
    }
    
    // Set user properties for analytics
    if (AppConfig.isFeatureEnabled('enableAnalytics')) {
      await AnalyticsService.setUserProperty('app_version', packageInfo.version);
      await AnalyticsService.setUserProperty('build_number', packageInfo.buildNumber);
      await AnalyticsService.setUserProperty('platform', Platform.operatingSystem);
    }
  } catch (e) {
    if (kDebugMode) {
      print('⚠️ Failed to get device info: $e');
    }
  }
}

void _showSplashScreen() {
  // Custom splash screen logic if needed
  if (kDebugMode) {
    print('🚀 Starting ${AppConfig.appName} v${AppConfig.appVersion}');
    print('🌍 Environment: ${AppConfig.environment}');
    print('🔗 API Base URL: ${AppConfig.apiBaseUrl}');
  }
}

Future<void> _initializeServices() async {
  // Initialize services in order
  await SecureStorageService.initialize();
  
  // Initialize network service
  final networkService = NetworkService();
  await networkService.initialize();
  
  // Initialize API service
  final apiService = ApiService();
  await apiService.initialize();
  
  // Initialize analytics
  if (AppConfig.isFeatureEnabled('enableAnalytics')) {
    await AnalyticsService.initialize();
  }
  
      // Initialize notifications
    if (AppConfig.isFeatureEnabled('enablePushNotifications')) {
      await NotificationService.initialize();
    }

    // Initialize biometric authentication
    if (AppConfig.isFeatureEnabled('enableBiometricAuth')) {
      await BiometricAuthService.isBiometricAvailable();
    }

    if (kDebugMode) {
      print('✅ All services initialized successfully');
    }
}

/// Main application widget
class NativeMarketplaceApp extends ConsumerWidget {
  const NativeMarketplaceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localizationProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      
      // Localization configuration
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Home page
      home: const SplashScreen(),
      
      // Error handling
      builder: (context, child) {
        return ErrorBoundary(
          child: child ?? const LoadingScreen(),
        );
      },
    );
  }
}

/// Error boundary widget to catch and handle errors gracefully
class ErrorBoundary extends StatefulWidget {
  final Widget child;

  const ErrorBoundary({
    super.key,
    required this.child,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Error? _error;

  @override
  void initState() {
    super.initState();
    _setupErrorHandling();
  }

  void _setupErrorHandling() {
    // Flutter error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      if (AppConstants.enableCrashlytics) {
        // Report to crashlytics
        // CrashlyticsService.recordFlutterError(details);
      }
      
      // Show error dialog in debug mode
      if (kDebugMode) {
        _showErrorDialog(details.exception.toString());
      }
    };

    // Platform error handling
    PlatformDispatcher.instance.onError = (error, stack) {
      if (AppConstants.enableCrashlytics) {
        // Report to crashlytics
        // CrashlyticsService.recordError(error, stack);
      }
      
      // Show error dialog in debug mode
      if (kDebugMode) {
        _showErrorDialog(error.toString());
      }
      
      return true;
    };
  }

  void _showErrorDialog(String error) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _buildErrorScreen();
    }

    return widget.child;
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'An unexpected error occurred. Please try again.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
