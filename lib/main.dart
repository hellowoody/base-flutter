import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:base/states/ThemeState.dart';
import 'package:base/routes/Routes.dart';
import 'package:base/kits/SharedPreferences.dart' as sp;
import 'package:base/pages/SplashPage.dart';

String spTheme = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  spTheme = await sp.getString("theme");
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:ThemeState())
      ],
      child: Consumer<ThemeState>(
        builder: (context,ThemeState theme,_){
          if (spTheme == "MyTheme.dark") {
            theme.initTheme(MyTheme.dark);
            spTheme = "MyTheme.light";
          }else {
            theme.initTheme(MyTheme.light);
            spTheme = "MyTheme.dark";
          }
          return MaterialApp(
            title:"少少便利店",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            home: SplashPage(),
            theme:theme.currentThemeData,
          );
        },
      ),
    );
  }
}

