import 'dart:ui';

import 'package:flutter/material.dart';

class SunProps {
  static final double radius1 = 40.0,
      radius2 = 60.0,
      radius3 = 80.0,
      radius4 = 100.0;
}

class SunWidget extends StatefulWidget {
  @override
  _SunWidgetState createState() =>  new _SunWidgetState();
}

class _SunWidgetState extends State<SunWidget> with TickerProviderStateMixin {
  AnimationController animation1, animation2;
  double animStartRadius1 = SunProps.radius1 - 10.0, animRadius1 = SunProps.radius1 - 10.0, animEndRadius1 = SunProps.radius3;
  double animStartRadius2 = SunProps.radius3, animRadius2 = SunProps.radius3, animEndRadius2 = SunProps.radius4;

  @override
  void initState() {
    super.initState();
    this.handleAnimations();
  }

  @override
  void dispose() {
    animation1.dispose();
    animation2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          new Container(width: 280.0, height: 280.0),
          new Container(
            width: 280.0,
            height: 280.0,
            decoration: new BoxDecoration(
                color: Color(0xffb63055).withAlpha(0x44),
                borderRadius: new BorderRadius.circular(140.0)
            ),
          ),
          new Container(
            width: SunProps.radius4 * 2.0,
            height: SunProps.radius4 * 2.0,
            decoration: new BoxDecoration(
              color: Color(0xffb83c64),
              borderRadius: new BorderRadius.circular(SunProps.radius4)
            ),
          ),
          new Container(
            // second animation
            width: animRadius2 * 2.0,
            height: animRadius2 * 2.0,
            decoration: new BoxDecoration(
                color: Color(0xff666666).withAlpha(((-0.5*animation2.value + 0.75) * 255).round()),
                borderRadius: new BorderRadius.circular(animRadius2)
            ),
          ),
          new Container(
            width: SunProps.radius3 * 2.0, // currentRadius * 2.0,
            height: SunProps.radius3 * 2.0, // currentRadius * 2.0,
            decoration: new BoxDecoration(
                color: Color(0xffd05f74),
                borderRadius: new BorderRadius.circular(SunProps.radius3)
            ),
          ),
          new Container(
            // first animation
            width: animRadius1 * 2.0,
            height: animRadius1 * 2.0,
            decoration: new BoxDecoration(
                color: Color(0xff666666).withAlpha(((-0.5*animation1.value + 0.75) * 255).round()),
                borderRadius: new BorderRadius.circular(animRadius1)
            ),
          ),
          new Container(
            width: SunProps.radius2 * 2.0,
            height: SunProps.radius2 * 2.0,
            decoration: new BoxDecoration(
                color: Color(0xfff39d71),
                borderRadius: new BorderRadius.circular(SunProps.radius2)
            ),
          ),
          new Container(
            width: SunProps.radius1 * 2.0,
            height: SunProps.radius1 * 2.0,
            decoration: new BoxDecoration(
                color: Color(0xffffe759),
                borderRadius: new BorderRadius.circular(SunProps.radius1)
            ),
          ),
        ]
    );
  }

  void handleAnimations() {
    animation1 = new AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          animRadius1 = lerpDouble(
            animStartRadius1,
            animEndRadius1,
            animation1.value,
          );
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // restart and start 2nd anim when finished
          animation1.forward(from: 0.0);
          animation2.forward(from: 0.0);
        } else if (status == AnimationStatus.dismissed) {
          animation1.forward();
        }
      });

    initAnim2();

    animation1.forward();
  }

  void initAnim2() {
    animation2 = new AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          animRadius2 = lerpDouble(
            animStartRadius2,
            animEndRadius2,
            animation2.value,
          );
        });
      });
  }

}