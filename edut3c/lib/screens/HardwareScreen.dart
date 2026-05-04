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
          description: "Aca tenes todos los niveles de microprocesador."),
        ),
        );
        }, // Aca termina el boton y abajo esta el child
        child: Text("Microprocesador"),
        ),
        SizedBox(height: 40),

        ElevatedButton(onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => StationScreens(title: "GPU", 
          description: "Aca tenes todos los niveles de GPU.")
        ),
        );
        }, 
        child: Text("GPU")),
         SizedBox(height: 40),

        ElevatedButton(onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => StationScreens(title: "Discos SSD/HDD", 
          description: "En minecraft java existen distintos tipos de abetos")
        
        ),
        );
        }, child: Text("Dispositivos de almacenamiento")),
        SizedBox(height: 40),

        ElevatedButton(onPressed: (){Navigator.push(context,
        MaterialPageRoute(builder:(context) => StationScreens(title: "ya esta flaco cuantos botones mas queres", 
        description: "aca pone algo distinto flaco"),
        )
        );
        }, child: Text("any another device")),
         SizedBox(height: 40),
         
        ]
      )
    
    
    );
  }
}