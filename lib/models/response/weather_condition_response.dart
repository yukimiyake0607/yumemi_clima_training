// 保存時の自動整形でfoundationが消えないように警告を消している
// ignore: unused_import, directives_ordering
import 'package:flutter/foundation.dart';
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
