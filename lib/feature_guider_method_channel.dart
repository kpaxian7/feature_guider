import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'feature_guider_platform_interface.dart';

/// An implementation of [FeatureGuiderPlatform] that uses method channels.
class MethodChannelFeatureGuider extends FeatureGuiderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('feature_guider');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
