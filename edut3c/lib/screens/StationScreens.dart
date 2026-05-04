import 'package:flutter/material.dart';
class StationScreens extends StatelessWidget{
  final String title;
  final  String description;

    const StationScreens({
      super.key,
      required this.title,
      required this.description,
});
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text(title)
    ),
    body: Center(
      child: Text(description),
    )
  );
}
}