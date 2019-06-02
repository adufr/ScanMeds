import 'package:ScanMeds/screens/HomePage.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  Color _primaryColor;
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _username = "";
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;

  // Astuce pour les rendus conditionnels n'ayant pas de "else"
  bool notNull(Object o) => o != null;

  _LoginPageState() {
    _usernameFilter.addListener(_usernameListen);
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _usernameListen() {
    if (_usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = _usernameFilter.text;
    }
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        // appBar: _buildBar(context),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(40, 80, 40, 40),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Image.asset("assets/icon.png", height: size.height * .25),
                  Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        "ScanMeds",
                        style: TextStyle(fontSize: 40),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  _buildTextFields(),
                  _buildButtons()
                ]))));
  }

  Widget _buildTextFields() {
    return Container(
        child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
      _form == FormType.register
          ? Container(
              child: TextField(
              controller: _usernameFilter,
              decoration: InputDecoration(labelText: "Nom d'utilisateur"),
              obscureText: true,
            ))
          : null,
      Container(
          child: TextField(
              controller: _emailFilter,
              decoration: InputDecoration(labelText: "Adresse mail"))),
      Container(
          child: TextField(
              controller: _passwordFilter,
              decoration: InputDecoration(labelText: "Mot de passe"),
              obscureText: true))
    ].where(notNull).toList())));
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(children: <Widget>[
            RaisedButton(
                child: Text(
                  "Se connecter",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                color: _primaryColor,
                onPressed: _loginPressed),
            FlatButton(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                    "Vous n'avez pas de compte ?\nAppuyez pour vous inscrire.",
                    textAlign: TextAlign.center),
                onPressed: _formChange),
            FlatButton(
                padding: EdgeInsets.only(top: 40),
                child: Text("Mot de passe oublié ?"),
                onPressed: _passwordReset)
          ]));
    } else {
      return Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(children: <Widget>[
            RaisedButton(
              child: Text(
                "S'inscrire",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              color: _primaryColor,
              onPressed: _createAccountPressed,
            ),
            FlatButton(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                    "Vous avez un compte ?\nAppuyez pour vous connecter.",
                    textAlign: TextAlign.center),
                onPressed: _formChange)
          ]));
    }
  }

  // ==============================================
  // == Fonctions de connexion / inscription
  // ==============================================

  // Login logic
  void _loginPressed() {
    const url = "https://scanmeds.arthurdufour.com/api/v1/auth/";
    http.post(url, body: {"email": _email, "password": _password}).then(
        (response) {
      // Connexion validée
      if (response.statusCode == 201) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      // Mot de passe invalide
      else if (response.statusCode == 401) {
        _showDialog("Mot de passe invalide",
            "Le mot de passe que vous avez indiqué n'est pas valide.");
      }
      // Utilisateur inconnu
      else if (response.statusCode == 404) {
        _showDialog("Utilisateur inconnu",
            "L'adresse mail que vous avez renseigné ne correspond à aucun compte.");
      } else {
        _showDialog("Erreur", "Une erreur inconnue est survenue");
      }
    });
  }

  void _createAccountPressed() {
    const url = "https://scanmeds.arthurdufour.com/api/v1/user/";
    http.post(url, body: {
      "username": _username,
      "email": _email,
      "password": _password
    }).then((response) {
      // Inscription validée
      if (response.statusCode == 201) {
        _formChange();
      }
      // Mot de passe invalide
      else if (response.statusCode == 400) {
        _showDialog("Champ(s) invalide(s)",
            "Veuillez remplir les champs correctement et ressayer.");
      }
      // Utilisateur inconnu
      else if (response.statusCode == 409) {
        _showDialog("Nom déjà utilisé",
            "Le nom d'utilisateur / l'adresse mail renseigné(e) est déjà utilisé(e).");
      } else {
        _showDialog("Erreur", "Une erreur inconnue est survenue");
      }
    });
  }

  void _passwordReset() {
    _showDialog("A venir", "Cette fonctionnalité n'est pas encore disponible.");
  }

  // ==============================================
  // == Autres fonctions
  // ==============================================

  void _showDialog(textTitle, textContent) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(textTitle),
              content: Text(textContent, textAlign: TextAlign.left),
              actions: <Widget>[
                FlatButton(
                    child: Text("Fermer"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
