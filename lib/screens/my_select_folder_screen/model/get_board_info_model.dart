// To parse this JSON data, do
//
//     final getBoardInfoModel = getBoardInfoModelFromJson(jsonString);

import 'dart:convert';

GetBoardInfoModel getBoardInfoModelFromJson(String str) => GetBoardInfoModel.fromJson(json.decode(str));

String getBoardInfoModelToJson(GetBoardInfoModel data) => json.encode(data.toJson());

class GetBoardInfoModel {
  GetBoardInfoModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<Datum>? data;
  String? message;

  factory GetBoardInfoModel.fromJson(Map<String, dynamic> json) => GetBoardInfoModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
