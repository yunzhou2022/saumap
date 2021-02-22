import 'package:flutter/material.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:saumap/pages/line/lineArguments.dart';
// import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';

class RecommendPage extends StatefulWidget {
  RecommendPage({Key key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  List<BMFCoordinate> points;
  @override
  void initState() {
    BMFCoordinate point1 = BMFCoordinate(41.93016734955775, 123.41128602667949);
    BMFCoordinate point2 = BMFCoordinate(41.93050946883013, 123.41281314604646);
    BMFCoordinate point3 = BMFCoordinate(41.93063692455699, 123.4149960284357);
    BMFCoordinate point4 = BMFCoordinate(41.93166326921593, 123.4149690792704);
    BMFCoordinate point5 = BMFCoordinate(41.93359516696747, 123.41620874087417);

    BMFCoordinate point6 =
        BMFCoordinate(41.933481132973526, 123.41347789212384);
    BMFCoordinate point7 = BMFCoordinate(41.93393055987675, 123.41257958661386);
    BMFCoordinate point8 = BMFCoordinate(41.93402446957293, 123.40834856766186);
    BMFCoordinate point9 =
        BMFCoordinate(41.933246356456884, 123.40731551632538);
    BMFCoordinate point10 = BMFCoordinate(41.9312406587243, 123.40745026215188);

    BMFCoordinate point11 =
        BMFCoordinate(41.929912435956844, 123.41003738202062);
    BMFCoordinate point12 = BMFCoordinate(41.93009355888409, 123.4111243316877);

    points = [
      point1,
      point2,
      point3,
      point4,
      point5,
      point6,
      point7,
      point8,
      point9,
      point10,
      point11,
      point12
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('推荐'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text('大环'),
                  subtitle: Text('全长两公里，夜跑不二选择'),
                  onTap: () {
                    Navigator.pushNamed(context, '/',
                        arguments: LineArguments(points));
                  },
                )
              ],
            )));
  }
}
