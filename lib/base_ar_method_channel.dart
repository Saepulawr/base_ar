import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'base_ar_platform_interface.dart';

/// An implementation of [BaseArPlatform] that uses method channels.
class MethodChannelBaseAr extends BaseArPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('base_ar');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
