enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  factory WeatherCondition.from(String value) {
    return WeatherCondition.values.singleWhere((condition) {
      return condition.name == value;
    });
  }
}
