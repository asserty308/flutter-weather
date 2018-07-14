import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_utils.dart';

class ForecastWidget extends StatelessWidget {
  final Color iconColor = Color(0xff696969);

  final int weatherType1, weatherType2, weatherType3;

  ForecastWidget({
    Key key,
    this.weatherType1,
    this.weatherType2,
    this.weatherType3
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Image(
            width: 60.0,
            height: 60.0,
            color: iconColor,
            image: WeatherTypes.getImageForType(this.weatherType1),
            fit: BoxFit.scaleDown,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Image(
            width: 60.0,
            height: 60.0,
            color: iconColor,
            image: WeatherTypes.getImageForType(this.weatherType2),
            fit: BoxFit.scaleDown,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Image(
            width: 60.0,
            height: 60.0,
            color: iconColor,
            image: WeatherTypes.getImageForType(this.weatherType3),
            fit: BoxFit.scaleDown,
          ),
        )
      ],
    );
  }

}