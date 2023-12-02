// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "Data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.customerId,
    this.customerName,
    this.firstName,
    this.lastName,
    this.customerShortAddress,
    this.customerAddress1,
    this.customerAddress2,
    this.city,
    this.state,
    this.country,
    this.zip,
    this.customerMobile,
    this.customerTempMobile,
    this.customerEmail,
    this.image,
    this.password,
    this.decodePassword,
    this.token,
    this.isSocial,
    this.socialToken,
    this.firebaseToken,
    this.company,
    this.mobileStatus,
    this.status,
  });

  String? customerId;
  String? customerName;
  String? firstName;
  String? lastName;
  String? customerShortAddress;
  String? customerAddress1;
  String? customerAddress2;
  String? city;
  String? state;
  String? country;
  String? zip;
  String? customerMobile;
  String? customerTempMobile;
  String? customerEmail;
  String? image;
  String? password;
  String? decodePassword;
  String? token;
  String? isSocial;
  String? socialToken;
  String? firebaseToken;
  String? company;
  String? mobileStatus;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerId: json["customer_id"] ?? '',
        customerName: json["customer_name"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        customerShortAddress: json["customer_short_address"] ?? '',
        customerAddress1: json["customer_address_1"] ?? '',
        customerAddress2: json["customer_address_2"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        country: json["country"] ?? '',
        zip: json["zip"] ?? '',
        customerMobile: json["customer_mobile"] ?? '',
        customerTempMobile: json["customer_temp_mobile"] ?? '',
        customerEmail: json["customer_email"] ?? '',
        image: json["image"] ?? '',
        password: json["password"] ?? '',
        decodePassword: json["decode_password"] ?? '',
        token: json["token"] ?? '',
        isSocial: json["is_social"] ?? '',
        socialToken: json["social_token"] ?? '',
        firebaseToken: json["firebase_toke"] ?? '',
        company: json["company"] ?? '',
        mobileStatus: json["mobile_status"] ?? '',
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId ?? '',
        "customer_name": customerName ?? '',
        "first_name": firstName ?? '',
        "last_name": lastName ?? '',
        "customer_short_address": customerShortAddress ?? '',
        "customer_address_1": customerAddress1 ?? '',
        "customer_address_2": customerAddress2 ?? '',
        "city": city ?? '',
        "state": state ?? '',
        "country": country ?? '',
        "zip": zip ?? '',
        "customer_mobile": customerMobile ?? '',
        "customer_temp_mobile": customerTempMobile ?? '',
        "customer_email": customerEmail ?? '',
        "image": image ?? '',
        "password": password ?? '',
        "decode_password": decodePassword ?? '',
        "token": token ?? '',
        "is_social": isSocial ?? '',
        "social_token": socialToken ?? '',
        "firebase_token": firebaseToken ?? '',
        "company": company ?? '',
        "mobile_status": mobileStatus ?? '',
        "status": status ?? '',
      };
}
