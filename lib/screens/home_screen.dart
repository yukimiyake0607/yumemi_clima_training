import 'package:flutter/foundation.dart';
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
  WeatherCondition weatherCondition = WeatherCondition.sunny;
  bool isLoading = false;
  String? errorMessage;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: _buildWeatherDisplay(),
              ),
              const SizedBox(height: 16),
              _buildTemperatureDisplay(),
              const SizedBox(height: 80),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDisplay() {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else if (errorMessage != null) {
      return Text(
        errorMessage!,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      );
    } else {
      return SvgPicture.asset(weatherCondition.svgAsset);
    }
  }

  Widget _buildTemperatureDisplay() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '**℃',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Expanded(
          child: Text(
            '**℃',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: _getWeather,
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<YumemiWeather>('yumemiWeather', yumemiWeather),
    );
    properties.add(
      EnumProperty<WeatherCondition?>('weatherCondition', weatherCondition),
    );
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
    properties.add(StringProperty('errorMessage', errorMessage));
  }
}
