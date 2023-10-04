import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/model/Demande.dart';
import 'package:tasareeh/screens/constants.dart';
import 'package:tasareeh/screens/home.dart';
import 'package:tasareeh/screens/payment.dart';
import 'package:tasareeh/screens/show.dart';
import 'package:tasareeh/widgets/PDFViewerScreen.dart';

import '../home.dart';
class BookContent extends StatefulWidget{
  const BookContent({Key? key}): super(key:key);

  @override
  _BookContentState createState() => _BookContentState();
}



class _BookContentState extends State<BookContent>{
 Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
       late List<Demande> _list = [];
          late bool _isLoading;

@override
  void initState() {
    super.initState();
     _isLoading = true;

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    Future.delayed(Duration.zero, () {
   _getData(context);
    });
  //  showAlertDialog(context);
  }




showAlertDialog(BuildContext context) async {
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  // The loading indicator
                          Lottie.asset('assets/loading.json'),                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('تحميل...')
                ],
              ),
            ),
          );
        });








    //Navigator.of(context).pop();
 Navigator.of(context).pop();



  }



 void _getData(BuildContext context) async {

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
      _list = (await ApiService().getlist())!;
    
      if(_list != null){
         setState(() {
        _isLoading = false;
         if (Navigator.of(context, rootNavigator: true).canPop()) {
       Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
     }
      });
      }
    //    Future.delayed(Duration.zero, () => showAlertDialog(context));


  //  Future.delayed(Duration(seconds: 2), () {
  //    if (Navigator.of(context, rootNavigator: true).canPop()) {
  //      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  //    }
  //  });
 


  }


  Color getCorrectColor(accepted) {
  if (accepted == "1") {
    return Colors.green;
  }else if(accepted == "2"){
    return Colors.red;
  }

  return Colors.white;
}


  @override
  Widget build(BuildContext context) {
     return Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
        appBar: AppBar(
          title: Center(child: Text('قائمة الطلبات')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40.0),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyHomePage()),
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
    body:
    _isLoading
            ? ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: defaultPadding),
              )
            :


    ListView.separated(
    padding: const EdgeInsets.all(10),
    itemCount: _list.length,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
    child:Container(
        height: 90,
     //   color: getCorrectColor(_list[index].accepted),
        decoration: BoxDecoration(
      border: Border.all(
          color: _accentColor, //color of border
          width: 2, //width of border
        ),
      borderRadius: BorderRadius.circular(20)
    ),

        child:
Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Row(
             textDirection: TextDirection.rtl,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

                 Text(' ${_list[index].cERTYPE}/${_list[index].id}'),

             Text(' ${_list[index].type}')
             ],

        ),
         Row(
             textDirection: TextDirection.ltr,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

               Text(_list[index].accepted == "0" ? 'تم رفض طلبك من اللجنة المنضمة لسباق الهجن' : ' ' ),
        Text(_list[index].accepted == "1" ? 'تم قبول طلبك من اللجنة المنضمة لسباق الهجن' : ' ' ),
 Text(_list[index].accepted == "null" ? 'قيد المراجعة  من اللجنة المنضمة لسباق الهجن ': ' ' ),

        Text(_list[index].accepted == "2" ? 'تم رفض طلبك من الثروة الحيوانية ' : ' ' ),
        Text(_list[index].accepted == "3" ? 'تم قبول طلبك من الثروة الحيوانية' : ' ' ),


      Text(_list[index].accepted == "5" ? 'تم قبول طلبك من الثروة الحيوانية' : ' ' ),   

  if(_list[index].pdf != null && _list[index].accepted.toString() == "3")
            IconButton(
                icon: Icon(Icons.download, color: Color.fromARGB(255, 153, 117, 96)),
                onPressed: () async {
                        String pdfUrl = '${_list[index].pdf}'; // Replace with your PDF URL

                  Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => PDFViewerScreen(pdfUrl: 'https://docs.google.com/viewer?url='+'${pdfUrl}'),
  ),
);

                }
              ),


             if(_list[index].linkpayment != null && _list[index].accepted.toString() == "5")
            IconButton(
                icon: Icon(Icons.payment, color: Color.fromARGB(255, 153, 117, 96)),
                onPressed: () async {
                        String pdfUrl = '${_list[index].linkpayment}'; // Replace with your PDF URL

                  Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => PaymentScreen(pdfUrl: '${pdfUrl}'),
  ),
);

                }
              ),            


             ],

        ),



],
        )
        ,
      ),
    onTap: () {
   //   print(_list[index].animal?.length.toString());
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => showContent(paramValue: _list[index]), // Pass the parameter
        ),
            (route) => true,
      );
        print("Click event on x");
    },
);
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  )

    )
    );
  }
}
