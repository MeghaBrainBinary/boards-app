// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  bool? success;
  Data? data;
  String? message;

  ContactUsModel({
    this.success,
    this.data,
    this.message,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  int? id;
  String? englishNumber;
  String? estonianNumber;
  String? latvianNumber;
  String? lithuanianNumber;
  String? telegram;
  String? email;

  Data({
    this.id,
    this.englishNumber,
    this.estonianNumber,
    this.latvianNumber,
    this.lithuanianNumber,
    this.telegram,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    englishNumber: json["english_number"],
    estonianNumber: json["estonian_number"],
    latvianNumber: json["latvian_number"],
    lithuanianNumber: json["lithuanian_number"],
    telegram: json["telegram"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "english_number": englishNumber,
    "estonian_number": estonianNumber,
    "latvian_number": latvianNumber,
    "lithuanian_number": lithuanianNumber,
    "telegram": telegram,
    "email": email,
  };
}
