import 'package:flutter/material.dart';
import '../widgets/video_block.dart';

class LevelScreen extends StatefulWidget {
  final int levelNumber;
  final List<Map<String, dynamic>> contenido;

  const LevelScreen({
    super.key,
    required this.levelNumber,
    required this.contenido
    });
  @override
  State<LevelScreen> createState() => _LevelScreenState();
}


class _LevelScreenState extends State<LevelScreen>{

 

@override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(title: Text("Nivel ${widget.levelNumber}")),
    body: 
    PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.contenido.length,
      itemBuilder: (context, index){
        if (widget.contenido[index]["type"] == "video") {
  return VideoBlock(
    assetPath: widget.contenido[index]["path"],
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
          widget.contenido[index]["question"],
          ),
          SizedBox(height: 30),
          ...widget.contenido[index]["options"].map((option) {
          return ElevatedButton(
          onPressed: () {},
          child: Text(option),
          );
          }).toList(),
          ],
        ),),],
  );}
      },
    ),
    );
  }
}
  

  

  
    
