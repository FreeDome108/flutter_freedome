import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flutter_freedome_platform_interface.dart';

class MethodChannelFlutterFreedome extends FlutterFreedomePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_freedome');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
