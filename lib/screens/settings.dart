import 'package:flutter/material.dart';
import 'package:tasareeh/api_service.dart';
import 'package:tasareeh/helpers/ui.dart';
import 'package:tasareeh/model/notification.dart';
import 'package:tasareeh/screens/show.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  _SettingsContent createState() => _SettingsContent();
}

class _SettingsContent extends State<SettingsContent> {
  Color _primaryColor = Color.fromARGB(234, 176, 74, 1);
  Color _accentColor = Color.fromARGB(255, 90, 42, 8);
  late List<notification> _list = [];
  late bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _list = (await ApiService().getnotification()) ?? [];

    setState(() {
      _isLoading = false;
    });
  }

  Color getCorrectColor(accepted) {
    if (accepted == "1") {
      return Colors.green;
    } else if (accepted == "2") {
      return Colors.red;
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Center(child: Text('الاشعارات')),
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
        body: _isLoading
            ? MyLoadingWidget()
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: _list.length,
                
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(

                    child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                      //   color: getCorrectColor(_list[index].accepted),
                      decoration: BoxDecoration(border: Border.all(color: _accentColor, width: 2), borderRadius: BorderRadius.circular(20)),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text(' ${_list[index].name}'), 
                            Text(' ${_list[index].date}'),
                            Text(' ${_list[index].type}')],
                          ),

                            Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [ Text(' ${_list[index].message}'),
                          
                          ],
                          ),
                      
                          // ...
                        ],
                      ),
                    ),

                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
      ),
    );
  }
}
