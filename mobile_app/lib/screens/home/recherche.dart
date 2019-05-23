import 'package:flutter/material.dart';
import 'package:mobile_app/components/TextFields/inputField.dart';
import 'package:mobile_app/theme/style.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:mobile_app/models/bar.model.dart';
import 'package:mobile_app/screens/home/bar.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:advanced_share/advanced_share.dart' show AdvancedShare;
import 'package:mobile_app/services/validations.dart';
import 'package:mobile_app/components/Buttons/roundedButton.dart';
import 'package:flutter/services.dart';

Future<List<Bar>> fetchBars(String id) async {
  String token = await getTokenPref();
  final response = await http.get(
      'https://caf56d63.ngrok.io/api/v1/bar/search/$id',
      headers: {"ResourceVersion": "v3", "Authorization": 'Bearer $token'});
  if (response.statusCode == 200) {
    List bars = json.decode(response.body)['bars'];
    return bars.map((bars) => new Bar.fromJson(bars)).toList();
  } else {
    throw Exception('Erreur dans le chargement de la liste');
  }
}

class RechercheWidget extends StatelessWidget {
  BuildContext context;
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();
  bool autovalidate = false;
  Validations validations = new Validations();
  final idController = new TextEditingController();
   var list_bars;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;

    //print(context.widget.toString());
    Validations validations = new Validations();
    return new Container(
                padding: new EdgeInsets.all(16.0),
                decoration: new BoxDecoration(),
                child: new GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: screenSize.height - 500,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
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
                                            hintText: "Recherche",
                                            hintStyle: hintStyle,
                                            obscureText: false,
                                            textInputType: TextInputType.text,
                                            textStyle: textStyle,
                                            textInputAction2:
                                                TextInputAction.next,
                                            textFieldColor: textFieldColor,
                                            bottomMargin: 20.0,
                                            onSaved: (String email) {}),
                                        new RoundedButton(
                                          buttonName: "Recherche",
                                          onTap: () {
                                            //fetchBars(idController.text);
                                            return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      // Retrieve the text the user has typed in using our
                                                      // TextEditingController
                                                      content: Text(
                                                          "Fonction En Cours de développement"),
                                                    );
                                                  },
                                                );
                                          },
                                          width: screenSize.width,
                                          height: 50.0,
                                          bottomMargin: 10.0,
                                          borderWidth: 0.0,
                                          buttonColor: primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
          FutureBuilder<List<Bar>>(
            future: list_bars,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<Bar> bars = snapshot.data;
                return new ListView(
                    controller: scrollController,
                    children: bars
                        .map((bars) => GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 10.0,
                                  top: 20.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0),
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[400]))),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                      child: Image.network('${bars.logo}')),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(children: <Widget>[
                                                Text("${bars.name}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10.0),
                                                      child: Row(children: <
                                                          Widget>[
                                                        IconButton(
                                                          icon: Icon(Icons.add),
                                                          color: getColorPlus(
                                                              bars.likeValue),
                                                          onPressed: () {},
                                                        ),
                                                        Text(
                                                            " ${bars.temperature} °",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 27.0,
                                                                color: getColorTemp(
                                                                    bars.likeValue))),
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.remove),
                                                          color: getColorMinus(
                                                              bars.likeValue),
                                                          onPressed: () {},
                                                        )
                                                      ]))
                                                ],
                                              )
                                            ],
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 10.0, bottom: 10.0),
                                              child: Text('${bars.description}',
                                                  style: TextStyle(
                                                      color: Colors.black))),
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    IconButton(
                                                      icon: Icon(Icons.message,
                                                          color: Colors.black),
                                                      onPressed: () {
                                                        print("MABITE");
                                                      },
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 3.0),
                                                      child: Text("15",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 20.0),
                                                        child: IconButton(
                                                          icon: Icon(
                                                              Icons.gps_fixed,
                                                              color:
                                                                  Colors.black),
                                                          onPressed: () {
                                                          },
                                                        ))
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 20.0),
                                                        child: IconButton(
                                                            icon: Icon(
                                                                Icons.share,
                                                                color: Colors
                                                                    .black),
                                                            onPressed: () {}))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )))
                        .toList());
              }
              return Text("");
            },
          ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                );
  }
}

Future<String> getTokenPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  return token;
}
