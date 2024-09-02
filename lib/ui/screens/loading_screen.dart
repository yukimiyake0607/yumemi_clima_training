import 'package:flutter/material.dart';
import 'package:flutter_training/models/navigate_to_homescreen_mixin.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomeScreen();
  }

  void _navigateToHomeScreen() {
    unawaited(
      WidgetsBinding.instance.endOfFrame.then((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            unawaited(
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(onReturn: _navigateToHomeScreen),
                ),
              ),
            );
          }
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
