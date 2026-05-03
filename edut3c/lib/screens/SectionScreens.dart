import 'package:flutter/material.dart';
class SectionScreens extends StatelessWidget{
  final String title;
  final  String description;

    const SectionScreens({
      super.key,
      required this.title,
      required this.description,
});
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("Hardware")
    ),
    body: Center(
      child: Text(description),
    )
  );
}
}