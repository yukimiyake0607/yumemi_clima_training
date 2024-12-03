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
  late MockWeatherUsecase mockWeatherUsecase;
  late ProviderContainer container;
  late Listener<AsyncValue<WeatherResponse>> listener;
  late WeatherRequest request;
  const defaultResponse = WeatherResponse(
    weatherCondition: null,
    maxTemperature: null,
    minTemperature: null,
  );

  setUp(() {
    mockWeatherUsecase = MockWeatherUsecase();
    request = WeatherRequest(
      area: 'tokyo',
      date: DateTime(2024, 10, 4),
    );
    container = ProviderContainer(
      overrides: [
        weatherUsecaseProvider.overrideWithValue(mockWeatherUsecase),
      ],
    );
    listener = Listener<AsyncValue<WeatherResponse>>();

    container.listen(
      weatherNotifierProvider,
      listener.call,
      fireImmediately: true,
    );

    verify(
      listener(null, const AsyncValue.data(defaultResponse)),
    ).called(1);
    verifyNoMoreInteractions(listener);
  });

  tearDown(() {
    container.dispose();
  });

  // データ取得に成功パターン
  test(
    '''
    The state of WeatherNotifierProvider changes when weatherData is acquired
    ''',
    () async {
      // Arrange
      const response = WeatherResponse(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 30,
        minTemperature: 20,
      );
      // getWeatherの返り値を固定
      when(mockWeatherUsecase.getWeather(request)).thenAnswer(
        (_) async => const Result<WeatherResponse, CustomWeatherError>.success(
          response,
        ),
      );

      // weatherNotifierProviderの初期値を取得(nullであるかの確認)
      final initialState = container.read(weatherNotifierProvider);
      expect(initialState, isA<AsyncData<WeatherResponse>>());
      expect(
        initialState.value,
        defaultResponse,
      );

      // Act：getWeatherを実行
      await container
          .read(weatherNotifierProvider.notifier)
          .getWeather(request);

      // Assert
      verifyInOrder([
        listener(any, argThat(isA<AsyncLoading<WeatherResponse>>())),
        listener(any, argThat(isA<AsyncData<WeatherResponse>>())),
      ]);

      final finalState = container.read(weatherNotifierProvider);
      expect(finalState, isA<AsyncValue<WeatherResponse>>());
      expect(finalState.value, response);

      verify(mockWeatherUsecase.getWeather(request)).called(1);
      verifyNoMoreInteractions(listener);
    },
  );

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
        expect(finalState, isA<AsyncValue<WeatherResponse>>());
        expect(finalState.value, response);

        verify(mockWeatherUsecase.getWeather(request)).called(1);
        verifyNoMoreInteractions(listener);

        // containerを破棄
        addTearDown(container.dispose);
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
          (_) async => Result<WeatherResponse, CustomWeatherError>.failure(
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
          (_) async => Result<WeatherResponse, CustomWeatherError>.failure(
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
}
