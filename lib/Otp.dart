import 'package:flutter/material.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/helpers/dialogs.dart';
import 'package:tasareeh/login.dart';
import 'package:tasareeh/model/success.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController phone = TextEditingController();

  showAlertDialog(BuildContext context, code) async {
    dialogLoading(context);

    final user = await SharedPreferences.getInstance();
    Success? success = await ApiService().confiramtion(code, user.get('id'));
    await Future.delayed(const Duration(seconds: 3));
    print(success!.errors);
    if (success.errors.toString() == "errors") {
      Navigator.of(context).pop();
      dialogInfo(context, text: 'الرجاء إدخال بيانات صحيحة');
    } else {
      dialogSuccess(
        context,
        message: 'الرجاء الانتضار حتى قبولك من اللجنة المنظمة لسباق الهجن ',
        action: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
      );
    }
  }
 showAlertDialogresend(BuildContext context) async {
    dialogLoading(context);

    final user = await SharedPreferences.getInstance();
    Success? success = await ApiService().resend(user.get('id'));
    await Future.delayed(const Duration(seconds: 3));
    print(success!.errors);
    if (success.errors.toString() == "errors") {
      Navigator.of(context).pop();
      dialogInfo(context, text: 'الرجاء إدخال بيانات صحيحة');
    } else {
        Navigator.of(context).pop();
      dialogSuccess(
        context,
        message: 'تمت العملية بنجاح',
      
      );
       Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff7f6fb),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'تَحَقّق',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "أدخل رقم رمز OTP الخاص بك",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 50,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        
                        fieldStyle: FieldStyle.underline,
                        
                        onCompleted: (pin) {
                          print("Completed: $pin");
                          Future.delayed(Duration.zero, () => showAlertDialog(context, pin));
                        },
                        
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "ألم تصلك أي كود؟",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black38),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 18),
                  ElevatedButton(
              onPressed: () {
                Future.delayed(Duration.zero, () => showAlertDialogresend(context));
              }, // function used to perform after pressing the button
              child: Text( "إعادة إرسال رمز جديد"),
            ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

//   Widget _textFieldOTP({required bool first, last}) {
//     return Container(
//       height: 50,
//       child: AspectRatio(
//         aspectRatio: 1.0,
//         child: TextField(
//           autofocus: true,
//           onChanged: (value) {
//             if (value.length == 1 && last == false) {
//               FocusScope.of(context).nextFocus();

//             }
//             if (value.length == 0 && first == false) {
//               FocusScope.of(context).previousFocus();
//             }
//           },
//           showCursor: false,
//           readOnly: false,

//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//             counter: Offstage(),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 2, color: Colors.black12),
//                 borderRadius: BorderRadius.circular(12)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 2, color: Color.fromARGB(234,176,74,1)),
//                 borderRadius: BorderRadius.circular(12)),
//           ),
//         ),
//       ),
//     );
//   }
}
