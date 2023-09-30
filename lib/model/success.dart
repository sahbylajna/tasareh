// To parse this JSON data, do
//
//     final success = successFromJson(jsonString);

import 'dart:convert';

Success successFromJson(String str) => Success.fromJson(json.decode(str));

String successToJson(Success data) => json.encode(data.toJson());

class Success {
    int? id;
    String? message;
    String? errors;

    Success({
        this.id,
        this.message,
        this.errors,
    });

    factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"],
        message: json["message"],
        errors: json["errors"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "errors": errors,
    };
}
