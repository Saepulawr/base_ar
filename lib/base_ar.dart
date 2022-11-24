
import 'base_ar_platform_interface.dart';

class BaseAr {
  Future<String?> getPlatformVersion() {
    return BaseArPlatform.instance.getPlatformVersion();
  }
}
