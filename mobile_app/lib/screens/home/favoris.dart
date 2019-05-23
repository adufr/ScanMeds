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

Future<List<Bar>> fetchBars() async {
  String token = await getTokenPref();
  final response = await http.get(
      'https://caf56d63.ngrok.io/api/v1/user/favs',
      headers: {"ResourceVersion": "v3", "Authorization": 'Bearer ${token}'});
  if (response.statusCode == 200) {
    // log(response.body);
    // Map<String, String> bars = {};
    // //_InternalLinkedHashMap<String, dynamic> bars = response.body;
    // for (var i = 0; i < bars.length; i++) {
    //   log(bars[i]);
    // }
    // return bars.toList();
    List bars = json.decode(response.body)['bars'];
    print(bars);
    return bars.map((bars) => new Bar.fromJson(bars)).toList();
  } else {
    throw Exception('Erreur dans le chargement de la liste');
  }
}

class FavorisWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavorisScreenState();
//  Widget build(BuildContext context) {
//    return Container(
//      child: new Text('Vols'),
//    );
//  }
}

class FavorisScreenState extends State<FavorisWidget> {
  final scrollController = new ScrollController();
  bool isLoading = false;

  var list_bars;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  String now = formatDate(new DateTime.now(), [dd, '/', mm, '/', yyyy]);
  //final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshListBars();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        //loadMore();
        log('test');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: RefreshIndicator(
          key: refreshKey,
          child: FutureBuilder<List<Bar>>(
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
                              //Add save
                              // saveBarPref(bars.id);
                              // //Navigator.pushNamed(context, "/Bar");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => BarScreen()),
                              // );
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
                                                        Text(
                                                            " ${bars.temperature} °",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 27.0,
                                                                color: getColorTemp(
                                                                    bars.likeValue))),
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
                                                            _launchURL(bars);
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
                                                            onPressed: () {
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
                                                            }))
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
              return CircularProgressIndicator();
            },
          ),
          onRefresh: refreshListBars),
    );
  }

  Future<Null> refreshListBars() async {
    refreshKey.currentState?.show(atTop: false);
    await new Future.delayed(const Duration(seconds: 1));
    setState(() {
      list_bars = fetchBars();
    });

    return null;
  }

  _launchURL(bars) async {
    var url = Uri.encodeFull(
        'https://www.google.com/maps/place/${bars.addressStreetNumber}+${bars.addressStreet},+${bars.addressZipcode}+${bars.addressCity}');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  loadMore() async {
    if (!isLoading) {
      setState(() => isLoading = true);
      var page = 2;
      var newFlights = await fetchBars();

      list_bars.addAll(newFlights);
      isLoading = false;
      setState(() {});
    }
  }
}

Future<bool> saveTokenPref(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  return prefs.commit();
}

Future<bool> saveBarPref(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("barId", id);
  return prefs.commit();
}

Future<String> getTokenPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  return token;
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

void sendValue(value, idBar) async {
  String token = await getTokenPref();
  http.put(
      'https://caf56d63.ngrok.io/api/v1/user/favs',
      headers: {"ResourceVersion": "v3", "Authorization": 'Bearer ${token}'},
      body: {"value": value});
}
