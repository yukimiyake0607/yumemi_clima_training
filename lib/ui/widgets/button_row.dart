import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/provider/weather_notifier_provider.dart';
import 'package:flutter_training/models/weather/weather_request.dart';

class ButtonRow extends ConsumerWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () => unawaited(
              ref.read(weatherNotifierProvider.notifier).getWeather(
                    WeatherRequest(
                      area: 'tokyo',
                      date: DateTime.now(),
                    ),
                  ),
            ),
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
