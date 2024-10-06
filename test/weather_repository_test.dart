import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'mock/mock.mocks.dart';

void main() {
  group('WeatherRepository tests group', () {
    test('WeatherRequest is correctly encoded', () {
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository = WeatherRepository(mockYumemiWeather);
      final weatherRequest =
          WeatherRequest(area: 'tokyo', date: DateTime(2024, 10, 4));

      final weatherJsonData = weatherRepository.toJsonString(weatherRequest);

      expect(
        weatherJsonData,
        '{"area":"tokyo","date":"2024-10-04 00:00:00.000"}',
      );
    });
  });
}
