import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'package:flutter/material.dart';
import 'HardwareScreen.dart';
/*class Home extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("EduT3C")
    ),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
        ElevatedButton(onPressed: (){
        Navigator.push
        (context,
        MaterialPageRoute(builder: (context) => HardwareScreen()),);
        }, 
    child: Text("Hardware")),
        SizedBox(height: 60),
        ElevatedButton(onPressed:(){Navigator.push
        (context, 
        MaterialPageRoute(builder:(context) => SoftwareScreen()),);
        }, 
    child: Text("Software")),
        SizedBox(height: 60),
        ElevatedButton(onPressed: (){Navigator.push
        (context, 
        MaterialPageRoute(builder: (context) => NetScreen()));
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(30),
          backgroundColor: const Color.fromARGB(255, 255, 255, 250),  
        ),
    child: Text("Redes")),
        SizedBox(height: 60),
      ]
      ),
      ),
  );
}
}
*/
class Home extends StatelessWidget{
@override
  Widget build(BuildContext context){
  return Scaffold(
    body: PageView(
      children: [
        HardwareScreen(),
        SoftwareScreen(),
        NetScreen(),
      ],
    )
  );
  }
}