import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'base_ar_method_channel.dart';

abstract class BaseArPlatform extends PlatformInterface {
  /// Constructs a BaseArPlatform.
  BaseArPlatform() : super(token: _token);

  static final Object _token = Object();

  static BaseArPlatform _instance = MethodChannelBaseAr();

  /// The default instance of [BaseArPlatform] to use.
  ///
  /// Defaults to [MethodChannelBaseAr].
  static BaseArPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BaseArPlatform] when
  /// they register themselves.
  static set instance(BaseArPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
