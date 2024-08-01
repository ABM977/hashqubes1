import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashqubes1/splashscreen.dart';

import 'homepage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashScreen(),
        // HomePage()
      // MyHomePage(),
    );
  }
}