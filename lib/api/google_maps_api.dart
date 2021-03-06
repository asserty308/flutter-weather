import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/api/secrets.dart';
import 'package:weather_app/api/weather_api.dart';

/// Fetches the duration seconds the local time of the weather data varies from the unix time.
/// This value is used after the weather request to calibrate all time related values
/// like sunset, sunrise
Future<int> getTimezoneOffset(WeatherInfo data) async {
  var url = "https://maps.googleapis.com/maps/api/timezone/json";

  var secrets = await SecretsLoader(secretsPath: "secrets.json").load();
  var apiKey = secrets.googleApiKey;

  final response = await http.get(url + "?location=" + data.lat + "," + data.lon + "&timestamp=" + data.date.toString() + "&key=" + apiKey);
  final responseJSON = json.decode(response.body);

  int dstOffset = responseJSON['dstOffset'].toInt(); // 3600 for summertime, 0 winter
  int rawOffset = responseJSON['rawOffset'].toInt(); // offset without summertime

  return rawOffset + dstOffset;
}

/// Fetches location predictions based on an input search string
/// Used by the location-list page when searching for a specific location
Future<List<String>> getAutocompleteLocation(String searchStr) async {
  var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  var secrets = await SecretsLoader(secretsPath: "secrets.json").load();
  var apiKey = secrets.googleApiKey;

  final response = await http.get(url + "?input=" + searchStr + "&key=" + apiKey);
  final responseJSON = json.decode(response.body);

  var predictionsJSON = responseJSON["predictions"] as List;
  var predictions = List<String>();

  for (var item in predictionsJSON) {
    predictions.add(item["description"]);
  }

  return predictions;
}

/// Requests the Geocoding API for the city at given coordinates
Future<String> getCityFromLatLong(String lat, String lng) async {
  var url = "https://maps.googleapis.com/maps/api/geocode/json";

  var secrets = await SecretsLoader(secretsPath: "secrets.json").load();
  var apiKey = secrets.googleApiKey;
  
  final response = await http.get(url + "?latlng=" + lat + "," + lng + "&key=" + apiKey);
  final responseJSON = json.decode(response.body);

  var resultsArray = responseJSON["results"][0]["address_components"] as List;

  // search result types for the city name
  for (var item in resultsArray) {
    // types are the 2nd index
    var types = item["types"];

    if (types == null) {
      continue;
    }

    if (types.contains("locality")) {
      // locality always shows the city name
      return item["long_name"];
    }
  }

  return "";
}