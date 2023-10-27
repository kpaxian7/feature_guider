import 'package:flutter_test/flutter_test.dart';
import 'package:feature_guider/feature_guider.dart';
import 'package:feature_guider/feature_guider_platform_interface.dart';
import 'package:feature_guider/feature_guider_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFeatureGuiderPlatform
    with MockPlatformInterfaceMixin
    implements FeatureGuiderPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FeatureGuiderPlatform initialPlatform = FeatureGuiderPlatform.instance;

  test('$MethodChannelFeatureGuider is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFeatureGuider>());
  });

  test('getPlatformVersion', () async {
    FeatureGuider featureGuiderPlugin = FeatureGuider();
    MockFeatureGuiderPlatform fakePlatform = MockFeatureGuiderPlatform();
    FeatureGuiderPlatform.instance = fakePlatform;

    expect(await featureGuiderPlugin.getPlatformVersion(), '42');
  });
}
