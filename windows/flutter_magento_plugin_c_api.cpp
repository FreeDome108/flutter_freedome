#include "include/flutter_magento/flutter_magento_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_magento_plugin.h"

void FlutterMagentoPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_magento::FlutterMagentoPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
