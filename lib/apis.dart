import 'package:dio/dio.dart';

final dio = new Dio();

// final baseUrl = "http://192.168.57.1:8888";
final baseUrl = "http://47.93.229.205:8888";

final uploadImgUrl = baseUrl + "/api/location/uploadImg";

final locationUrl = baseUrl + "/api/location";

final getPathsUrl = baseUrl + "/api/location/paths";

final getMp3 = baseUrl + "/api/location/getMp3";
// class Api{

// }
