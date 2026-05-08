import 'package:flutter/material.dart';
import '../widgets/video_block.dart';

class LevelScreen extends StatefulWidget {
  final int levelNumber;

  const LevelScreen({
    super.key,
    required this.levelNumber
    });
  @override
  State<LevelScreen> createState() => _LevelScreenState();
}


class _LevelScreenState extends State<LevelScreen>{

final List<Map<String, dynamic>> contenido = [
    {
      "type": "video",
      "path": "assets/videos/test.mp4",
    },

    {
      "type": "quiz",
      "question": "¿Qué hace la CPU?",
    },
  ];

@override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(title: Text("Nivel ${widget.levelNumber}")),
    body: 
    PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: contenido.length,
      itemBuilder: (context, index){
        if (contenido[index]["type"] == "video") {
  return VideoBlock(
    assetPath: contenido[index]["path"],
  );
} else {
  return Stack( //podes poner widgets uno encima de otro.
    children: [
  Container(
      decoration: BoxDecoration(
      color: const Color.fromARGB(255, 4, 125, 206),
    ),
    ),
  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
          contenido[index]["question"],
          style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          ),),
          SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text("se caga en tus muertos"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Procesa las instrucciones de entrada"),
            ),],
        ),),],
  );}
      },
    ),
    );
  }
}
  

  

  
    
