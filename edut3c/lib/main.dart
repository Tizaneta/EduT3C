import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/RegisterScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterScreen(),);

  }

}