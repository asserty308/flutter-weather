import 'package:flutter/material.dart';

class CityOverviewPage extends StatefulWidget {
  CityOverviewPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CityOverviewPageState createState() => new _CityOverviewPageState();
}

class _CityOverviewPageState extends State<CityOverviewPage> {
  @override
  Widget build(BuildContext context) {

    return new Container(
      color: Colors.black45,
      child: new Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.red,
          tooltip: 'Add City',
          onPressed: () {},
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}