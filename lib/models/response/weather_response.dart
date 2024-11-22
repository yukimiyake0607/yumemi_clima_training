import 'package:flutter_training/models/weather/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    required WeatherCondition? weatherCondition,
    required int? maxTemperature,
    required int? minTemperature,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
