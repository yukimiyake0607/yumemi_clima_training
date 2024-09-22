import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/ui/mixins/navigate_to_homescreen_mixin.dart';
import 'package:flutter_training/ui/screens/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with AfterLayoutMixin {
  Future<void> _navigateToHomeScreen() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
    await _navigateToHomeScreen();
  }

  @override
  Future<void> navigateToHomeScreen() {
    return _navigateToHomeScreen();

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
