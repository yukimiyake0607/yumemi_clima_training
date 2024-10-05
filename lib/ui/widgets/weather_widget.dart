import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/data/provider/weather_notifier_provider.dart';
import 'package:flutter_training/models/response/weather_condition_response.dart';
import 'package:flutter_training/ui/extensions/weather_condition_ext.dart';
import 'package:flutter_training/ui/widgets/button_row.dart';
import 'package:flutter_training/ui/widgets/temperature_row.dart';

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({
    required WeatherResponse data,
    super.key,
  }) : _data = data;

  final WeatherResponse _data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: _data.weatherCondition == null
                ? const Placeholder()
                : SvgPicture.asset(_data.weatherCondition!.svgAsset),
          ),
          const SizedBox(height: 16),
          TemperatureRow(
            _data.minTemperature,
            _data.maxTemperature,
          ),
          const SizedBox(height: 80),
          ButtonRow(
            getWeather: ref.read(weatherNotifierProvider.notifier).getWeather,
          ),
        ],
      ),
    );
  }
}
