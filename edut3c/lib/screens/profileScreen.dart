import 'package:flutter/material.dart';
import 'SocialProfileScreen.dart';

class Profilescreen extends StatefulWidget {
const Profilescreen({Key? key}) : super(key: key);

  @override
  _ProfilescreenState createState() => _ProfilescreenState();


}
class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SocialProfileScreen(),
              ),
            );
          },
          child: const Text('Ir a Social Profile'),
        ),
      ),
    );
  }
}