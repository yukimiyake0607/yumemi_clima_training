import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/models/request/weather_condition_request.dart';
import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/models/weather_condition.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:flutter_training/ui/extensions/weather_condition_ext.dart';
import 'package:flutter_training/ui/widgets/button_row.dart';
import 'package:flutter_training/ui/widgets/temperature_row.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherCondition? _weatherCondition;
  int? _lowTemperature;
  int? _highTemperature;
  final YumemiWeather _yumemiWeather = YumemiWeather();
  WeatherCondition? _weatherCondition;
  int? _lowTemperature;
  int? _highTemperature;

  static final WeatherRequest _weatherRequest =
      WeatherRequest(area: 'tokyo', date: DateTime.now());
  final _request = jsonEncode(_weatherRequest.toJson());

  Future<void> _getWeather() async {
    try {
      final weatherConditionOfJson = _yumemiWeather.fetchWeather(_request);
      final weatherCondition =
          jsonDecode(weatherConditionOfJson) as Map<String, dynamic>;
      setState(() {
        final weather = weatherCondition['weather_condition'] as String;
        _lowTemperature = weatherCondition['min_temperature'] as int?;
        _highTemperature = weatherCondition['max_temperature'] as int?;
        _weatherCondition = WeatherCondition.from(weather);
      });
    } on YumemiWeatherError catch (e) {
      await _errorMessage(e);
    }
  }

  Future<WeatherConditionResponse> _fetchWeatherCondition() async {
    final request =
        WeatherConditionRequest(area: 'Tokyo', date: DateTime.now());
    final json = jsonEncode(request);
    final weatherConditionOfRequest = _yumemiWeather.fetchWeather(json);
    final weatherConditionOfMap =
        jsonDecode(weatherConditionOfRequest) as Map<String, dynamic>;
    final response = WeatherConditionResponse.fromJson(weatherConditionOfMap);
    return response;
  }

  void _updateWeatherState(WeatherConditionResponse response) {
    setState(() {
      final weather = response.weatherCondition;
      _lowTemperature = response.minTemperature;
      _highTemperature = response.maxTemperature;
      _weatherCondition = WeatherCondition.from(weather);
    });
  }

  Future<void> _errorMessage(YumemiWeatherError e) async {
    switch (e) {
      case YumemiWeatherError.invalidParameter:
        await _showDialog('もう一度お試しください');
        break;
      case YumemiWeatherError.unknown:
        await _showDialog('天気情報を取得できませんでした');
        break;
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
              TemperatureRow(
                _lowTemperature,
                _highTemperature,
              ),
              const SizedBox(height: 80),
              ButtonRow(
                getWeather: _getWeather,
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
  }) : _onReloadButtonPressed = getWeather;
  final VoidCallback _onReloadButtonPressed;

  @override
  Widget build(BuildContext context) {
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
  final int? _lowTemp;
  final int? _highTemp;

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
