import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class CurrentLocationPage extends StatefulWidget {
  CurrentLocationPage({Key key}) : super(key: key);

  @override
  _CurrentLocationPageState createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  Map<String, double> currentLocation;
  StreamSubscription<Map<String, double>> locationSubscription;
  String error;

  Location _location = new Location();

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      currentLocation = location;
    });
  }

  @override
  void initState() {
    super.initState();

    initPlatformState();

    locationSubscription =
        _location.onLocationChanged.listen((Map<String,double> result) {
          setState(() {
            currentLocation = result;
          });
        });
  }

  @override
  build(BuildContext context) {
  }

}