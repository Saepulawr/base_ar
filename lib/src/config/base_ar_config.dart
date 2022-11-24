import 'package:base_ar/src/model/base_ar_detection_images.dart';
import 'package:flutter/material.dart';

class BaseARConfig {
  final List<BaseARDetectionImage> detectionImages;
  final AppBar? appBar;
  BaseARConfig({
    required this.detectionImages,
    this.appBar,
  });
}
