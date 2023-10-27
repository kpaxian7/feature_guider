
import 'feature_guider_platform_interface.dart';

class FeatureGuider {
  Future<String?> getPlatformVersion() {
    return FeatureGuiderPlatform.instance.getPlatformVersion();
  }
}
