
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/home.dart';
import 'package:tasareeh/model/Demande.dart';
import 'package:tasareeh/model/contrie.dart';
import 'package:tasareeh/model/success.dart';
import 'package:intl/intl.dart' as inl;
import 'package:tasareeh/model/term.dart';

import '../model/check.dart';



class InContent extends StatefulWidget{
  const InContent({Key? key}): super(key:key);

  @override
  _InContentState createState() => _InContentState();
}



class _InContentState extends State<InContent>{
  Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);

 static const int rest = 1200;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
            appBar:AppBar(
              title: Center(child: Text("دخول بعد المشاركة")),
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






 const Center(
          child: StepperExample(),
        ),



        )
    );
  }



}











class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}



class _StepperExampleState extends State<StepperExample> {
      late List<Contries> _contrie = [];
        term? _term ;
          late List<Demande> _list = [];
    
 @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getData(context);
    });
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
 Lottie.network(    'https://lottie.host/66e2a97f-0826-425b-bca6-d7e1ee74f757/YmBvSTB48I.json'),                SizedBox(height: 15),
                Text('...تحميل'),

              ],
            ),
          ),
        );
      },
    );

  _list = (await ApiService().getexports())!;
          _term = (await ApiService().getterm())!;
    _contrie = (await ApiService().getcontries())!;
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
      // Close the dialog
    }
    }
  int _index = 0;
    Color _primaryColor = Color.fromARGB(234,176,74,1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
bool hide = false;
  Contries? _EXPORT_COUNTRY,_ORIGIN_COUNTRY;
Demande? EXP_CER_SERIAL;
  Contries? _EXPORT_COUNTRYa,_ORIGIN_COUNTRYa,_TRANSIET_COUNTRY;
  String ENTERY_PORT = 'معبر ابو سمرة';
TextEditingController _controller = TextEditingController();

  TextEditingController EXPECTED_ARRIVAL_DATE = TextEditingController();
  TextEditingController SHIPPING_DATE = TextEditingController();
  bool _validateENTERY_PORT = false;
    bool _validateEXP_CER_SERIAL = false;
  final GlobalKey<State> _statefulBuilderKey = GlobalKey<State>();
  DateTime dateTime0 = DateTime.now();
  DateTime dateTime1 = DateTime.now();
 String EXPORT_COUNTRY = '';
    String ORIGIN_COUNTRY = '';

    String TRANSIET_COUNTRY = '';

    String ANML_NUMBER = '0';
String ANML_NUMBER1 = '9999';
   String? files;

 Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        files = result.files.single.path;
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Stepper(
        type: StepperType.vertical,
      currentStep: _index,

      onStepContinue: () {
        if (_index <= 1) {
          setState(() {
            _index += 1;
           if (_index == 2) {
             hide = true;
           }else if (_index == 0) {
            hide = false;
           }
print(_index);
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
           print(hide);
           if (_index == 2) {
             hide = true;
           }else if (_index == 0) {
            hide = false;
           }
            print(hide);
        });
      },
  onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },

  steps: <Step>[
    
        Step(
          title: const Text('البيانات العامة'),
          content: Container(

            child: SingleChildScrollView( // Wrap your content with SingleChildScrollView
                child:  Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        SizedBox(
                          height: 10, // <-- SEE HERE
                        ),




                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Row(
                              children: [
                                Text('منفذ الدخول'),
                                SizedBox(
                                  width: 30,
                                ),
                                DropdownButton<String>(
                                  hint: Text('منفذ الدخول'),
                                  items: <String>['معبر ابو سمرة']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      ENTERY_PORT = newValue.toString();

                                      // print("selected2 "+_EXPORT_COUNTRY!.name.toString());
                                    });
                                  },
                                  value: ENTERY_PORT,
                                ),
                              ],
                            ),
                          ),
                        ),
    const SizedBox(
                          height: 10,
                        ),







                        InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Colors.blueAccent,
                                          //      .MainColor, // header background color
                                          onPrimary:
                                          Colors.white, // header text color
                                          onSurface: Colors.blueAccent
                                        //    .AccentColor, // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                context: context,
                                initialDate: dateTime0,
                                firstDate:
                                DateTime.now().subtract(const Duration(days: 0)),
                                lastDate: DateTime(dateTime0.year + 2));
                            if (newDate == null) return;
                            final newDateTime = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                            );

                            setState(() {
                              dateTime0 = newDateTime;
                              EXPECTED_ARRIVAL_DATE.text = inl.DateFormat(
                                'yyyy-MM-dd',
                              ).format(dateTime0);
                              print(dateTime0);
                            });
                          },


                          child: TextFormField(
                            controller: EXPECTED_ARRIVAL_DATE,
                            enabled: false,
                            decoration: const InputDecoration(
                                label: Text('تاريخ الوصول المتوقع'),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),









                        InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Colors.blueAccent,
                                          //      .MainColor, // header background color
                                          onPrimary:
                                          Colors.white, // header text color
                                          onSurface: Colors.blueAccent
                                        //    .AccentColor, // body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                context: context,
                                initialDate: dateTime1,
                                firstDate:
                                DateTime.now().subtract(const Duration(days: 0)),
                                lastDate: DateTime(dateTime1.year + 2));
                            if (newDate == null) return;
                            final newDateTime = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                            );

                            setState(() {
                              dateTime1 = newDateTime;
                              SHIPPING_DATE.text = inl.DateFormat(
                                'yyyy-MM-dd',
                              ).format(dateTime1);
                              print(dateTime1);
                            });
                          },


                          child: TextFormField(
                            controller: SHIPPING_DATE,
                            enabled: false,
                            decoration: const InputDecoration(
                                label: Text('تاريخ الشحن'),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
   Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Row(
                              children: [
                                Text('البلد المصدر '),
                                SizedBox(
                                  width: 30,
                                ),
                                DropdownButton<Contries>(
                                  hint: Text('البلد المصدر '),
                                  items:_contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                    return DropdownMenuItem<Contries>(
                                      value:  value ,
                                      child: Text( value.name ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _EXPORT_COUNTRY = newValue;
                                      // print("selected2 "+_EXPORT_COUNTRY!.name.toString());
                                    });
                                  },
                                  value: _EXPORT_COUNTRY,
                                ),
                              ],
                            ),
                          ),
                        ),


                        const SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Row(
                              children: [
                                Text('البلد الأصلي '),
                                SizedBox(
                                  width: 30,
                                ),
                                DropdownButton<Contries>(
                                  hint: Text('البلد الأصلي '),
                                  items:_contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                    return DropdownMenuItem<Contries>(
                                      value:  value ,
                                      child: Text( value.name ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _ORIGIN_COUNTRY = newValue;
                                      // print("selected2 "+_selectedValue!.name.toString());
                                    });
                                  },
                                  value: _ORIGIN_COUNTRY,
                                ),
                              ],
                            ),
                          ),
                        ),



                        const SizedBox(
                          height: 10,
                        ),

 ElevatedButton(
              onPressed: _pickPDF,
              child: Text( 'كشف المطايا'),
            ),

 const SizedBox(
                          height: 10,
                        ),

                  const SizedBox(
                          height: 10,
                        ),
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
                              _showDialog(_term);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                              elevation: 0, // No shadow
                            ),
                            child: Text(
                              'التعهد'.toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),











                      ]
                  ),
                  )
                  ),
          ),
        ),
         Step(
          title: const Text('البحث'),
          content: Container(

            child: SingleChildScrollView( // Wrap your content with SingleChildScrollView
                child:  Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        SizedBox(
                          height: 10, // <-- SEE HERE
                        ),


 Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Row(
                              children: [
                                Text('معرفه الخروج'),
                                SizedBox(
                                  width: 30,
                                ),
                                DropdownButton<Demande>(
                                  hint:  Text('معرفه الخروج'),
                                  items:_list.map<DropdownMenuItem<Demande>>((Demande value) {
                                    return DropdownMenuItem<Demande>(
                                      value:  value ,
                                      child: Text( value.cERSERIAL.toString() ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      EXP_CER_SERIAL = newValue;
                                      // print("selected2 "+_EXPORT_COUNTRY!.name.toString());
                                    });
                                  },
                                  value: EXP_CER_SERIAL,
                                ),
                              ],
                            ),
                          ),
                        ),



                        const SizedBox(
                          height: 10,
                        ),
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
                              checkd();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                              elevation: 0, // No shadow
                            ),
                            child: Text(
                              'البحث'.toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),



  const SizedBox(
                          height: 10,
                        ),












                      ]
                  ),
                  )
                  ),
          ),
        ),
         Step(
          title: const Text('أضف هجن'),
          content: Container(

            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                        child: Row(
                          children: [
                        //    Text('البلد التصدير '),

                            DropdownButton<Contries>(
                              hint: Text('بلد التصدير'),
                              items:_contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                return DropdownMenuItem<Contries>(
                                  value:  value ,
                                  child: Text( value.name ),
                                );
                              }).toList(),
                              onChanged: (newValue) {

                                setState(() {
                                  _EXPORT_COUNTRYa = newValue; // Update the selected value
                                  EXPORT_COUNTRY = newValue!.name; // Update the string value
                                  print("selected2 $EXPORT_COUNTRY");
                                });
                              },
                              value: _EXPORT_COUNTRYa,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                        child: Row(
                          children: [
                        //    Text('البلد الأصلي '),

                            DropdownButton<Contries>(
                              hint: Text('بلد الأصلي'),
                              items:_contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                return DropdownMenuItem<Contries>(
                                  value:  value ,
                                  child: Text( value.name ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _ORIGIN_COUNTRYa = newValue; // Update the selected value
                                  ORIGIN_COUNTRY = newValue!.name; // Update the string value
                                  print("ORIGIN_COUNTRY $ORIGIN_COUNTRY");
                                });
                              },
                              value: _ORIGIN_COUNTRYa,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                        child: Row(
                          children: [
                     //       Text('البلد العبور '),

                            DropdownButton<Contries>(
                              hint: Text('بلد العبور'),
                              items:_contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                return DropdownMenuItem<Contries>(
                                  value:  value ,
                                  child: Text( value.name ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _TRANSIET_COUNTRY = newValue; // Update the selected value
                                  TRANSIET_COUNTRY = newValue!.name; // Update the string value
                                  print("TRANSIET_COUNTRY $TRANSIET_COUNTRY");
                                });
                              },
                              value: _TRANSIET_COUNTRY,
                            ),
                          ],
                        ),
                      ),
                    ),


                    TextField(
                        controller: _controller,

                      decoration: InputDecoration(labelText: 'عدد هجن'),
                      keyboardType: TextInputType.number,
                       inputFormatters: [
                       FilteringTextInputFormatter.digitsOnly,
  ],
                      onChanged: (value) {
                       
                   
                         final number = int.tryParse(value);
                              var number1 = int.tryParse(ANML_NUMBER);
    if (number != null && number <= number1!) {
     log(value);
                    log(ANML_NUMBER);
  
    }else{
      _controller.text = ANML_NUMBER;
    }
                      },
                    ),


                       const SizedBox(
                          height: 10,
                        ),
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
                              _apisend();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                              elevation: 0, // No shadow
                            ),
                            child: Text(
                              'إضافة'.toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),



                  ],
                ),
              ),
          ),
        ),


      ],
      controlsBuilder: (BuildContext ctx, ControlsDetails dtl){
           return Row(
            children: <Widget>[
              TextButton(
                onPressed: dtl.onStepContinue,
                child: Text(hide == true ? '' :'التالي'),
              ),
              TextButton(
                onPressed: dtl.onStepCancel,
                child: Text(hide == true ? '' :''),
              ),
            ],
          );
        },



    );
  }


    Future<void>  _showDialog(term) async {

bool checkboxValue =false ;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(('التعهد')),
          content: Text(term!.conditionar),
          actions: <Widget>[
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
                                    Text("أوافق على التعهد.", style: TextStyle(color: Colors.grey),),
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
                              if (checkboxValue) {
                                                    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }
 
                              }
                              // Open a dialog to add a new row
         
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                              elevation: 0, // No shadow
                            ),
                            child: Text(
                               'موافق'.toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
          ],
        );
      },
    );
  }

   Future<void> _apisend() async {




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
    List<String> variables = [

      _EXPORT_COUNTRY != null ? _EXPORT_COUNTRY!.name.toString() : '',
      _EXPORT_COUNTRYa != null ? _EXPORT_COUNTRYa!.name.toString() : '',
      _ORIGIN_COUNTRY != null ? _ORIGIN_COUNTRY!.name.toString() : '',
      _ORIGIN_COUNTRYa != null ? _ORIGIN_COUNTRYa!.name.toString() : '',
      _TRANSIET_COUNTRY != null ? _TRANSIET_COUNTRY!.name.toString() : '',
    
      EXPECTED_ARRIVAL_DATE.text,
      SHIPPING_DATE.text,
       _controller.text,
      EXP_CER_SERIAL != null ? EXP_CER_SERIAL!.cERSERIAL.toString() : ''

    ];

    bool hasEmptyVariable = false;

    for (var variable in variables) {
      if (variable.isEmpty) {
        hasEmptyVariable = true;
        break;
      }
    }

    if (hasEmptyVariable || _controller.text == "0") {
      Navigator.of(context, rootNavigator: true).pop();
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
                children: const [

                  SizedBox(height: 15),
                  Text('الرجاء إدخال بيانات صحيحة')
                ],
              ),
            ),
          );
        },
      );

      Future.delayed(Duration(seconds: 2), () {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        }
      });
    } else {
      // All variables have values, you can proceed with your logic


    Success? success =  (await ApiService().Setimportations(_EXPORT_COUNTRY!.name.toString(),_ORIGIN_COUNTRY!.name.toString(),_EXPORT_COUNTRYa!.name.toString(),_ORIGIN_COUNTRYa!.name.toString(),_TRANSIET_COUNTRY!.name.toString(),ENTERY_PORT,EXPECTED_ARRIVAL_DATE.text,SHIPPING_DATE.text,_controller.text,files,'',EXP_CER_SERIAL!.cERSERIAL.toString()));

    if(success?.message =="success"){
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
Lottie.asset('assets/ok.json'),
              SizedBox(height: 15),
              Text('تم إرسال طلبك بنجاح'),



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
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: _primaryColor, // Text color
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                              elevation: 0, // No shadow
                            ),
                            child: Text(
                               'عودة للصفحة الرئيسية'.toUpperCase(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),





            ],
          ),
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {

  });



}else{
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
    // Close the dialog
  }
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
            children: const [

              SizedBox(height: 15),
              Text('الرجاء إدخال بيانات صحيحة')
            ],
          ),
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }
  });
}
    }

  }

