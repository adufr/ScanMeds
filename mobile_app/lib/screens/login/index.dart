import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/theme/style.dart';
import 'style.dart';
import 'package:mobile_app/components/TextFields/inputField.dart';
import 'package:mobile_app/components/Buttons/textButton.dart';
import 'package:mobile_app/components/Buttons/roundedButton.dart';
import 'package:mobile_app/services/validations.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  int _state = 0;
  BuildContext context;
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();
  bool autovalidate = false;
  Validations validations = new Validations();

  void checkLog() async {
    String token = await getTokenPref();
    print(token);
    if (!["", null, false, 0].contains(token)) {
      Navigator.pushReplacementNamed(context, "/HomePage");
    }
  }

  void deleteToken() async {
    clearTokenPref().then((bool committed) {});
  }

  _onPressed() {
    print("button clicked");
  }

  _adminRoute() {
    Navigator.pushReplacementNamed(context, "/HomePage");
  }

  login(String email, String password) async {
    print("plop");
    var url = "https://caf56d63.ngrok.io/api/v1/auth/";
    http.post(url, body: {"email": email, "password": password}).then(
        (response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      return response;
    });
  }

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  // void animateButton() {
  //   setState(() {
  //     _state = 1;
  //   });

  //   Timer(Duration(milliseconds: 3300), () {
  //     setState(() {
  //       _state = 2;
  //     });
  //   });
  // }

  // Widget setUpButtonChild() {
  //   if (_state == 0) {
  //     return new Text(
  //       "Connexion",
  //       style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 16.0,
  //       ),
  //     );
  //   } else if (_state == 1) {
  //     return CircularProgressIndicator(
  //       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //     );
  //   } else {
  //     return Icon(Icons.check, color: Colors.white);
  //   }
  // }

  void _handleSubmitted(idController, passController) async {
    // setState(() {
    //   if (_state == 0) {
    //     animateButton();
    //   }
    // });
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the user has typed in using our
          // TextEditingController
          content: Text(idController.text),
        );
      },
    );

    var email = "aze";
    var password = "aze";
    var url = "https://caf56d63.ngrok.io/api/v1/auth/";
    http.post(url, body: {"email": email, "password": password}).then(
        (response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, "/HomePage");
      }
    });
  }

  final idController = new TextEditingController();
  final passController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    //clearTokenPref();
    checkLog();
    //print(getTokenPref());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;

    Validations validations = new Validations();
    return new Scaffold(
        key: _scaffoldKey,
        body: new SingleChildScrollView(
            controller: scrollController,
            child: new Container(
                padding: new EdgeInsets.all(16.0),
                decoration: new BoxDecoration(image: backgroundImage),
                child: new GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: screenSize.height - 32,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                                child: new Image(
                              image: logo,
                              width: (screenSize.width < 500)
                                  ? 280.0
                                  : (screenSize.width / 4) + 12.0,
                              height: screenSize.height / 4 + 20,
                            )),
                            new Container(
                                margin: const EdgeInsets.only(
                                    bottom: 70.0, top: 10.0),
                                alignment: new Alignment(0.0, -1.0),
                                child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'ScanMeds',
                                        style: new TextStyle(
                                            fontSize: 50.0,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1)),
                                      )
                                    ])),
                            new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Form(
                                    key: formKey,
                                    autovalidate: autovalidate,
                                    child: new Column(
                                      children: <Widget>[
                                        new InputField(
                                            controllerAction: idController,
                                            hintText: "Adresse mail",
                                            hintStyle: hintStyle,
                                            obscureText: false,
                                            textInputType: TextInputType.text,
                                            textStyle: textStyle,
                                            textInputAction2:
                                                TextInputAction.next,
                                            textFieldColor: textFieldColor,
                                            bottomMargin: 20.0,
                                            onSaved: (String email) {}),
                                        new InputField(
                                            controllerAction: passController,
                                            hintText: "Mot de passe",
                                            hintStyle: hintStyle,
                                            obscureText: true,
                                            textInputAction2:
                                                TextInputAction.done,
                                            textInputType: TextInputType.text,
                                            textStyle: textStyle,
                                            textFieldColor: textFieldColor,
                                            bottomMargin: 30.0,
                                            validateFunction:
                                                validations.validatePassword,
                                            onSaved: (String password) {}),
                                        new RoundedButton(
                                          buttonName: "Connexion",
                                          onTap: () {
                                            var email = idController.text;
                                            var password = passController.text;
                                            var url =
                                                "https://caf56d63.ngrok.io/api/v1/auth/";
                                            http.post(url, body: {
                                              "email": email,
                                              "password": password
                                            }).then((response) {
                                              print(
                                                  "Response status: ${response.statusCode}");
                                              print(
                                                  "Response body: ${response.body}");
                                              if (response.statusCode == 201) {
                                                Map<String, dynamic> jsonData =
                                                    jsonDecode(response.body);
                                                //final jsonData = json.decode(response.body);
                                                print(jsonData["accessToken"]);

                                                saveTokenPref(
                                                        jsonData["accessToken"])
                                                    .then((bool committed) {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, "/HomePage");
                                                });
                                              } else if (response.statusCode == 400 || response.statusCode == 401) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      // Retrieve the text the user has typed in using our
                                                      // TextEditingController
                                                      content: Text(
                                                          "Mot de passe incorrect"),
                                                    );
                                                  },
                                                );
                                              } else if (response.statusCode == 404) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      // Retrieve the text the user has typed in using our
                                                      // TextEditingController
                                                      content: Text(
                                                          "Aucun utilisateur correspondant !"),
                                                    );
                                                  },
                                                );
                                              }
                                            });
                                          },
                                          width: screenSize.width,
                                          height: 50.0,
                                          bottomMargin: 10.0,
                                          borderWidth: 0.0,
                                          buttonColor: primaryColor,
                                        ),
                                        // new MaterialButton(
                                        //     child: setUpButtonChild(),
                                        //     color: primaryColor,
                                        //     height: 50.0)
                                        //new CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new TextButton(
                                          buttonName: "A propos",
                                          onPressed: _adminRoute,
                                          buttonTextStyle: buttonTextStyle),
                                      new TextButton(
                                          buttonName: "Besoin d'aide ?",
                                          onPressed: _onPressed,
                                          buttonTextStyle: buttonTextStyle)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
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

Future<bool> clearTokenPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return prefs.commit();
}
