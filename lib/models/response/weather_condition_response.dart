import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_condition_response.freezed.dart';
part 'weather_condition_response.g.dart';

@freezed
class WeatherConditionResponse with _$WeatherConditionResponse {
  const factory WeatherConditionResponse({
    required String weatherCondition,
    required int maxTemperature,
    required int minTemperature,
  }) = _WeatherConditionResponse;

  factory WeatherConditionResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionResponseFromJson(json);
}
