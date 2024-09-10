import 'package:flutter/material.dart';

class TemperatureRow extends StatelessWidget {
  const TemperatureRow(this._lowTemp, this._highTemp, {super.key});
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
