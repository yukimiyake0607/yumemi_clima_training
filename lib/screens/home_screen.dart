import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
}

extension WeatherConditionExtension on WeatherCondition {
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final YumemiWeather yumemiWeather = YumemiWeather();
  WeatherCondition? weatherCondition;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  Future<void> _getWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final condition = yumemiWeather.fetchSimpleWeather();
      setState(() {
        switch (condition) {
          case 'sunny':
            weatherCondition = WeatherCondition.sunny;
            break;
          case 'cloudy':
            weatherCondition = WeatherCondition.cloudy;
            break;
          case 'rainy':
            weatherCondition = WeatherCondition.rainy;
            break;
          default:
            throw Exception('Unknown weather condition: $condition');
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching weather: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Placeholder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '**℃',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '**℃',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Close'),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Reload'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
