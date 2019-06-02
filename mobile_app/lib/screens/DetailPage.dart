import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final dynamic med;

  DetailPage(this.med);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(context), body: getBody(context));
  }

  // ===============================================
  // == App bar
  // ===============================================

  AppBar getAppBar(context) {
    return new AppBar(elevation: 2.0, title: Text('Détail'), actions: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.info_outline),
                    color: Colors.white,
                    onPressed: () => _openLink(context))
              ]))
    ]);
  }

  // ===============================================
  // == Body
  // ===============================================

  Material getBody(context) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            onTap: () => print("test"),
            child: ListView(children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text(
                    _getMedDenomination(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  // TODO: change icon
                  leading: Icon(Icons.insert_emoticon),
                  title: Text(
                    "Forme",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(_getMedForme()),
                ),
              ),
              Card(
                child: ListTile(
                  // TODO: change icon
                  leading: Icon(Icons.insert_emoticon),
                  title: Text(
                    "Administration",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(_getMedVoieAdministration()),
                ),
              ),
              Card(
                  child: ListTile(
                      leading: Icon(Icons.euro_symbol),
                      title: Text(
                        "Prix",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_getMedPrice()),
                      trailing: Icon(Icons.help_outline),
                      onTap: () => {
                            _showDialog(
                                context,
                                // "Les prix indiqués sont ceux fixés par le CEPS (organisme interministériel).\nUn prix non défini signifie que le médicament n'est pas remboursable, et qu'il appartient donc aux pharmaciens d'officinede les déterminer.")
                                "Infos",
                                "Un prix \"non défini\" signifie que le médicament n'est pas remboursable, et qu'il appartient aux laboratoires de le fixer.",
                                "Ok")
                          })),
              Card(
                  child: ListTile(
                      // TODO: change icon
                      // leading: Icon(Icons.insert_emoticon),
                      title: Text(
                        "Indications thérapeutiques",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_getIndicationsTherapeutiques()),
                      isThreeLine: true)),
              Card(
                  child: ListTile(
                      // TODO: change icon
                      // leading: Icon(Icons.insert_emoticon),
                      title: Text(
                        "Conditions de préscription",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(_getConditionsPrescription()),
                      isThreeLine: true))
            ])));
  }

  // ===============================================
  // == Propriétés du médicament
  // ===============================================

  String _getMedDenomination() {
    String denomination =
        _capitalize(med["denomination"].split(",")[0].toLowerCase());

    return denomination;
  }

  String _getMedPrice() {
    String price = med["presentations"][0]["prix"].toString() == "null"
        ? "Non défini"
        : med["presentations"][0]["prix"].toString() + "€";

    return price;
  }

  String _getMedForme() {
    String forme = _capitalize(med["formePharmaceutique"]);

    return forme;
  }

  String _getMedVoieAdministration() {
    String voieAdministration = med["voiesAdministration"] != null
        ? _capitalize(med["voiesAdministration"][0])
        : 'Non précisée';

    return voieAdministration;
  }

  String _getIndicationsTherapeutiques() {
    String indicationsTherapeutiques = med["indicationsTherapeutiques"] != null
        ? med["indicationsTherapeutiques"].split("<")[0]
        : "Aucunes indications fournies...";

    return indicationsTherapeutiques;
  }

  String _getConditionsPrescription() {
    String string = "";
    List<dynamic> conditions = med["conditionsPrescriptionDelivrance"];

    if (conditions == null || conditions.length == 0) {
      return "Ce médicament ne possède pas de conditions de prescription particulières...";
    }

    for (var i = 0; i < conditions.length; i++) {
      string += "- " + _capitalize(conditions[i]) + "\n";
    }

    return string.substring(0, string.length - 1);
  }

  void _openLink(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Êtes vous sûr ?"),
              content: Text(
                  "Vous vous apprêtez à quitter l'application pour ouvrir une page internet.",
                  textAlign: TextAlign.justify),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("Confirmer"),
                    onPressed: () async {
                      String url =
                          "http://base-donnees-publique.medicaments.gouv.fr/affichageDoc.php?specid=" +
                              med["codeCIS"] +
                              "&typedoc=R";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                      Navigator.of(context).pop();
                    }),
                new FlatButton(
                    child: new Text("Annuler"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  // ===============================================
  // == Fonctions utiles
  // ===============================================

  // Met la première lettre d'un mot en majuscule
  String _capitalize(String input) {
    if (input == null) throw new ArgumentError("string: $input");
    if (input.length == 0) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  void _showDialog(context, textTitle, textContent, textButton) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(textTitle),
              content: Text(textContent, textAlign: TextAlign.justify),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                    child: new Text(textButton),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
