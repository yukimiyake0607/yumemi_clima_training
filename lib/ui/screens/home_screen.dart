import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/provider/weather_notifier_provider.dart';
import 'package:flutter_training/models/error/custom_weather_error.dart';
import 'package:flutter_training/models/response/weather_response.dart';
import 'package:flutter_training/ui/extensions/api_error_ext.dart';
import 'package:flutter_training/ui/widgets/weather_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _showErrorDialog(
    BuildContext context,
    String errorMessage,
  ) async {
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

    ref.listen<AsyncValue<WeatherResponse>>(
      weatherNotifierProvider,
      (_, next) async {
        next.whenOrNull(
          error: (error, stackTrace) {
            if (error is CustomWeatherError) {
              _showErrorDialog(context, error.error.message);
            }
          },
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
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
