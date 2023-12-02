// To parse this JSON data, do
//
//     final addressAdded = addressAddedFromJson(jsonString);

import 'dart:convert';

AddressAdded addressAddedFromJson(String str) =>
    AddressAdded.fromJson(json.decode(str));

String addressAddedToJson(AddressAdded data) => json.encode(data.toJson());

class AddressAdded {
  AddressAdded({
    this.address,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  Address? address;
  String? responseCode;
  String? result;
  String? responseMsg;

  factory AddressAdded.fromJson(Map<String, dynamic> json) => AddressAdded(
        address:
            json["Address"] == null ? null : Address.fromJson(json["Address"]),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "Address": address == null ? null : address!.toJson(),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Address {
  Address({
    this.id,
    this.uid,
    this.addressLine,
    this.houseNumber,
    this.latitude,
    this.longitude,
    this.pincode,
    this.apartment,
    this.city,
    this.directionToReach,
    this.type,
    this.status,
  });

  String? id;
  String? uid;
  String? addressLine;
  String? houseNumber;
  String? latitude;
  String? longitude;
  String? pincode;
  String? apartment;
  String? city;
  String? directionToReach;
  String? type;
  String? status;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        uid: json["uid"],
        addressLine: json["address_line"],
        houseNumber: json["house_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pincode: json["pincode"],
        apartment: json["apartment"],
        city: json["city"],
        directionToReach: json["direction_to_reach"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "address_line": addressLine,
        "house_number": houseNumber,
        "latitude": latitude,
        "longitude": longitude,
        "pincode": pincode,
        "apartment": apartment,
        "city": city,
        "direction_to_reach": directionToReach,
        "type": type,
        "status": status,
      };
}
