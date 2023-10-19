import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasareeh/animation/wrapper.dart';
import 'package:tasareeh/common/theme_helper.dart';
import 'package:tasareeh/helpers/dialogs.dart';
import 'package:tasareeh/helpers/theme.dart';
import 'package:tasareeh/helpers/ui.dart';
import 'package:tasareeh/model/success.dart';
import 'package:tasareeh/term.dart';
import 'package:tasareeh/widgets/header_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';
import 'model/contrie.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  Contries? _selectedValue;
  Contries? _selectedValue1;
  late List<Contries> _contrie = [];
  final _formKey = GlobalKey<FormState>();
  // bool checkedValue = false;
  bool checkboxValue = false;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fistname = TextEditingController();
  TextEditingController ud = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController adresse = TextEditingController();
  File? _imageFile;
  File? _imageFile2;
  bool _isLoading = true;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    _contrie = (await ApiService().getcontries())!;
    setState(() {
      _isLoading = false;
    });
  }

  register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_selectedValue == null) {
      dialogError(context, message: 'يرجى تحديد دولتك');
      return;
    }
    if (_selectedValue1 == null) {
      dialogError(context, message: 'يرجى تحديد رمز الدولة لهاتفك');
      return;
    }
    if (_imageFile == null || _imageFile2 == null) {
      dialogError(context, message: 'يرجى إرفاق صور الهوية');
      return;
    }
    // showUpload(context);
    ctrl.startAnimation?.call();
    // await Future.delayed(Duration(seconds: 5));
    // return;

    final bytes = _imageFile?.readAsBytesSync();
    String base64Image1 = "data:image/png;base64,${base64Encode(bytes!)}";
    final bytes2 = _imageFile2?.readAsBytesSync();
    String base64Image2 = "data:image/png;base64,${base64Encode(bytes2!)}";

    Success success = (await ApiService().register(
      fistname.text,
      lastname.text,
      phone.text,
      password.text,
      email.text,
      ud.text,
      _selectedValue!.id.toString(),
      _selectedValue1!.id.toString(),
      base64Image1.toString(),
      base64Image2.toString(),
      '0',
      '0',
      '0',
    ))!;
    print(success.message);

    if (!mounted) {
      return;
    }
    // Navigator.of(context, rootNavigator: true).pop();
    if (success.message != 'success') {
      ctrl.finishAnimationWithFailure?.call();
      dialogError(context, message: 'رقم الهاتف أو كلمة المرور غير صحيحة');
    } else {
      ctrl.finishAnimationWithSuccess?.call();
      final user = await SharedPreferences.getInstance();
      user.setString('id', success.id.toString());
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TermContent()), (Route<dynamic> route) => false);
    }
  }

  final AnimatorCtrl ctrl = AnimatorCtrl();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: UploadWrapper(
            animatorCtrl: ctrl,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: 150,
                    child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      title: Text('إنشاء حساب'),
                      centerTitle: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration('الاسم الأول', 'أدخل اسمك الأول'),
                                  controller: fistname,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "أدخل  اسمك الأول ";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration('اسم العائلة', 'أدخل اسم العائلة الخاص بك'),
                                  controller: lastname,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "أدخل  اسمك العائلة ";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: email,
                                  decoration: ThemeHelper().textInputDecoration("بريد إلكتروني", "أدخل بريدك الإلكتروني"),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val == null ||
                                        val.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)) {
                                      return "أدخل عنوان بريد إلكتروني صحيحًا";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration("رقم الهوية", "أدخل رقم الهوية"),
                                  controller: ud,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val == null || val.isEmpty || !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                      return "أدخل رقم هوية صحيحًا";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  validator: (value) => (value == null || value.isEmpty) ? 'يرجى تحديد العنوان' : null,
                                  decoration: ThemeHelper().textInputDecoration("العنوان", "أدخل  العنوان"),
                                  controller: adresse,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100.0),
                                      border: Border.all(color: Colors.deepPurple.shade300, style: BorderStyle.solid, width: 0.8),
                                    ),
                                    child: DropdownButtonFormField<Contries>(
                                      validator: (value) => (value == null) ? 'يرجى تحديد دولتك' : null,
                                      hint: Text('اختر دولتك'),
                                      value: _selectedValue1,
                                      isExpanded: true,
                                      icon: Icon(Icons.check_circle_outline),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.deepPurple),
                                      onChanged: (newValue1) {
                                        setState(() {
                                          _selectedValue1 = newValue1;
                                          _selectedValue ??= newValue1;
                                        });
                                      },
                                      items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                        return DropdownMenuItem<Contries>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                    ),
                                  ),
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
                              SizedBox(height: 12.0),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                    "رقم الهاتف",
                                    "أدخل رقم هاتفك",
                                    _selectedValue1?.phonecode == null
                                        ? null
                                        : Padding(
                                            padding: const EdgeInsets.only(top: 18, right: 10),
                                            child: Text(_selectedValue1?.phonecode != null ? '+${_selectedValue1!.phonecode}' : '-'),
                                          ),
                                  ),
                                  controller: phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (val == null || val.isEmpty || !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                      return "أدخل رقم هاتف صحيحًا";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Row(
                                children: [
                                  Text("الصورة الامامية للهوية"),
                                  Spacer(),
                                  Container(
                                    decoration: ThemeHelper().buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        log(pickedImage!.path);
                                        setState(() {
                                          log(pickedImage.path);
                                          _imageFile = File(pickedImage.path);
                                        });
                                      },
                                      child: Icon(Icons.photo, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  Container(
                                    decoration: ThemeHelper().buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                                        log(pickedImage!.path);
                                        setState(() {
                                          log(pickedImage.path);
                                          _imageFile = File(pickedImage.path);
                                        });
                                      },
                                      child: Icon(Icons.camera, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              if (_imageFile != null)
                                Stack(
                                  children: [
                                    Image.file(_imageFile!, height: 100),
                                    Positioned(
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: () => setState(() => _imageFile = null),
                                        child: Icon(Icons.close, color: Colors.red, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 12.0),
                              Row(
                                children: [
                                  Text("الصورة الخلفية للهوية"),
                                  Spacer(),
                                  Container(
                                    decoration: ThemeHelper().buttonBoxDecorationsmol(context),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final pickedImage2 = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        log(pickedImage2!.path);
                                        setState(() {
                                          log(pickedImage2.path);
                                          _imageFile2 = File(pickedImage2.path);
                                        });
                                      },
                                      child: Icon(Icons.photo, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 3.0),
                                  Container(
                                    decoration: ThemeHelper().buttonBoxDecorationsmol(context),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          final pickedImage2 = await ImagePicker().pickImage(source: ImageSource.camera);
                                          log(pickedImage2!.path);
                                          setState(() {
                                            log(pickedImage2.path);
                                            _imageFile2 = File(pickedImage2.path);
                                          });
                                        },
                                        child: Icon(Icons.camera, color: Colors.white)),
                                  ),
                                  //  image2 == null?Container():Image.network(image2!.path,
                                  // width: _screen.width * 0.40,
                                  //  height: _screen.width * 0.20,)
                                ],
                              ),
                              if (_imageFile2 != null)
                                Stack(
                                  children: [
                                    Image.file(_imageFile2!, width: 200, height: 200),
                                    Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () => setState(() => _imageFile2 = null),
                                        child: Icon(Icons.close, color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 12.0),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration("كلمة المرور*", "ادخل رقمك السري"),
                                  controller: password,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "من فضلك أدخل رقمك السري";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 12.0),
                              FormField<bool>(
                                builder: (state) {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: checkboxValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  checkboxValue = value!;
                                                  state.didChange(value);
                                                });
                                              }),
                                          Text(
                                            "أوافق على جميع الشروط والأحكام.",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.errorText ?? '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.error,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                validator: (value) {
                                  if (value == null || !value) {
                                    return 'تحتاج إلى قبول الشروط والأحكام';
                                  } else {}
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  onPressed: register,
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      "تسجيل",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
