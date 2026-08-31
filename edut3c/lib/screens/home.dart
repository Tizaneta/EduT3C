import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'package:flutter/material.dart';
import 'SocialProfileScreen.dart';
import 'HardwareIntroScreen.dart';
import 'SettingsScreen.dart';
import '../models/user.dart';

class Home extends StatefulWidget {

  final User user;

  const Home({
    super.key,
    required this.user,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final PageController _controller = PageController();

  int currentPage = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.user.username,
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                "XP: ${widget.user.xp}",
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                "Bits: ${widget.user.bits}",
              ),
            ),
          ),
        ],
      ),

      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
        setState(() {
        currentPage = index;
        });},
        children: [
          HardwareIntroScreen(),
          SoftwareScreen(),
          NetScreen(),
          SocialProfileScreen(user: widget.user,),
          SettingsScreen(),
        ],
      ),
    );
  }
}

