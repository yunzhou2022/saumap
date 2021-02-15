import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final onChange, placeholder;
  MyTextField({Key key, this.placeholder = "请输入", this.onChange})
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String data;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.black12, hintColor: Colors.white),
      child: TextField(
        decoration: InputDecoration(
          hintText: widget.placeholder,
          contentPadding: EdgeInsets.only(left: 10.0),
          // border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(25.0),
          // )
        ),
        onChanged: (value) {
          setState(() {
            data = value;
            widget.onChange(data);
          });
        },
      ),
    );
  }
}
