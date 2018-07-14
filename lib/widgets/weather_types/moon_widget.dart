import 'dart:ui';

import 'package:flutter/material.dart';

class MoonWidget extends StatefulWidget {
  @override
  _MoonWidgetState createState() =>  new _MoonWidgetState();
}

class _MoonWidgetState extends State<MoonWidget> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return new Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          new Container(width: 280.0, height: 280.0),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 240.0,
              height: 240.0,
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.5),
                borderRadius: BorderRadius.circular(120.0)
              ),
            ),
          ),
          new Container(
            width: 160.0, // currentRadius * 2.0,
            height: 160.0, // currentRadius * 2.0,
            decoration: new BoxDecoration(
                color: Colors.white70,
                borderRadius: new BorderRadius.circular(80.0)
            ),
          ),
        ]
    );
  }

}