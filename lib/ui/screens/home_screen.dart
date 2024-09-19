import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/models/weather_condition.dart';
import 'package:flutter_training/models/weather_request.dart';
import 'package:flutter_training/ui/extensions/api_error_ext.dart';
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
  final WeatherRepository _weatherRepository =
      WeatherRepository(YumemiWeather());

  Future<void> _getWeather() async {
    try {
      final weatherData = await _weatherRepository.getWeather();
      await updateState(weatherData);
    } on YumemiWeatherError catch (e) {
      await _showDialog(e.message);
    }
  }

  Future<void> updateState(WeatherConditionResponse weatherData) async {
    setState(() {
      _lowTemperature = weatherData.minTemperature;
      _highTemperature = weatherData.maxTemperature;
      _weatherCondition = weatherData.weatherCondition;
    });
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
              _TemperatureRow(
                _lowTemperature,
                _highTemperature,
              ),
              const SizedBox(height: 80),
              _ButtonRow(
                getWeather: _getWeather,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
