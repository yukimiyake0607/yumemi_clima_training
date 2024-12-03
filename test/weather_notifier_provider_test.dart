import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/provider/weather_notifier_provider.dart';
import 'package:flutter_training/data/usecase/weather_usecase.dart';
import 'package:flutter_training/models/error/custom_weather_error.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/result/result.dart';
import 'package:flutter_training/models/weather/weather_condition.dart';
import 'package:flutter_training/models/weather/weather_request.dart';
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
      'YumemiWeatherError.unknown returns AsyncError state.',
      () async {
        // Arrange
        final stackTrace = StackTrace.current;
        final expectedError = CustomWeatherError(
          YumemiWeatherError.unknown,
          stackTrace,
        );

        when(mockWeatherUsecase.getWeather(request)).thenAnswer(
          (_) async => Result<WeatherResponse, Exception>.failure(
            expectedError,
            stackTrace,
          ),
        );

        // Act
        await container
            .read(weatherNotifierProvider.notifier)
            .getWeather(request);

        // Assert
        final finalState = container.read(weatherNotifierProvider);
        expect(finalState, isA<AsyncError<WeatherResponse>>());

        final actualError = finalState.error! as CustomWeatherError;
        expect(actualError.error, equals(YumemiWeatherError.unknown));
        expect(actualError.stackTrace, equals(stackTrace));

        verifyInOrder([
          listener(any, argThat(isA<AsyncLoading<WeatherResponse>>())),
          listener(any, argThat(isA<AsyncData<WeatherResponse>>())),
        ]);
        verifyNoMoreInteractions(listener);
      },
    );

    // エラー2パターン:YumemiWeatherError.invalidParameter
    test(
      'YumemiWeatherError.unknown returns AsyncError state.',
      () async {
        // Arrange
        final stackTrace = StackTrace.current;
        final expectedError = CustomWeatherError(
          YumemiWeatherError.invalidParameter,
          stackTrace,
        );

        when(mockWeatherUsecase.getWeather(request)).thenAnswer(
          (_) async => Result<WeatherResponse, Exception>.failure(
            expectedError,
            stackTrace,
          ),
        );

        // Act
        await container
            .read(weatherNotifierProvider.notifier)
            .getWeather(request);

        // Assert
        final finalState = container.read(weatherNotifierProvider);
        expect(finalState, isA<AsyncError<WeatherResponse>>());

        final actualError = finalState.error! as CustomWeatherError;
        expect(actualError.error, equals(YumemiWeatherError.invalidParameter));
        expect(actualError.stackTrace, equals(stackTrace));

        verifyInOrder([
          listener(any, argThat(isA<AsyncLoading<WeatherResponse>>())),
          listener(any, argThat(isA<AsyncError<WeatherResponse>>())),
        ]);
        verifyNoMoreInteractions(listener);
      },
    );
  });

  // エラー1パターン:YumemiWeatherError.unknown
  test(
    '''
    When YumemiWeatherError.unknown is returned,
    state changes to AsyncError containing it
    ''',
    () async {
      // Arrange
      final mockWeatherUsecase = MockWeatherUsecase();
      final request =
          WeatherRequest(area: 'tokyo', date: DateTime(2024, 10, 4));
      const defaultResponse = WeatherResponse(
        weatherCondition: null,
        maxTemperature: null,
        minTemperature: null,
      );
      when(mockWeatherUsecase.getWeather(request)).thenAnswer(
        (_) async => Result<WeatherResponse, CustomWeatherError>.failure(
          CustomWeatherError(YumemiWeatherError.unknown, StackTrace.current),
        ),
      );
      final container = ProviderContainer(
        overrides: [
          weatherUsecaseProvider.overrideWithValue(mockWeatherUsecase),
        ],
      );
      final listener = Listener<AsyncValue<WeatherResponse>>();
      container.listen(
        weatherNotifierProvider,
        listener.call,
        fireImmediately: true,
      );

      // この時点でListenerのデフォルト値が呼び出されているはず
      verify(listener(null, const AsyncValue.data(defaultResponse))).called(1);
      verifyNoMoreInteractions(listener);

      expect(
        container.read(weatherNotifierProvider),
        const AsyncValue.data(defaultResponse),
      );

      // Act：getWeatherを実行
      await container
          .read(weatherNotifierProvider.notifier)
          .getWeather(request);

      // Assert
      final finalState = container.read(weatherNotifierProvider);
      expect(
        finalState,
        isA<AsyncError<WeatherResponse>>(),
      );
      expect(finalState.error, YumemiWeatherError.unknown);
      verifyInOrder([
        listener(any, argThat(isA<AsyncLoading<WeatherResponse>>())),
        listener(any, argThat(isA<AsyncError<WeatherResponse>>())),
      ]);
      verifyNoMoreInteractions(listener);
    },
  );

  // エラー2パターン:YumemiWeatherError.invalidParameter
  test(
    '''
    When YumemiWeatherError.invalidParameter is returned,
    state changes to AsyncError containing it
    ''',
    () async {
      // Arrange
      // mockWeatherUsecase.getWeatherが実行できるように設定
      final mockWeatherUsecase = MockWeatherUsecase();
      final request = WeatherRequest(
        area: 'tokyo',
        date: DateTime(2024, 10, 4),
      );
      const defaultResponse = WeatherResponse(
        weatherCondition: null,
        maxTemperature: null,
        minTemperature: null,
      );
      when(mockWeatherUsecase.getWeather(request)).thenAnswer(
        (_) async => Result<WeatherResponse, CustomWeatherError>.failure(
          CustomWeatherError(
            YumemiWeatherError.invalidParameter,
            StackTrace.current,
          ),
        ),
      );

      // stateが変化するたびListenerを実行
      final listener = Listener<AsyncValue<WeatherResponse>>();

      // providerを監視できるようにProviderContainerを設定
      final container = ProviderContainer(
        overrides: [
          weatherUsecaseProvider.overrideWithValue(mockWeatherUsecase),
        ],
      );
      container.listen(
        weatherNotifierProvider,
        listener.call,
        fireImmediately: true,
      );

      // この時点でListenerのデフォルト値が呼び出されているはず
      verify(
        listener(
          null,
          const AsyncData(defaultResponse),
        ),
      ).called(1);
      verifyNoMoreInteractions(listener);
      expect(
        container.read(weatherNotifierProvider),
        const AsyncData(defaultResponse),
      );

      // Act：weatherNotifierProvider.getWeatherを実行
      await container
          .read(weatherNotifierProvider.notifier)
          .getWeather(request);

      // Assert
      verify(
        listener(any, argThat(isA<AsyncLoading<WeatherResponse>>())),
      ).called(1);
      verify(
        listener(any, argThat(isA<AsyncError<WeatherResponse>>())),
      ).called(1);
      final finalState = container.read(weatherNotifierProvider);

      // AsyncErrorが獲得できているかチェック
      expect(
        finalState,
        isA<AsyncError<WeatherResponse>>(),
      );
      expect(finalState.error, YumemiWeatherError.invalidParameter);
      verifyNoMoreInteractions(listener);
    },
  );
}
