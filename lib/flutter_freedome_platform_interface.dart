import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'flutter_freedome_method_channel.dart';

abstract class FlutterFreedomePlatform extends PlatformInterface {
  FlutterFreedomePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFreedomePlatform _instance = MethodChannelFlutterFreedome();

  static FlutterFreedomePlatform get instance => _instance;

  static set instance(FlutterFreedomePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }
}
