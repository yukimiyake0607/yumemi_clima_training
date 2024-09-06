enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  factory WeatherCondition.from(dynamic value) {
    return WeatherCondition.values.singleWhere((condition) {
      return condition.name == value;
    });
  }
}
