import 'package:flutter/material.dart';
import 'package:flutter_training/models/weather_request.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    required Future<void> Function(WeatherRequest) getWeather,
    super.key,
  }) : _onReloadButtonPressed = getWeather;
  final Future<void> Function(WeatherRequest) _onReloadButtonPressed;

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
            onPressed: () async => _onReloadButtonPressed(
              WeatherRequest(
                area: 'tokyo',
                date: DateTime.now(),
              ),
            ),
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
