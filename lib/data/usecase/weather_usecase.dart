import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/result/result.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_usecase.g.dart';

@riverpod
WeatherUsecase weatherUsecase(WeatherUsecaseRef ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return WeatherUsecase(weatherRepository);
}

class WeatherUsecase {
  const WeatherUsecase(this.weatherRepository);
  final WeatherRepository weatherRepository;

  Future<Result<WeatherResponse, YumemiWeatherError>> getWeather(
    WeatherRequest request,
  ) async {
    try {
      final weatherData = await weatherRepository.getWeather(request);
      return Result.success(weatherData);
    } on YumemiWeatherError catch (e) {
      return Result.failure(e);
    }
  }
}
