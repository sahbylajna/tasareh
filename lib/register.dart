import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasareeh/common/theme_helper.dart';
import 'package:tasareeh/model/success.dart';
import 'package:tasareeh/term.dart';
import 'package:tasareeh/widgets/header_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'api_service.dart';
import 'model/contrie.dart';

class RegistrationPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{
 Contries? _selectedValue;
  Contries? _selectedValue1;
   late List<Contries> _contrie = [];
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
   TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
   TextEditingController email = TextEditingController();
  TextEditingController fistname = TextEditingController();
  TextEditingController ud = TextEditingController();
  TextEditingController lastname = TextEditingController();

    TextEditingController adresse = TextEditingController();
    TextEditingController fax = TextEditingController();
    TextEditingController POBOX = TextEditingController();
@override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
         setState(() async {
        _contrie = (await ApiService().getcontries())!;
    });
      
 
Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {

    }));
  }


  ImagePicker picker = ImagePicker();
  XFile? image;

   ImagePicker picker2 = ImagePicker();
  XFile? image2;



  File? _imageFile;
    File? _imageFile2;

  @override
  Widget build(BuildContext context) {
    final screen =  MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
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

                        SizedBox(height: 50,),
                        Container(

                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('الاسم الأول', 'أدخل اسمك الأول'),
                             controller: fistname,
                             validator: (val) {
                              if( (val!.isEmpty)){
                                return "أدخل  اسمك الأول ";
                              }
                              return null;

                            },
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('اسم العائلة', 'أدخل اسم العائلة الخاص بك'),
                             controller: lastname,
                                                          validator: (val) {
                              if( (val!.isEmpty)){
                                return "أدخل  اسمك العائلة ";
                              }
                              return null;

                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                             controller: email,
                            decoration: ThemeHelper().textInputDecoration("بريد إلكتروني", "أدخل بريدك الإلكتروني"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)  || (val.isEmpty)){
                                return "أدخل عنوان بريد إلكتروني صحيحًا";
                              }
                              return null;

                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                " رقم ال id",
                                "أدخل رقم id"),
                                controller: ud,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)  || (val.isEmpty)){
                                return "أدخل رقم id صحيحًا";
                              }
                              return null;

                            },
                          ),
                        ),

SizedBox(height: 20.0),




//      Container(
//                           decoration: ThemeHelper().inputBoxDecorationShaddow(),
//                           child: TextFormField(
//                             decoration: ThemeHelper().textInputDecoration(
//                                 " رقم ال Fax",
//                                 "أدخل رقم fax"),
//                                 controller: fax,
//                             keyboardType: TextInputType.number,
//                             validator: (val) {
//                               if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)  || (val.isEmpty)){
//                                 return "أدخل رقم id صحيحًا";
//                               }
//                               return null;

//                             },
//                           ),
//                         ),

// SizedBox(height: 20.0),


//  Container(
//                           decoration: ThemeHelper().inputBoxDecorationShaddow(),
//                           child: TextFormField(
//                             decoration: ThemeHelper().textInputDecoration(
//                                 " رقم ال POBOX",
//                                 "أدخل رقم POBOX"),
//                                 controller: POBOX,
//                             keyboardType: TextInputType.number,
//                             validator: (val) {
//                               if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)  || (val.isEmpty)){
//                                 return "أدخل رقم id صحيحًا";
//                               }
//                               return null;

//                             },
//                           ),
//                         ),

SizedBox(height: 20.0),

     Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "العنوان",
                                "أدخل  العنوان"),
                                controller: adresse,
                            keyboardType: TextInputType.text,

                          ),
                        ),


