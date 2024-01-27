import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(child: Text("YUBU", style: TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold),)),
      nextScreen: HomePage(),
      backgroundColor: Colors.green,
      splashIconSize: 450,
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: Duration(seconds: 2),
    );
  }
}