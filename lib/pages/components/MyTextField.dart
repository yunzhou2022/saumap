import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final onChange, placeholder, theme, circle;
  MyTextField(
      {Key key,
      this.placeholder = "请输入",
      this.onChange,
      this.theme = 'light',
      this.circle = false})
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String data;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: widget.theme == 'dark'
              ? ColorScheme.dark()
              : ColorScheme.light()),
      child: TextField(
        decoration: InputDecoration(
            hintText: widget.placeholder,
            contentPadding: EdgeInsets.only(left: 10.0),
            border: widget.circle
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  )
                : null),
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