SizedBox(height: 20.0),

                       Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                        // SizedBox(height: 20.0),
                        Container(
width: screen.width * 0.45,
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "رقم الهاتف",
                                "أدخل رقم هاتفك"),
                                controller: phone,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val) || (val.isEmpty)){
                                return "أدخل رقم هاتف صحيحًا";
                              }
                              return null;

                            },
                          ),
                        ),
                         Container(

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
          ),]),

                        SizedBox(height: 20.0),





      Container(

                                padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Colors.deepPurple.shade300, style: BorderStyle.solid, width: 0.8),
          ),
            child: DropdownButton<Contries>(

              //isDense: true,
              hint: Text('اختر دولتك'),
//isDense: true,
                //    isExpanded: true,
              value: _selectedValue1,

              icon: Icon(Icons.check_circle_outline),
              iconSize: 24,
              elevation: 16,
               //style: ThemeHelper().buttonStyle(),
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.blue[300],
              ),
              onChanged:( newValue1) {
                setState(() {
                _selectedValue1 = newValue1;
                //  contry_id =_contrie.indexOf();
                });
              },
              items:
                  _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                return DropdownMenuItem<Contries>(
                  value:  value ,
                  child: Text(value.name ),
                );
              }).toList(),
            ),
          ),














                       Row(
                        children: [
                          Text("الصورة الامامية لل id"),
                          SizedBox(width: 4.0),
 Container(
   decoration: ThemeHelper().buttonBoxDecoration(context),
                          child:ElevatedButton(
                  onPressed: () async {
                          final pickedImage  = await ImagePicker().pickImage(source: ImageSource.gallery);
                      log(pickedImage!.path);
                      setState(()  {
                    log(pickedImage!.path);
                           if (pickedImage != null) {
        _imageFile = File(pickedImage!.path);
      }
                      });
                  },
                  child:  Icon(Icons.photo, color: Colors.white),

                ),
                              ),


       
//  image == null?Container():Image.file(File(image!.path),
// width: _screen.width * 0.40,
//  height: _screen.width * 0.20,)
     SizedBox(width: 4.0),

Container(
   decoration: ThemeHelper().buttonBoxDecoration(context),
                          child:ElevatedButton(
                  onPressed: () async {
                      // image = await picker.pickImage(source: ImageSource.camera);
                      // setState(() {
                      //   //update UI
                      // });

                               final pickedImage  = await ImagePicker().pickImage(source: ImageSource.camera);
                      log(pickedImage!.path);
                      setState(()  {
                    log(pickedImage!.path);
                           if (pickedImage != null) {
        _imageFile = File(pickedImage!.path);
      }
                 
                  });
                   },
                  child:  Icon(Icons.camera, color: Colors.white),

                ),



                              ),

                        ],
                       ),

     SizedBox(height: 20.0),

 if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 200,
                height: 200,
              ),
  SizedBox(height: 10.0),
                       Row(
                        children: [
                          Text("الصورة الخلفية لل id"),
                          SizedBox(width: 4.0),
 Container(
   decoration: ThemeHelper().buttonBoxDecorationsmol(context),
                          child:ElevatedButton(
                  onPressed: () async {
                             final pickedImage2  = await ImagePicker().pickImage(source: ImageSource.gallery);
                      log(pickedImage2!.path);
                      setState(()  {
                    log(pickedImage2!.path);
                           if (pickedImage2 != null) {
        _imageFile2 = File(pickedImage2!.path);
      }
                 
                  });
                  },
                  child: Icon(Icons.photo, color: Colors.white),
                ),



                              ),
                                 SizedBox(width: 3.0),
                              Container(
   decoration: ThemeHelper().buttonBoxDecorationsmol(context),
                          child:ElevatedButton(
                  onPressed: () async {
                            final pickedImage2  = await ImagePicker().pickImage(source: ImageSource.camera);
                      log(pickedImage2!.path);
                      setState(()  {
                    log(pickedImage2!.path);
                           if (pickedImage2 != null) {
        _imageFile2 = File(pickedImage2!.path);
      }
                 
                  });
                  },
                  child: 
                  Icon(Icons.camera, color: Colors.white)
                  
                ),



                              ),
//  image2 == null?Container():Image.network(image2!.path,
// width: _screen.width * 0.40,
//  height: _screen.width * 0.20,)




                        ],
                       ),

 if (_imageFile2 != null)
              Image.file(
                _imageFile2!,
                width: 200,
                height: 200,
              ),
  SizedBox(height: 10.0),

                        SizedBox(height: 30,),


















                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "كلمة المرور*", "ادخل رقمك السري"),
                                 controller: password,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "من فضلك أدخل رقمك السري";
                              }
                              return null;

                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
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
                                    Text("أوافق على جميع الشروط والأحكام.", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).colorScheme.error,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'تحتاج إلى قبول الشروط والأحكام';
                            } else {

                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "تسجيل".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                
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
              Lottie.asset('assets/up.json'),

              ],
            ),
          ),
        );
      },
    );


                                 final bytes = _imageFile?.readAsBytesSync();
                          String base64Image1 =  "data:image/png;base64,${base64Encode(bytes!)}";
                             final bytes2 = _imageFile2?.readAsBytesSync();
                          String base64Image2 =  "data:image/png;base64,${base64Encode(bytes2!)}";

// log(base64Image1);

// log(base64Image2);


 Success success =  (await ApiService().register(fistname.text,lastname.text,phone.text,password.text,email.text,ud.text,_selectedValue!.id.toString(),_selectedValue1!.id.toString(),base64Image1.toString(),base64Image2.toString(),'0','0','0'))!;
print(success.message);

 if(success.message != 'success'){
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }
                                           showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("إنتباه",
                                        'رقم الهاتف أو كلمة المرور غير صحيحة' ,
                                          context);
                                    },
                                  );
                                    }else{
                                      if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }
                                            final user = await SharedPreferences.getInstance();
                                    user.setString('id',success.id.toString());
Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => TermContent()
                                    ),
                                        (Route<dynamic> route) => false
                                );
                                    }


                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

}
