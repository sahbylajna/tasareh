import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PDFViewerScreen extends StatefulWidget {
    final  String pdfUrl;

  PDFViewerScreen({required this.pdfUrl});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

 class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late WebViewController controller;
 


 Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);

  @override
  void initState() {
    super.initState();
    print(widget.pdfUrl);
    controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
   
    controller.loadRequest(
        Uri.parse(widget.pdfUrl),
      );
  }


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
              title: Center(child: Text('الكتاب')),
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
      body:  WebViewWidget(
        controller: controller,
        
      ),
      
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed
   
    super.dispose();
  }
}
