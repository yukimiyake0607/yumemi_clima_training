import 'package:yumemi_weather/yumemi_weather.dart';

class CustomWeatherError implements Exception {
  CustomWeatherError(this.error, this.stackTrace);

  final YumemiWeatherError error;
  final StackTrace stackTrace;

  @override
  String toString() => error.toString();
}
