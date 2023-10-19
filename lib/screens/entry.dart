import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tasareeh/animation/wrapper.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/helpers/dialogs.dart';
import 'package:tasareeh/home.dart';
import 'package:tasareeh/model/contrie.dart';
import 'package:tasareeh/model/success.dart';
import 'package:intl/intl.dart' as inl;
import 'package:tasareeh/model/term.dart';
import 'package:tasareeh/helpers/ui.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  State<JoinScreen> createState() => _InContentafterState();
}

class _InContentafterState extends State<JoinScreen> {
  Color _primaryColor = Color.fromARGB(234, 176, 74, 1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
           backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Center(child: Text("دخول للمشاركة")),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.0),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false),
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
          body: const Center(
            child: StepperExample(),
          ),
        ));
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  final _formKey0 = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  bool checkboxValue = false;
  late List<Contries> _contrie = [];
  term? _term;
  bool _isLoading = true;
  @override
  void initState() {
    _getData(context);
    super.initState();
  }

  void _getData(BuildContext context) async {
    _term = (await ApiService().getterm())!;
    _contrie = (await ApiService().getcontries())!;
    setState(() {
      _isLoading = false;
    });
  }

  int _index = 0;
  Color _primaryColor = Color.fromARGB(234, 176, 74, 1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
  bool hide = false;
  Contries? _EXPORT_COUNTRY, _ORIGIN_COUNTRY;

  Contries? _EXPORT_COUNTRYa, _ORIGIN_COUNTRYa, _TRANSIET_COUNTRY;

  TextEditingController EXPECTED_ARRIVAL_DATE = TextEditingController();
  TextEditingController SHIPPING_DATE = TextEditingController();
  // final GlobalKey<State> _statefulBuilderKey = GlobalKey<State>();
  DateTime dateTime0 = DateTime.now();
  DateTime dateTime1 = DateTime.now();
  String EXPORT_COUNTRY = '';
  String ORIGIN_COUNTRY = '';

  String TRANSIET_COUNTRY = '';

  String ANML_NUMBER = '';

  String? pdfFilePath, Pledge = '';
  String ENTERY_PORT = 'معبر ابو سمرة';

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        pdfFilePath = result.files.single.path;
      });
    }
  }

  final AnimatorCtrl ctrl = AnimatorCtrl();
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? MyLoadingWidget()
        : UploadWrapper(
         
            animatorCtrl: ctrl,
            okAction: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false),
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _index,

              onStepContinue: () {
                bool pass = true;
                if (_index == 0) {
                  pass = _formKey0.currentState?.validate() ?? false;
                  if (pass && pdfFilePath == null) {
                    dialogError(context, message: 'كشف المطايا ضروري');
                    pass = false;
                  }
                }
                if (_index == 1) {
                  pass = _formKey1.currentState?.validate() ?? false;
                }
                if (!pass) {
                  return;
                }
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                    if (_index == 1) {
                      hide = true;
                    } else if (_index == 0) {
                      hide = false;
                    }
                    print(_index);
                  });
                }
              },
              // onStepTapped: (int index) {
              //   setState(() {
              //     _index = index;
              //      print(hide);
              //      if (_index == 1) {
              //        hide = true;
              //      }else if (_index == 0) {
              //       hide = false;
              //      }
              //       print(hide);
              //   });
              // },
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },

              steps: <Step>[
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                // STAP 1
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                Step(
                  title: const Text('البيانات العامة'),
                  content: Form(
                    key: _formKey0,
                    child: SingleChildScrollView(
                      
                        // Wrap your content with SingleChildScrollView
                        child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
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
                                  width: 25,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) => (value == null || value.isEmpty) ? 'يرجى تحديد منفذ الدخول' : null,
                                    hint: Text('منفذ الدخول'),
                                    items: <String>['معبر ابو سمرة'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        ENTERY_PORT = newValue.toString();

                                        // print("selected2 "+_EXPORT_COUNTRY!.name);
                                      });
                                    },
                                    value: ENTERY_PORT,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            TextFormField(
                              validator: (value) => (value == null || value.isEmpty) ? 'يرجى تحديد تاريخ الوصول المتوقع' : null,
                              controller: EXPECTED_ARRIVAL_DATE,
                              decoration: const InputDecoration(
                                label: Text('تاريخ الوصول المتوقع'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Positioned.fill(
                              child: InkWell(
                                  onTap: () async {
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: dateTime0,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(dateTime0.year + 2),
                                    );
                                    if (newDate == null) return;
                                    setState(() {
                                      dateTime0 = newDate;
                                      EXPECTED_ARRIVAL_DATE.text = inl.DateFormat('yyyy-MM-dd').format(dateTime0);
                                      print(dateTime0);
                                    });
                                  },
                                  child: null),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            TextFormField(
                              validator: (value) => (value == null || value.isEmpty) ? 'يرجى تحديد تاريخ الشحن' : null,
                              controller: SHIPPING_DATE,
                              decoration: const InputDecoration(label: Text('تاريخ الشحن'), border: OutlineInputBorder()),
                            ),
                            Positioned.fill(
                              child: InkWell(
                                  onTap: () async {
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: dateTime1,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(dateTime1.year + 2),
                                    );
                                    if (newDate == null) return;
                                    setState(() {
                                      dateTime1 = newDate;
                                      SHIPPING_DATE.text = inl.DateFormat('yyyy-MM-dd').format(dateTime1);
                                      print(dateTime1);
                                    });
                                  },
                                  child: Container()),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Row(
                              children: [
                                
                                Expanded(
                                  child: DropdownButtonFormField<Contries>(
                                    validator: (value) => (value == null) ? 'يرجى تحديد البلد المصدر' : null,
                                    hint: Text('البلد المصدر'),
                                    items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                      return DropdownMenuItem<Contries>(
                                        value: value,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _EXPORT_COUNTRY = newValue;
                                        // print("selected2 "+_EXPORT_COUNTRY!.name);
                                      });
                                    },
                                    value: _EXPORT_COUNTRY,
                                  ),
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
                             
                                Expanded(
                                  child: DropdownButtonFormField<Contries>(
                                    validator: (value) => (value == null) ? 'يرجى تحديد البلد الأصلي' : null,
                                    hint: Text('البلد الأصلي '),
                                    items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                      return DropdownMenuItem<Contries>(
                                        value: value,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _ORIGIN_COUNTRY = newValue;
                                        // print("selected2 "+_selectedValue!.name);
                                      });
                                    },
                                    value: _ORIGIN_COUNTRY,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.attach_file),
                              onPressed: _pickPDF,
                              label: Text('كشف المطايا'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        FormField<bool>(
                          validator: (value) {
                            if (value == null || !value) {
                              return 'تحتاج إلى قبول الشروط والأحكام';
                            } else {}
                            return null;
                          },
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
                                    Text("أوافق على التعهد.", style: TextStyle(color: Colors.grey)),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () => dialogInfo(context, title: 'التعهد', text: _term?.conditionar ?? ''),
                                      child: Text("نص التعهد", style: TextStyle(color: Colors.blue)),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ]),
                    )),
                  ),
                ),
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                // STAP 2
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                Step(
                  title: const Text('أضف هجن'),
                  content: Form(
                    key: _formKey1,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<Contries>(
                                      validator: (value) => (value == null) ? 'يرجى تحديد بلد التصدير' : null,
                                      hint: Text('بلد التصدير'),
                                      items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                        return DropdownMenuItem<Contries>(value: value, child: Text(value.name));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _EXPORT_COUNTRYa = newValue;
                                          EXPORT_COUNTRY = newValue!.name;
                                          print("selected2 $EXPORT_COUNTRY");
                                        });
                                      },
                                      value: _EXPORT_COUNTRYa,
                                    ),
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
                                  Expanded(
                                    child: DropdownButtonFormField<Contries>(
                                      validator: (value) => (value == null) ? 'يرجى تحديد البلد الأصلي' : null,
                                      hint: Text('البلد الأصلي'),
                                      items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                        return DropdownMenuItem<Contries>(value: value, child: Text(value.name));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _ORIGIN_COUNTRYa = newValue;
                                          ORIGIN_COUNTRY = newValue!.name;
                                        });
                                      },
                                      value: _ORIGIN_COUNTRYa,
                                    ),
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
                                  Expanded(
                                    child: DropdownButtonFormField<Contries>(
                                      validator: (value) => (value == null) ? 'يرجى تحديد بلد العبور' : null,
                                      hint: Text('بلد العبور'),
                                      items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                        return DropdownMenuItem<Contries>(value: value, child: Text(value.name));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _TRANSIET_COUNTRY = newValue;
                                          TRANSIET_COUNTRY = newValue!.name;
                                        });
                                      },
                                      value: _TRANSIET_COUNTRY,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) => (value == null || value.isEmpty) ? 'يرجى تحديد عدد هجن' : null,
                            // controller: _controller,
                            decoration: InputDecoration(labelText: 'عدد هجن'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              ANML_NUMBER = value;
                            },
                          ),
                          const SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [_primaryColor, _accentColor], begin: Alignment.centerLeft, end: Alignment.centerRight),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: _apisend,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                elevation: 0, // No shadow
                              ),
                              child: Text('إضافة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
              ],
              controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
                return Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: dtl.onStepContinue,
                      child: Text(hide == true ? '' : 'التالي'),
                    ),
                    TextButton(
                      onPressed: dtl.onStepCancel,
                      child: Text(hide == true ? '' : ''),
                    ),
                  ],
                );
              },
            ),
          );
  }

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  // HANDLERS
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  Future<void> _apisend() async {
    if (!_formKey0.currentState!.validate() || !_formKey1.currentState!.validate()) {
      return;
    }

    List<String> variables = [
      _EXPORT_COUNTRY != null ? _EXPORT_COUNTRY!.name : '',
      _EXPORT_COUNTRYa != null ? _EXPORT_COUNTRYa!.name : '',
      _ORIGIN_COUNTRY != null ? _ORIGIN_COUNTRY!.name : '',
      _ORIGIN_COUNTRYa != null ? _ORIGIN_COUNTRYa!.name : '',
      _TRANSIET_COUNTRY != null ? _TRANSIET_COUNTRY!.name : '',
      EXPECTED_ARRIVAL_DATE.text,
      SHIPPING_DATE.text,
    ];

    bool hasEmptyVariable = false;

    for (var variable in variables) {
      if (variable.isEmpty) {
        hasEmptyVariable = true;
        break;
      }
    }
    if (hasEmptyVariable) {
      dialogInfo(context, text: 'الرجاء إدخال بيانات صحيحة');
      return;
    }

    // showUpload(context);
    ctrl.startAnimation?.call();

    Success? success = (await ApiService().Setimportations(_EXPORT_COUNTRY!.name, _ORIGIN_COUNTRY!.name, _EXPORT_COUNTRYa!.name, _ORIGIN_COUNTRYa!.name, _TRANSIET_COUNTRY!.name,
        ENTERY_PORT, EXPECTED_ARRIVAL_DATE.text, SHIPPING_DATE.text, ANML_NUMBER, pdfFilePath, Pledge, ''));

    if (!mounted) {
      return;
    }
    // Navigator.of(context, rootNavigator: true).pop();
    if (success?.message == "success") {
      ctrl.finishAnimationWithSuccess?.call();
      // dialogSuccess(
      //   context,
      //   message: 'تم إرسال طلبك بنجاح',
      //   action: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false),
      // );
    } else {
      ctrl.finishAnimationWithFailure?.call();
      dialogInfo(context, text: 'الرجاء إدخال بيانات صحيحة');
    }
  }
}
