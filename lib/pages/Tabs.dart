import 'package:flutter/material.dart';
import 'package:saumap/pages/Map.dart';
import 'package:saumap/pages/user/User.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList = [MapPage(), UserPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // iconSize: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的')
        ],
      ),
    );
  }
}
