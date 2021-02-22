import 'dart:math';

double getDistance(double mLonA, double mLatA, double mLonB, double mLatB) {
  double R = 6371004;
  double C =
      sin(mLatA) * sin(mLatB) * cos(mLonA - mLonB) + cos(mLatA) * cos(mLatB);
  double distance = R * acos(C) * pi / 180;
  return distance;
}
