import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'SoftwareScreenP.dart';
import 'package:flutter/material.dart';
import 'HardwareScreen.dart';
import 'SocialProfileScreen.dart';
import 'HardwareIntroScreen.dart';
import 'SettingsScreen.dart';


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
        SocialProfileScreen(),
        SettingsScreen(),
      ],
    )
  );
  }
}