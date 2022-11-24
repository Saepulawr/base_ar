import 'package:base_ar/src/config/base_ar_config.dart';
import 'package:base_ar/src/view/base_ar_view.dart';
import 'package:flutter/material.dart';
export 'src/config/base_ar_config.dart';
export 'src/model/base_ar_image_source.dart';
export 'src/model/base_ar_detection_images.dart';
export 'src/model/base_ar_object.dart';
export 'src/model/base_ar_distance_unit.dart';
// export 'src/view/base_ar_view.dart';

class BaseAR {
  BaseAR({
    required this.config,
  });

  final BaseARConfig config;

  void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => BaseARView(
          baseAR: this,
        ),
      ),
    );
  }
}
