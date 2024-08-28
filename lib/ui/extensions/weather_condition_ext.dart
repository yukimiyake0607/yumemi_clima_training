import 'package:flutter_training/models/weather_condition.dart';

extension WeatherConditionExt on WeatherCondition {
  String get svgAsset {
    switch (this) {
      case WeatherCondition.sunny:
        return 'assets/sunny.svg';
      case WeatherCondition.cloudy:
        return 'assets/cloudy.svg';
      case WeatherCondition.rainy:
        return 'assets/rainy.svg';
    }
  }
}
