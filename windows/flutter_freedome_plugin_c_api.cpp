#include "include/flutter_freedome/flutter_freedome_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_freedome_plugin.h"

void FlutterFreedomePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_freedome::FlutterFreedomePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

