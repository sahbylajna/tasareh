import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tasareeh/screens/book.dart';
import 'package:tasareeh/screens/entryAfter.dart';
import 'package:tasareeh/screens/entry.dart';
import 'package:tasareeh/screens/exit.dart';
import 'package:tasareeh/screens/exitAfter.dart';

Color _primaryColor = Color.fromARGB(234, 176, 74, 1);
Color _accentColor = Color.fromARGB(255, 90, 42, 8);

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // bool _isLoading = true;
  String users = "";
  // count? _count;
  // String importations = '-1';
  // String exports = '0';
  // String backs = '0';
  @override
  void initState() {
    super.initState();
    _fetchData(context);
  }

  void _fetchData(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      users = prefs.getString('first_name') ?? '';
      // _count = await ApiService().getcount();
      // exports = _count!.exports;
      // importations = _count!.importations;
      // backs = _count!.backs;
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }

    // setState(() {
    //   _isLoading = false;
    // });
    // _isLoading
    //             ? MyLoadingWidget()
    //             :
  }

  @override
  Widget build(context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              toolbarHeight: 100,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_accentColor, _primaryColor], // Add your colors here
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', width: 80, height: 80),
                  Text('مرحبا بك $users', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 40, height: 40), // Empty SizedBox for spacing
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      title: "دخول للمشاركة",
                      image: 'assets/in.png',
                      action: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => JoinScreen()), (route) => true),
                    ),
                    RoundedButton(
                      title: "دخول بعد المشاركة",
                      image: 'assets/in.png',
                      action: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => JoinAfterScreen()), (route) => true),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      title: "خروج للمشاركة",
                      image: 'assets/out.png',
                      action: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OutContent()), (route) => true),
                    ),
                    RoundedButton(
                      title: "خروج بعد المشاركة",
                      image: 'assets/out.png',
                      action: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OutafterContent()), (route) => true),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                RoundedButton(
                  title: "قائمة طلبات",
                  icon: Icon(Icons.book_outlined, size: 30, color: Color.fromARGB(255, 153, 117, 96)),
                  action: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BookContent()), (route) => true),
                  fixedSize: Size(330, 80),
                ),
                SizedBox(height: 80),
              ],
            ))));
  }
}

class RoundedButton extends StatelessWidget {
  final String title;
  final String? image;
  final Widget? icon;
  final Function() action;
  final Size? fixedSize;
  const RoundedButton({
    super.key,
    required this.title,
    required this.action,
    this.image,
    this.icon,
    this.fixedSize = const Size(145, 120),
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: action,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: _primaryColor),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
        backgroundColor: Colors.white,
        elevation: 10,
        fixedSize: fixedSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          if (image != null) Image.asset(image!, height: 50, width: 50),
          if (icon != null) icon!,
          SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: _accentColor),
          ),
        ],
      ),
    );
  }
}
