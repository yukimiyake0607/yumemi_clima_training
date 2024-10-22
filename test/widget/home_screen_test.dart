import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/usecase/weather_usecase.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/result/result.dart';
import 'package:flutter_training/models/weather_condition.dart';
import 'package:flutter_training/ui/screens/home_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../mock/weather_usecase_mock.mocks.dart';

final mockWeatherUsecase = MockWeatherUsecase();

void main() {
  group('description', () {
    testWidgets('Display a sunny image', (tester) async {
      // Arrange
      const weatherResponse = WeatherResponse(
        weatherCondition: WeatherCondition.sunny,
        maxTemperature: 20,
        minTemperature: 30,
      );

      // weatherUsecaseProviderが呼び出された場合の挙動を設定
      when(mockWeatherUsecase.getWeather(any)).thenAnswer(
        (_) async => const Result<WeatherResponse, YumemiWeatherError>.success(
          weatherResponse,
        ),
      );

      // HomeScreenのインスタンスを生成
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherUsecaseProvider.overrideWithValue(mockWeatherUsecase),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      // 初期状態を確認
      expect(find.byType(Placeholder), findsOneWidget);

      // Act
      await tester.tap(find.widgetWithText(TextButton, 'Reload'));

      await tester.pump();

      // Assert
      // 晴れの画像が表示されているかの確認
      final svgPicture = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(svgPicture.bytesLoader, isA<SvgAssetLoader>());
      expect(
        (svgPicture.bytesLoader as SvgAssetLoader).assetName,
        equals('assets/sunny.svg'),
      );
    });
  });
}
