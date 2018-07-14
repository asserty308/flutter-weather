import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/widgets/current_temperature_widget.dart';
import 'package:weather_app/widgets/weather_types/moon_widget.dart';
import 'package:weather_app/widgets/weather_types/sun_widget.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherInfo weatherData;

  const CurrentWeatherWidget({Key key, this.weatherData}) : super(key: key);

  @override
  build(BuildContext context) {
    if (weatherData == null) {
      return new CircularProgressIndicator();
    }

    return new Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        timeIsDay() ? new SunWidget() : new MoonWidget(),
        new CurrentTemperatureWidget(temperature: this.weatherData.currentCelsius,),
      ],
    );
  }

  bool timeIsDay() {
    if (weatherData == null) {
      return true;
    }

    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(this.weatherData.sunrise * 1000);
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(this.weatherData.sunset * 1000);
    DateTime current = DateTime.fromMillisecondsSinceEpoch(this.weatherData.date * 1000);

    if (current.isAfter(sunrise) && current.isBefore(sunset)) {
      // daytime
      return true;
    }

    // nighttime
    return false;
  }
}