import 'package:flutter/material.dart';
import 'package:mobile_app/services/validations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_app/screens/login/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<String> fetchUser() async {
  String token = await getTokenPref();
  final response = await http.get(
      'https://caf56d63.ngrok.io/api/v1/user',
      headers: {"ResourceVersion": "v3", "Authorization": 'Bearer $token'});
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body)["user"];
    var nom = jsonData["firstname"];
    var prenom = jsonData["lastname"];
    String nomPrenom = "$nom $prenom";
    print(nomPrenom);
    return nomPrenom;
  } else {
    throw Exception('Erreur dans le chargement de la liste');
  }
}


class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  BuildContext context;
  var deconnexion = <String, WidgetBuilder>{
    "/Deconnexion": (BuildContext context) => new LoginScreen()
  };

  static const SystemUiOverlayStyle light = const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark);

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        // return object of type Dialog
        return new CupertinoAlertDialog(
          title: new Text("Déconnexion"),
          content: new Text("Êtes-vous sur de vouloir vous déconnecter ?"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("OUI"),
              onPressed: () {
                clearTokenPref().then((bool committed) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/Deconnexion', (Route<dynamic> route) => false);
                });
              },
            ),
            CupertinoDialogAction(
              child: Text("NON"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop("Discard");
              },
            )
          ],
        );
      },
    );
  }

  @override
  String nomPrenom = "NOM";
  void initState() {
    super.initState();
    fetchUser().then((result) {
      print(result);
      setState(() {
          nomPrenom = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
    Validations validations = new Validations();



    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "BarOMetre",
        routes: deconnexion,
        home: new Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                color: Colors.black,
                onPressed: () {
                  _showDialog();
                },
              )
            ],
          ),
          body: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'assets/profile/chris.jpg',
                    child: Container(
                      height: 125.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(62.5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/profile/profile.png'))),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    nomPrenom,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'San Jose, CA',
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '24K',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'FOLLOWERS',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '31',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'TRIPS',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '21',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'BUCKET LIST',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.table_chart), onPressed: () {},),
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  buildImages(),
                  buildInfoDetail(),
                  buildImages(),
                  buildInfoDetail(),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildImages() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Container(
          height: 200.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: AssetImage('assets/profile/beach1.jpg'),
                  fit: BoxFit.cover))),
    );
  }

  Widget buildInfoDetail() {
    return Padding(
      padding:
          EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Maldives - 12 Days',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    'Teresa Soto',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '3 Videos',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/profile/navarrow.png'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/profile/chatbubble.png'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 22.0,
                  width: 22.0,
                  child: Image.asset('assets/profile/fav.png'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Future<bool> clearTokenPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return prefs.commit();
}