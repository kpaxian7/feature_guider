import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'feature_guider_method_channel.dart';

abstract class FeatureGuiderPlatform extends PlatformInterface {
  /// Constructs a FeatureGuiderPlatform.
  FeatureGuiderPlatform() : super(token: _token);

  static final Object _token = Object();

  static FeatureGuiderPlatform _instance = MethodChannelFeatureGuider();

  /// The default instance of [FeatureGuiderPlatform] to use.
  ///
  /// Defaults to [MethodChannelFeatureGuider].
  static FeatureGuiderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FeatureGuiderPlatform] when
  /// they register themselves.
  static set instance(FeatureGuiderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
