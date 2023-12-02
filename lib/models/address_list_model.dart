// To parse this JSON data, do
//
//     final addressList = addressListFromJson(jsonString);

import 'dart:convert';

AddressList addressListFromJson(String str) =>
    AddressList.fromJson(json.decode(str));

String addressListToJson(AddressList data) => json.encode(data.toJson());

class AddressList {
  AddressList({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.resultData,
  });

  String? responseCode;
  String? result;
  String? responseMsg;
  List<AddressData>? resultData;

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        resultData: List<AddressData>.from(
            json["ResultData"].map((x) => AddressData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "ResultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class AddressData {
  AddressData({
    this.id,
    this.uid,
    this.addressLine,
    this.houseNumber,
    this.apartment,
    this.city,
    this.latitude,
    this.pincode,
    this.longitude,
    this.directionToReach,
    this.type,
    this.status,
  });

  String? id;
  String? uid;
  String? addressLine;
  String? houseNumber;
  String? apartment;
  String? city;
  String? latitude;
  String? pincode;
  String? longitude;
  String? directionToReach;
  String? type;
  String? status;

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
        id: json["id"],
        uid: json["uid"],
        addressLine: json["address_line"],
        houseNumber: json["house_number"],
        apartment: json["apartment"],
        city: json["city"],
        latitude: json["latitude"],
        pincode: json["pincode"],
        longitude: json["longitude"],
        directionToReach: json["direction_to_reach"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "address_line": addressLine,
        "house_number": houseNumber,
        "apartment": apartment,
        "city": city,
        "latitude": latitude,
        "pincode": pincode,
        "longitude": longitude,
        "direction_to_reach": directionToReach,
        "type": type,
        "status": status,
      };
}
