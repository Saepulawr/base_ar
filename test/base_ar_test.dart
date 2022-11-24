import 'package:flutter_test/flutter_test.dart';
import 'package:base_ar/base_ar.dart';
import 'package:base_ar/base_ar_platform_interface.dart';
import 'package:base_ar/base_ar_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBaseArPlatform
    with MockPlatformInterfaceMixin
    implements BaseArPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BaseArPlatform initialPlatform = BaseArPlatform.instance;

  test('$MethodChannelBaseAr is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBaseAr>());
  });

  test('getPlatformVersion', () async {
    BaseAr baseArPlugin = BaseAr();
    MockBaseArPlatform fakePlatform = MockBaseArPlatform();
    BaseArPlatform.instance = fakePlatform;

    expect(await baseArPlugin.getPlatformVersion(), '42');
  });
}
