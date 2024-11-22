import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/models/error/custom_weather_error.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/result/result.dart';
import 'package:flutter_training/models/weather/weather_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_usecase.g.dart';

@riverpod
WeatherUsecase weatherUsecase(WeatherUsecaseRef ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return WeatherUsecase(weatherRepository);
}

class WeatherUsecase {
  const WeatherUsecase(this.weatherRepository);
  final WeatherRepository weatherRepository;

  Future<Result<WeatherResponse, CustomWeatherError>> getWeather(
    WeatherRequest request,
  ) async {
    try {
      final weatherData = await weatherRepository.getWeather(request);
      return Result.success(weatherData);
    } on CustomWeatherError catch (e, stackTrace) {
      return Result.failure(e, stackTrace);
    } on Exception catch (e, stackTrace) {
      return Result.failure(e, stackTrace);
    }
  }
}
