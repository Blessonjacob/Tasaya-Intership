import 'dart:convert';

LocalityList localityListFromJson(String str) => LocalityList.fromJson(json.decode(str));

String localityListToJson(LocalityList data) => json.encode(data.toJson());

class LocalityList {
  LocalityList({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Localities>? data;

  factory LocalityList.fromJson(Map<String, dynamic> json) => LocalityList(
        status: json["status"],
        message: json["Message"],
        data: json["Data"] == null ? null : List<Localities>.from(json["Data"].map((x) => Localities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Localities {
  Localities({
    this.localityId,
    this.locality,
  });

  String? localityId;
  String? locality;

  factory Localities.fromJson(Map<String, dynamic> json) => Localities(
        localityId: json["locality_id"],
        locality: json["locality"],
      );

  Map<String, dynamic> toJson() => {
        "locality_id": localityId,
        "locality": locality,
      };
}
