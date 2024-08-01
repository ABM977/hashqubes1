import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/c green.json", // Ensure this path is correct
            width: 200, // Adjust width as needed
            height: 200, // Adjust height as needed
          ),
          Container(height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    child: Text(
                      "Hash",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff244a3f),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3,),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    child: Text(
                      "Qubes",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff244a3f),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      nextScreen: HomePage(), // Navigate to HomePage after the splash screen

      splashIconSize: 300, // Adjust as needed
      splashTransition: SplashTransition.fadeTransition, // Optional: Adjust splash transition

    );
  }
}
