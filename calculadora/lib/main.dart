import 'package:calculadora/homeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';

enum Operation {
  nothing,
  plus,
  divide,
  minus,
  multi,
  plusZero,
  percent,
  Ac,
  equal
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
