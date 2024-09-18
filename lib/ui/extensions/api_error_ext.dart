import 'package:yumemi_weather/yumemi_weather.dart';

extension YumemiWeatherErrorExt on YumemiWeatherError {
  String get message {
    switch (this) {
      case YumemiWeatherError.invalidParameter:
        return '無効な入力です。入力内容をご確認ください';
      case YumemiWeatherError.unknown:
        return '天気情報の取得に失敗しました。再度時間をおいてお試しください。';
    }
  }
}
