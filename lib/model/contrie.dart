// To parse this JSON data, do
//
//     final contries = contriesFromJson(jsonString);

import 'dart:convert';

List<Contries> contriesFromJson(String str) => List<Contries>.from(json.decode(str).map((x) => Contries.fromJson(x)));

String contriesToJson(List<Contries> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contries {
    int id;
    String iso;
    String name;
    String iso3;
    int numcode;
    int phonecode;
    String active;

    Contries({
        required this.id,
        required this.iso,
        required this.name,
        required this.iso3,
        required this.numcode,
        required this.phonecode,
        required this.active,
    });

    factory Contries.fromJson(Map<String, dynamic> json) => Contries(
        id: json["id"],
        iso: json["iso"],
        name: json["name"],
        iso3: json["iso3"],
        numcode: json["numcode"],
        phonecode: json["phonecode"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "iso": iso,
        "name": name,
        "iso3": iso3,
        "numcode": numcode,
        "phonecode": phonecode,
        "active": active,
    };
}
