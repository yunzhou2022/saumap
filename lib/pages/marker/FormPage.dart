import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saumap/apis.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saumap/pages/marker/add.dart';
import 'package:saumap/pages/marker/markerArguments.dart';
import 'package:toast/toast.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _name, _introduce;
  //  String _type = 'lujing';
  File _image;

  String lat_x, lng_y;
  Map _info;
  var ctl;
  final picker = ImagePicker();

  String imageCtl;

  TextEditingController nameCtl = TextEditingController();
  TextEditingController introCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final MarkerArguments args = ModalRoute.of(context).settings.arguments;

    lat_x = args.lat_x;
    lng_y = args.lng_y;
    ctl = args.ctl;
    _info = args.info;

    if (_info != null) {
      if (nameCtl.text == '') nameCtl.text = _info['name'];
      if (introCtl.text == '') introCtl.text = _info['introduce'];
      imageCtl =
          _info['imgs'].length != 0 ? baseUrl + _info['imgs'][0]['path'] : null;
    }

    return Scaffold(
      appBar: AppBar(
        title: _info == null ? Text('添加标注') : Text('修改标注'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Form(
              onWillPop: () async {
                return await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('提示'),
                        content: Text('确认退出吗？'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('确认'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    });
              },
              key: _formKey,
              child: Column(children: [
                // Row(
                //   children: [
                //     Text('标注类型:'),
                //     Radio(
                //         value: 'lujing',
                //         groupValue: _type,
                //         onChanged: _handleTypeChange),
                //     Text('路径'),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Radio(
                //         value: 'jingdian',
                //         groupValue: _type,
                //         onChanged: _handleTypeChange),
                //     Text('景点'),
                //   ],
                // ),
                Divider(),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    labelText: '名称',
                  ),
                  validator: (v) {
                    return v.trim().length > 0 ? null : "名称不能为空";
                  },
                  onSaved: (val) {
                    _name = val;
                  },
                  controller: nameCtl,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    labelText: '介绍',
                  ),
                  onChanged: (val) {
                    _introduce = val;
                  },
                  onSaved: (val) {
                    _introduce = val;
                  },
                  controller: introCtl,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(-4),
                  title: Text('图片'),
                  subtitle: _image == null
                      ? imageCtl == null
                          ? RaisedButton(
                              child: Text("请选择"),
                              onPressed: _getImageFromGallery)
                          : InkWell(
                              child: Image.network(imageCtl),
                              onTap: _getImageFromGallery,
                            )
                      : InkWell(
                          child: Image.file(_image),
                          onTap: _getImageFromGallery,
                        ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(-4),
                  title: Text('坐标'),
                  subtitle: Text("$lat_x,$lng_y"),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                                padding: EdgeInsets.all(15.0),
                                child: Text('添加'),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () => _forSubmitted()))
                      ],
                    ))
              ])),
        ),
      ),
    );
  }

  // 相机选择
  // Future _getImageFromCamera() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('没有选择图片.');
  //     }
  //   });
  // }

  //相册选择
  Future _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  //上传图片到服务器
  _uploadImage() async {
    var dio = new Dio();
    FormData formData = FormData.fromMap({
      "name": _name,
      "introduce": _introduce,
      "lat_x": lat_x,
      "lng_y": lng_y,
      "file": await MultipartFile.fromFile(_image.path),
    });

    var response = await dio.post(
      uploadImgUrl,
      data: formData,
    );
    Map res = response.data;
    return res;
  }

  void _addMarker(Map res) {
    Map markerBmfText;
    if (_info != null) {
      if (_info['marker'] != null) ctl.removeMarker(_info['marker']);
      if (_info['bmfText'] != null) ctl.removeOverlay(_info['bmfText'].getId());
    }
    markerBmfText = addMarkerWithText(
        ctl, res['name'], double.parse(lat_x), double.parse(lng_y));

    res['marker'] = markerBmfText['marker'];
    res['bmgText'] = markerBmfText['bmfText'];

    Toast.show("添加成功！", context);
    Navigator.pop(context, res);
  }

  upload() async {
    String path = '';
    String name = '';
    List imgs;
    if (_image != null) {
      Map pathName = await _uploadImage();
      path = pathName['path'];
      name = pathName['name'];
    }

    if (path == '') {
      if (_info != null) {
        imgs = _info['imgs'];
      } else {
        imgs = [];
      }
    } else {
      imgs = [
        {"path": path, "name": name}
      ];
    }

    Map data = {
      "name": _name,
      "introduce": _introduce,
      "lat_x": lat_x,
      "lng_y": lng_y,
      "imgs": imgs
    };

    var response;
    if (_info != null) {
      response = await dio.put(locationUrl + '/' + _info['_id'], data: data);
    } else {
      response = await dio.post(locationUrl, data: data);
    }

    Map res = response.data;
    return res;
  }

  void _forSubmitted() async {
    var _form = _formKey.currentState;

    if (_form.validate()) {
      _form.save();
      Map marker = await upload();
      _addMarker(marker);
    }
  }
}
