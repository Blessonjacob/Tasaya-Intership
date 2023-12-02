// To parse this JSON data, do
//
//     final registration = registrationFromJson(jsonString);

import 'dart:convert';

Registration registrationFromJson(String str) =>
    Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Registration({
    this.status,
    this.message,
    this.uid,
  });

  bool? status;
  String? message;
  int? uid;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        status: json["status"],
        message: json["Message"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "uid": uid,
      };
}
