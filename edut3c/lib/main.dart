import 'package:flutter/material.dart';
import 'screens/SignScreen.dart';
import 'screens/home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RegisterScreen(),);

  }
}

