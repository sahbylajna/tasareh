import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasareeh/home.dart';

import 'package:tasareeh/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    checkAuth();
    super.initState();
  }

  bool auth = false;
  void checkAuth() async {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => auth ? MyHomePage() : LoginPage()), (route) => false);
    });

    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('ud') != null) {
      auth = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color.fromARGB(234, 176, 74, 1);
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
        splash: Image.asset('assets/logo.png', width: 200.0, height: 150.0),
        nextScreen: LoginPage(),
        duration: 10000,
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: accentColor,
      ),
    );
  }
}
