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

import '../mock/weather_usecase_mock.mocks.dart';

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

  group('Error cases', () {
    // エラー1パターン:YumemiWeatherError.unknown
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
          listener(any, argThat(isA<AsyncError<WeatherResponse>>())),
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
      verify(
        listener(any, argThat(isA<AsyncLoading<WeatherResponse>>())),
      ).called(1);
      verify(
        listener(any, argThat(isA<AsyncError<WeatherResponse>>())),
      ).called(1);
      final finalState = container.read(weatherNotifierProvider);

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
}
