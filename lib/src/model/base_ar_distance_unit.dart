class BaseARDistanceUnit {
  //distance in milimeter
  double _distance = 0;
  BaseARDistanceUnit({
    double? meter,
    double? centiMeter,
    double? miliMeter,
  }) {
    _distance =
        (miliMeter ?? 0) + ((centiMeter ?? 0) * 10) + ((meter ?? 0) * 1000);
  }
  double get inMeter => _distance / 1000;
  double get inCentiMeter => _distance / 10;
  double get inMiliMeter => _distance;
}
