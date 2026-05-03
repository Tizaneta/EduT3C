import 'package:flutter/material.dart';

class HardwareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hardware"),
      ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("Niveles de microprocesador"),
        SizedBox(height: 20),
        Text("Niveles de GPU"),
        SizedBox(height: 20),
        Text("Niveles de fuente de alimentación"),
        SizedBox(height: 20),

        ]
      )
      
    )
    );
  }
}