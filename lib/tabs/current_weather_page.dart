import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/api/google_maps_api.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/utils/date_utils.dart';
import 'package:weather_app/utils/weather_utils.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/forecast_widget.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

/// Shows the weather at the current location

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => new _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  // Weather
  WeatherInfo weatherData;
  bool dataFetched = false;

  // Location
  String city = "";
  Map<String, double> currentLocation;
  StreamSubscription<Map<String, double>> locationSubscription;
  Location _location = new Location();

  final Color fontColor = Color(0xff696969);

  _CurrentWeatherPageState();

  // Platform messages are asynchronous, so we initialize in an async method.
  getCurrentLocation() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      location = await _location.getLocation;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        print('Permission denied - please ask the user to enable it from the app settings');
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      currentLocation = location;
      getWeatherData();
    });
  }

  getWeatherData() async {
    final lat = currentLocation["latitude"].toString();
    final lng = currentLocation["longitude"].toString();
    this.city = await getCityFromLatLong(lat, lng) ?? "";

    this.weatherData = await fetchWeather(this.city, "");

    if (this.weatherData != null) {
      if (!this.dataFetched) {
        this.dataFetched = true;
      }

      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Get current location. When found, fetch weather data
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: new Container(
        color: Colors.black,
        child: new Column(
          children: <Widget>[
            new Text(
              this.city.toUpperCase(),
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: fontColor,
                fontSize: 22.0
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 4.0, bottom: 24.0),
              child: new Text(
                DateUtils.getDateStringFromDate(date).toUpperCase(),
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: fontColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            new Center(
              child: new CurrentWeatherWidget(weatherData: this.weatherData,),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 32.0),
              child: new Text(
                "VORHERSAGE HEUTE",
                textAlign: TextAlign.center,
                style: new TextStyle(
                    color: fontColor,
                    fontSize: 16.0,
                ),
              )
            ),
            new Padding(
                padding: new EdgeInsets.only(top: 16.0),
                child: new ForecastWidget(weatherType1: WeatherTypes.SUN, weatherType2: WeatherTypes.THUNDER_LIGHTNING, weatherType3: WeatherTypes.RAIN_WIND,),
            )
          ]
        ),
      ),
    );
  }
}