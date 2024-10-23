import 'package:flutter_training/data/usecase/weather_usecase.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_notifier_provider.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  @override
  FutureOr<WeatherResponse> build() {
    return const WeatherResponse(
      weatherCondition: null,
      maxTemperature: null,
      minTemperature: null,
    );
  }

  Future<void> getWeather(WeatherRequest weatherRequest) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(weatherUsecaseProvider);
    final result = await usecase.getWeather(weatherRequest);

    state = result.when(
      success: (data) {
        return AsyncValue.data(data);
      },
      failure: (error) {
        return AsyncValue.error(error, StackTrace.current);
      },
    );
  }
}
