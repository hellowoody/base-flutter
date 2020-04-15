import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:base/kits/IconKit.dart';
import 'package:base/kits/ColorKit.dart' as ColorKit;
import 'package:base/kits/SharedPreferences.dart' as sp;
import 'package:base/kits/HttpKit.dart';
import 'package:base/states/ThemeState.dart';

class PersonTab extends StatefulWidget {
  @override
  _PersonTabState createState() => _PersonTabState();
}

class _PersonTabState extends State<PersonTab> {
  bool _darkMode = false;
  bool _ifLogin = false;

  void init() async {
    String spTheme = await sp.getString("theme");
    String sessionId = await sp.getString("sessionId");
    setState((){
      this._darkMode = spTheme == "MyTheme.dark" ? true : false;
      this._ifLogin = sessionId != null && sessionId != "" ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void _changeDarkMode(bool flag){
    Provider.of<ThemeState>(context, listen: false).switchTheme();
    String afterTheme = Provider.of<ThemeState>(context,listen:false).currentTheme.toString();
    sp.setString("theme",afterTheme);
    setState(() {
      this._darkMode = flag;    
    });
  }

  void _login(){
    Navigator.pushNamed(context, "/login").then((value){
      if(value == true) {
        setState(() {
          this._ifLogin = true;
        });
      }
    });
  }

  void _logout() {
    sp.setString("sessionId", "");
    sp.setString("userId", "");
    sp.setString("userName", "");
    setState(() {
      this._ifLogin = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopMenus(),
          this._ifLogin ? Logined() : Login(this._login),
          Expanded(child: MenuList(this._darkMode,this._changeDarkMode,this._logout))
        ],
      )
    );
  }
}

class TopMenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Icon(Icons.notifications_none,size:20),
            margin: EdgeInsets.only(right:30),
          ),
          Container(
            child:Icon(IconKit.setting,size:20)
          )
        ],
      )
    );
  }
}

class Login extends StatelessWidget {
  final Function _login;
  Login(this._login);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child:Text(
              "注册/登陆",
              style: Theme.of(context).textTheme.display1
            ),
            onTap: ()=>this._login(),
          ),
          Container(
            child:Image.asset('assets/images/login.png')
          )
        ],
      ),
    );
  }
}

class Logined extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Column(
        children:<Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child:Text("少少",style: Theme.of(context).textTheme.display1),
                    ),
                    GestureDetector(
                      child:Container(
                        child:Text("查看并编辑个人资料",style:Theme.of(context).textTheme.display2.copyWith(
                          color:Theme.of(context).accentColor
                        ))
                      ),
                      onTap:(){
                        print("编辑基本信息");
                      }
                    )
                  ],
                ),
                Stack(
                  alignment:Alignment.center,
                  children: <Widget>[
                    ClipOval(
                      child:Container(
                        color:Theme.of(context).accentColor,
                        width: 56,
                        height:56
                      )
                    ),
                    Text("少",style:Theme.of(context).textTheme.display2.copyWith(
                      color: ColorKit.hexToColor("#ffffff"),
                      fontWeight: FontWeight.bold
                    ))
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:15),
            child:SizedBox(
              height: 105,
              child:Card(
                elevation: 10,
                child: Container(
                  padding:EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("完善个人信息",style:Theme.of(context).textTheme.display1.copyWith(
                                  fontSize:18
                                )),
                                Text(
                                  "完善信息(如绑定手机号/邮箱等信息),可以更好体验全部功能",
                                  style: Theme.of(context).textTheme.body1,
                                  softWrap: true,
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,size: 16,)
                        ],
                      ),
                      LinearProgressIndicator(
                        value:0.5,
                        backgroundColor: Theme.of(context).dividerColor,
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).highlightColor),
                      )
                    ]
                  )
                ) ,
              )
            ),
          )
        ]
      ),
    );
  }
}


class MenuList extends StatelessWidget {
  final bool _darkMode;
  final Function _changeDarkMode;
  final Function _logout;
  MenuList(this._darkMode,this._changeDarkMode,this._logout);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("深色模式",style:Theme.of(context).textTheme.display2),
                Switch(
                  value: this._darkMode, 
                  onChanged: _changeDarkMode,
                  activeColor: Theme.of(context).accentColor,
                  inactiveTrackColor: Theme.of(context).dividerColor
                )
              ],
            )
          ),
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
            child: GestureDetector(
              child:Text("版本信息",style:Theme.of(context).textTheme.display2),
              onTap:(){
                HttpKit.post(
                  "/version", 
                  {}, 
                  (data){
                    print("版本信息"+data["data"]);
                    final snackBar = SnackBar(
                      content: Text("版本信息"+data["data"],style: Theme.of(context).textTheme.body1),
                      backgroundColor:Theme.of(context).backgroundColor,
                      behavior: SnackBarBehavior.floating,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }, 
                  (err){
                    print("err:"+err);
                  }
                );
              }
            )
          ),
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
            child: GestureDetector(
              child:Text("退出",style:Theme.of(context).textTheme.display2),
              onTap:()=>this._logout(),
            )
          )
        ],
      )
    );
  }
}

class Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:2,
      color:Theme.of(context).dividerColor
    );
  }
}