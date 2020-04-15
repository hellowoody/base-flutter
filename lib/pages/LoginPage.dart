// import 'dart:convert';
// import 'package:base/kits/HttpKit.dart';
import 'package:flutter/material.dart';
import 'package:base/kits/ColorKit.dart' as colorKit;
import 'package:base/kits/SharedPreferences.dart' as sp;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Container(
        color:Theme.of(context).backgroundColor,
        width: double.infinity,
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Title(),
            Expanded(child: FormContent())
          ],
        ),
      )
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Text("邮箱快捷登陆",style: Theme.of(context).textTheme.display1,),
        SizedBox(
          height: 6,
        ),
        Text("该邮箱未注册将自动创建新账号",style: Theme.of(context).textTheme.subhead),
      ]
    );
  }
}

class FormContent extends StatefulWidget {
  @override
  _FormContentState createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userIdCtrl = new TextEditingController();
  TextEditingController pwdCtrl = new TextEditingController();
  bool _btnFlag = true;

  void _login(){
    bool _validateFlag = this._formKey.currentState.validate();
    if (!_btnFlag) {
      final snackBar = SnackBar(
        content:Text("请不要连续点击"),
        behavior: SnackBarBehavior.floating,
      );
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }
    if (_btnFlag) {
      this._btnFlag = false;
      if (_validateFlag){
        sp.setString("sessionId", "123456");
        sp.setString("userId", "id123");
        sp.setString("userName", "shao");
        Navigator.of(context).pop(true);
        // Map<String,dynamic> p = {
        //   "userId":userIdCtrl.text,
        //   "pwd":pwdCtrl.text
        // };
        // HttpKit.post("/login",p,(data){
        //   this._btnFlag = true;
        //   if(data["code"] == "0" ){
        //     sp.setString("sessionId", json.decode(data["data"])["sessionId"]);
        //     sp.setString("userId", json.decode(data["data"])["userId"]);
        //     sp.setString("userName", json.decode(data["data"])["userName"]);
        //   }
        //   final snackBar = SnackBar(
        //     content:Text(data["msg"]),
        //     behavior: SnackBarBehavior.floating,
        //   );
        //   Scaffold.of(context).showSnackBar(snackBar);
        //   Navigator.of(context).pop(true);
        // },(err){
        //   this._btnFlag = true;
        //   final snackBar = SnackBar(
        //     content:Text(err.toString()),
        //     behavior: SnackBarBehavior.floating,
        //   );
        //   Scaffold.of(context).showSnackBar(snackBar);
        // });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top:8),
      child: Form(
        key:_formKey,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:<Widget>[
            SizedBox(height:24),
            Text("邮箱",style:Theme.of(context).textTheme.display2.copyWith(fontWeight:FontWeight.bold)),
            TextFormField(
              controller: this.userIdCtrl,
              cursorColor: Theme.of(context).accentColor,
              validator: (value){
                final String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
                if(value.isEmpty){
                  return "请您输入邮箱";
                }
                if(!RegExp(regexEmail).hasMatch(value)){
                  return "请输入正确的邮箱";
                }
                return null;
              },
            ),
            SizedBox(height:24),
            Text("密码",style:Theme.of(context).textTheme.display2.copyWith(fontWeight:FontWeight.bold)),
            TextFormField(
              obscureText:true,
              controller: this.pwdCtrl,
              cursorColor: Theme.of(context).accentColor,
              validator: (value){
                if(value.isEmpty){
                  return "请输入密码";
                }
                return null;
              },
            ),
            SizedBox(height:64),
            LoginBtn(this._login),
          ]
        ),
      ),
    );
  }
}

class LoginBtn extends StatelessWidget {
  final Function _callback;
  LoginBtn(this._callback);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width:double.infinity,
      child: FlatButton(
        color:Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        onPressed: ()=>_callback(), 
        child: Text(
          "登陆",
          style: Theme.of(context).textTheme.display2.copyWith(color:colorKit.hexToColor('#ffffff'))
        )
      ), 
    );
  }
}