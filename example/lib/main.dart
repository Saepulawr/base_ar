import 'package:base_ar_example/base64.dart';
import 'package:flutter/material.dart';
import 'package:base_ar/base_ar.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final BaseAR _baseAR;

  @override
  void initState() {
    _baseAR = BaseAR(
      config: BaseARConfig(
          detectionImages: base64Images
              .map(
                (data) => BaseARDetectionImage(
                  detectionImage: BaseARImageFromBase64(data),
                  objectAR: BaseARObject(
                      material: BaseARImageFromNetwork(Uri.parse(
                          "https://katalogpromosi.com/wp-content/uploads/2022/03/mcdonalds_ojol_15032022.jpg"))),
                  physicalWidth: BaseARDistanceUnit(centiMeter: 20),
                ),
              )
              .toList(),
          // ..add(
          //   BaseARDetectionImage(
          //     detectionImage: BaseARImageFromBase64(base64Images[3]),
          //     objectAR: BaseARObject(
          //         material: BaseARImageFromNetwork(Uri.parse(
          //             "https://katalogpromosi.com/wp-content/uploads/2022/03/mcdonalds_ojol_15032022.jpg"))),
          //     physicalWidth: BaseARDistanceUnit(centiMeter: 20),
          //   ),
          // ),

          // [
          //   BaseARDetectionImage(
          //     detectionImage: BaseARImageFromNetwork(Uri.parse(
          //         "https://e7.pngegg.com/pngimages/906/866/png-clipart-mcdonald-s-logo-golden-arches-mcdonald-s-sign-logo-golden-arches.png")),
          //     objectAR: BaseARObject(
          //         material: BaseARImageFromNetwork(Uri.parse(
          //             "https://katalogpromosi.com/wp-content/uploads/2022/03/mcdonalds_ojol_15032022.jpg"))),
          //     physicalWidth: BaseARDistanceUnit(centiMeter: 20),
          //   ),
          //   BaseARDetectionImage(
          //     detectionImage: BaseARImageFromAssets("assets/detection1.png"),
          //     objectAR: BaseARObject(
          //         material: BaseARImageFromAssets("assets/promo1.jpg")),
          //     physicalWidth: BaseARDistanceUnit(centiMeter: 20),
          //   )
          // ],
          appBar: AppBar(
            title: const Text("Test Base AR"),
            backgroundColor: Colors.green,
          )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          return Center(
              child: ElevatedButton(
            child: const Text("test AR"),
            onPressed: () {
              if (Platform.isAndroid) {
                print("Android belum tersedia cuy");
              } else if (Platform.isIOS) {
                _baseAR.show(context);
              }
            },
          ));
        }),
      ),
    );
  }
}
