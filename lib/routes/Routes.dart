import 'package:flutter/material.dart';

import '../pages/TabsPage.dart';
import '../pages/LoginPage.dart';

final routes = {
  "/main":(context)=>TabsPage(),
  "/login":(context)=>LoginPage()
};

Function onGenerateRoute = (RouteSettings settings){
  final String name = settings.name;
  final Function buildContext = routes[name];
  Route route;
  if (buildContext != null) {
    if (settings.arguments != null) {
      route = MaterialPageRoute(builder: (context)=>buildContext(context,arguments:settings.arguments));
    }else{
      route = MaterialPageRoute(builder: (context)=>buildContext(context));
    }
  }
  return route;
};