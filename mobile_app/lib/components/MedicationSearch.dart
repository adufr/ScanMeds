import 'package:flutter/material.dart';

class MedicationSearch extends SearchDelegate<String> {

  // Temp lists
  final medications = [
    "Doliprane",
    "Advil",
    "Arnigel",
  ];

  final recentMedications = [
    "Doliprane",
    "Arnigel"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on the selection
    print('------------- :v -------------');
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty ?
    recentMedications : medications.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: (){
            showResults(context);
          },
          leading: Icon(Icons.gamepad),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold
                ),
                children: [TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Color(0xFF707070))
                )]
            ),
          )
      ),
      itemCount: suggestionList.length,
    );
  }
}