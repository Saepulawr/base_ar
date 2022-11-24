import 'package:base_ar/base_ar.dart';

///Detection image and show AR Object when image is detected <br>
///[detectionImage] source image for detection, you can use BaseARImageFromNetwork or BaseARImageFromAssets <br>
///[physicalWidth] physical width of image for detection
///[objectAR] source to display AR object
class BaseARDetectionImage {
  final BaseARSource detectionImage;
  final BaseARDistanceUnit physicalWidth;
  final BaseARObject objectAR;

  BaseARDetectionImage({
    required this.detectionImage,
    required this.physicalWidth,
    required this.objectAR,
  });
}
