import 'package:freezed_annotation/freezed_annotation.dart';
part 'weather_condition_request.freezed.dart';
part 'weather_condition_request.g.dart';

@freezed
class WeatherConditionRequest with _$WeatherConditionRequest {
  const factory WeatherConditionRequest({
    required String area,
    required DateTime date,
  }) = _WeatherConditionRequest;

  factory WeatherConditionRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionRequestFromJson(json);
}
