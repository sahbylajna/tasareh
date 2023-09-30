import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/model/notification.dart';
import 'package:tasareeh/screens/constants.dart';
import 'package:tasareeh/screens/home.dart';
import 'package:tasareeh/screens/show.dart';




class SettingsContent extends StatefulWidget{
  const SettingsContent({Key? key}): super(key:key);

  @override
  _SettingsContent createState() => _SettingsContent();
}


class _SettingsContent extends State<SettingsContent>{
  Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
       late List<notification> _list = [];
        late bool _isLoading;
@override
  void initState() {
    super.initState();
       _isLoading = true;

    Future.delayed(const Duration(seconds: 2), () {
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
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('تحميل...')
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)







    //Navigator.of(context).pop();
 Navigator.of(context).pop();



    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning

//   Navigator.of(context).pop();
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
               Lottie.network(    'https://lottie.host/66e2a97f-0826-425b-bca6-d7e1ee74f757/YmBvSTB48I.json'),               SizedBox(height: 15),
               Text('...تحميل'),

             ],
           ),
         ),
       );
     },
   );
      _list = (await ApiService().getnotification())!;
    //    Future.delayed(Duration.zero, () => showAlertDialog(context));
Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {

    }));

   if(_list != null){
     Future.delayed(Duration(seconds: 2), () {
       if (Navigator.of(context, rootNavigator: true).canPop()) {
         Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
       }
     });
   }



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
          title: Center(child: Text('اللجنة المنضمة لسباق الهجن')),
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
    body:_isLoading
            ? ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: defaultPadding),
              )
            :ListView.separated(
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
  mainAxisAlignment: MainAxisAlignment.start, // Alignement vertical des enfants
  crossAxisAlignment: CrossAxisAlignment.center, // Alignement horizontal des enfants
  children: [
    // Liste d'éléments à afficher verticalement
    Text(' ${_list[index].name}'),
    Text(' ${_list[index].type}') ,
    Text(' ${_list[index].message}'),
    Text(' ${_list[index].date}'),
    // ...
  ],
),





      ),
    onTap: () {
        print(_list[index].message);

    //   Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //       builder: (context) => showContent(paramValue: _list[index]), // Pass the parameter
    //     ),
    //         (route) => false,
    //   );
    //     print("Click event on x");
    },
)





      ;
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  )

    )
    );
  }
}
