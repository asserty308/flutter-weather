import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/utils/date_utils.dart';
import 'package:weather_app/utils/weather_utils.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/forecast_widget.dart';

class CurrentWeatherPage extends StatefulWidget {
  CurrentWeatherPage({Key key, this.city}) : super(key: key);
  final String city;

  @override
  _CurrentWeatherPageState createState() =>
      new _CurrentWeatherPageState(
          city: this.city
      );
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final String city;
  WeatherInfo weatherData;
  String latestWeatherUpdate = "";
  int latestTemperature;
  bool dataFetched = false;

  final Color fontColor = Color(0xff696969);

  _CurrentWeatherPageState({this.city});

  updateLatestFetchTime() async {
    DateTime date = DateTime.now();
    String timeStr = "${date.day}.${date.month}.${date.year}, ${date.hour}:${date.minute} Uhr";

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("latest_weather_update_time", timeStr);

    setLatestWeatherUpdate();
  }

  setLatestWeatherUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    String time = prefs.getString("latest_weather_update_time");

    if (time == null || time.isEmpty) {
      time = "niemals";
    }

    setState(() {
      this.latestWeatherUpdate = time;
    });
  }

  getWeatherData() async {
    this.weatherData = await fetchWeather(this.city, "");

    if (this.weatherData != null) {
      if (!this.dataFetched) {
        this.dataFetched = true;
        updateLatestFetchTime();
      }

      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setLatestWeatherUpdate();
    getWeatherData();
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