import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "accueil.dart";
import "recherche.dart";
import "favoris.dart";
import "package:mobile_app/screens/profile/profile.dart";


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _title = "Accueil";
  int _currentIndex = 0; // this will be set when a new tab is tapped
  final List<Widget> _children = [
    BarsWidget(),
    RechercheWidget(),
    FavorisWidget()
  ];
  void onTabTapped(int index) {
    setState(() {
      if (index == 0) {
        _title = 'Accueil';
      } else if (index == 1) {
        _title = 'Recherche';
      } else if (index == 2) {
        _title = 'Favoris';
      }
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Color.fromRGBO(131, 207, 234, 1),
        actions: <Widget>[
            // action button
            Padding(
              padding: EdgeInsets.only(right:8.0),
              child: IconButton(
                icon: Icon(Icons.account_circle),
                iconSize: 32.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            )
            
          ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Accueil'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Recherche'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favoris'))
        ],
      ),
    );
  }
}
