import 'dart:math' as math;
import 'package:base_ar/base_ar.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';

import 'package:vector_math/vector_math_64.dart' as vector;

class _ARObjectAndAnchorPlane {
  final BaseARObject arObject;
  final ARKitPlaneAnchor? planeAnchor;

  _ARObjectAndAnchorPlane({
    required this.arObject,
    this.planeAnchor,
  });
  _ARObjectAndAnchorPlane copyWith({
    BaseARObject? arObject,
    ARKitPlaneAnchor? planeAnchor,
  }) {
    return _ARObjectAndAnchorPlane(
      arObject: arObject ?? this.arObject,
      planeAnchor: planeAnchor ?? this.planeAnchor,
    );
  }
}

class BaseARView extends StatefulWidget {
  const BaseARView({required this.baseAR, super.key});
  final BaseAR baseAR;
  @override
  State<BaseARView> createState() => _BaseARViewState();
}

class _BaseARViewState extends State<BaseARView> {
  late final ARKitController arkitController;

  final List<ARKitReferenceImage> _detectionImages = [];
  //key => imageAnchor.referenceImageName
  final Map<String, BaseARObject> _arObjects = {};
  //key => arObject.material.source
  final Map<String, ARKitNode> _arNodes = {};
  // ARKitPlaneAnchor? _tmpPlaneAnchor;
  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    for (final e in widget.baseAR.config.detectionImages) {
      //add data detection mode
      _detectionImages.add(
        ARKitReferenceImage(
          name: e.detectionImage.source,
          physicalWidth: e.physicalWidth.inMeter,
        ),
      );

      //add ar object by key
      _arObjects.addAll({
        e.detectionImage.source: e.objectAR,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.baseAR.config.appBar,
      body: ARKitSceneView(
        enablePinchRecognizer: true,
        // enablePanRecognizer: true,
        // enableRotationRecognizer: true,
        // showFeaturePoints: true,
        // showWorldOrigin: true,
        // forceUserTapOnCenter: true,

        // // planeDetection: ARPlaneDetection.horizontalAndVertical,

        detectionImages: _detectionImages,

        onARKitViewCreated: (controller) {
          arkitController = controller;
          arkitController.onAddNodeForAnchor = onAnchorWasFound;
          arkitController.onNodePinch = _onPinchHandler;
          // arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
        },
      ),
    );
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinchs) {
    final pinch = pinchs.first;
    final node = _arNodes[pinch.nodeName];
    node?.scale = vector.Vector3.all(pinch.scale);
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      _buildArObject(
        imageAnchor: anchor,
      );

      // timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      //   final old = node.eulerAngles;
      //   final eulerAngles = vector.Vector3(old.x + 0.01, old.y, old.z);
      //   node.eulerAngles = eulerAngles;
      // });
    }
  }

  // void _handleUpdateAnchor(ARKitAnchor anchor) {
  //   if (anchor is ARKitImageAnchor) {
  //     arkitController.getCameraEulerAngles().then((aulerAngels) {
  //       final key = anchor.referenceImageName ?? "-";
  //       final arObject = _arObjects[key]!;
  //       final node = _arNodes[arObject.material.source];
  //       final vectorAnchor = anchor.transform.getColumn(3);
  //       node?.position =
  //           vector.Vector3(vectorAnchor.x, vectorAnchor.y, vectorAnchor.z);
  //       node?.eulerAngles = vector.Vector3(aulerAngels.y, aulerAngels.x, 0);
  //     });
  //   }
  // }

  Future<void> _buildArObject({
    required ARKitImageAnchor imageAnchor,
  }) async {
    final key = imageAnchor.referenceImageName ?? "-";
    final arObject = _arObjects[key]!;
    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.lambert,
      diffuse: ARKitMaterialProperty.image(arObject.material.source),
    );
    final plane = ARKitPlane(materials: [material], width: 0.3, height: 0.3);
    final vectorAnchor = imageAnchor.transform.getColumn(3);
    final aulerAngels = await arkitController.getCameraEulerAngles();
    final node = ARKitNode(
      name: arObject.material.source,
      geometry: plane,
      position: vector.Vector3(vectorAnchor.x, vectorAnchor.y, vectorAnchor.z),
      eulerAngles: vector.Vector3(aulerAngels.y, aulerAngels.x, 0),
    );
    arkitController.add(node);
    if (!_arNodes.containsKey(arObject.material.source)) {
      _arNodes.addAll({arObject.material.source: node});
    }
  }

  void _clearArObject() {
    _arObjects.forEach((key, value) {
      arkitController.remove(value.material.source);
      _arNodes.remove(
        value.material.source,
      );
    });
  }
}
