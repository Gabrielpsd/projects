import 'package:flutter/material.dart';
import 'package:gifsearch/ui/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_page(),
      theme: ThemeData(
        hintColor: Colors.white,
      ),
    ),
  );
}
