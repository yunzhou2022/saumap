import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:saumap/apis.dart';

class LocationDialog extends StatelessWidget {
  final onClose, info;
  const LocationDialog({Key key, this.onClose, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(info);
    List imgs = info['imgs'].length != 0
        ? (info['imgs'].map((d) => baseUrl + d['path'])).toList()
        : [];
    String name = info['name'];
    String description = info['introduce'];
    return NetworkGiffyDialog(
      image: Image.network(
        imgs[0],
        fit: BoxFit.cover,
      ),
      title: Text(name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        description,
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.BOTTOM,
      onOkButtonPressed: onClose,
      // Navigator.pop(context);
      onlyOkButton: true,
    );
  }
}

alertConfirmDialog(context) async {
  var alertDialogs = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("确定要删除吗"),
          actions: <Widget>[
            FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context, false);
                  return false;
                }),
            FlatButton(
                child: Text("确定"),
                onPressed: () {
                  Navigator.pop(context, true);
                  return true;
                }),
          ],
        );
      });
  return alertDialogs;
}

alertLocationDialog(context, info) async {
  var alertDialogs = await showDialog(
      context: context,
      builder: (context) {
        List imgs = info['imgs'].length != 0
            ? (info['imgs'].map((d) => baseUrl + d['path'])).toList()
            : [];
        String img = imgs.length == 0 ? null : imgs[0];
        String name = info['name'];
        String description = info['introduce'];
        return NetworkGiffyDialog(
          image: img == null
              ? Image.asset('images/noImg.jpg')
              : Image.network(
                  imgs[0],
                  fit: BoxFit.cover,
                ),
          title: Text(name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
          description: Text(
            description,
            textAlign: TextAlign.center,
          ),
          entryAnimation: EntryAnimation.BOTTOM,
          buttonOkText: Text('关闭'),
          onOkButtonPressed: () => Navigator.pop(context, 'close'),
          // onlyOkButton: true,
          buttonCancelText: Text('更改'),
          onCancelButtonPressed: () => Navigator.pop(context, 'update'),
        );
      });
  return alertDialogs;
}
