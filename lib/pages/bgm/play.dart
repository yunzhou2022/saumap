import 'package:saumap/apis.dart';
import 'package:saumap/pages/bgm/util.dart';
import 'package:video_player/video_player.dart';

void play(url, setState) {
  VideoPlayerController _player;
  _player = VideoPlayerController.network(url);
  _player.setLooping(false);
  _player.initialize().then((_) => setState(() {}));
  _player.play();
}

void playText(String text, setState) async {
  var res = await dio.post(getMp3, data: {"text": text});
  String url = baseUrl + res.data['path'];
  play(url, setState);
}

class Item {
  final marker;
  final distance;
  Item(this.marker, this.distance);
}

/**
 * 
 * 自动播放距离距离自己100m以内的最近的标注点的介绍
 * 返回本次播放的内容
 * 根据内容进行判断，相同的内容，只播放一次
 */
String autoPlay(double fromLatitude, double fromLongitude, List markers,
    String lastText, setState) {
  List distances = markers.map((item) {
    double toLatitude = double.parse(item['lat_x']);
    double toLongitude = double.parse(item['lng_y']);
    double distance =
        getDistance(fromLongitude, fromLatitude, toLongitude, toLatitude);
    return Item(item, distance);
    // return {"marker": item, "distance": distance};
  }).toList();
  distances.sort((a, b) => a.distance.compareTo(b.distance));
  double distance = distances[0].distance;
  print(distance);
  String text = distances[0].marker['introduce'];
  if (text != lastText && distance < 100) {
    playText(text, setState);
  }
  return text;
}
