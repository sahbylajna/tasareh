import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasareeh/common/theme_helper.dart';
import 'package:tasareeh/helpers/dialogs.dart';
import 'package:tasareeh/helpers/ui.dart';
import 'package:tasareeh/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasareeh/helpers/theme.dart';
import 'package:tasareeh/model/success.dart';

import '../api_service.dart';
import '../model/user.dart';

class AccountContent extends StatefulWidget {
  @override
  State<AccountContent> createState() => _AccountContentState();
}

class _AccountContentState extends State<AccountContent> {
  late SharedPreferences prefs;
  User? _user;
  Success? _success;
  @override
  void initState() {
    _getData(context);
    super.initState();
  }

  Future<void> _getData(BuildContext context) async {
    _user = (await ApiService().getuser());
    setState(() {});
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
    }
  }

  Future<void> _handleConfirmation() async {

dialogLoading(context);

_success = (await ApiService().deleteuser());
if(_success?.errors.toString() == ""){
   logout() ;
}
log(_success.toString());

    print("Confirmed action");
  }
   void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تأكيد"),
          content: Text("هل أنت متأكد أنك تريد تنفيذ هذا الإجراء؟"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("مؤكد"),
              onPressed: () {
                _handleConfirmation(); // Call the confirmation action
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Center(child: Text('اللجنة المنضمة لسباق الهجن')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40.0),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              gradient: LinearGradient(
                colors: [primaryColor, accentColor], // Start and end colors
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        body: (_user == null)
            ? MyLoadingWidget()
            : Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Card(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ...ListTile.divideTiles(
                                color: Colors.grey,
                                tiles: [
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(" الاسم"),
                                    subtitle: Text(_user!.firstName),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(" اللقب"),
                                    subtitle: Text(_user!.lastName),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text("بريد إلكتروني"),
                                    subtitle: Text(_user!.email),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone),
                                    title: Text("هاتف"),
                                    subtitle: Text(_user!.phone),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text("ud"),
                                    subtitle: Text(_user!.ud),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          'تسجيل خروج'.toUpperCase(),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        logout();
                      },
                    ),
                  ),

                   SizedBox(height: 30),
                  Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          'حذف خروج'.toUpperCase(),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                         _showConfirmationDialog(context);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
