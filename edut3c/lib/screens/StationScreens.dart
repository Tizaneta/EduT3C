import 'package:flutter/material.dart';
import 'LevelScreen.dart';
class StationScreens extends StatelessWidget{
  final Map<int, List<Map<String, dynamic>>> levelsData;
  final String title;
  final int levels;
    const StationScreens({
      super.key,
      required this.levelsData,
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
          child: ElevatedButton(onPressed: (){Navigator.push(
    context,
    MaterialPageRoute(
     builder: (context) => LevelScreen(
  levelNumber: index + 1,
  contenido: levelsData[index + 1]!,
),
    ),);
          }, 
          child: Text("Nivel ${index + 1}")
          ),
        );
      },
      )
  );
}
}