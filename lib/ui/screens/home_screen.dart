import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/provider/weather_notifier_provider.dart';
import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/ui/extensions/api_error_ext.dart';
import 'package:flutter_training/ui/widgets/weather_widget.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class HomeScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(weatherNotifierProvider);

    ref.listen<AsyncValue<WeatherConditionResponse>>(
      weatherNotifierProvider,
      (_, next) async {
        next.whenOrNull(
          error: (error, stackTrace) {
            if (error is YumemiWeatherError) {
              _showDialog(context, error);
            }
          },
        );
      },
    );
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
