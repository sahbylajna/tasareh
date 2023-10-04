
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasareeh/common/theme_helper.dart';
import 'package:tasareeh/model/token.dart';
import 'package:tasareeh/model/user.dart';
import 'package:tasareeh/register.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/model/contrie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasareeh/screens/constants.dart';
import 'package:tasareeh/screens/home.dart';
import 'home.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage>{
 final user = SharedPreferences.getInstance();
      late List<Contries> _contrie = [];
      
    Contries? _selectedValue;
 Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
 late bool _isLoading =true;
@override
  void initState() {
    super.initState();
     setState(() {
        _isLoading = false;
         _getData(context);
      });
     Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
         _getData(context);
      });
    });
   
  }
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  void _getData(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();

 if(prefs.getString('ud') != null){

print(prefs.getString('first_name'));

        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);
    }else{

          setState(() async {
        _contrie = (await ApiService().getcontries())!;
    });
      

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
                Lottie.network(    'https://lottie.host/66e2a97f-0826-425b-bca6-d7e1ee74f757/YmBvSTB48I.json'),                SizedBox(height: 15),
                Text('...تحميل'),

              ],
            ),
          ),
        );
      },
    );
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
      // Close the dialog
    }
  
}

  }
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screen =  MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    Text(
                      'مرحبًا',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'سجل الدخول إلى حسابك',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [


                        Row(

                          children: [


                            SizedBox(
                                width: screen.width * 0.45,

                                child:Container(
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextField(
                                    controller: phone,
                                    decoration: ThemeHelper().textInputDecoration('الهاتف', 'أدخل رقم هاتفك'),
                                    keyboardType: TextInputType.number,),

                                )),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child:Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: Colors.deepPurple.shade300, style: BorderStyle.solid, width: 0.80),
                                  ),
                                  child: DropdownButton<Contries>(

                                    //isDense: true,
                                    hint: Text('اختر دولتك'),
//isDense: true,
                                    //    isExpanded: true,
                                    value: _selectedValue,

                                    icon: Icon(Icons.check_circle_outline),
                                    iconSize: 24,
                                    elevation: 16,
                                    //style: ThemeHelper().buttonStyle(),
                                    style: TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue[300],
                                    ),
                                    onChanged:( newValue) {
                                      setState(() {
                                        _selectedValue = newValue;
                                        //  contry_id =_contrie.indexOf();
                                      });
                                    },
                                    items:
                                    _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                      return DropdownMenuItem<Contries>(
                                        value:  value ,
                                        child: Text('+${value.phonecode}' ),
                                      );
                                    }).toList(),
                                  ),
                                )

                            ),


                          ],
                        ) ,

                            SizedBox(height: 10.0),

                            Directionality(
      textDirection: TextDirection.rtl,
      child:Container(
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextField(
                                obscureText: true,
                                controller: password,
                                decoration: ThemeHelper().textInputDecoration('كلمة المرور', 'ادخل رقمك السري'),
                              ),
                            )),
                            SizedBox(height: 15.0),
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(10,0,10,20),
                            //   alignment: Alignment.topRight,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //      // Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                            //     },
                            //     child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('تسجيل الدخول'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: () async {
                                    if (phone.text.isEmpty || password.text.isEmpty || _selectedValue == null) {
                                        showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("إنتباه",
                                        'رقم الهاتف أو كلمة المرور غير صحيحة' ,
                                          context);
                                    },
                                  );
                                    }
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
 Lottie.asset('assets/loading.json'),
              SizedBox(height: 15),
              Text('...تحميل'),

            ],
          ),
        ),
      );
    },
  );



                                    Token token = (await ApiService().login(phone.text,password.text,_selectedValue!.id.toString()))!;
                                      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
     

      }
                                    if(token.error.isNotEmpty){
                                           showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("إنتباه",
                                       token.error,
                                          context);
                                    },
                                  );
                                    }else{


                                  final user = await SharedPreferences.getInstance();
                                    user.setString('phone',phone.text);
                                    user.setString('token',token.accessToken);

                                    User?  user0 = (await ApiService().getuser())!;
                                    if (user0 != null) {
                         user.setString('phone',user0.phone);
         user.setString('first_name',user0.firstName);
         user.setString('last_name',user0.lastName);
         user.setString('email',user0.email);
         user.setString('ud',user0.ud);

         user.setInt('contry_id',user0.contryId);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));

                                    }
           

                                    }


                                    //_selectedValue!.id
                                  //After successful login we will redirect to profile page. Let's create profile page now
                              //
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "ليس لديك حساب؟ ",
                                    recognizer: TapGestureRecognizer()
                                        ..onTap = () async {

                                         Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },),

                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    ));

  }
}
