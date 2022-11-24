import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:base_ar/base_ar_method_channel.dart';

void main() {
  MethodChannelBaseAr platform = MethodChannelBaseAr();
  const MethodChannel channel = MethodChannel('base_ar');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
