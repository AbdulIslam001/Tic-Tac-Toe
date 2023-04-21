import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/splashScreens/startingSplashScreen.dart';

void main() {
  runApp(
     const MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.orange,
      // ),
      debugShowCheckedModeBanner: false,
      home: StartingSplashScreen(),
    ),
  );
}