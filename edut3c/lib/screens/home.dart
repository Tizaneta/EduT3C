import 'package:edut3c/screens/profileScreen.dart';
import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'SoftwareScreenP.dart';
import 'package:flutter/material.dart';
//import 'HardwareScreen.dart';
import 'SocialProfileScreen.dart';
import 'hardware_map_screen.dart';
import 'HardwareIntroScreen.dart';


class Home extends StatelessWidget{
@override
  Widget build(BuildContext context){
  return Scaffold(
    body: PageView(
      children: [
        HardwareIntroScreen(),
        SoftwareScreenPP(),
        SoftwareScreen(),
        NetScreen(),
        Profilescreen(),
        SocialProfileScreen(),
        HardwareMapScreen(),
      ],
    )
  );
  }
}