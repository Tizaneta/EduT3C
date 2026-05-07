import 'HardwareScreen.dart';
import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'StationScreens.dart';
import 'package:flutter/material.dart';
import '../widgets/video_block.dart';

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
    PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: contenido.length,
      itemBuilder: (context, index){
        if (contenido[index] == "Video") {
  return VideoBlock(
    assetPath: "assets/videos/test.mp4",
  );
} else {
  return Stack(
    children: [
    Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 125, 206),
        ),
    ),
      Center(
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
            ),],
        ),),],
  );}
      },
    ),
    );
  }
}
  
    
