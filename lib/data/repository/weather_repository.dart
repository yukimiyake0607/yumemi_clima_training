import 'dart:convert';

import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  WeatherRepository(this._yumemiWeather);
  final YumemiWeather _yumemiWeather;

  Future<WeatherConditionResponse> getWeather() async {
    final weatherRequest = WeatherRequest(area: 'tokyo', date: DateTime.now());
    final request = jsonEncode(weatherRequest);
    final weatherDataOfJson = _yumemiWeather.fetchWeather(request);
    final response = jsonDecode(weatherDataOfJson) as Map<String, dynamic>;
    final weatherData = WeatherConditionResponse.fromJson(response);
    return weatherData;
  }
}
