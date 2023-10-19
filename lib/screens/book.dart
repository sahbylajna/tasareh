import 'package:flutter/material.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/helpers/ui.dart';
import 'package:tasareeh/model/Demande.dart';
import 'package:tasareeh/screens/payment.dart';
import 'package:tasareeh/screens/show.dart';
import 'package:tasareeh/widgets/PDFViewerScreen.dart';

import '../home.dart';

class BookContent extends StatefulWidget {
  const BookContent({Key? key}) : super(key: key);

  @override
  _BookContentState createState() => _BookContentState();
}

class _BookContentState extends State<BookContent> {
  Color _primaryColor = Color.fromARGB(234, 176, 74, 1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
  late List<Demande> _list = [];
  bool _isLoading = true;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    _list = (await ApiService().getlist())!;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
         backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Center(child: Text('قائمة الطلبات')),
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
        body: _isLoading
            ? MyLoadingWidget()
            : ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: _list.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ShowContent(paramValue: _list[index])), (route) => true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(border: Border.all(color: _accentColor, width: 2), borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text(' ${_list[index].cERTYPE}/${_list[index].id}'), Text(' ${_list[index].type}')],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(_list[index].demandMessage()),
                              if (_list[index].pdf != null && _list[index].accepted.toString() == "3")
                                IconButton(
                                  icon: Icon(Icons.download, color: Color.fromARGB(255, 153, 117, 96)),
                                  onPressed: () async {
                                    String pdfUrl = '${_list[index].pdf}';
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PDFViewerScreen(pdfUrl: '$pdfUrl')));
                                  },
                                ),
                              if (_list[index].linkpayment != null && _list[index].accepted.toString() == "5")
                                IconButton(
                                  icon: Icon(Icons.payment, color: Color.fromARGB(255, 153, 117, 96)),
                                  onPressed: () async {
                                    String pdfUrl = '${_list[index].linkpayment}';
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(pdfUrl: pdfUrl)));
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
