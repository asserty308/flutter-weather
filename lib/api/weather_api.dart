import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/api/google_maps_api.dart';
import 'package:weather_app/api/secrets.dart';

Future<WeatherInfo> fetchWeather(String city, String country) async {
  var url = "https://api.openweathermap.org/data/2.5/weather";
  WeatherInfo data = await callWeatherApi(url, city, country);
  return await calibrateWeatherTimezone(data);
}

Future<WeatherInfo> fetchForecast(String city, String country) async {
  var url = "https://api.openweathermap.org/data/2.5/forecast";
  WeatherInfo data = await callWeatherApi(url, city, country);
  return await calibrateWeatherTimezone(data);
}

Future<WeatherInfo> calibrateWeatherTimezone(WeatherInfo data) async {
  // calculate real time from timezone
  int timezoneOffset = await getTimezoneOffset(data);

  data.date += timezoneOffset;
  data.sunset += timezoneOffset;
  data.sunrise += timezoneOffset;

  return data;
}

Future<WeatherInfo> callWeatherApi(String url, String city, String country) async {
  var location = city + (country.isNotEmpty ? "," + country : "");
  var units = "metric";

  var secrets = await SecretsLoader(secretsPath: "secrets.json").load();
  var appId = secrets.owmApiKey;

  final response = await http.get(url + "?q=" + location + "&units=" + units + "&APPID=" + appId);
  final responseJSON = json.decode(response.body);

  return new WeatherInfo.fromJson(responseJSON);
}

class WeatherInfo {
  final String weatherType, weatherDescription, lat, lon;
  final int currentCelsius, minCelsius, maxCelsius;
  int date, sunrise, sunset;

  WeatherInfo({
    this.weatherType,
    this.weatherDescription,
    this.lat,
    this.lon,
    this.currentCelsius,
    this.minCelsius,
    this.maxCelsius,
    this.date,
    this.sunrise,
    this.sunset
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final int cod = json['cod'];

    if (cod == null) {
      print("Request failed");
      return null;
    }

    if (cod != 200) {
      print("An api error occured: Code = ${cod}");
      return null;
    }

    var weatherInfo = json['weather'][0];

    return new WeatherInfo(
      weatherType: weatherInfo['main'],
      weatherDescription: weatherInfo['description'],
      lat: json['coord']['lat'].toString(),
      lon: json['coord']['lon'].toString(),
      currentCelsius: json['main']['temp'].toInt(),
      minCelsius: json['main']['temp_min'].toInt(),
      maxCelsius: json['main']['temp_max'].toInt(),
      date: json['dt'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset']
    );
  }
}