import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child:Text("login"),
          onPressed: (){
            Navigator.pushNamed(context, "/login");
          }
        )
      ],
    );
  }
}