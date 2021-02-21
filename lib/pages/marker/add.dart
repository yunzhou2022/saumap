import 'package:flutter/material.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';
import 'package:saumap/apis.dart';

BMFMarker addMark(BMFMapController ctl, double lat_x, double lng_y,
    {title = 'flutterMaker',
    id = "flutter_marker",
    icon = 'images/icon_location_48.png'}) {
  BMFMarker marker = BMFMarker(
      position: BMFCoordinate(lat_x, lng_y),
      title: title,
      identifier: id,
      icon: icon);
  ctl.addMarker(marker);
  return marker;
}

BMFText addText(
  BMFMapController ctl,
  String text,
  double lat_x,
  double lng_y,
) {
//  text经纬度信息
  BMFCoordinate position = new BMFCoordinate(lat_x, lng_y);

  /// 构造text
  BMFText bmfText = BMFText(
      text: text,
      position: position,
      bgColor: Colors.transparent,
      fontColor: Colors.black54,
      fontSize: 40,
      typeFace: BMFTypeFace(
          familyName: BMFFamilyName.sMonospace,
          textStype: BMFTextStyle.BOLD_ITALIC),
      alignY: BMFVerticalAlign.ALIGN_TOP,
      alignX: BMFHorizontalAlign.ALIGN_CENTER_HORIZONTAL,
      rotate: 0.0);

  /// 添加text
  ctl.addText(bmfText);
  return bmfText;
}

Map addMarkerWithText(
  BMFMapController ctl,
  String text,
  double lat_x,
  double lng_y,
) {
  BMFMarker marker = addMark(ctl, lat_x, lng_y);
  BMFText bmfText = addText(ctl, text, lat_x, lng_y);
  return {"marker": marker, "bmfText": bmfText};
}

Future<List> addMarkers(ctl) async {
  var res = await dio.get(locationUrl);
  List<dynamic> markers = [];
  for (Map item in res.data) {
    double lat_x = double.parse(item['lat_x']);
    double lng_y = double.parse(item['lng_y']);
    String name = item['name'];

    BMFMarker marker = addMark(ctl, lat_x, lng_y, title: name, id: item['_id']);
    var t = item;
    t["marker"] = marker;
    t['bmfText'] = addText(ctl, name, lat_x, lng_y);
    markers.add(t);
  }

  return markers;
}
