import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_repository.g.dart';

@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return WeatherRepository(YumemiWeather());
}

class WeatherRepository {
  WeatherRepository(this._yumemiWeather);
  final YumemiWeather _yumemiWeather;

  Future<WeatherResponse> getWeather(
    WeatherRequest weatherRequest,
  ) async {
    final request = toJsonString(weatherRequest);
    final weatherDataOfJson =
        await compute(_yumemiWeather.syncFetchWeather, request);
    final response = toMap(weatherDataOfJson);
    final weatherData = WeatherResponse.fromJson(response);
    return weatherData;
  }

  String toJsonString(WeatherRequest weatherRequest) {
    final request = jsonEncode(weatherRequest);
    return request;
  }

  Map<String, dynamic> toMap(String weatherDataOfJson) {
    final response = jsonDecode(weatherDataOfJson) as Map<String, dynamic>;
    return response;
  }
}
