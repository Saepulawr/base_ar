abstract class BaseARSource {
  // ignore: unused_field
  String? _from;
  String get source => _from ?? "";
}

class BaseARImageFromNetwork extends BaseARSource {
  final Uri uri;

  BaseARImageFromNetwork(this.uri) {
    super._from = uri.toString();
  }
}

class BaseARImageFromAssets extends BaseARSource {
  final String path;

  BaseARImageFromAssets(this.path) {
    super._from = path;
  }
}

class BaseARImageFromBase64 extends BaseARSource {
  final String base64;

  BaseARImageFromBase64(this.base64) {
    super._from = base64;
  }
}
