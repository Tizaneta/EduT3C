import 'package:flutter/material.dart';

class StationScreens extends StatelessWidget{
  final String title;
  final int levels;
    const StationScreens({
      super.key,
      required this.title,
      required this.levels,
});
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text(title)
    ),
    body: ListView.builder(
      itemCount: levels,
      itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(onPressed: (){
            debugPrint("Entraste al nivel $index.");
          }, 
          child: Text("Nivel ${index + 1}")
          ),


        );
      },
      )
    /*body: Column(
      children: [Text(description),
       Text("Nivel $levels")
      ]
    )*/
  );
}
}