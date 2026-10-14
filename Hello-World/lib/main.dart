
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MeuApp());
}
class MeuApp extends StatelessWidget{
  const MeuApp({super.key});
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Guia de Viagem",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: HomePage(),
    );
  }
}