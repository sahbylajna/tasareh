import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:tasareeh/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    Timer(const Duration(milliseconds: 4000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      });
    });

    Timer(
      Duration(milliseconds: 50),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {
  // GlobalKey<State> _dialogKey = GlobalKey<State>();
  Color primaryColor = Color.fromARGB(234,176,74,1);
  Color accentColor = Color.fromARGB(255, 90, 42, 8);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, accentColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedSplashScreen(
        splash:  Image.asset('assets/logo.png',
         width: 200.0, // Set the desired width
  height: 150.0, // Set the desired height
        ) ,
        nextScreen: LoginPage() ,
        duration: 3000,
        splashTransition: SplashTransition.rotationTransition,

            backgroundColor: accentColor
        // duration: Duration(milliseconds: 1200),
        // child: Center(
        //   child: Container(
        //     height: 140.0,
        //     width: 140.0,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.3),
        //           blurRadius: 2.0,
        //           offset: Offset(5.0, 3.0),
        //           spreadRadius: 2.0,
        //         )
        //       ]
        //     ),
        //     child: Center(
        //       child: ClipOval(
        //         child: Image.asset('assets/logo.png'), //put your logo here
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
