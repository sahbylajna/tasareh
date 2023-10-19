import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tasareeh/Otp.dart';
import 'package:tasareeh/helpers/dialogs.dart';
import 'package:tasareeh/model/term.dart';
import 'package:tasareeh/widgets/header_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'api_service.dart';
import 'common/theme_helper.dart';
import 'dart:ui' as ui;

import 'package:tasareeh/model/success.dart';

class TermContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TermContentState();
  }
}

class _TermContentState extends State<TermContent> {
  ScrollController ctrl = ScrollController();
  bool _isLoading = true;
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  Key _formKey = GlobalKey<FormState>();
  double _headerHeight = 250;
  term? _term;
  late String imageEncoded = "null";

  ByteData? byteData;
  late Uint8List imageBytes;
  Uint8List? _signatureImage;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      _term = (await ApiService().getterm())!;
    } catch (e) {}
    setState(() {
      _isLoading = false;
    });
  }

  confirm() async {
    showUpload(context);
    if (imageEncoded.isNotEmpty) {
      final user = await SharedPreferences.getInstance();
      Success? success = await ApiService().signature(imageEncoded, user.get('id'));

      if (success?.message == 'success') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));
      } else {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        }
        dialogInfo(context, text: 'الرجاء إدخال بيانات صحيحة');
      }
    } else {
      dialogInfo(context, text: 'الرجاء إدخال بيانات صحيحة');
    }
  }

  sign() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text('إمضاء'),
          content: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            SfSignaturePad(key: _signaturePadKey, backgroundColor: Colors.white, strokeColor: Colors.black, minimumStrokeWidth: 1.0, maximumStrokeWidth: 4.0),
          ]),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, // function used to perform after pressing the button
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                ui.Image signatureData = await _signaturePadKey.currentState!.toImage();
                byteData = await signatureData.toByteData(format: ui.ImageByteFormat.png);
                setState(() {
                  imageEncoded = "data:image/png;base64,${base64.encode(byteData!.buffer.asUint8List())}";
                });

                final bytes = byteData!.buffer.asUint8List();
                setState(() {
                  _signatureImage = bytes;
                });
                print("Encoded: $imageEncoded");
                Navigator.of(context, rootNavigator: true).pop();
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ctrl.animateTo(ctrl.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                });
              },
              child: Text('قبول'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            controller: ctrl,
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
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 3),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Color.fromARGB(255, 204, 88, 5),
                          //         ),
                          //         borderRadius: BorderRadius.all(Radius.circular(20))),
                          //     child: SfSignaturePad(
                          //       key: _signaturePadKey,
                          //       backgroundColor: Colors.white,
                          //       strokeColor: Colors.black,
                          //       minimumStrokeWidth: 1.0,
                          //       maximumStrokeWidth: 4.0,
                          //     ),
                          //   ),
                          // ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _isLoading
                                      ? SizedBox(height: 100, child: const Center(child: CircularProgressIndicator()))
                                      : 
                                      // Text(_term?.termAr.toString() != null ? _term!.termAr.toString() : '')
                                         Html(data:_term?.termAr.toString() != null ? _term!.termAr.toString() : ''),
                                  // Text(
                                  //     "ليس لوريم إيبسوم على الإطلاق ، ولكن لوريم إيبسوم الخاص بك! باستخدام منشئ النص عبر الإنترنت ، يمكنك معالجة Lorem Ipsum الخاص بك بإثرائه بعناصر html التي تحدد هيكله ، مع إمكانية إدراج روابط خارجية ، ولكن ليس فقط . يعد الآن كتابة نص لوريم إيبسوم أكثر متعة! في الواقع ، فإن إدخال أي نص خيالي أو نص مشهور ، سواء كان قصيدة أو خطاب أو مقطعًا أدبيًا أو نص أغنية وما إلى ذلك ، سيوفر مولد النص الخاص بنا الاستخراج العشوائي للمصطلحات والخطوات لتأليف برنامج Lorem Ipsum الخاص بك. كن أصليًا ، اختبر خيالك ... سوف يذهلك مُنشئ Lorem Ipsum. جربه الآن! نسخ ولصق!"),

                                  SizedBox(height: 30.0),
                                  if (_signatureImage == null)
                                    Container(
                                      decoration: ThemeHelper().buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        onPressed: sign,
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                          child: Text('إمضاء', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ),
                                      ),
                                    ),

                                  if (_signatureImage != null)
                                    Stack(
                                      children: [
                                        Image.memory(_signatureImage!, width: 300, height: 150),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _signatureImage = null;
                                              imageEncoded = '';
                                            });
                                            // Add your clear functionality here
                                          },
                                          icon: Icon(Icons.clear),
                                        ),
                                      ],
                                    ),
                                  SizedBox(height: 15.0),
                                  //    if(imageEncoded != "null")
                                  //Image.memory(base64Decode("data:image/png;base64,${base64.encode(byteData!.buffer.asUint8List())}"),width: 200,height: 200,),

                                  if (_signatureImage != null)
                                    Container(
                                      decoration: ThemeHelper().buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        onPressed: confirm,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                          child: Text(
                                            'تسجيل '.toUpperCase(),
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                        ),
                                      ),
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
