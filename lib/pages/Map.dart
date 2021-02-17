import 'package:flutter/material.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';
import 'package:saumap/apis.dart';
import 'package:saumap/pages/marker/add.dart';
import 'package:saumap/pages/marker/markerArguments.dart';
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
  Map _clickedMarker = null;
  @override
  void initState() {
    super.initState();
    mapOptions = BMFMapOptions(
        center: BMFCoordinate(41.932551, 123.410423),
        zoomLevel: 18,
        mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
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
                onPressed: () {
                  print(where);
                }),
          ],
        ),
        body: BMFMapWidget(
          onBMFMapCreated: (controller) {
            ctl = controller;
            addMarkers(ctl).then((value) => markers = value);
            // 地图点击回调
            ctl?.setMapOnClickedMapBlankCallback(
                callback: (BMFCoordinate coordinate) {
              if (addmarker) {
                Navigator.pushNamed(context, '/form',
                    arguments: MarkerArguments(
                        ctl,
                        coordinate.latitude.toString(),
                        coordinate.longitude.toString()));
              }
            });
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
          },
          mapOptions: mapOptions,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
            width: 40,
            height: 40,
            // padding: EdgeInsets.all(2),
            margin: EdgeInsets.fromLTRB(0, 0, 4, 100),
            child: FloatingActionButton(
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
              // backgroundColor:
              //     _currentIndex != 1 ? Colors.yellow : Colors.orange,
            )));
  }
}
