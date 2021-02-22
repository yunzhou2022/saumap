import 'package:flutter/material.dart';
import 'package:saumap/pages/Map.dart';
import 'package:saumap/pages/recommend/Recommend.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList = [MapPage(), RecommendPage()];
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
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: '推荐')
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Container(
      //     width: 60,
      //     height: 60,
      //     padding: EdgeInsets.all(2),
      //     margin: EdgeInsets.only(top: 30),
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(40), color: Colors.white),
      //     child: FloatingActionButton(
      //       child: Icon(
      //         Icons.add,
      //         color: Colors.black,
      //         size: 40,
      //       ),
      //       elevation: 5, //阴影
      //       onPressed: () {
      //         setState(() {
      //           // _currentIndex = 1;
      //         });
      //       },
      //       // backgroundColor:
      //       //     _currentIndex != 1 ? Colors.yellow : Colors.orange,
      // )
      // )
    );
  }
}
