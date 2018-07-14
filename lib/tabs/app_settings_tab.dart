import 'package:flutter/material.dart';

class AppSettingsTab extends StatefulWidget {
  AppSettingsTab({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppSettingsTabState createState() => new _AppSettingsTabState();
}

class _AppSettingsTabState extends State<AppSettingsTab> {
  @override
  Widget build(BuildContext context) {
    final Color fontColor = Color(0xff696969);

    return new Container(
      color: Colors.black45,
      child: new Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Einstellungen', style: TextStyle(color: fontColor),),
          centerTitle: true,
        ),
      ),
    );
  }
}