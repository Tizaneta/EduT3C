import 'package:edut3c/screens/profileScreen.dart';
import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'package:flutter/material.dart';
import 'HardwareScreen.dart';
import 'SocialProfileScreen.dart';
class Home extends StatelessWidget{
@override
  Widget build(BuildContext context){
  return Scaffold(
    body: PageView(
      children: [
        HardwareScreen(),
        SoftwareScreen(),
        NetScreen(),
        Profilescreen(),
        SocialProfileScreen(),
      ],
    )
  );
  }
}