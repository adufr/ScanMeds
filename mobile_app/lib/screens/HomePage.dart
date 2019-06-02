import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'DetailPage.dart';
// import '../components/MedicationSearch.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final apiCPIUrl =
      "https://www.open-medicaments.fr/api/v1/medicaments?limit=1&query=";
  final apiCISUrl = "https://www.open-medicaments.fr/api/v1/medicaments/";
  String result = "Commencez par scanner une boîte de médicament !";

  // On tente de scanner le code bar
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      Response response = await http.get(apiCPIUrl + qrResult);

      if (response.statusCode == 200) {
        String codeCIS = json.decode(response.body)[0]["codeCIS"];
        print("Code CIS $codeCIS");
        response = await http.get(apiCISUrl + codeCIS);

        if (response.statusCode == 200) {
          final med = json.decode(response.body);

          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new DetailPage(med)));
        } else {
          setState(() {
            result = "Une erreur est survenue";
          });
        }
      } else {
        setState(() {
          result = "Une erreur est survenue";
        });
      }

      // On catch les potentielles erreurs
    } on PlatformException catch (ex) {
      print(ex);
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result =
              "Vous avez refusé de donner la permission d'accéder à la caméra";
        });
      } else {
        setState(() {
          result = "Une erreur est survenue";
        });
      }
    } on FormatException {
      setState(() {
        result = "Aucun code barre trouvé...";
      });
    } catch (ex) {
      print(ex);
      setState(() {
        result = "Une erreur est survenue";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ScanMeds"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       showSearch(context: context, delegate: MedicationSearch());
        //     },
        //   )
        // ],
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icon.png",
                height: size.height * 0.3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text("ScanMeds",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text(
                    "Scannez le code barre d'une boîte de médicaments pour commencer",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black54)),
              ),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 50,
                width: size.width * 0.6,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: _scanQR,
                    color: primaryColor,
                    child: Text("Scanner",
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
