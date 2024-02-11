import 'package:app_artificial_intelligence/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
