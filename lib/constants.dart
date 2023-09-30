import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  static String baseUrl = 'https://tasareeh.qa/api';
    static String bUrl = 'https://tasareeh.qa/';
  static String contries = '/contries';
  static String login = '/login';

  static String user = '/user';

  static String register = '/sungupp';
 static String term = '/term';

  static String signature = '/signature';
get userzs async => await SharedPreferences.getInstance();
  static String confiramtion = '/confiramtion';
    static String getcount = '/getcount';
  static String getlist = '/getlist';
  static String getnotification = '/getnotife';
     static String importations = '/importations';
  static String check = '/getcheck';
  static String exports = '/exports';

}
