import 'package:edut3c/screens/HardwareScreen.dart';
import 'package:edut3c/screens/NetScreen.dart';
import 'package:edut3c/screens/SoftwareScreen.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),);

  }

}