
import 'dart:convert';

import 'package:tasareeh/model/Animal.dart';

List<Demande> DemandeFromJson(String str) => List<Demande>.from(json.decode(str).map((x) => Demande.fromJson(x)));

String DemandeToJson(List<Demande> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Demande {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? clientId;
  String? cERTYPE;
  String? cERLANG;
  String? cOMPID;
  String? eUSERQID;
  String? eXPNAME;
  String? eXPTEL;
  String? eXPQID;
  String? eXPFAX;
  String? eXPCOUNTRY;
  String? iMPNAME;
  String? iMPADDRESS;
  String? iMPFAX;
  String? iMPTEL;
  String? iMPPOBOX;
  String? iMPCOUNTRY;
  String? oRIGINCOUNTRY;
  String? sHIPPINGPLACE;
  String? eNTERYPORT;
  String? eXPECTEDARRIVALDATE;
  String? tRANSPORT;
  String? sHIPPINGDATE;
  String? aPPLICANTNAME;
  String? aPPLICANTTEL;
  String? eXPNATIONALITY;
  String? eXPPASSPORTNUM;
  String? accepted;
  String? reson;
  String? files;
  String? cERSERIAL;
  String? pledge;
  String? eXPCERSERIAL;
  String? pdf;
  String? linkpayment;
  String? type;
  String? date;
  List<Animal>? animal;

  Demande(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.clientId,
      this.cERTYPE,
      this.cERLANG,
      this.cOMPID,
      this.eUSERQID,
      this.eXPNAME,
      this.eXPTEL,
      this.eXPQID,
      this.eXPFAX,
      this.eXPCOUNTRY,
      this.iMPNAME,
      this.iMPADDRESS,
      this.iMPFAX,
      this.iMPTEL,
      this.iMPPOBOX,
      this.iMPCOUNTRY,
      this.oRIGINCOUNTRY,
      this.sHIPPINGPLACE,
      this.eNTERYPORT,
      this.eXPECTEDARRIVALDATE,
      this.tRANSPORT,
      this.sHIPPINGDATE,
      this.aPPLICANTNAME,
      this.aPPLICANTTEL,
      this.eXPNATIONALITY,
      this.eXPPASSPORTNUM,
      this.accepted,
      this.reson,
      this.files,
      this.cERSERIAL,
      this.pledge,
      this.eXPCERSERIAL,
      this.pdf,
      this.linkpayment,
      this.type,
      this.date,
      this.animal});

  Demande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    clientId = json['client_id'];
    cERTYPE = json['CER_TYPE'];
    cERLANG = json['CER_LANG'];
    cOMPID = json['COMP_ID'];
    eUSERQID = json['EUSER_QID'];
    eXPNAME = json['EXP_NAME'];
    eXPTEL = json['EXP_TEL'];
    eXPQID = json['EXP_QID'];
    eXPFAX = json['EXP_FAX'];
    eXPCOUNTRY = json['EXP_COUNTRY'];
    iMPNAME = json['IMP_NAME'];
    iMPADDRESS = json['IMP_ADDRESS'];
    iMPFAX = json['IMP_FAX'];
    iMPTEL = json['IMP_TEL'];
    iMPPOBOX = json['IMP_POBOX'];
    iMPCOUNTRY = json['IMP_COUNTRY'];
    oRIGINCOUNTRY = json['ORIGIN_COUNTRY'];
    sHIPPINGPLACE = json['SHIPPING_PLACE'];
    eNTERYPORT = json['ENTERY_PORT'];
    eXPECTEDARRIVALDATE = json['EXPECTED_ARRIVAL_DATE'];
    tRANSPORT = json['TRANSPORT'];
    sHIPPINGDATE = json['SHIPPING_DATE'];
    aPPLICANTNAME = json['APPLICANT_NAME'];
    aPPLICANTTEL = json['APPLICANT_TEL'];
    eXPNATIONALITY = json['EXP_NATIONALITY'];
    eXPPASSPORTNUM = json['EXP_PASSPORT_NUM'];
    accepted = json['accepted'];
    reson = json['reson'];
    files = json['files'];
    cERSERIAL = json['CER_SERIAL'];
    pledge = json['Pledge'];
    eXPCERSERIAL = json['EXP_CER_SERIAL'];
    pdf = json['pdf'];
    linkpayment = json['linkpayment'];
    type = json['type'];
    date = json['date'];
    if (json['animal'] != null) {
      animal = <Animal>[];
      json['animal'].forEach((v) {
        animal!.add(new Animal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['client_id'] = this.clientId;
    data['CER_TYPE'] = this.cERTYPE;
    data['CER_LANG'] = this.cERLANG;
    data['COMP_ID'] = this.cOMPID;
    data['EUSER_QID'] = this.eUSERQID;
    data['EXP_NAME'] = this.eXPNAME;
    data['EXP_TEL'] = this.eXPTEL;
    data['EXP_QID'] = this.eXPQID;
    data['EXP_FAX'] = this.eXPFAX;
    data['EXP_COUNTRY'] = this.eXPCOUNTRY;
    data['IMP_NAME'] = this.iMPNAME;
    data['IMP_ADDRESS'] = this.iMPADDRESS;
    data['IMP_FAX'] = this.iMPFAX;
    data['IMP_TEL'] = this.iMPTEL;
    data['IMP_POBOX'] = this.iMPPOBOX;
    data['IMP_COUNTRY'] = this.iMPCOUNTRY;
    data['ORIGIN_COUNTRY'] = this.oRIGINCOUNTRY;
    data['SHIPPING_PLACE'] = this.sHIPPINGPLACE;
    data['ENTERY_PORT'] = this.eNTERYPORT;
    data['EXPECTED_ARRIVAL_DATE'] = this.eXPECTEDARRIVALDATE;
    data['TRANSPORT'] = this.tRANSPORT;
    data['SHIPPING_DATE'] = this.sHIPPINGDATE;
    data['APPLICANT_NAME'] = this.aPPLICANTNAME;
    data['APPLICANT_TEL'] = this.aPPLICANTTEL;
    data['EXP_NATIONALITY'] = this.eXPNATIONALITY;
    data['EXP_PASSPORT_NUM'] = this.eXPPASSPORTNUM;
    data['accepted'] = this.accepted;
    data['reson'] = this.reson;
    data['files'] = this.files;
    data['CER_SERIAL'] = this.cERSERIAL;
    data['Pledge'] = this.pledge;
    data['EXP_CER_SERIAL'] = this.eXPCERSERIAL;
    data['pdf'] = this.pdf;
    data['linkpayment'] = this.linkpayment;
    data['type'] = this.type;
    data['date'] = this.date;
    if (this.animal != null) {
      data['animal'] = this.animal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
