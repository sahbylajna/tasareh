
import 'dart:convert';


List<notification> notificationFromJson(String str) => List<notification>.from(json.decode(str).map((x) => notification.fromJson(x)));

String notificationToJson(List<notification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class notification {
  int? id;
  int? userId;
  int? demandeId;
  String? type;
  String? commenter;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? message;
  String? date;

  notification(
      {this.id,
      this.userId,
      this.demandeId,
      this.type,
      this.commenter,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.message,
      this.date});

  notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['User_id'];
    demandeId = json['demande_id'];
    type = json['type'];
    commenter = json['commenter'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    message = json['message'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['User_id'] = this.userId;
    data['demande_id'] = this.demandeId;
    data['type'] = this.type;
    data['commenter'] = this.commenter;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['message'] = this.message;
    data['date'] = this.date;
    return data;
  }
}
