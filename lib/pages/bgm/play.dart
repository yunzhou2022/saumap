import 'package:saumap/apis.dart';
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
