import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    required VoidCallback getWeather,
    super.key,
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
