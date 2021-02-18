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
