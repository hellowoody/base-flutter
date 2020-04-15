import 'package:flutter/material.dart';
import '../kits/IconKit.dart';
import 'tabs/HomeTab.dart';
import 'tabs/ServiceTab.dart';
import 'tabs/PersonTab.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int  _currentIndex = 0 ;
  List _pageList = [
    HomeTab(),
    ServiceTab(),
    PersonTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:(int index){
          setState(() {
            this._currentIndex = index;
          });
        },
        items:[
          BottomNavigationBarItem(
              icon: Icon(IconKit.home),
              title: Text("首页")
          ),
          BottomNavigationBarItem(
              icon: Icon(IconKit.mid),
              title: Text("核心业务")
          ),
          BottomNavigationBarItem(
              icon: Icon(IconKit.person), 
              title: Text("我的")
          ),
        ],
      )
    );
  }
}