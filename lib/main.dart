import 'package:flutter/material.dart';

import './current_location.dart' as currentLocation;
import './historique_location.dart'  as historiqueLocation;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapsMe',
      theme: ThemeData(

        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'MapsMe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{
  TabController controller;

  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
          style: new TextStyle(
            color: Colors.white
          ),
        ),
      ),
      bottomNavigationBar: new Material(
        color: Colors.orange,

        child: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.gps_fixed, color: Colors.white)),
            new Tab(icon: new Icon(Icons.history, color: Colors.white)),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new currentLocation.CurrentLocation(),
          new historiqueLocation.HistoriqueLocation(),
        ]
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
