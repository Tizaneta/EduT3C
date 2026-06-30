import 'package:flutter/material.dart';
import 'screens/SignScreen.dart';
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

