import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_training/ui/screens/home_screen.dart';

mixin NavigateToHomescreenMixin<T extends StatefulWidget> on State<T> {
  void navigateToHomeScreen() {
    unawaited(
      WidgetsBinding.instance.endOfFrame.then(
        (_) {
          if (!mounted) {
            return;
          }
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!mounted) {
              return;
            }

            unawaited(
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(onReturn: navigateToHomeScreen),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
