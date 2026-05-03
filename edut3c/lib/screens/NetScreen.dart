import 'package:flutter/material.dart';
  class NetScreen extends StatelessWidget{
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Text("Redes")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Entraste a redes."),
            Text("Ya aprendi a usar children xdddddd")
          ],
          ),
          ),
        );
    }
  }