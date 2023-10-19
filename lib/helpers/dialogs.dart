import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasareeh/Otp.dart';
import 'package:tasareeh/helpers/theme.dart';

void showUpload(BuildContext context) {
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
              Lottie.asset('assets/upl.json'),
            ],
          ),
        ),
      );
    },
  );
}

void dialogSuccess(BuildContext context, {String message = ' تمت العملية بنجاح', Function()? action, dismissible = false}) {
  showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (_) {
        return Dialog(
          // backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.done, size: 80, color: appColor),
                SizedBox(height: 15),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                ElevatedButton(onPressed: action, child: Text('حسنا')),
              ],
            ),
          ),
        );
      });
}

void dialogLoading(BuildContext context, {String message = '...Loading'}) {
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
              Lottie.asset('assets/loading.json'), //  Lottie.network('https://lottie.host/66e2a97f-0826-425b-bca6-d7e1ee74f757/YmBvSTB48I.json'),
              SizedBox(height: 15),
              Text(message),
            ],
          ),
        ),
      );
    },
  );
}


// "إنتباه"
void dialogError(BuildContext context, {String title = 'خطأ', required String message, String okText = 'حسنا'}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text(okText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


void dialogErroropt(BuildContext context, {String title = 'خطأ', required String message, String okText = 'حسنا',required String id}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text(okText),
            onPressed: () async {
              Navigator.of(context).pop();
              final user = await SharedPreferences.getInstance();
      user.setString('id', id);
         Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));
            },
          ),
        ],
      );
    },
  );
}


void dialogInfo(BuildContext context, {String? title, String? text, String okText = 'حسنا'}) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SingleChildScrollView(
              child:
               Html(data: text ?? ''),
             //  Text(text ?? ''),
            ),
          ),
          actions: [
            ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(okText)),
          ],
        );
      });
}

// Future<void> _showTermsDialog(BuildContext context, String text, {Function(bool?)? action}) async {
//   showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         title: Text(('التعهد')),
//         content: SingleChildScrollView(
//           child: Text(text),
//         ),
//         actions: <Widget>[
//           FormField<bool>(
//             builder: (state) {
//               return Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Checkbox(value: checkboxValue, onChanged: action),
//                       Text(
//                         "أوافق على التعهد.",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       state.errorText ?? '',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: Theme.of(context).colorScheme.error,
//                         fontSize: 12,
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             },
//             validator: (value) {
//               if (!checkboxValue) {
//                 return 'تحتاج إلى قبول الشروط والأحكام';
//               }
//               return null;
//             },
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [primaryColor, accentColor], // Start and end colors
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//               borderRadius: BorderRadius.circular(30), // Rounded corners
//             ),
//             child: ElevatedButton(
//               onPressed: () {
//                 if (checkboxValue) {
//                   if (Navigator.of(context, rootNavigator: true).canPop()) {
//                     Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
//                   }
//                 }
//                 // Open a dialog to add a new row
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//                 elevation: 0, // No shadow
//               ),
//               child: Text(
//                 'موافق'.toUpperCase(),
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }






        // showDialog(
        //   barrierDismissible: false,
        //   context: context,
        //   builder: (_) {
        //     return Dialog(
        //       backgroundColor: Colors.white,
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 20),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Lottie.asset('assets/ok.json'),
        //             SizedBox(height: 15),
        //             Text('تم إرسال طلبك بنجاح'),
        //             Container(
        //               decoration: BoxDecoration(
        //                 gradient: LinearGradient(
        //                   colors: [_primaryColor, _accentColor], // Start and end colors
        //                   begin: Alignment.centerLeft,
        //                   end: Alignment.centerRight,
        //                 ),
        //                 borderRadius: BorderRadius.circular(30), // Rounded corners
        //               ),
        //               child: ElevatedButton(
        //                 onPressed: () {
        //                   // Open a dialog to add a new row
        //                   if (Navigator.of(context, rootNavigator: true).canPop()) {
        //                     Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        //                   }
        //                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                   foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
        //                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        //                   elevation: 0, // No shadow
        //                 ),
        //                 child: Text(
        //                   'عودة للصفحة الرئيسية'.toUpperCase(),
        //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // );