import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_notifier_provider.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  @override
  FutureOr<WeatherConditionResponse> build() {
    return const WeatherConditionResponse(
      weatherCondition: null,
      maxTemperature: null,
      minTemperature: null,
    );
  }

  Future<void> getWeather(WeatherRequest weatherRequest) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final provider = ref.read(weatherRepositoryProvider);
        final weatherData = await provider.getWeather(weatherRequest);
        return weatherData;
      } on YumemiWeatherError {
        rethrow;
      }
    });
  }
}
