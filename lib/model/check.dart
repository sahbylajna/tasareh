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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CER_SERIAL'] = this.cERSERIAL;
    data['APPLICIANT_ID'] = this.aPPLICIANTID;
    data['APPLICATION_STATUS'] = this.statu;
    data['PAYMENT_LINK'] = this.pAYMENTLINK;
    data['PAYMENT_ERROR'] = this.pAYMENTERROR;
    data['CER_ID'] = this.cERID;
    data['data'] = this.data;
    return data;
  }
}

