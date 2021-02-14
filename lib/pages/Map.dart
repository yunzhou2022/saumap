import 'package:flutter/material.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';

/// 创建BMFMarker
// BMFMarker marker = BMFMarker(
//         position: BMFCoordinate(39.928617, 116.40329),
//         title: 'flutterMaker',
//         identifier: 'flutter_marker'
//         icon: 'resoures/icon_end.png');

// /// 添加Marker
// myMapController?.addMarker(marker);

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  BMFMapOptions mapOptions;
  BMFMapController ctl;
  BMFMarker marker;
  @override
  void initState() {
    super.initState();
    mapOptions = BMFMapOptions(
        center: BMFCoordinate(41.932551, 123.410423),
        zoomLevel: 18,
        mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

    marker = BMFMarker(
        position: BMFCoordinate(41.932551, 123.410423),
        title: 'flutterMaker',
        identifier: 'flutter_marker',
        icon: 'images/icon_location.png');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('百度地图'),
        ),
        body: BMFMapWidget(
          onBMFMapCreated: (controller) {
            ctl = controller;
            ctl.addMarker(marker);
            // 地图点击回调
            ctl?.setMapOnClickedMapBlankCallback(
                callback: (BMFCoordinate coordinate) {
              print(coordinate.latitude);
              print(coordinate.longitude);
            });
          },
          mapOptions: mapOptions,
        ),
      ),
    );
  }
}
