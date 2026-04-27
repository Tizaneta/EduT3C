import 'package:flutter/material.dart';
import 'hardware_screen.dart';
class Home extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("EduT3C")
    ),
    body: Center(
      child: Column(
      children: [
        ElevatedButton(onPressed: (){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => hardware_screen()),
  );
}, child: Text("Hardware")),
        SizedBox(height: 30),
        ElevatedButton(onPressed:(){print("Entraste a SO");}, child: Text("Sistemas Operativos")),
        SizedBox(height: 30),
        ElevatedButton(onPressed: (){print("Entraste a programacion");}, child: Text("Programación")),
        SizedBox(height: 30),
      ]
      ),
      ),
  );
}
}