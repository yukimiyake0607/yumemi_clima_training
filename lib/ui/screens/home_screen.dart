import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/provider/weather_notifier_provider.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/ui/extensions/api_error_ext.dart';
import 'package:flutter_training/ui/widgets/weather_widget.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showErrorDialog(
    BuildContext context,
    String errorMessage,
  ) {
    Navigator.of(context).pop();
    unawaited(
      showDialog<void>(
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
      ),
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(weatherNotifierProvider);

    ref.listen<AsyncValue<WeatherResponse>>(
      weatherNotifierProvider,
      (_, next) async {
        next.when(
          data: (response) => Navigator.of(context).pop(),
          error: (error, stackTrace) {
            if (error is YumemiWeatherError) {
              _showErrorDialog(context, error.message);
            }
          },
          loading: () => _showLoadingDialog(context),
        );
      },
    );
    return Scaffold(
      body: Center(
        child: weatherData.when(
          data: (weatherData) => WeatherWidget(data: weatherData),
          error: (error, stackTrace) {
            return weatherData.value != null
                ? WeatherWidget(data: weatherData.value!)
                : null;
          },
          loading: () {
            return weatherData.value != null
                ? WeatherWidget(data: weatherData.value!)
                : null;
          },
        ),
      ),
    );
  }
}
