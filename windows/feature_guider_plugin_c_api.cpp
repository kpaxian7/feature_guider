#include "include/feature_guider/feature_guider_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "feature_guider_plugin.h"

void FeatureGuiderPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  feature_guider::FeatureGuiderPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
