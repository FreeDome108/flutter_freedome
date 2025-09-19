import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'flutter_freedome_platform_interface.dart';

class FlutterFreedomeWeb extends FlutterFreedomePlatform {
  FlutterFreedomeWeb();

  static void registerWith(Registrar registrar) {
    FlutterFreedomePlatform.instance = FlutterFreedomeWeb();
  }

  @override
  Future<String?> getPlatformVersion() async {
    return 'Web ${DateTime.now()}';
  }
}
