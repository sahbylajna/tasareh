import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasareeh/common/theme_helper.dart';
import 'package:tasareeh/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasareeh/screens/constants.dart';
import 'package:tasareeh/screens/home.dart';

import '../api_service.dart';
import '../model/user.dart';

class AccountContent extends StatefulWidget {
  @override
  _AccountContentState createState() => _AccountContentState();

}



class _AccountContentState extends State<AccountContent> {
  late SharedPreferences prefs;
   Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
  User?  _user;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getData(context);

    });
  }

    Future<void> _getData(BuildContext context) async {


      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.network(    'https://lottie.host/66e2a97f-0826-425b-bca6-d7e1ee74f757/YmBvSTB48I.json'),                  SizedBox(height: 15),
                  Text('...تحميل'),

                ],
              ),
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
      }));
    _user = (await ApiService().getuser());
      if(_user != null){
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
          }
        });
      }

  }


    void logout() async {
    final prefs = await SharedPreferences.getInstance();

      prefs.clear();

     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);


  }
  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 2),child:Text("Loading" )),
        ],),
    );
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pop(true);
          });
          return alert;
        });
  }
  @override
  Widget build(BuildContext context) {


     if(_user == null){
  Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
         showAlertDialog(context);
       }));
       return  Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
           appBar:AppBar(
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
                   colors: [_primaryColor, _accentColor], // Start and end colors
                   begin: Alignment.centerLeft,
                   end: Alignment.centerRight,
                 ),
               ),
             ),
           ),
    body: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: defaultPadding),
              )
       )

       );

     }else{
       return Directionality(
           textDirection: TextDirection.rtl,
           child:Scaffold(
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
                   colors: [_primaryColor, _accentColor], // Start and end colors
                   begin: Alignment.centerLeft,
                   end: Alignment.centerRight,
                 ),
               ),
             ),
           ),
    body:Directionality(
         textDirection: TextDirection.rtl,

         child: Column(
           children: <Widget>[

             Card(
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
             Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('تسجيل خروج'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: ()  {
                                    logout();

                                },
                              ),
                            ),
           ],
         ),
       )
       ));
     }

  }
}
