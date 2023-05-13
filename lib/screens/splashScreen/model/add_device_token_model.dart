// To parse this JSON data, do
//
//     final addDeviceTokenModel = addDeviceTokenModelFromJson(jsonString);

import 'dart:convert';

AddDeviceTokenModel addDeviceTokenModelFromJson(String str) => AddDeviceTokenModel.fromJson(json.decode(str));

String addDeviceTokenModelToJson(AddDeviceTokenModel data) => json.encode(data.toJson());

class AddDeviceTokenModel {
  String? message;

  AddDeviceTokenModel({
    this.message,
  });

  factory AddDeviceTokenModel.fromJson(Map<String, dynamic> json) => AddDeviceTokenModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
