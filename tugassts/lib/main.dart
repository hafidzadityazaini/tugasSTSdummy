import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tugassts/tugassts/coba.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Column(
          children: [
            SizedBox(
              width: 150, 
              height: 150,
              child: Icon(  
                Icons.shopping_cart,
                size: 100,
                color: Colors.blue,
              ),
            ),

            Text("",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          ],
        ),
        nextScreen: const Belajar(),
        splashIconSize: 200,
        backgroundColor: Colors.white,
        duration: 3000, 
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}