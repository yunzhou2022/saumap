import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        '请在此输入您在开放平台上申请的API_KEY', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    // Android 目前不支持接口设置Apikey,
    // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }

  runApp(new MyApp());
}

/// 创建BMFMarker
// BMFMarker marker = BMFMarker(
//         position: BMFCoordinate(39.928617, 116.40329),
//         title: 'flutterMaker',
//         identifier: 'flutter_marker'
//         icon: 'resoures/icon_end.png');

// /// 添加Marker
// myMapController?.addMarker(marker);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        icon: 'resources/icon-location.png');
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