Future<void> checkd() async {




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
                Lottie.network(    'https://lottie.host/66e2a97f-0826-425b-bca6-d7e1ee74f757/YmBvSTB48I.json'),
                SizedBox(height: 15),
                Text('...تحميل'),

              ],
            ),
          ),
        );
      },
    );
    List<String> variables = [


     EXP_CER_SERIAL != null ? EXP_CER_SERIAL!.cERSERIAL.toString() : ''

    ];

    bool hasEmptyVariable = false;

    for (var variable in variables) {
      if (variable.isEmpty) {
        hasEmptyVariable = true;
        break;
      }
    }

    if (hasEmptyVariable) {
      Navigator.of(context, rootNavigator: true).pop();
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
                children: const [

                  SizedBox(height: 15),
                  Text('الرجاء إدخال بيانات صحيحة')
                ],
              ),
            ),
          );
        },
      );

      Future.delayed(Duration(seconds: 2), () {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        }
      });
    } else {
      // All variables have values, you can proceed with your logic
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
  if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
        }
    check checkss =  (await ApiService().getcheck(EXP_CER_SERIAL!.cERSERIAL.toString()));

print(checkss.tOTALREST);
   setState(() {
     _controller.text = checkss.tOTALREST!;
     ANML_NUMBER = checkss.tOTALREST!;
      });

 final status = checkss.tOTALREST ?? '';
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }

  // ignore: use_build_context_synchronously
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
                SizedBox(height: 15),
                Text('عدد هجن : ' + status),
              ],
            ),
          ),
        );
      },
    );

  Future.delayed(Duration(seconds: 3), () {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    }

  });



}
    }









}
