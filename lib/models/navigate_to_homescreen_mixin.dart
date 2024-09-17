import 'dart:async';
import 'package:flutter/material.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  Future<void> navigateToHomeScreen() async {
    await WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (!mounted) {
          return;
        }
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) {
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => HomeScreen(onReturn: navigateToHomeScreen),
            ),
          );
        });
      },
    );
  }
}

