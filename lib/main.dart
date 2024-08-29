import 'package:flutter/material.dart';
import 'package:flutter_training/ui/screens/loading_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoadingScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          error: Colors.red,
          primary: Colors.blue,
        ),
      ),
    );
  }
}
