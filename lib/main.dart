import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Bar Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF90CAF9),
      ),
      home: MyHomePage(cityName: "Puri"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String cityName;
  MyHomePage({Key key, @required this.cityName}) : super(key : key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Bar Demo"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
             String city = await showSearch(context: context, delegate: DataSearch());
             upDateCity(city);
            },
            icon: Icon(
              Icons.search
            ),
          )
        ],
      ),
      drawer: Drawer(),
      body: Container(
        child: Text(
          widget.cityName
        ),
      )
    );
  }

  void upDateCity(String city) {
    setState(() {
      widget.cityName = city;
    });
  }
}

class DataSearch extends SearchDelegate<String> {

  final cities = ["Delhi", "Bangalore", "Chenai", "Kolkata", "Mumbai", "Hydrabad", "Bhubaneswar", "Pune", "Kochin", "Panchi", "Bhopal", "Amritsar"];
  final recentCities = ["Delhi", "Bangalore", "Chenai", "Kolkata"];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        }
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty? recentCities : cities.where((p)=> p.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
              onTap: (){
                query = suggestionList[index];
                close(context, query);
              },
              leading: Icon(Icons.location_city),
              title: RichText(
                text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                    children: [TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(
                          color: Colors.grey,
                      ),
                    )]
                ),
              ),
      )
    );
  }

}