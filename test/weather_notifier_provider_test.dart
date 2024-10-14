import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/provider/weather_notifier_provider.dart';
import 'package:flutter_training/data/usecase/weather_usecase.dart';
import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/models/result/result.dart';
import 'package:flutter_training/models/weather_condition.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'mock/weather_usecase_mock.mocks.dart';

class Listener<T> extends Mock {
  void call(T? previous, T? current);
}

void main() {
  group('WeatherNotifierProvider tests group', () {
    // データ取得に成功パターン
    test(
      '''
    The state of WeatherNotifierProvider changes when weatherData is acquired
    ''',
      () async {
        // Arrange
        final mockWeatherUsecase = MockWeatherUsecase();
        final container = ProviderContainer(
          overrides: [
            weatherUsecaseProvider.overrideWithValue(mockWeatherUsecase),
          ],
        );
        final request = WeatherRequest(
          area: 'tokyo',
          date: DateTime(2024, 10, 4),
        );
        const response = WeatherConditionResponse(
          weatherCondition: WeatherCondition.cloudy,
          maxTemperature: 30,
          minTemperature: 20,
        );
        // getWeatherの返り値を固定
        when(mockWeatherUsecase.getWeather(request)).thenAnswer(
          (_) async => const Result<WeatherConditionResponse,
              YumemiWeatherError>.success(response),
        );

        final listener = Listener<AsyncValue<WeatherConditionResponse>>();
        container.listen(
          weatherNotifierProvider,
          listener.call,
          fireImmediately: true,
        );

        // この時点でListenerはデフォルトの値が呼び出されているはず
        verify(
          listener(
            null,
            const AsyncValue.data(
              WeatherConditionResponse(
                weatherCondition: null,
                maxTemperature: null,
                minTemperature: null,
              ),
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(listener);

        // weatherNotifierProviderの初期値を取得(nullであるかの確認)
        final initialState = container.read(weatherNotifierProvider);
        expect(initialState, isA<AsyncData<WeatherConditionResponse>>());
        expect(
          initialState.value,
          const WeatherConditionResponse(
            weatherCondition: null,
            maxTemperature: null,
            minTemperature: null,
          ),
        );

        // Act：getWeatherを実行
        await container
            .read(weatherNotifierProvider.notifier)
            .getWeather(request);

        // Assert
        verify(mockWeatherUsecase.getWeather(request)).called(1);

        final finalState = container.read(weatherNotifierProvider);
        expect(finalState, isA<AsyncValue<WeatherConditionResponse>>());
        expect(finalState.value, response);
      },
    );
  });
  // エラー1パターン
  // エラー2パターン
}
