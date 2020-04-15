import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("欢迎光临"),
              RaisedButton(
                child: Text("跳过"),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/main");
                }
              )
            ],
          ),
        )
      ),
    );
  }
}