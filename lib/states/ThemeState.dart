
import 'package:flutter/material.dart';
import 'package:base/kits/ColorKit.dart' as colorKit;

enum MyTheme {
  light,
  dark
}

class ThemeState with ChangeNotifier {
  static List<ThemeData> themes = [
    ThemeData(
      brightness:Brightness.light,
      primarySwatch:Colors.red,
      primaryColor: colorKit.hexToColor("#FA585E"),
      accentColor:colorKit.hexToColor("#1A8287"),
      backgroundColor: Colors.white,
      dividerColor: colorKit.hexToColor("#f2f2f2"),
      highlightColor: colorKit.hexToColor("#46A5A8"),
      textTheme: TextTheme(
        //display1 代表一个页面的title
        display1 : TextStyle(
          fontSize:24.0,
          color:colorKit.hexToColor("#3e3e3e"),
          fontWeight: FontWeight.bold
        ),
        display2 : TextStyle(
          fontSize:20.0,
          color:colorKit.hexToColor("#3e3e3e"),
        ),
      ),
      appBarTheme:AppBarTheme(
        color:Colors.white,
        elevation:0,
        iconTheme:IconThemeData(
          color: colorKit.hexToColor("#3e3e3e"),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color:colorKit.hexToColor("#1A8287"))),
      )
    ),
    ThemeData(
      brightness:Brightness.dark,
      primarySwatch:Colors.red,
      // primaryColor: colorKit.hexToColor("#FA585E"),
      accentColor:colorKit.hexToColor("#1A8287"),
      backgroundColor: Colors.grey[800],
      dividerColor: colorKit.hexToColor("#363636"),
      highlightColor: colorKit.hexToColor("#46A5A8"),
      textTheme: TextTheme(
        //display1 代表一个页面的title
        display1 : TextStyle(
          fontSize:24.0,
          color:colorKit.hexToColor("#f1f1f1"),
          fontWeight: FontWeight.bold
        ),
        display2 : TextStyle(
          fontSize:20.0,
          color:colorKit.hexToColor("#f1f1f1"),
        ),
      ),
      iconTheme: IconThemeData(
          color: colorKit.hexToColor("#f1f1f1"),
      ),
      appBarTheme:AppBarTheme(
        color:Colors.grey[800],
        elevation:0,
        iconTheme:IconThemeData(
          color: colorKit.hexToColor("#f1f1f1"),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color:colorKit.hexToColor("#1A8287")))
      )
    ),
  ];

  MyTheme _currentTheme = MyTheme.light;

  ThemeData _currentThemeData = themes[0];

  void initTheme(MyTheme t){
    if (t == MyTheme.dark) {
      this._currentTheme = MyTheme.dark;
      this._currentThemeData = themes[1];
    }
  }

  get currentTheme => _currentTheme;

  get currentThemeData => _currentThemeData;

  set currentTheme(MyTheme theme){
    if(theme != null){
      _currentTheme = theme;
      _currentThemeData = _currentTheme == MyTheme.light ? themes[0] : themes[1];
      notifyListeners();
    }
  }

  void switchTheme() => currentTheme == MyTheme.light ? currentTheme = MyTheme.dark : currentTheme = MyTheme.light;
}