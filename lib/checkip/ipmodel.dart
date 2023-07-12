// To parse this JSON data, do
//
//     final myipModel = myipModelFromJson(jsonString);

import 'dart:convert';

MyipModel myipModelFromJson(String str) => MyipModel.fromJson(json.decode(str));

String myipModelToJson(MyipModel data) => json.encode(data.toJson());

class MyipModel {
  String? ip;
  String? country;

  MyipModel({
    this.ip,
    this.country,
  });

  factory MyipModel.fromJson(Map<String, dynamic> json) => MyipModel(
        ip: json["ip"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "country": country,
      };
}
