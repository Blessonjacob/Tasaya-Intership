// To parse this JSON data, do
//
//     final deleteAddress = deleteAddressFromJson(jsonString);

import 'dart:convert';

DeleteAddress deleteAddressFromJson(String str) =>
    DeleteAddress.fromJson(json.decode(str));

String deleteAddressToJson(DeleteAddress data) => json.encode(data.toJson());

class DeleteAddress {
  DeleteAddress({
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  String? responseCode;
  String? result;
  String? responseMsg;

  factory DeleteAddress.fromJson(Map<String, dynamic> json) => DeleteAddress(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}
