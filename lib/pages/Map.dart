import 'package:flutter/material.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';
import 'package:saumap/apis.dart';
import 'package:saumap/pages/components/Dialog.dart';
import 'package:saumap/pages/components/Locate.dart';
import 'package:saumap/pages/line/add.dart';
import 'package:saumap/pages/marker/add.dart';
import 'package:saumap/pages/marker/markerArguments.dart';
import 'package:toast/toast.dart';
import 'components/MyTextField.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  BMFMapOptions mapOptions;
  BMFMapController ctl;

  bool addmarker = false;
  String where;

  List markers;
  Map _clickedMarker;

  Map myLocate;
  // BMFMarker myLocateMarker;
  BMFPolyline path;

  @override
  void initState() {
    super.initState();
    mapOptions = BMFMapOptions(
        center: BMFCoordinate(41.932551, 123.410423),
        zoomLevel: 18,
        mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

    // 设置监听当前位置，更新位置
    var listener = getLocate();
    listener().listen((Map<String, Object> result) {
      // myLocateMarker?.updatePosition(
      //     BMFCoordinate(result['latitude'], result['longitude']));
      ctl?.updateLocationData(BMFUserLocation(
        location: BMFLocation(
            coordinate: BMFCoordinate(result['latitude'], result['longitude']),
            altitude: 0,
            horizontalAccuracy: 5,
            verticalAccuracy: -1.0,
            speed: -1.0,
            course: -1.0),
      ));

      myLocate = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: MyTextField(
            placeholder: "想去哪？",
            theme: 'dark',
            onChange: (d) => where = d,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  var from = myLocate['latitude'].toString() +
                      ',' +
                      myLocate['longitude'].toString();
                  var response = await dio.get(getPathsUrl,
                      queryParameters: {"to": where, "from": from});

                  List points = response.data;
                  if (points.length == 0) {
                    Toast.show("未标注！", context, gravity: Toast.TOP);
                  }
                  print(points);
                  ctl?.removeOverlay(path?.getId());
                  path = addLine(
                    ctl,
                    points,
                  );
                }),
          ],
        ),
        body: Stack(children: [
          BMFMapWidget(
            onBMFMapCreated: (controller) {
              ctl = controller;

              // 渲染我的位置，得到marker实例用于更新
              // myLocateMarker = addMyLocateMarker(ctl, 41.932551, 123.411564);
              ctl?.showUserLocation(true);
              // 开始定位
              startLocation();

              // 渲染用户添加的标注
              addMarkers(ctl).then((value) => markers = value);
              // 标注点击回调
              ctl?.setMapClickedMarkerCallback(
                  callback: (String id, dynamic extra) {
                for (Map item in markers) {
                  if (item["id"] == id) {
                    setState(() {
                      _clickedMarker = item;
                    });
                    break;
                  }
                }
              });
              // 地图点击回调
              ctl?.setMapOnClickedMapBlankCallback(callback: mapClickCallback);
              ctl?.setMapOnClickedMapPoiCallback(
                  callback: (poi) => mapClickCallback(poi.pt));
            },
            mapOptions: mapOptions,
          ),
          _clickedMarker == null
              ? Container(
                  width: 0,
                  height: 0,
                )
              : LocationDialog(
                  info: _clickedMarker,
                  onClose: () {
                    setState(() {
                      _clickedMarker = null;
                    });
                  }),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
            width: 40,
            height: 120,
            margin: EdgeInsets.fromLTRB(0, 0, 4, 100),
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "addOrClose",
                  child: Icon(
                    addmarker ? Icons.close : Icons.add,
                    // color: Colors.black,
                    size: 30,
                  ),
                  elevation: 5, //阴影
                  onPressed: () {
                    setState(() {
                      addmarker = !addmarker;
                    });
                  },
                ),
                FloatingActionButton(
                  heroTag: "locateMyself",
                  child: Icon(
                    Icons.my_location_sharp,
                    // color: Colors.black,
                    size: 25,
                  ),
                  elevation: 5, //阴影
                  onPressed: () {
                    double lat = myLocate['latitude'];
                    double lng = myLocate['longitude'];
                    ctl.setCenterCoordinate(BMFCoordinate(lat, lng), true);
                  },
                ),
              ],
            )));
  }

  void mapClickCallback(BMFCoordinate coordinate) {
    print(coordinate.latitude);
    print(coordinate.longitude);
    if (addmarker) {
      Navigator.pushNamed(context, '/form',
          arguments: MarkerArguments(ctl, coordinate.latitude.toString(),
              coordinate.longitude.toString()));
    }
  }
}
