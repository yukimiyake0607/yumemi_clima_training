import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/models/error/custom_weather_error.dart';
import 'package:flutter_training/models/weather/weather_condition.dart';
import 'package:flutter_training/models/weather/weather_request.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../mock/yumemi_weather_mock.mocks.dart';

void main() {
  late MockYumemiWeather mockYumemiWeather;
  late WeatherRepository weatherRepository;

  setUp(() {
    mockYumemiWeather = MockYumemiWeather();
    weatherRepository = WeatherRepository(mockYumemiWeather);
  });

  test('WeatherRequest is correctly encoded', () {
    // Arrange
    final weatherRequest =
        WeatherRequest(area: 'tokyo', date: DateTime(2024, 10, 4));

    //Act
    final weatherJsonData = weatherRepository.toJsonString(weatherRequest);

    // Assert
    expect(
      weatherJsonData,
      '{"area":"tokyo","date":"2024-10-04 00:00:00.000"}',
    );
  });

  test('toMap is decoded correctly', () {
    // Arrange
    const weatherDataOfJson = '''
          {"weather_condition":"cloudy","max_temperature":25,"min_temperature":7,"date":"2020-04-01T12:00:00+09:00"}
          ''';

    // Act
    final request = weatherRepository.toMap(weatherDataOfJson);

    // Assert
    final matcher = {
      'weather_condition': 'cloudy',
      'max_temperature': 25,
      'min_temperature': 7,
      'date': '2020-04-01T12:00:00+09:00',
    };
    expect(request, matcher);
  });

  test('If invalid data is entered, toMap will throw an exception', () {
    // Act & Assert
    expect(
      () => weatherRepository.toMap('invalid_data'),
      throwsA(isA<FormatException>()),
    );
  });

  test(
      '''When YumemiWeatherError.unknown is thrown, getWeather throws YumemiWeatherError.unknown''',
      () async {
    // Arrange
    final weatherRequest = WeatherRequest(
      area: 'tokyo',
      date: DateTime(2024, 10, 4),
    );

    // Act
    when(mockYumemiWeather.syncFetchWeather(any))
        .thenThrow(YumemiWeatherError.unknown);

    // Assert
    try {
      await weatherRepository.getWeather(weatherRequest);
      fail('should throw CustomWeatherError');
    } on CustomWeatherError catch (e) {
      expect(e.error, equals(YumemiWeatherError.unknown));
      expect(e.stackTrace, isNotNull);
    }
  });

  test(
    '''When YumemiWeatherError.invalidParameter is thrown, getWeather throws YumemiWeatherError.invalidParameter''',
    () async {
      // Arrange
      final weatherRequest =
          WeatherRequest(area: 'tokyo', date: DateTime(2024, 10, 4));

      when(mockYumemiWeather.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act & Assert
      try {
        await weatherRepository.getWeather(weatherRequest);
        fail('should be YumemiWeatherError.unknown');
      } on CustomWeatherError catch (e) {
        expect(e.error, equals(YumemiWeatherError.invalidParameter));
        expect(e.stackTrace, isNotNull);
      }
    },
  );

  test(
    'getWeather accurately returns weather data',
    () async {
      // Arrange
      final weatherRequest = WeatherRequest(
        area: 'tokyo',
        date: DateTime(2024, 10, 4),
      );
      const expectedWeatherData =
          '''{"weather_condition":"cloudy","max_temperature":25,"min_temperature":7}''';

      when(mockYumemiWeather.syncFetchWeather(any))
          .thenReturn(expectedWeatherData);

      // Act
      final weatherData = await weatherRepository.getWeather(weatherRequest);

      // Assert
      expect(weatherData.weatherCondition, WeatherCondition.cloudy);
      expect(weatherData.maxTemperature, 25);
      expect(weatherData.minTemperature, 7);
    },
  );
}
