import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    required VoidCallback getWeather,
    required VoidCallback onReturn,
    super.key,
  })  : _onReturn = onReturn,
        _onReloadButtonPressed = getWeather;
  final VoidCallback _onReloadButtonPressed;
  final VoidCallback _onReturn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              _onReturn();
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
