import 'package:flutter/material.dart';

class WeatherTypes {
  static const SUN = 0;
  static const RAIN = 1;
  static const CLOUDS = 2;
  static const FOG = 3;
  static const SNOW = 4;
  static const RAIN_WIND = 5;
  static const SUN_CLOUDS = 6;
  static const SUN_CLOUDS_RAIN = 7;
  static const THUNDER_LIGHTNING = 8;
  static const WIND = 9;

  static AssetImage getImageForType(int type) {
    switch (type) {
      case WeatherTypes.SUN:
        return AssetImage('images/sun.png');
      case WeatherTypes.RAIN:
        return AssetImage('images/rain.png');
      case WeatherTypes.CLOUDS:
        return AssetImage('images/clouds.png');
      case WeatherTypes.FOG:
        return AssetImage('images/fog.png');
      case WeatherTypes.SNOW:
        return AssetImage('images/snow.png');
      case WeatherTypes.RAIN_WIND:
        return AssetImage('images/rain_wind.png');
      case WeatherTypes.SUN_CLOUDS:
        return AssetImage('images/sun_clouds.png');
      case WeatherTypes.SUN_CLOUDS_RAIN:
        return AssetImage('images/sun_clouds_rain.png');
      case WeatherTypes.THUNDER_LIGHTNING:
        return AssetImage('images/thunder_lightning.png');
      case WeatherTypes.WIND:
        return AssetImage('images/wind.png');
      default:
        return null;
    }
  }
}