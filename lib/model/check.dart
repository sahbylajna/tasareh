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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EXP_TOTAL_NUM'] = eXPTOTALNUM;
    data['ACTUAL_IMP_NUM'] = aCTUALIMPNUM;
    data['IMP_TOTAL_NUM'] = iMPTOTALNUM;
    data['ACTUAL_EXP_NUM'] = aCTUALEXPNUM;
    data['TOTAL_REST'] = tOTALREST;
    return data;
  }
}