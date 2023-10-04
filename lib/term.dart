

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasareeh/Otp.dart';
import 'package:tasareeh/model/term.dart';
import 'package:tasareeh/widgets/header_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'api_service.dart';
import 'common/theme_helper.dart';
import 'dart:ui' as ui;

import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:tasareeh/model/success.dart';

class TermContent extends StatefulWidget   {

  @override
  State<StatefulWidget> createState() {
     return _TermContentState();
  }




}
class _TermContentState extends State<TermContent>{
  bool _isLoading = false;
      double _headerHeight = 250;
       term? _term ;
       late String imageEncoded ="null";

       ByteData? byteData ;
           late Uint8List imageBytes;

  Key _formKey = GlobalKey<FormState>();
@override
  void initState() {
    super.initState();
    _getData();
  }

show(BuildContext context){
    Widget okButton = TextButton(
    child: Text("حسنا"),
    onPressed: () {
    Navigator.of(context).pop();


    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("خطأ"),
    content: Text( 'الرجاء إدخال بيانات صحيحة'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

   void _handleSaveButtonPressed(BuildContext context) async {
     final data =
        await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
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
    void _getData() async {
log(imageEncoded);
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
                       Lottie.asset('assets/loading.json'),               SizedBox(height: 15),
               Text('...تحميل'),

             ],
           ),
         ),
       );
     },
   );
 setState(() async {
   _term = (await ApiService().getterm())!;
      });

   
   Future.delayed(Duration(seconds: 2), () {
     if (Navigator.of(context, rootNavigator: true).canPop()) {
       Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
     }
   });
  }
  Uint8List? _signatureImage;
  @override
  Widget build( context) {
  bool isLoading = false;

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

                            Text(_term?.termAr.toString() != null ? _term!.termAr.toString() : ''),



                            SizedBox(height: 10.0),


                            SizedBox(height: 15.0),

Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child:ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return  AlertDialog(
        contentPadding: const EdgeInsets.all(6.0),
        title: Text('إمضاء'),
        content: Column(mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SfSignaturePad(
key: _signaturePadKey,
                      backgroundColor: Colors.white,
                      strokeColor: Colors.black,
                      minimumStrokeWidth: 1.0,
                      maximumStrokeWidth: 4.0),]),
            actions: [
ElevatedButton(                     // FlatButton widget is used to make a text to work like a button

                  onPressed: () {
                    Navigator.of(context).pop();
                  },             // function used to perform after pressing the button
                  child: Text('إلغاء'),
                ),

                ElevatedButton(

                  onPressed: () async {
                      ui.Image signatureData  = await _signaturePadKey.currentState!.toImage();

byteData = await signatureData.toByteData(format: ui.ImageByteFormat.png);

 setState(()  {

        imageEncoded =
   "data:image/png;base64,${base64.encode(byteData!.buffer.asUint8List())}";
      });

    //       final signatureImage = await _signaturePadKey.currentState!.toImage();
    // final data = await signatureImage.toByteData(format: ui.ImageByteFormat.png);
     final bytes = byteData!.buffer.asUint8List();
    setState(() {
      _signatureImage = bytes;
    });
      //  imageBytes = base64Decode(imageEncoded);
print("Encoded: $imageEncoded");          //   print(image.clone.toString());
                    //   print(_signaturePadKey.currentState.);
                    //   _handleSaveButtonPressed(context);
  Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('قبول'),
                ),
            ],
          );
            },
          );
        },
style: ThemeHelper().buttonStyle(),
       child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('إمضاء', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),),
      ),
),

                            SizedBox(height: 15.0),
                          
                             
                            if (_signatureImage != null)
                            ElevatedButton(
  onPressed: () {
     setState(() {
      _signatureImage = null;
        imageEncoded = '';
    });
    // Add your clear functionality here
  },
  child: Icon(Icons.clear),
),
   if (_signatureImage != null)
                              Image.memory(
                _signatureImage!,
                width: 300,
                height: 150,
              ),
              SizedBox(height: 15.0),
                        //    if(imageEncoded != "null")
                             //Image.memory(base64Decode("data:image/png;base64,${base64.encode(byteData!.buffer.asUint8List())}"),width: 200,height: 200,),

  if (_signatureImage != null)
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('تسجيل '.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: () async {
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

if(imageEncoded.isNotEmpty){
         final user = await SharedPreferences.getInstance();
Success? success = await ApiService().signature(imageEncoded,user.get('id'));

  if(success?.message.toString() == 'success'){
      if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }

  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => Otp()),
                                    (Route<dynamic> route) => false
                                );
  }else{
      if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }
 show(context);
  }
}else{
 show(context);
  }








                                    //_selectedValue!.id
                                  //After successful login we will redirect to profile page. Let's create profile page now
                              //
                                },
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


