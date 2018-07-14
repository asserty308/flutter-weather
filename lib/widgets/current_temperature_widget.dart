import 'package:flutter/material.dart';

class CurrentTemperatureWidget extends StatelessWidget {
  final int temperature;

  CurrentTemperatureWidget({
    this.temperature
  });

  @override
  Widget build(BuildContext context) {
    return new Text(
      "${this.temperature}",
      textAlign: TextAlign.center,
      style: new TextStyle(
          color: Color(0xff292929),
          fontSize: 200.0,
          fontWeight: FontWeight.bold
      ),
    );
  }

}