import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'package:flutter/material.dart';
import 'HardwareScreen.dart';
class Home extends StatelessWidget{
@override
  Widget build(BuildContext context){
  return Scaffold(
    body: PageView(
      children: [
        HardwareScreen(),
        SoftwareScreen(),
        NetScreen(),
      ],
    )
  );
  }
}