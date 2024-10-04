import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/models/weather_request.dart';

void main() {
  test('WeatherRequest is correctly encoded', () {
    final weatherRequest =
        WeatherRequest(area: 'tokyo', date: DateTime(2024, 10, 4));
    final jsonString = jsonEncode(weatherRequest);
  });
}
