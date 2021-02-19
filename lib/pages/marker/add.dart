// import 'package:flutter/material.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';
import 'package:saumap/apis.dart';

// class AddMarker extends StatefulWidget {
//   BMFCoordinate coordinate;
//   AddMarker({Key key, this.coordinate}) : super(key: key);

//   @override
//   _AddMarkerState createState() => _AddMarkerState();
// }

// class _AddMarkerState extends State<AddMarker> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: child,
//     );
//   }
// }

String addMark(BMFMapController ctl, double lat_x, double lng_y,
    {title = 'flutterMaker',
    id = "flutter_marker",
    icon = 'images/icon_location_48.png'}) {
  BMFMarker marker = BMFMarker(
      position: BMFCoordinate(lat_x, lng_y),
      title: title,
      identifier: id,
      icon: icon);
  ctl.addMarker(marker);
  return marker.getId();
}

BMFMarker addMyLocateMarker(BMFMapController ctl, double lat_x, double lng_y,
    {title = 'flutterMaker',
    id = "flutter_marker",
    icon = 'images/my_location_64.png'}) {
  BMFMarker marker = BMFMarker(
      position: BMFCoordinate(lat_x, lng_y),
      title: title,
      identifier: id,
      icon: icon);
  ctl.addMarker(marker);
  return marker;
}

Future<List> addMarkers(ctl) async {
  var res = await dio.get(locationUrl);
  List<dynamic> markers = [];
  for (Map item in res.data) {
    String id = addMark(
        ctl, double.parse(item['lat_x']), double.parse(item['lng_y']),
        title: item['name'], id: item['_id']);
    var t = item;
    t["id"] = id;
    markers.add(t);
  }

  return markers;
}
