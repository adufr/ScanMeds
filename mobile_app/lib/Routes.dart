import 'package:flutter/material.dart';
import 'package:mobile_app/screens/login/index.dart';
import 'package:mobile_app/screens/home/index.dart';
import 'package:mobile_app/theme/style.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    "/HomePage": (BuildContext context) => new HomeScreen(),
    "/Deconnexion": (BuildContext context) => new LoginScreen(),
  };

  Routes() {
    runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BarOMetre",
      home: new LoginScreen(),
      theme: appTheme,
      routes: routes,
    ));
  }
}
