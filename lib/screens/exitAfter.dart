import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tasareeh/animation/wrapper.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/helpers/dialogs.dart';
import 'package:tasareeh/helpers/ui.dart';
import 'package:tasareeh/home.dart';
import 'package:tasareeh/model/Demande.dart';
import 'package:tasareeh/model/check.dart';
import 'package:tasareeh/model/contrie.dart';
import 'package:tasareeh/model/success.dart';
import 'package:intl/intl.dart' as inl;
import 'package:tasareeh/model/term.dart';

class OutafterContent extends StatefulWidget {
  const OutafterContent({Key? key}) : super(key: key);

  @override
  _OutafterContentState createState() => _OutafterContentState();
}

class _OutafterContentState extends State<OutafterContent> {
  Color _primaryColor = Color.fromARGB(234, 176, 74, 1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
           backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Center(child: Text("خروج بعد المشاركة")),
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
class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  final _formKey0 = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool checkboxValue = false;
  late List<Contries> _contrie = [];
  term? _term;
  late List<Demande> _list = [];
  bool _isLoading = true;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    setState(() {
      _isLoading = false;
    });
    _list = (await ApiService().getimportations())!;
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
  Demande? IMP_CER_SERIAL;
  Contries? _EXPORT_COUNTRYa, _ORIGIN_COUNTRYa, _TRANSIET_COUNTRY;

  TextEditingController SHIPPING_DATE = TextEditingController();

  TextEditingController _controller = TextEditingController();

  DateTime dateTime0 = DateTime.now();
  DateTime dateTime1 = DateTime.now();
  String EXPORT_COUNTRY = '';
  String ORIGIN_COUNTRY = '';

  String TRANSIET_COUNTRY = '';

  String ANML_NUMBER = '';

  String? pdfFilePath, Pledge = '';

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
              type: StepperType.vertical,
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
                if (_index == 2) {
                  pass = _formKey2.currentState?.validate() ?? false;
                }
                if (!pass) {
                  return;
                }
                if (_index <= 1) {
                  setState(() {
                    _index += 1;
                    if (_index == 2) {
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
              //     print(hide);
              //     if (_index == 2) {
              //       hide = true;
              //     } else if (_index == 0) {
              //       hide = false;
              //     }
              //     print(hide);
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
                // STEP 1
                //
                //
                //
                //
                //
                //
                //
                //
                //
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
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                          SizedBox(height: 10),
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
                                        return DropdownMenuItem<Contries>(value: value, child: Text(value.name));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _EXPORT_COUNTRY = newValue;
                                        });
                                      },
                                      value: _EXPORT_COUNTRY,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Row(
                              children: [
                               
                                Expanded(
                                  child: DropdownButtonFormField<Contries>(
                                    validator: (value) => (value == null) ? 'يرجى تحديد البلد الأصلي' : null,
                                    hint: Text('البلد الأصلي '),
                                    items: _contrie.map<DropdownMenuItem<Contries>>((Contries value) {
                                      return DropdownMenuItem<Contries>(value: value, child: Text(value.name));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _ORIGIN_COUNTRY = newValue;
                                      });
                                    },
                                    value: _ORIGIN_COUNTRY,
                                  ),
                                ),
                              ],
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
                          const SizedBox(height: 10),
                          FormField<bool>(
                            validator: (value) {
                              if (!checkboxValue) {
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
                // STEP 2
                //
                //
                //
                //
                //
                //
                //
                //
                //
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
                  title: const Text('البحث'),
                  content: Form(
                    key: _formKey1,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                          SizedBox(height: 10),
                          Center(
                            child: Row(
                              children: [
                                Text('معرفه الخروج'),
                                SizedBox(width: 30),
                                Expanded(
                                  child: DropdownButtonFormField<Demande>(
                                    validator: (value) => (value == null) ? 'يرجى تحديد معرفه الخروج' : null,
                                    hint: Text('معرفه الخروج'),
                                    items: _list.map((Demande value) => DropdownMenuItem<Demande>(value: value, child: Text(value.cERSERIAL ?? ''))).toList(),
                                    value: IMP_CER_SERIAL,
                                    onChanged: (newValue) => setState(() => IMP_CER_SERIAL = newValue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [_primaryColor, _accentColor],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                              onPressed: checkd,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                elevation: 0,
                              ),
                              child: Text('البحث'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ]),
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
                // STEP 3
                //
                //
                //
                //
                //
                //
                //
                //
                //
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
                    key: _formKey2,
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
                            controller: _controller,
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
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                elevation: 0,
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

  Future<void> _apisend() async {
    if (!_formKey0.currentState!.validate() || !_formKey1.currentState!.validate() || !_formKey2.currentState!.validate()) {
      return;
    }
    List<String> variables = [
      _EXPORT_COUNTRY != null ? _EXPORT_COUNTRY!.name : '',
      _EXPORT_COUNTRYa != null ? _EXPORT_COUNTRYa!.name : '',
      _ORIGIN_COUNTRY != null ? _ORIGIN_COUNTRY!.name : '',
      _ORIGIN_COUNTRYa != null ? _ORIGIN_COUNTRYa!.name : '',
      _TRANSIET_COUNTRY != null ? _TRANSIET_COUNTRY!.name : '',
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

    Success? success = (await ApiService().Setexport(_EXPORT_COUNTRY!.name, _ORIGIN_COUNTRY!.name, _EXPORT_COUNTRYa!.name, _ORIGIN_COUNTRYa!.name, _TRANSIET_COUNTRY!.name,
        SHIPPING_DATE.text, _controller.text, pdfFilePath, Pledge, IMP_CER_SERIAL!.cERSERIAL.toString()));
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

  Future<void> checkd() async {
    List<String> variables = [IMP_CER_SERIAL != null ? IMP_CER_SERIAL!.cERSERIAL.toString() : ''];

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
    } else {
      dialogLoading(context);
      check checkss = (await ApiService().getcheck(IMP_CER_SERIAL!.cERSERIAL.toString()));
      if (!mounted) {
        return;
      }
      Navigator.of(context, rootNavigator: true).pop();
      final status = checkss.tOTALREST ?? '';
      if (checkss.tOTALREST != null) {
        _controller.text = checkss.tOTALREST!;
        dialogInfo(context, text: 'عدد هجن : $status');
      } else {
        dialogInfo(context, text: 'الرجاء إدخال بيانات صحيحة');
      }
    }
  }
}
