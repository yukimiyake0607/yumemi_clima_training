import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/models/error/custom_weather_error.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/weather/weather_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_repository.g.dart';

@riverpod
WeatherRepository weatherRepository(Ref ref) {
  return WeatherRepository(YumemiWeather());
}

class WeatherRepository {
  WeatherRepository(this._yumemiWeather);
  final YumemiWeather _yumemiWeather;

  Future<WeatherResponse> getWeather(
    WeatherRequest weatherRequest,
  ) async {
    try {
      final request = toJsonString(weatherRequest);
      final weatherDataOfJson = _yumemiWeather.fetchWeather(request);
      final response = toMap(weatherDataOfJson);
      final weatherData = WeatherResponse.fromJson(response);
      return weatherData;
    } on YumemiWeatherError catch (e, stackTrace) {
      throw CustomWeatherError(e, stackTrace);
    }
  }

  @visibleForTesting
  String toJsonString(WeatherRequest weatherRequest) {
    final request = jsonEncode(weatherRequest);
    return request;
  }

  @visibleForTesting
  Map<String, dynamic> toMap(String weatherDataOfJson) {
    final response = jsonDecode(weatherDataOfJson) as Map<String, dynamic>;
    return response;
  }
}
