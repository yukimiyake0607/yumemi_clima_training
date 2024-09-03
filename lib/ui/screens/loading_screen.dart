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
    unawaited(navigateToHomeScreen());
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
