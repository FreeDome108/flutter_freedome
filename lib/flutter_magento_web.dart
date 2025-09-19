// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_magento_platform_interface.dart';

/// A web implementation of the FlutterMagentoPlatform of the FlutterMagento plugin.
class FlutterMagentoWeb extends FlutterMagentoPlatform {
  /// Constructs a FlutterMagentoWeb
  FlutterMagentoWeb();

  static void registerWith(Registrar registrar) {
    FlutterMagentoPlatform.instance = FlutterMagentoWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }
}
