import 'dart:convert';

check checkFromJson(String str) => check.fromJson(json.decode(str));

String checkToJson(check data) => json.encode(data.toJson());

class check {
  String cERSERIAL;
  String? aPPLICIANTID;
  String statu;
  String? pAYMENTLINK;
  String? pAYMENTERROR;
  String? cERID;
  String? data;

  check({
   required this.cERSERIAL,
     required this.aPPLICIANTID,
   required   this.statu,
      this.pAYMENTLINK,
      this.pAYMENTERROR,
    required  this.cERID,
      this.data});

  factory check.fromJson(Map<String, dynamic> json) => check(
    cERSERIAL : json['CER_SERIAL'],
    aPPLICIANTID : json['APPLICIANT_ID'],
    statu : json['APPLICATION_STATUS'],
    pAYMENTLINK : json['PAYMENT_LINK'],
    pAYMENTERROR : json['PAYMENT_ERROR'],
    cERID : json['CER_ID'],
    data : json['data'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CER_SERIAL'] = cERSERIAL;
    data['APPLICIANT_ID'] = aPPLICIANTID;
    data['APPLICATION_STATUS'] = statu;
    data['PAYMENT_LINK'] = pAYMENTLINK;
    data['PAYMENT_ERROR'] = pAYMENTERROR;
    data['CER_ID'] = cERID;
    data['data'] = this.data;
    return data;
  }
}

