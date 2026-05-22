import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/video_block.dart';
import 'package:flutter/rendering.dart';
import '../widgets/nobackscroll.dart';


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
    Timer? timer;
    int timeLeft = 7;
    void startTimer(){
      timer?.cancel();
      timeLeft = 7;
      timer = Timer.periodic(
        Duration(seconds: 1),
        (timer){
          setState(() {
          timeLeft--;
          if (timeLeft <= 0){
            timer.cancel();
            timeLeft = 7;
            canScroll = true;
            quizAnswered = true;
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("You've run out of time partner!"),
                content: Text("The correct answer was just like ${widget.contenido[currentPage]["correctAnswer"]}"),
                actions: [ElevatedButton.icon(onPressed: (){Navigator.pop(context);}, label: Text("Holy shii"))],
            );
          }
          );
        }
          });
        },
      );
    }
    final PageController pageController = PageController();
    bool canScroll = false;
    bool quizAnswered = false;
    int currentPage = 0;
    
 

@override
  Widget build(BuildContext context){
    final currentType = widget.contenido[currentPage]["type"];
    return Scaffold(
    appBar: AppBar(title: Text("Nivel ${widget.levelNumber}")), 
    body:  
    PageView.builder(
      onPageChanged: (index) {
      setState(() {
      currentPage = index;
      canScroll = false;
      quizAnswered = false;
      final newType = widget.contenido[index]["type"];

      if (newType == "quiz"){startTimer();}
      else{timer?.cancel();}
      });
      },
      controller: pageController,
      physics: canScroll
      ? const NoBackScrollPhysics()
      : const NeverScrollableScrollPhysics(),
      // Usar "type" nos va a permitir que mas adelante podamos 
      // cambiarlo ademas de video y quiz, 
      // por otros tipos de niveles que se piensa integrar
      // mas adelante.
      scrollDirection: Axis.vertical,
      itemCount: widget.contenido.length,
      itemBuilder: (context, index){
        if (widget.contenido[index]["type"] == "video") {
          return VideoBlock(
          assetPath: widget.contenido[index]["path"],
          onVideoFinished: () {
            setState(() {
            canScroll = true;
            });
            },
          );
/*Cuando termina el video:
VideoBlock avisa a
LevelScreen, este recibe el evento,
cambia estado y
habilita scroll*/
        
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
          Text("$timeLeft"),
          Text(
          widget.contenido[index]["question"],
          ),
          SizedBox(height: 30),
          ...widget.contenido[index]["options"].map((option) {
          return ElevatedButton(
          onPressed: quizAnswered
          ? null
          : () 
          {
            setState(() {
          quizAnswered = true;
          timer?.cancel();
          timeLeft = 7;
          canScroll = true;
          });
          final correctAnswer = widget.contenido[index]["correctAnswer"];
      if (option == correctAnswer)
      {
      showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("¡Correcto!"),
        content: Text("que quede flipando chaval"),
        actions: [ElevatedButton(onPressed: ()
        {
          quizAnswered = true;
          Navigator.pop(context);
          }, 
          child: Text("anashiiii"))],
      );
      },
      );
      } else {
      showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("¡Incorrecto!"),
        content: Text("que queres queque? que mandas crack que mandas"),
        actions: [ElevatedButton(onPressed: ()
        {
          quizAnswered = true;
          Navigator.pop(context);
          }, 
          child: Text("te voa a rapta"))],
      );
      },
      );}
          },
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