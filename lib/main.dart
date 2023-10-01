import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasareeh/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasareeh/splash_screen.dart';

SharedPreferences? SharedPref;
main()  {
   
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


    Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'لوحة تحكم التصاريح',

      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: _primaryColor,
          ),
          textTheme: GoogleFonts.tajawalTextTheme(
            Theme.of(context).textTheme,
          ),
          tabBarTheme: TabBarTheme(
            labelStyle: GoogleFonts.tajawal(),
            unselectedLabelStyle: GoogleFonts.tajawal(),
          )),
      debugShowCheckedModeBanner: false,

      home:   Directionality( // add this
        textDirection: TextDirection.rtl, // set this property
        child:  SharedPref != null ? MyHomePage() : SplashScreen(title: "Splash Screen"),
      ),
      initialRoute: '/',
    );
  }



}

