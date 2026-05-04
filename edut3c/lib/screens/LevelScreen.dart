import 'HardwareScreen.dart';
import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'StationScreens.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatelessWidget {
  final int levelNumber;
  LevelScreen({required this.levelNumber});
  final List<String> contenido = [
    "Video",
    "Cuestionario",
    "Video",
    "Cuestionario",
    "Video",
    "Cuestionario",
    "Video",
    "Cuestionario",
    "Video",
    "Cuestionario",
    "Video",
    "Cuestionario",
  ];

  @override

  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(title: Text("Nivel $levelNumber")),
    body: 
    ListView.builder(
      itemCount: contenido.length,
      itemBuilder: (context, index){
        if (contenido[index] == "video") {
  return Container(
    height: 200,
    margin: EdgeInsets.all(10),
    color: Colors.black12,
    child: Center(
      child: Text("Video del nivel $levelNumber"),
    ),
  );
} else {
  return Container(
    margin: EdgeInsets.all(10),
    child: Column(
      children: [
        Text("Pregunta del nivel $levelNumber"),
        ElevatedButton(
          onPressed: () {},
          child: Text("Opción A"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("Opción B"),
        ),
      ],
    ),
  );
}
      }
    )
    );
  }
}
