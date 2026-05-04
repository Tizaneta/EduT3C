import 'package:flutter/material.dart';
import 'StationScreens.dart';

class HardwareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hardware"),
      ),
      body: 
      ListView(
        padding: EdgeInsets.all(20),
        children: [
        ElevatedButton(onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => StationScreens(title: "Microprocesador", 
          levels: 7,
          ),
        ),
        );
        }, // Aca termina el boton y abajo esta el child
        child: Text("Microprocesador"),
        ),
        SizedBox(height: 40),

        ElevatedButton(onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => StationScreens(title: "GPU",
          levels: 5, 
          )
        ),
        );
        }, 
        child: Text("GPU")),
         SizedBox(height: 40),

        ElevatedButton(onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => StationScreens(title: "Discos SSD/HDD", 
          levels: 5,
          )
        
        ),
        );
        }, child: Text("Dispositivos de almacenamiento")),
        SizedBox(height: 40),

        ElevatedButton(onPressed: (){Navigator.push(context,
        MaterialPageRoute(builder:(context) => StationScreens(title: "cuantos botones queres", 
        levels: 3
        ),
        )
        );
        }, child: Text("any another device")),
         SizedBox(height: 40),
         
        ]
      )
    
    
    );
  }
}