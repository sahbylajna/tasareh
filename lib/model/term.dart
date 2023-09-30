import 'dart:convert';
term termFromJson(String str) => term.fromJson(json.decode(str));

String termToJson(term data) => json.encode(data.toJson());
class term {
  String? termAr;
  String? termEn;
  String? conditionar;
  String? conditionen;

  term({this.termAr, this.termEn, this.conditionar, this.conditionen});

  term.fromJson(Map<String, dynamic> json) {
    termAr = json['term_ar'];
    termEn = json['term_en'];
    conditionar = json['Conditionar'];
    conditionen = json['Conditionen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_ar'] = this.termAr;
    data['term_en'] = this.termEn;
    data['Conditionar'] = this.conditionar;
    data['Conditionen'] = this.conditionen;
    return data;
  }
}
