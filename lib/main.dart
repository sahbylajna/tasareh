import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tasareeh/splash_screen.dart';

// SharedPreferences? SharedPref;
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لوحة تحكم التصاريح',
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Color.fromARGB(234, 176, 74, 1)),
        textTheme: GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),
        tabBarTheme: TabBarTheme(labelStyle: GoogleFonts.tajawal(), unselectedLabelStyle: GoogleFonts.tajawal()),
      ),
      debugShowCheckedModeBanner: false,
      // home: MyWidget(),
      home: Directionality(textDirection: TextDirection.rtl, child: SplashScreen(title: "Splash Screen")), //SharedPref != null ? MyHomePage() :
      initialRoute: '/',
    );
  }
}
