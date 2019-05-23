import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:mobile_app/models/bar.model.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:advanced_share/advanced_share.dart' show AdvancedShare;

class BarScreen extends StatefulWidget {
  const BarScreen({Key key}) : super(key: key);

  @override
  BarScreenState createState() => new BarScreenState();
}

class BarScreenState extends State<BarScreen> {
  BuildContext context;
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();

  final idController = new TextEditingController();
  final passController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBar();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 173, 0, 1),
      ),
      );
  }
}


Future<Bar> fetchBar() async{
  String token = await getTokenPref();
  String barId = await getBarPref();
  final response = await http.get(
      'https://caf56d63.ngrok.io/api/v1/bar/$barId',
      headers: {"ResourceVersion": "v3", "Authorization": 'Bearer $token'});
  Map<String, dynamic> jsonData = jsonDecode(response.body);

}

Future<bool> saveTokenPref(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  return prefs.commit();
}

Future<String> getTokenPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  return token;
}

Future<String> getBarPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString("barId");
  print(id);
  return id;
}


Color getColorPlus(color) {
  if (color == '+') {
    return Colors.blue;
  } else {
    return Colors.black;
  }
}

Color getColorMinus(color) {
  if (color == '-') {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

Color getColorTemp(color) {
  if (color == '+') {
    return Colors.blue;
  } else if (color == '-') {
    return Colors.red;
  } else {
    return Colors.black;
  }
}
