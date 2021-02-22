import 'package:flutter/material.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';
import 'package:flutter_bmfmap/BaiduMap/models/overlays/bmf_polyline.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';

BMFPolyline addLine(ctl, List points) {
  // 构造点数组
  if (points.length == 0) {
    return null;
  }
  List<BMFCoordinate> coordinates = points
      .map((e) => BMFCoordinate(double.parse(e[0]), double.parse(e[1])))
      .toList();

  List<Color> colors = List(points.length);
  colors.fillRange(0, points.length, Colors.blue);
  List<int> indexs = List(points.length);
  indexs.fillRange(0, points.length, 0);
  // 画出路径
  /// 创建polyline
  BMFPolyline colorsPolyline = BMFPolyline(
      coordinates: coordinates,
      indexs: indexs,
      colors: colors,
      width: 16,
      lineDashType: BMFLineDashType.LineDashTypeNone,
      lineCapType: BMFLineCapType.LineCapButt,
      lineJoinType: BMFLineJoinType.LineJoinRound);

  ctl.addPolyline(colorsPolyline);
  return colorsPolyline;
}

BMFPolyline addLineWithListCoordinate(ctl, List<BMFCoordinate> points) {
  print(112131213);
  print(ctl);
  List<Color> colors = List(points.length);
  colors.fillRange(0, points.length, Colors.blue);
  List<int> indexs = List(points.length);
  indexs.fillRange(0, points.length, 0);
  // 画出路径
  /// 创建polyline
  BMFPolyline colorsPolyline = BMFPolyline(
      coordinates: points,
      indexs: indexs,
      colors: colors,
      width: 16,
      lineDashType: BMFLineDashType.LineDashTypeNone,
      lineCapType: BMFLineCapType.LineCapButt,
      lineJoinType: BMFLineJoinType.LineJoinRound);

  ctl.addPolyline(colorsPolyline);
  return colorsPolyline;
}
