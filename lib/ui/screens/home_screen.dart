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
      builder: (_) => const Center(
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
        await next.whenOrNull(
          error: (error, stackTrace) {
            if (error is CustomWeatherError) {
              _showErrorDialog(context, error.error.message);
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
          error: (error, _) {
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
