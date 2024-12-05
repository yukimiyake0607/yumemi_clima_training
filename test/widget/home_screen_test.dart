import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/usecase/weather_usecase.dart';
import 'package:flutter_training/models/error/custom_weather_error.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/models/result/result.dart';
import 'package:flutter_training/models/weather/weather_condition.dart';
import 'package:flutter_training/ui/extensions/api_error_ext.dart';
import 'package:flutter_training/ui/screens/home_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../mock/weather_usecase_mock.mocks.dart';

final mockWeatherUsecase = MockWeatherUsecase();
const _reloadButtonText = 'Reload';

void main() {
  group('WidgetTests of Home Screen', () {
    testWidgets('Display a sunny image', (tester) async {
      // Arrange
      const weatherResponse = WeatherResponse(
        weatherCondition: WeatherCondition.sunny,
        maxTemperature: 20,
        minTemperature: 30,
      );

      // weatherUsecaseProviderが呼び出された場合の挙動を設定
      when(mockWeatherUsecase.getWeather(any)).thenAnswer(
        (_) async => const Result<WeatherResponse, Exception>.success(
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
      await tester.tap(find.widgetWithText(TextButton, _reloadButtonText));

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

    testWidgets('display a cloudy image', (tester) async {
      // Arrange
      // ウィジェットツリーを生成
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

      // 天気情報のデータを設定
      const response = WeatherResponse(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 30,
        minTemperature: 20,
      );
      when(mockWeatherUsecase.getWeather(any)).thenAnswer(
        (_) async => const Result<WeatherResponse, Exception>.success(response),
      );

      // 初期状態のHomeScreenにPlaceholderが表示されているか確認
      expect(find.byType(Placeholder), findsOneWidget);

      // Act
      await tester.tap(find.widgetWithText(TextButton, _reloadButtonText));
      await tester.pump();

      // Assert
      // SvgPictureウィジェットが存在するか
      expect(find.byType(SvgPicture), findsOneWidget);

      final svgPicture = tester.widget<SvgPicture>(find.byType(SvgPicture));

      // svgPictureがアセットから読み込まれているか確認
      expect(svgPicture.bytesLoader, isA<SvgAssetLoader>());
      final svgAsset = svgPicture.bytesLoader as SvgAssetLoader;
      expect(svgAsset.assetName, equals('assets/cloudy.svg'));
    });

  testWidgets('display a rainy image', (tester) async {
    // Arrange
    // テスト環境にウィジェットツリーを生成
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

    // ウィジェット内にPlaceholderが生成されているか
    expect(find.byType(Placeholder), findsOneWidget);

    // Reloadボタンを押した時の返り値を設定
    const response = WeatherResponse(
      weatherCondition: WeatherCondition.rainy,
      maxTemperature: 30,
      minTemperature: 20,
    );
    when(mockWeatherUsecase.getWeather(any))
        .thenAnswer((_) async => const Result.success(response));

    // Act
    await tester.tap(find.widgetWithText(TextButton, _reloadButtonText));
    await tester.pump();

    // Assert
    // SvgPictureを確認
    expect(find.byType(SvgPicture), findsOneWidget);
    // rainy.svgが表示されているか確認
    final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(svgWidget.bytesLoader, isA<SvgAssetLoader>());
    final svgAsset = svgWidget.bytesLoader as SvgAssetLoader;
    expect(svgAsset.assetName, equals('assets/rainy.svg'));
  });

  testWidgets('display a max temperature', (tester) async {
    // Arrange
    // テスト環境にウィジェットツリー生成
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

    // プロバイダーの返り値を設定
    const response = WeatherResponse(
      weatherCondition: WeatherCondition.sunny,
      maxTemperature: 30,
      minTemperature: 20,
    );
    when(mockWeatherUsecase.getWeather(any))
        .thenAnswer((_) async => const Result.success(response));

    // Act
    await tester.tap(find.widgetWithText(TextButton, _reloadButtonText));
    await tester.pump();

    // Assert
    // 最高気温が表示されているか確認
    expect(find.text('30℃'), findsOneWidget);
  });

  testWidgets('display a min temperature', (tester) async {
    // Arrange
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

    // プロバイダーの返り値を設定
    const response = WeatherResponse(
      weatherCondition: WeatherCondition.sunny,
      maxTemperature: 30,
      minTemperature: 20,
    );
    when(mockWeatherUsecase.getWeather(any))
        .thenAnswer((_) async => const Result.success(response));

    // Act
    await tester.tap(find.widgetWithText(TextButton, _reloadButtonText));
    await tester.pump();

    // Assert
    expect(find.text('20℃'), findsOneWidget);
  });

  testWidgets(
    'a display when YumemiWeatherError.unknown is received',
    (tester) async {
      // Arrange
      // テスト環境にウィジェットツリーを生成
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

      // ウィジェット内にPlaceholderが生成されているか
      expect(find.byType(Placeholder), findsOneWidget);

      // Reloadボタンを押した時の返り値を設定
      const response = WeatherResponse(
        weatherCondition: WeatherCondition.rainy,
        maxTemperature: 30,
        minTemperature: 20,
      );
      when(mockWeatherUsecase.getWeather(any))
          .thenAnswer((_) async => const Result.success(response));

      // Act
      await tester.tap(find.widgetWithText(TextButton, _reloadButtonText));
      await tester.pump();

      // Assert
      // SvgPictureを確認
      expect(find.byType(SvgPicture), findsOneWidget);
      // rainy.svgが表示されているか確認
      final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(svgWidget.bytesLoader, isA<SvgAssetLoader>());
      final svgAsset = svgWidget.bytesLoader as SvgAssetLoader;
      expect(svgAsset.assetName, equals('assets/rainy.svg'));
    });

    testWidgets('display a max temperature', (tester) async {
      // Arrange
      // テスト環境にウィジェットツリー生成
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

      // プロバイダーの返り値を設定
      const response = WeatherResponse(
        weatherCondition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 20,
      );
      when(mockWeatherUsecase.getWeather(any))
          .thenAnswer((_) async => const Result.success(response));

      // Act & Assert
      expect(find.byType(AlertDialog), findsNothing);

      // Reloadボタンをタップ
      await tester.tap(find.widgetWithText(TextButton, _reloadButtonText));
      await tester.pump();
      await tester.pumpAndSettle();

      // Assert
      // 最高気温が表示されているか確認
      expect(find.text('30℃'), findsOneWidget);
    });

    testWidgets('display a min temperature', (tester) async {
      // Arrange
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

      // プロバイダーの返り値を設定
      const response = WeatherResponse(
        weatherCondition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 20,
      );
      when(mockWeatherUsecase.getWeather(any))
          .thenAnswer((_) async => const Result.success(response));

      // Act
      await tester.tap(find.widgetWithText(TextButton, 'Reload'));
      await tester.pump();

      // Assert
      expect(find.text('20℃'), findsOneWidget);
    });

    testWidgets(
      'a display when YumemiWeatherError.unknown is received',
      (tester) async {
        // Arrange
        // テスト環境にウィジェットツリーを生成
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

        // プロバイダーの戻り値をYumemiWeatherError.unknownに設定
        when(mockWeatherUsecase.getWeather(any)).thenAnswer(
          (_) async => const Result.failure(YumemiWeatherError.unknown),
        );

        // Act
        await tester.tap(find.widgetWithText(TextButton, 'Reload'));
        await tester.pump();

        // Assert
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text(YumemiWeatherError.unknown.message), findsOneWidget);
      },
    );

    testWidgets(
      'a display when YumemiWeatherError.invalidParameter is received',
      (tester) async {
        // Arrange
        // テスト環境にウィジェットツリーを生成
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

        // プロバイダーの戻り値を設定
        when(mockWeatherUsecase.getWeather(any)).thenAnswer(
          (_) async =>
              const Result.failure(YumemiWeatherError.invalidParameter),
        );

        // Act
        await tester.tap(find.widgetWithText(TextButton, 'Reload'));
        await tester.pump();

        // Assert
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(
          find.text(YumemiWeatherError.invalidParameter.message),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      '''
        The CircularProgressIndicator is displayed on the screen when data is being acquired
        ''',
      (tester) async {
        // Arrange
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

        when(mockWeatherUsecase.getWeather(any)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          return const Result.success(
            WeatherResponse(
              weatherCondition: WeatherCondition.cloudy,
              maxTemperature: 30,
              minTemperature: 20,
            ),
          );
        });

        // この時点でCircularProgressIndicatorは表示されていない
        expect(find.byType(CircularProgressIndicator), findsNothing);

        // Act
        await tester.tap(find.widgetWithText(TextButton, 'Reload'));
        await tester.pump();

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // 非同期処理の完了を待つ
        await tester.pumpAndSettle();
      },
    );
  });
}
