#ifndef FLUTTER_PLUGIN_FLUTTER_MAGENTO_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_MAGENTO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_magento {

class FlutterMagentoPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterMagentoPlugin();

  virtual ~FlutterMagentoPlugin();

  // Disallow copy and assign.
  FlutterMagentoPlugin(const FlutterMagentoPlugin&) = delete;
  FlutterMagentoPlugin& operator=(const FlutterMagentoPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_magento

#endif  // FLUTTER_PLUGIN_FLUTTER_MAGENTO_PLUGIN_H_
