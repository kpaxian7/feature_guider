#ifndef FLUTTER_PLUGIN_FEATURE_GUIDER_PLUGIN_H_
#define FLUTTER_PLUGIN_FEATURE_GUIDER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace feature_guider {

class FeatureGuiderPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FeatureGuiderPlugin();

  virtual ~FeatureGuiderPlugin();

  // Disallow copy and assign.
  FeatureGuiderPlugin(const FeatureGuiderPlugin&) = delete;
  FeatureGuiderPlugin& operator=(const FeatureGuiderPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace feature_guider

#endif  // FLUTTER_PLUGIN_FEATURE_GUIDER_PLUGIN_H_
