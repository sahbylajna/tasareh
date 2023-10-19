import 'dart:developer';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tasareeh/model/Demande.dart';
import 'package:tasareeh/model/check.dart';
import 'package:tasareeh/model/count.dart';
import 'package:tasareeh/model/notification.dart';
import 'package:tasareeh/model/success.dart';
import 'package:tasareeh/model/token.dart';
import 'package:tasareeh/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:tasareeh/constants.dart';
import 'package:tasareeh/model/contrie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/term.dart';

Dio dio = Dio();

class HttpError implements Exception {}

class ApiService {
  get context => null;

  Future<List<Contries>?> getcontries() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.contries);
      var response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        List<Contries> model = contriesFromJson(response.body);
        print('dd');
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Token?> login(phone, password, contry) async {
    final data = {
      'phone': phone,
      'password': password,
      'contry_id': contry,
    };
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      print(data);
      // print(response.body);
      if (response.statusCode == 200) {
        Token model = tokenFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> getuser() async {
    // return User.test();
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.user);
      var response = await http.get(
        url,
        headers: <String, String>{"Accept": "application/json", 'Authorization': 'Bearer ${user.getString('token')}'},
      );
      if (response.statusCode == 200) {
        User model = userFromJson(response.body);
        user.setString('phone', model.phone);
        user.setString('first_name', model.firstName);
        user.setString('last_name', model.lastName);
        user.setString('email', model.email);
        user.setString('ud', model.ud);
        user.setInt('contry_id', model.contryId);

        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }



   Future<Success?> deleteuser() async {
    // return User.test();
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.delete);
      var response = await http.get(
        url,
        headers: <String, String>{"Accept": "application/json", 'Authorization': 'Bearer ${user.getString('token')}'},
      );
      if (response.statusCode == 200) {
         final model = successFromJson(response.body);
        // log(model.message.toString());
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


  Future<term?> getterm() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.term);
      print(url);
      var response = await http.get(
        url,
        headers: <String, String>{
          "Accept": "application/json",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
       // print(response.body);
        term model = termFromJson(response.body);

        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Success?> register(String firstName, String lastName, String phone, String password, String email, String ud, String contryId, String contry, String photoUdFrent,
      String photoUdBack, String adresse, String fax, String POBOX) async {
    log('e.toString()1h');
    print(firstName);
    print(lastName);
    print(phone);
    print(password);
    print(email);
    print(ud);
    print(contry);
    print(contryId);

    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.register);

      final Map<String, String> data = {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'password': password,
        'email': email,
        'ud': ud,
        'contry_id': contryId,
        'contry': contry,
        'adresse': adresse,
        'fax': fax,
        'POBOX': POBOX,
        'photo_ud_frent': photoUdFrent,
        'photo_ud_back': photoUdBack,
      };

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final model = successFromJson(response.body);
        // log(model.message.toString());
        return model;
      } else {
        log('Failed with status code: ${response.body}');
      }
    } catch (e, stackTrace) {
      log('Exception occurred: $e', error: e, stackTrace: stackTrace);
    }

    return null;
  }

  Future<Success?> signature(signature, id) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.signature}/" + id);
      print(url);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'signature': signature,
        }),
      );
      if (response.statusCode == 200) {
        Success model = successFromJson(response.body);
        return model;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
    return null;
  }

  Future<Success?> confiramtion(code, id) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.confiramtion}/" + id);
      print(url);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'code': code,
        }),
      );
      if (response.statusCode == 200) {
        Success model = successFromJson(response.body);
        return model;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
    return null;
  }



  Future<Success?> resend(id) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.resend}/" + id);
      print(url);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        
      );
      if (response.statusCode == 200) {
        Success model = successFromJson(response.body);
        return model;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
    return null;
  }

  Future<count?> getcount() async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getcount);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.getString('token')}',
      });

      if (response.statusCode == 200) {
        count model = countFromJson(response.body);
        print(model.importations);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<check> getcheck(String cerSerial) async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.check);
      var request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer ${user.getString('token')}';

      request.fields['CER_SERIAL'] = cerSerial;

      print(url);
      print(request);
      var response = await request.send();

      print('Bearer ${user.getString('token')}');
      print(cerSerial);
      final responseString = await response.stream.bytesToString();
      print(responseString);

      if (response.statusCode == 200) {
        return checkFromJson(responseString);
      }
    } catch (e) {
      log(e.toString());
      // Handle the error gracefully and return a default check object with an error message
      return check(
        eXPTOTALNUM: ' ',
        aCTUALIMPNUM: '',
        iMPTOTALNUM: 'يرجى التأكد من المعرفه',
        aCTUALEXPNUM: '',
        tOTALREST: '',
      );
    }

    // Handle the case where the response iMPTOTALNUMs code is not 200 gracefully
    return check(
      eXPTOTALNUM: ' ',
      aCTUALIMPNUM: '',
      iMPTOTALNUM: 'يرجى التأكد من المعرفه',
      aCTUALEXPNUM: '',
      tOTALREST: '',
    );
  }

  Future<List<Demande>?> getlist() async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getlist);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.getString('token')}',
      });

      if (response.statusCode == 200) {
        // print(response.body);
        List<Demande> model = DemandeFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Demande>?> getimportations() async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getimportations);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.getString('token')}',
      });

      if (response.statusCode == 200) {
        List<Demande> model = DemandeFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Demande>?> getexports() async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getexports);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.getString('token')}',
      });
      print(url);
      print('getexports');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        List<Demande> model = DemandeFromJson(response.body);
        return model;
      }
    } catch (e) {
       log('getexporssssssssssssssssssssssssssssssssssssssssssssssssts');
      log(e.toString());
    }
    return null;
  }

  Future<List<notification>?> getnotification() async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getnotification);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.getString('token')}',
      });

      if (response.statusCode == 200) {
        List<notification> model = notificationFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Success?> Setimportations(
      exportCountry, originCountry, exportCountrya, originCountrya, transietCountry, enteryPort, expectedArrivalDate, shippingDate, anmlNumber, files, Pledge, expCerSerial) async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.importations);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${user.getString('token')}';
      request.fields['EXPORT_COUNTRYa'] = exportCountrya;
      request.fields['ORIGIN_COUNTRYa'] = originCountrya;
      request.fields['TRANSIET_COUNTRYa'] = transietCountry;
      request.fields['ANML_NUMBER'] = anmlNumber;
      request.fields['EXPECTED_ARRIVAL_DATE'] = expectedArrivalDate;
      request.fields['EXP_COUNTRY'] = exportCountry;
      request.fields['ORIGIN_COUNTRY'] = originCountry;
      request.fields['EXP_CER_SERIAL'] = expCerSerial;
      request.fields['ENTERY_PORT'] = enteryPort;
      request.fields['SHIPPING_DATE'] = shippingDate;

      // Add the PDF file
      var pdfFile = await http.MultipartFile.fromPath('files', files);
      request.files.add(pdfFile);

      var response = await request.send();

      // FormData formdata = FormData.fromMap({
      //   "file": await MultipartFile.fromFile(files, filename: (files)),
      //   'EXPORT_COUNTRYa': exportCountrya,
      //   'ORIGIN_COUNTRYa': originCountrya,
      //   'TRANSIET_COUNTRYa': transietCountry,
      //   'ANML_NUMBER': anmlNumber,
      //   'EXPECTED_ARRIVAL_DATE': expectedArrivalDate,
      //   'EXP_COUNTRY': exportCountry,
      //   'ORIGIN_COUNTRY': originCountry,
      //   'EXP_CER_SERIAL': expCerSerial,
      //   'ENTERY_PORT': enteryPort,
      //   'SHIPPING_DATE': shippingDate,
      // });
      // final responsex = await dio.post(
      //   url.toString(),
      //   data: formdata,
      //   onSendProgress: (int sent, int total) {
      //     String percentage = (sent / total * 100).toStringAsFixed(2);
      //     // progress = "$sent" + " Bytes of " "$total Bytes - " + percentage + " % uploaded";
      //   },
      // );

      print('hnaaaaaaaaaaaaaaaaaaaaaa');
      final responseString = await response.stream.bytesToString();
      print(responseString);

      if (response.statusCode == 200) {
        // Handle a successful response here if needed
        Success model = successFromJson(responseString);
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Success?> Setexport(exportCountry, originCountry, exportCountrya, originCountrya, transietCountry, shippingDate, anmlNumber, files, Pledge, impCerSerial) async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.exports);
      var request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer ${user.getString('token')}';

      request.fields['EXPORT_COUNTRYa'] = exportCountrya;
      request.fields['ORIGIN_COUNTRYa'] = originCountrya;
      request.fields['TRANSIET_COUNTRYa'] = transietCountry;
      request.fields['ANML_NUMBER'] = anmlNumber;

      request.fields['EXP_COUNTRY'] = exportCountry;

      request.fields['ORIGIN_COUNTRY'] = originCountry;
      request.fields['IMP_CER_SERIAL'] = impCerSerial;

      request.fields['SHIPPING_DATE'] = shippingDate;

      // Add the PDF file
      var pdfFile = await http.MultipartFile.fromPath('files', files);
      request.files.add(pdfFile);

      print(request);
      // Send the request
      var response = await request.send();

      print('hnaaaaaaaaaaaaaaaaaaaaaa');
      final responseString = await response.stream.bytesToString();
      print(responseString);

      if (response.statusCode == 200) {
        // Handle a successful response here if needed
        Success model = successFromJson(responseString);
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Success?> Setexports(compId, euserQid, expName, expTel, expQid, expFax, expCountry, impName, impFax, impTel, impCountry, originCountry, shippingPlace, TRANSPORT,
      shippingDate, expNationality, expPassportNum, animalInfo, filePath) async {
    try {
      final user = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.exports);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${user.getString('token')}';

      // Add your other form data fields
      request.fields['COMP_ID'] = compId;
      request.fields['EUSER_QID'] = euserQid;
      request.fields['EXP_NAME'] = expName;
      request.fields['IMP_QID'] = expQid;
      request.fields['EXP_TEL'] = expTel;
      request.fields['EXP_FAX'] = expFax;
      request.fields['EXP_COUNTRY'] = expCountry;
      request.fields['IMP_NAME'] = impName;
      request.fields['IMP_FAX'] = impFax;
      request.fields['IMP_TEL'] = impTel;
      request.fields['IMP_COUNTRY'] = impCountry;
      request.fields['ORIGIN_COUNTRY'] = originCountry;
      request.fields['SHIPPING_PLACE'] = shippingPlace;
      request.fields['TRANSPORT'] = TRANSPORT;
      request.fields['SHIPPING_DATE'] = shippingDate;
      request.fields['EXP_NATIONALITY'] = expNationality;
      request.fields['EXP_PASSPORT_NUM'] = expPassportNum;
      request.fields['ANIMAL_INFO'] = jsonEncode(animalInfo);

      // Add the PDF file
      var pdfFile = await http.MultipartFile.fromPath('files', filePath);
      request.files.add(pdfFile);

      var response = await request.send();

      print('hnaaaaaaaaaaaaaaaaaaaaaa');
      final responseString = await response.stream.bytesToString();
      print(responseString);

      if (response.statusCode == 200) {
        // Handle a successful response here if needed
        Success model = successFromJson(responseString);
        return model;
      }
    } catch (e) {
      log(e.toString());
      print(e.toString());
    }
    return null;
  }
}
