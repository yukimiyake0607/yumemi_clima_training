import 'dart:convert';

import 'package:flutter_training/models/weather_request.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherDatastore {
  WeatherDatastore(this._yumemiWeather);
  final YumemiWeather _yumemiWeather;

  Future<String> fetchWeather(WeatherRequest weatherRequest) async {
    final request = jsonEncode(weatherRequest);
    final weatherDataOfJson = _yumemiWeather.fetchWeather(request);
    return weatherDataOfJson;
  }
}
