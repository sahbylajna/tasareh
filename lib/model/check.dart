import 'dart:convert';

check checkFromJson(String str) => check.fromJson(json.decode(str));

String checkToJson(check data) => json.encode(data.toJson());


class check {
  String? eXPTOTALNUM;
  String? aCTUALIMPNUM;
  String? iMPTOTALNUM;
  String? aCTUALEXPNUM;
  String? tOTALREST;

  check(
      {this.eXPTOTALNUM,
      this.aCTUALIMPNUM,
      this.iMPTOTALNUM,
      this.aCTUALEXPNUM,
      this.tOTALREST});

  check.fromJson(Map<String, dynamic> json) {
    eXPTOTALNUM = json['EXP_TOTAL_NUM'];
    aCTUALIMPNUM = json['ACTUAL_IMP_NUM'];
    iMPTOTALNUM = json['IMP_TOTAL_NUM'];
    aCTUALEXPNUM = json['ACTUAL_EXP_NUM'];
    tOTALREST = json['TOTAL_REST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EXP_TOTAL_NUM'] = this.eXPTOTALNUM;
    data['ACTUAL_IMP_NUM'] = this.aCTUALIMPNUM;
    data['IMP_TOTAL_NUM'] = this.iMPTOTALNUM;
    data['ACTUAL_EXP_NUM'] = this.aCTUALEXPNUM;
    data['TOTAL_REST'] = this.tOTALREST;
    return data;
  }
}