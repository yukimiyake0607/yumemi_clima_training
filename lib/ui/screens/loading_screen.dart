import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/models/navigate_to_homescreen_mixin.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with NavigateToHomescreenMixin {
  @override
  void initState() {
    super.initState();
    unawaited(
      WidgetsBinding.instance.endOfFrame.then(
        (_) => _navigateToHomeScreen(),
      ),
    );
  }

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
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
