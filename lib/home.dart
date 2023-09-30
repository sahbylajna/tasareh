
import 'package:flutter/material.dart';
import 'package:tasareeh/screens/home.dart';
import 'package:tasareeh/screens/account.dart';

import 'package:tasareeh/screens/settings.dart';
import 'package:tasareeh/login.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
 // TabController? _tabController;
  void reLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('ud') != null) {
      setState(() {
      });
    } else {
      prefs.remove('adminName');
      prefs.remove(
        'uid',
      );
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

    }
  }

 Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
Widget? _child;

  @override
  void initState() {
    _child = HomeContent();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor:_accentColor,
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [

            FluidNavBarIcon(
                icon: Icons.account_circle,
                backgroundColor: _accentColor,
                extras: {"label": "account"}),
            FluidNavBarIcon(
                icon: Icons.home,
                backgroundColor: _accentColor,
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.notifications,
                backgroundColor: _accentColor,
                extras: {"label": "notifications"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
            iconSelectedForegroundColor: Colors.white,
              iconUnselectedForegroundColor: Colors.white60),
          scaleFactor: 1.5,
          defaultIndex: 1,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = AccountContent();
          break;
        case 1:
          _child = HomeContent();
          break;
        case 2:
          _child = SettingsContent();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
