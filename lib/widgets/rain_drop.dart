import 'dart:ui';

import 'package:flutter/material.dart';

class RainDrop extends StatefulWidget {
  @override
  _RainDropState createState() =>  new _RainDropState();
}

class _RainDropState extends State<RainDrop> with TickerProviderStateMixin {
  AnimationController animation;
  double startX, startY;
  double currentX, currentY;
  double endX, endY;

  @override
  void initState() {
    super.initState();

    animation = new AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )
    ..addListener(() {
      setState(() {
        currentX = lerpDouble(
          startX,
          endX,
          animation.value,
        );

        currentY = lerpDouble(
          startY,
          endY,
          animation.value,
        );
      });
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });

    startX = 120.0;
    startY = 120.0;
    currentX = 120.0;
    currentY = 120.0;
    endX = 80.0;
    endY = 150.0;

    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[
          new Container(width: 200.0, height: 200.0),
          new Positioned(
            child: new Container(
              width: 4.0,
              height: 12.0,
              decoration: new BoxDecoration(
                  color: Colors.cyan,
              ),
            ),
            left: currentX,
            top: currentY,
          ),
        ]
    );
  }

}