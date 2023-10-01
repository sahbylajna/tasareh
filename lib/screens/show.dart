import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasareeh/constants.dart';
import 'package:tasareeh/screens/book.dart';
import 'package:tasareeh/screens/payment.dart';
import 'package:tasareeh/widgets/PDFViewerScreen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


import '../model/Demande.dart';


class showContent extends StatefulWidget{
  final Demande paramValue;
  const showContent({Key? key, required this.paramValue}): super(key:key);

  @override
  _showContentState createState() => _showContentState();
}



class _showContentState extends State<showContent>{
  Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
late String _localPath;
late bool _permissionReady;
late TargetPlatform? platform;


@override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  final GlobalKey<State> _statefulBuilderKey = GlobalKey<State>();
String _selectedFolder = "Downloads";

 Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }


Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }
Future<void> downloadFile(String fileUrl, String fileName) async {
  Dio dio = Dio();
    _permissionReady = await _checkPermission();
          if (_permissionReady) {
            await _prepareSaveDir();
            }
  try {
    OpenFile.open('/data/user/0/com.example.tasareeh/app_flutter/test2.pdf');
    final response = await dio.get(fileUrl, options: Options(responseType: ResponseType.bytes));

    final directory = await getApplicationDocumentsDirectory();
    print(directory);
   
    final filePath = '/data/user/0/com.example.tasareeh/$fileName';

    File file = File(filePath);
    await file.writeAsBytes(response.data);
print(filePath);
    // Optionally, you can open the file after downloading.
     

    // Optionally, show a confirmation dialog or notification.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('File Downloaded'),
          content: Text('The file has been downloaded and saved to your device.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (error) {
    print('Error downloading file: $error');
    // Handle the error here, e.g., show an error message.
  }
}








  @override
  Widget build(BuildContext context) {
    String? url = widget.paramValue.pdf;
    print(widget.paramValue.pdf);
    return Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
            appBar:AppBar(
              title: Center(child: Text(widget.paramValue.type.toString())),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40.0),
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => BookContent()),
                        (route) => false),
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

            body:SingleChildScrollView( // Wrap your content with SingleChildScrollView
                child:  Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 30, // <-- SEE HERE
                        ),

                            
                            
               Text(widget.paramValue.accepted.toString() == "0" ? 'تم رفض طلبك من اللجنة المنضمة لسباق الهجن' : ' ' ),
        Text(widget.paramValue.accepted.toString() == "1" ? 'تم قبول طلبك من اللجنة المنضمة لسباق الهجن' : ' ' ),
 Text(widget.paramValue.accepted.toString() == "null" ? 'قيد المراجعة  من اللجنة المنضمة لسباق الهجن ': ' ' ),

        Text(widget.paramValue.accepted.toString() == "2" ? 'تم رفض طلبك من الثروة الحيوانية ' : ' ' ),
        Text(widget.paramValue.accepted.toString() == "3" ? 'تم قبول طلبك من الثروة الحيوانية' : ' ' ),


          //  Text(widget.paramValue.accepted.toString() == "5" ? 'تحميل الكتاب / الدفع' : ' ' ),
 if(widget.paramValue.accepted.toString() == "3" && widget.paramValue.pdf != null) 
              
                Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [_primaryColor, _accentColor], // Start and end colors
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30), // Rounded corners
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Open a dialog to add a new row
                              if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }
    

            Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => PDFViewerScreen(pdfUrl: 'https://docs.google.com/viewer?url='+'${widget.paramValue.pdf}'),
  ),
);

                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                              elevation: 0, // No shadow
                            ),
                            child: Text(
                               ('تحميل الكتاب').toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
              





              if(widget.paramValue.accepted.toString() == "5" && widget.paramValue.linkpayment != null) 
              
                Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [_primaryColor, _accentColor], // Start and end colors
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30), // Rounded corners
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Open a dialog to add a new row
                              if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }
    
            Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => PaymentScreen(pdfUrl: '${widget.paramValue.linkpayment}'),
  ),
);

                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                              elevation: 0, // No shadow
                            ),
                            child: Text(
                               ('الدفع').toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
              
              
              
              
              
              
              
              
              
              
              
          
                            
                            
                            
            //                  if(widget.paramValue.pdf != null && widget.paramValue.accepted.toString() == "3")

            //              IconButton(
            //     icon: Icon(Icons.download, color: Color.fromARGB(255, 153, 117, 96)),
            //     onPressed: () async {
            //             String pdfUrl = '${widget.paramValue.pdf}'; // Replace with your PDF URL

            //  downloadFile(pdfUrl,'test2.pdf');

            //     }
            //   ),


//                          ListTile(
//                                       title:Icon( Icons.download,size: 30, color: Color.fromARGB(255, 153, 117, 96)),
//                                        onTap: () {
//             // Handle onTap action here

//             Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (context) => PDFViewerScreen(pdfUrl: '${widget.paramValue.pdf}'),
//   ),
// );


//           },

//                                     ),


                        const SizedBox(
                          height: 10,
                        ),





                        if (widget.paramValue.eXPCOUNTRY.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('البلد المصدر '),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.eXPCOUNTRY.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        if (widget.paramValue.iMPNAME.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(' المورد'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.iMPNAME.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),


                        if (widget.paramValue.iMPADDRESS.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                          if(widget.paramValue.iMPADDRESS.toString()!='')
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('عنوان المورد'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.iMPADDRESS.toString()),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),




                        if (widget.paramValue.iMPFAX.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('فاكس المورد'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.cOMPID.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        if (widget.paramValue.iMPTEL.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('هاتف المورد'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.iMPTEL.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),


                        if (widget.paramValue.iMPCOUNTRY.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('البلد المورد'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.cOMPID.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        if (widget.paramValue.oRIGINCOUNTRY.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('البلد الأصلي'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.oRIGINCOUNTRY.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        if (widget.paramValue.sHIPPINGPLACE.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('مكان الشحن'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.sHIPPINGPLACE.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (widget.paramValue.eNTERYPORT.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('منفذ الدخول'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.eNTERYPORT.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        if (widget.paramValue.tRANSPORT.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('الناقل'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.tRANSPORT.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        if (widget.paramValue.sHIPPINGDATE.toString() != 'null')
                        Padding(
                          padding: EdgeInsets.all(10), // Add your desired padding values here
                          child: Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('تاريخ الشحن'),
                              ),
                              SizedBox(width: 10), // Add spacing between text and value
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(widget.paramValue.sHIPPINGDATE.toString()),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),








                        if (widget.paramValue.eXPECTEDARRIVALDATE.toString() != 'null')
                          Padding(
                            padding: EdgeInsets.all(10), // Add your desired padding values here
                            child: Row(
                              children: [
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text('تاريخ الوصول المتوقع'),
                                ),
                                SizedBox(width: 10), // Add spacing between text and value
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(widget.paramValue.eXPECTEDARRIVALDATE.toString()),
                                ),
                              ],
                            ),
                          ),







                        Text('قائمة الحيوانات'),

                        const SizedBox(
                          height: 2,
                        ),

                        Padding(
                            padding: EdgeInsets.only(left: 40.0, right: 40.0,top: 2.0,bottom: 2.0), // Adjust the padding values as needed
                            child:
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.paramValue.animal?.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 4, // You can adjust the elevation for the shadow effect
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0), // Radius of 5 for rounded corners
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.blue, // Blue background color
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: ListTile(
                                      title: Text('عدد هجن: ${widget.paramValue.animal?[index].aNMLNUMBER}'),

                                    ),
                                  ),
                                );
                              },
                            )
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                     

                                       const SizedBox(
                          height: 20,
                        ),






                        const SizedBox(
                          height: 2,
                        ),



                      ]
                  ),
                )

            )
        )
    );
  }




}
