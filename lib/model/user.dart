// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String createdAt;
  String updatedAt;
  String firstName;
  String lastName;
  String phone;
  String email;
  String ud;
  String photoUdFrent;
  String photoUdBack;
  int contryId;
  String accepted;
  dynamic refused;
  dynamic deletedAt;
  String singateur;
  String code;
  String virification;
  String contry;
  String adresse;
  String fax;
  String pOBOX;

  User(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.ud,
      required this.photoUdFrent,
      required this.photoUdBack,
      required this.contryId,
      required this.accepted,
       this.refused,
       this.deletedAt,
      required this.singateur,
      required this.code,
      required this.virification,
      required this.contry,
      required this.adresse,
      required this.fax,
      required this.pOBOX});

   factory User.fromJson(Map<String, dynamic> json) => User(
    id : json['id'],
    createdAt : json['created_at'],
    updatedAt : json['updated_at'],
    firstName : json['first_name'],
    lastName : json['last_name'],
    phone : json['phone'],
    email : json['email'],
    ud : json['ud'],
    photoUdFrent : json['photo_ud_frent'],
    photoUdBack : json['photo_ud_back'],
    contryId : json['contry_id'],
    accepted : json['accepted'],
    refused : json['refused'],
    deletedAt : json['deleted_at'],
    singateur : json['singateur'],
    code : json['code'],
    virification : json['virification'],
    contry : json['contry'],
    adresse : json['adresse'],
    fax : json['fax'],
    pOBOX : json['POBOX'],
   );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['ud'] = this.ud;
    data['photo_ud_frent'] = this.photoUdFrent;
    data['photo_ud_back'] = this.photoUdBack;
    data['contry_id'] = this.contryId;
    data['accepted'] = this.accepted;
    data['refused'] = this.refused;
    data['deleted_at'] = this.deletedAt;
    data['singateur'] = this.singateur;
    data['code'] = this.code;
    data['virification'] = this.virification;
    data['contry'] = this.contry;
    data['adresse'] = this.adresse;
    data['fax'] = this.fax;
    data['POBOX'] = this.pOBOX;
    return data;
  }
}
