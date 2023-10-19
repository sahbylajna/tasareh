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
  factory User.test() => User(
        id: 999,
        createdAt: "createdAt",
        updatedAt: "updatedAt",
        firstName: "firstName",
        lastName: "lastName",
        phone: "phone",
        email: "email",
        ud: "ud",
        photoUdFrent: "photoUdFrent",
        photoUdBack: "photoUdBack",
        contryId: 1,
        accepted: "accepted",
        singateur: "singateur",
        code: "code",
        virification: "virification",
        contry: "contry",
        adresse: "adresse",
        fax: "fax",
        pOBOX: "pOBOX",
        refused: "refused",
        deletedAt: "deletedAt",
      );

  User({
    required this.id,
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
    required this.singateur,
    required this.code,
    required this.virification,
    required this.contry,
    required this.adresse,
    required this.fax,
    required this.pOBOX,
    this.refused,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phone: json['phone'],
        email: json['email'],
        ud: json['ud'],
        photoUdFrent: json['photo_ud_frent'],
        photoUdBack: json['photo_ud_back'],
        contryId: json['contry_id'],
        accepted: json['accepted'],
        refused: json['refused'],
        deletedAt: json['deleted_at'],
        singateur: json['singateur'],
        code: json['code'],
        virification: json['virification'],
        contry: json['contry'],
        adresse: json['adresse'],
        fax: json['fax'],
        pOBOX: json['POBOX'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['ud'] = ud;
    data['photo_ud_frent'] = photoUdFrent;
    data['photo_ud_back'] = photoUdBack;
    data['contry_id'] = contryId;
    data['accepted'] = accepted;
    data['refused'] = refused;
    data['deleted_at'] = deletedAt;
    data['singateur'] = singateur;
    data['code'] = code;
    data['virification'] = virification;
    data['contry'] = contry;
    data['adresse'] = adresse;
    data['fax'] = fax;
    data['POBOX'] = pOBOX;
    return data;
  }
}
