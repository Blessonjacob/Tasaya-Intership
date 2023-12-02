
import 'dart:convert';

OrderPlaced orderPlacedFromJson(String str) =>
    OrderPlaced.fromJson(json.decode(str));

String orderPlacedToJson(OrderPlaced data) => json.encode(data.toJson());

class OrderPlaced {
  OrderPlaced({
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  String? responseCode;
  String? result;
  String? responseMsg;

  factory OrderPlaced.fromJson(Map<String, dynamic> json) => OrderPlaced(
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
