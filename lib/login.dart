// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasareeh/common/theme_helper.dart';
import 'package:tasareeh/helpers/dialogs.dart';
import 'package:tasareeh/helpers/ui.dart';
import 'package:tasareeh/model/token.dart';
import 'package:tasareeh/model/user.dart';
import 'package:tasareeh/register.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/model/contrie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:tasareeh/helpers/theme.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = SharedPreferences.getInstance();
  late List<Contries> _contrie = [];
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  Contries? _selectedValue;
  bool _isLoading = true;
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _contrie = (await ApiService().getcontries())!;

    _isLoading = false;
    setState(() {
  
    });
  }

  //
  //
  //
  //
  //
  //
  //
  //
  login() async {
    if (phone.text.isEmpty || password.text.isEmpty || _selectedValue == null) {
      dialogError(context, message: 'رقم الهاتف أو كلمة المرور غير صحيحة');

      return;
    }

    dialogLoading(context);
    Token token = (await ApiService().login(phone.text, password.text, _selectedValue!.id.toString()))!;
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }

    if (token.error.isNotEmpty) {
      if(token.error == 'في إنتظار تفعيل حسابك.'){

        dialogErroropt(context, message: token.error,id:token.accessToken);
      }
      dialogError(context, message: token.error);
      return;
    }
    log(token.accessToken.toString());
    final user = await SharedPreferences.getInstance();
    user.setString('phone', phone.text);
    user.setString('token', token.accessToken);

    User? user0 = (await ApiService().getuser())!;
    user.setString('phone', user0.phone);
    user.setString('first_name', user0.firstName);
    user.setString('last_name', user0.lastName);
    user.setString('email', user0.email);
    user.setString('ud', user0.ud);
    user.setInt('contry_id', user0.contryId);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10), // This will be the login form
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
                                      Expanded(
                                        child: Container(
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                          child: TextField(
                                            controller: phone,
                                            decoration: ThemeHelper().textInputDecoration('الهاتف', 'أدخل رقم هاتفك'),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Stack(
                                        children: [
                                          Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100.0),
                                                  border: Border.all(color: Colors.deepPurple.shade300, style: BorderStyle.solid, width: 0.80),
                                                ),
                                                child: DropdownButton<Contries>(
                                                  hint: Text('اختر دولتك'),
                                                  value: _selectedValue,
                                                  icon: Icon(Icons.check_circle_outline),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  style: TextStyle(color: Colors.deepPurple),
                                                  underline: Container(height: 0),
                                                  onChanged: (newValue) => setState(() => _selectedValue = newValue),
                                                  items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                                    return DropdownMenuItem<Contries>(value: value, child: Text('+${value.phonecode}'));
                                                  }).toList(),
                                                ),
                                              )),
                                          if (_isLoading)
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: appColor.withOpacity(0.4),
                                                  borderRadius: BorderRadius.circular(100.0),
                                                  border: Border.all(color: Colors.deepPurple.shade300, style: BorderStyle.solid, width: 0.8),
                                                ),
                                                child: InputLoadingWidget(),
                                              ),
                                            )
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10.0),

                                  Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Container(
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
                                      onPressed: login,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                        child: Text(
                                          'تسجيل الدخول'.toUpperCase(),
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: "ليس لديك حساب؟ ",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                          },
                                      ),
                                    ])),
                                  ),
                                ],
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
