import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'mock/mock.mocks.dart';

void main() {
  group('WeatherRepository tests group', () {
    test('WeatherRequest is correctly encoded', () {
      // Arrange
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository = WeatherRepository(mockYumemiWeather);
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
      const weatherDataOfJson =
          '{"weather_condition":"cloudy","max_temperature":25,"min_temperature":7,"date":"2020-04-01T12:00:00+09:00"}';
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository = WeatherRepository(mockYumemiWeather);

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
      // Arrange
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository = WeatherRepository(mockYumemiWeather);

      // Act
      // 無効な入力
      const invalidData = 'invalid_data';

      // Assert
      expect(
        weatherRepository.toMap(invalidData),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
