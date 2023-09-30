import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/model/count.dart';

import 'package:tasareeh/screens/back.dart';
import 'package:tasareeh/screens/book.dart';
import 'package:tasareeh/screens/constants.dart';
import 'package:tasareeh/screens/in.dart';
import 'package:tasareeh/screens/inafter.dart';
import 'package:tasareeh/screens/out.dart';
import 'package:tasareeh/screens/outafter.dart';
import 'package:tasareeh/screens/skeleton.dart';


class HomeContent extends StatefulWidget {

 @override
  _HomeContentState createState() => _HomeContentState();

}


class _HomeContentState extends State<HomeContent> {
  count? _count;
   late bool _isLoading;
  // ignore: prefer_typing_uninitialized_variables
   String  users="";
  String importations = '-1';
  String exports = '0';
  String backs = '0';
  // Remove the GlobalKey
  // GlobalKey<State> _dialogKey = GlobalKey<State>();
  Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
  @override
  void initState() {
    super.initState();
     _isLoading = true;
      _fetchData(context);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });

    Future.delayed(Duration.zero, () async {


    });
  }



void _fetchData(BuildContext context) async {
 final prefs = await SharedPreferences.getInstance();
users = prefs.getString('first_name')! ;

   //  user = await SharedPreferences.getInstance();
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
 Lottie.asset('assets/loading.json'),
              SizedBox(height: 15),
              Text('...تحميل'),

            ],
          ),
        ),
      );
    },
  );


  try {
    _count = await ApiService().getcount();
    exports = _count!.exports;
    importations = _count!.importations;
    backs = _count!.backs;


    // Close the dialog after a 2-second delay
    Future.delayed(Duration(seconds: 2), () {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        print(_count.toString());

      }
    });
    print(importations);
       print(  "here");
         if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        print(_count.toString());

      }
  } catch (e) {
    print('Error: $e');
    // Dismiss the dialog using the original context
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

}



  @override
  Widget build(context) {
     //_fetchData(context) ;
    var borderRadius = BorderRadius.circular(8.0);


    return Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
        appBar:    AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_accentColor, _primaryColor], // Add your colors here
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 80,
                height: 80,
              ),
              Text('مرحبا بك ${users}', style: TextStyle(fontSize: 20)),
              SizedBox(width: 40, height: 40), // Empty SizedBox for spacing
            ],
          ),
          toolbarHeight: 150, // Set the height of the AppBar
        ),
    body:_isLoading
            ? SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
)
            :

   Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[



       Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
      OutlinedButton(
        onPressed: () {

             Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(builder: (context) => InContentafter()),
                     (route) => true);
        },

   style: OutlinedButton.styleFrom(

      foregroundColor: Colors.white,
      side:BorderSide(color: _primaryColor),
      shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),

 backgroundColor: Colors.white,
      elevation: 10,
       fixedSize: Size(130,120),
    ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        SizedBox(
      height: 5, // <-- SEE HERE
    ),
          Row(
            textDirection: TextDirection.rtl,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

         SizedBox(
      width: 30, // <-- SEE HERE
    ),
 Image.asset('assets/in.png',height: 50,
    width: 50,)

  ]),
SizedBox(
      height: 30, // <-- SEE HERE
    ),

    Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

      Text("دخول للمشاركة",style: TextStyle(color: _accentColor)),


  ]),

    ],

  ),
    ),



   OutlinedButton(
        onPressed: () {

             Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(builder: (context) => InContent()),
                     (route) => true);
        },

   style: OutlinedButton.styleFrom(

      foregroundColor: Colors.white,
      side:BorderSide(color: _primaryColor),
      shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),

 backgroundColor: Colors.white,
      elevation: 10,
       fixedSize: Size(130,120),
    ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        SizedBox(
      height: 7, // <-- SEE HERE
    ),
          Row(
            textDirection: TextDirection.rtl,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

         SizedBox(
      width: 20, // <-- SEE HERE
    ),
 Image.asset('assets/in.png',height: 50,
    width: 50,)

  ]),
SizedBox(
      height: 30, // <-- SEE HERE
    ),

    Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

      Text("دخول بعد المشاركة",style: TextStyle(color: _accentColor)),


  ]),

    ],

  ),
    ),









  ],
),


















       Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [


 OutlinedButton(
        onPressed: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OutContent()));
        },

   style: OutlinedButton.styleFrom(

      foregroundColor: Colors.white,
      side:BorderSide(color: _primaryColor),
      shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),

 backgroundColor: Colors.white,
      elevation: 10,
       fixedSize: Size(130,120),
    ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        SizedBox(
      height: 10, // <-- SEE HERE
    ),
          Row(
            textDirection: TextDirection.rtl,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

         SizedBox(
      width: 30, // <-- SEE HERE
    ),
 Image.asset('assets/out.png',height: 50,
    width: 50,)

  ]),
SizedBox(
      height: 30, // <-- SEE HERE
    ),

    Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

      Text("خروج للمشاركة",style: TextStyle(color: _accentColor)),

  ]),

    ],

  ),
    ),



OutlinedButton(
        onPressed: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OutafterContent()));
        },

   style: OutlinedButton.styleFrom(

      foregroundColor: Colors.white,
      side:BorderSide(color: _primaryColor),
      shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),

 backgroundColor: Colors.white,
      elevation: 10,
       fixedSize: Size(130,120),
    ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        SizedBox(
      height: 5, // <-- SEE HERE
    ),
          Row(
            textDirection: TextDirection.rtl,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

         SizedBox(
      width: 30, // <-- SEE HERE
    ),
 Image.asset('assets/out.png',height: 50,
    width: 50,)

  ]),
SizedBox(
      height: 30, // <-- SEE HERE
    ),

    Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

      Text("خروج بعد المشاركة",style: TextStyle(color: _accentColor)),

  ]),

    ],

  ),
    ),

//  OutlinedButton(
//         onPressed: () {
//              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookContent()));
//         },

//    style: OutlinedButton.styleFrom(

//       foregroundColor: Colors.white,
//      side:BorderSide(color: _primaryColor),
//       shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(18),
//               ),
//             ),

//  backgroundColor: Colors.white,
//       elevation: 10,
//        fixedSize: Size(130,120),
//     ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//         SizedBox(
//       height: 10, // <-- SEE HERE
//     ),
//           Row(
//             textDirection: TextDirection.rtl,
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [

// Icon( Icons.book_outlined,size: 30, color: Color.fromARGB(255, 153, 117, 96)),

//   ]),
// SizedBox(
//       height: 100, // <-- SEE HERE
//     ),

//     Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [

//       Text("قائمة طلبات",style: TextStyle(color: _accentColor)),

//       SizedBox(
//       width: 50, // <-- SEE HERE
//     ),
//   ]),

//     ],

//   ),
//     ),



  ],
),












 OutlinedButton(
        onPressed: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookContent()));
        },

   style: OutlinedButton.styleFrom(

      foregroundColor: Colors.white,
     side:BorderSide(color: _primaryColor),
      shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),

 backgroundColor: Colors.white,
      elevation: 2,
       fixedSize: Size(300,70),
    ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

          Row(
            textDirection: TextDirection.rtl,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

Icon( Icons.book_outlined,size: 30, color: Color.fromARGB(255, 153, 117, 96)),

  ]),
SizedBox(
      height: 2, // <-- SEE HERE
    ),

    Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

      Text("قائمة طلبات",style: TextStyle(color: _accentColor)),


  ]),

    ],

  ),
    )
,














        ],)
      )




    ));
  }
}


class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
