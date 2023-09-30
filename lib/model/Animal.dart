import 'dart:convert';

Animal animalFromJson(String str) => Animal.fromJson(json.decode(str));

String animalToJson(Animal data) => json.encode(data.toJson());
class Animal {
  int? id;
  String? eXPORTCOUNTRY;
  String? oRIGINCOUNTRY;
  String? tRANSIETCOUNTRY;
  String? aNMLSPECIES;
  String? aNMLSEX;
  String? aNMLNUMBER;
  String? aNMLUSE;
  String? aNIMALBREED;
  int? clientId;
  String? createdAt;
  String? updatedAt;
  String? aNMLMICROCHIP;
  Pivot? pivot;

  Animal(String name, int age,
      {this.id,
      this.eXPORTCOUNTRY,
      this.oRIGINCOUNTRY,
      this.tRANSIETCOUNTRY,
      this.aNMLSPECIES,
      this.aNMLSEX,
      this.aNMLNUMBER,
      this.aNMLUSE,
      this.aNIMALBREED,
      this.clientId,
      this.createdAt,
      this.updatedAt,
      this.aNMLMICROCHIP,
      this.pivot});

  Animal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eXPORTCOUNTRY = json['EXPORT_COUNTRY'];
    oRIGINCOUNTRY = json['ORIGIN_COUNTRY'];
    tRANSIETCOUNTRY = json['TRANSIET_COUNTRY'];
    aNMLSPECIES = json['ANML_SPECIES'];
    aNMLSEX = json['ANML_SEX'];
    aNMLNUMBER = json['ANML_NUMBER'];
    aNMLUSE = json['ANML_USE'];
    aNIMALBREED = json['ANIMAL_BREED'];
    clientId = json['client_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    aNMLMICROCHIP = json['ANML_MICROCHIP'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['EXPORT_COUNTRY'] = eXPORTCOUNTRY;
    data['ORIGIN_COUNTRY'] = oRIGINCOUNTRY;
    data['TRANSIET_COUNTRY'] = tRANSIETCOUNTRY;
    data['ANML_SPECIES'] = aNMLSPECIES;
    data['ANML_SEX'] = aNMLSEX;
    data['ANML_NUMBER'] = aNMLNUMBER;
    data['ANML_USE'] = aNMLUSE;
    data['ANIMAL_BREED'] = aNIMALBREED;
    data['client_id'] = clientId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['ANML_MICROCHIP'] = aNMLMICROCHIP;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? importationId;
  int? aNIMALINFOsId;

  Pivot({this.importationId, this.aNIMALINFOsId});

  Pivot.fromJson(Map<String, dynamic> json) {
    importationId = json['importation_id'];
    aNIMALINFOsId = json['a_n_i_m_a_l__i_n_f_os_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['importation_id'] = importationId;
    data['a_n_i_m_a_l__i_n_f_os_id'] = aNIMALINFOsId;
    return data;
  }
}
