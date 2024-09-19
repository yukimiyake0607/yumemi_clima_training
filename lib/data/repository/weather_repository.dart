import 'dart:convert';

import 'package:flutter_training/data/datastore/weather_datastore.dart';
import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/models/weather_request.dart';

class WeatherRepository {
  WeatherRepository(this.weatherDatastore);
  final WeatherDatastore weatherDatastore;

  Future<WeatherConditionResponse> getWeather() async {
    final weatherRequest = WeatherRequest(area: 'tokyo', date: DateTime.now());
    final weatherDataOfJson =
        await weatherDatastore.fetchWeather(weatherRequest);
    final response = jsonDecode(weatherDataOfJson) as Map<String, dynamic>;
    final weatherData = WeatherConditionResponse.fromJson(response);
    return weatherData;
  }
}
