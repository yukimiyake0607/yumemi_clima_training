import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/models/weather_condition.dart';
import 'package:flutter_training/ui/extensions/weather_condition_ext.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required void Function() onReturn, super.key})
      : _onReturn = onReturn;

  final VoidCallback _onReturn;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final YumemiWeather _yumemiWeather = YumemiWeather();
  WeatherCondition? _weatherCondition;
  String? _lowTemperature;
  String? _highTemperature;

  final String _jsonString = '''
{
    "area": "tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}''';

  Future<void> _getWeather() async {
    try {
      final weatherConditionOfJson = _yumemiWeather.fetchWeather(_jsonString);
      final weatherCondition =
          jsonDecode(weatherConditionOfJson) as Map<String, dynamic>;
      setState(() {
        final weather = weatherCondition['weather_condition'];
        _lowTemperature = weatherCondition['min_temperature'].toString();
        _highTemperature = weatherCondition['max_temperature'].toString();
        _weatherCondition = WeatherCondition.from(weather);
      });
    } on YumemiWeatherError catch (e) {
      if (e == YumemiWeatherError.unknown) {
        await _showDialog('もう一度お試しください');
      } else if (e == YumemiWeatherError.invalidParameter) {
        await _showDialog('天気情報を取得できませんでした');
      }
    }
  }

  Future<void> _showDialog(String errorMessage) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                child: _weatherCondition == null
                    ? const Placeholder()
                    : SvgPicture.asset(_weatherCondition!.svgAsset),
              ),
              const SizedBox(height: 16),
              _TemperatureRow(_lowTemperature, _highTemperature),
              const SizedBox(height: 80),
              _ButtonRow(
                getWeather: _getWeather,
                onReturn: widget._onReturn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonRow extends StatelessWidget {
  const _ButtonRow({
    required VoidCallback getWeather,
    required VoidCallback onReturn,
  })  : _onReturn = onReturn,
        _onReloadButtonPressed = getWeather;
  final VoidCallback _onReloadButtonPressed;
  final VoidCallback _onReturn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              _onReturn();
            },
            child: const Text('Close'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: _onReloadButtonPressed,
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}

class _TemperatureRow extends StatelessWidget {
  const _TemperatureRow(this._lowTemp, this._highTemp);
  final String? _lowTemp;
  final String? _highTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _lowTemp != null ? '$_lowTemp℃' : '**℃',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Expanded(
          child: Text(
            _highTemp != null ? '$_highTemp℃' : '**℃',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ],
    );
  }
}
