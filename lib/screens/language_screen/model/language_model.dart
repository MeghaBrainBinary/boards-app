// To parse this JSON data, do
//
//     final updateLanguageModel = updateLanguageModelFromJson(jsonString);

import 'dart:convert';

UpdateLanguageModel updateLanguageModelFromJson(String str) => UpdateLanguageModel.fromJson(json.decode(str));

String updateLanguageModelToJson(UpdateLanguageModel data) => json.encode(data.toJson());

class UpdateLanguageModel {
  bool? status;
  String? message;

  UpdateLanguageModel({
    this.status,
    this.message,
  });

  factory UpdateLanguageModel.fromJson(Map<String, dynamic> json) => UpdateLanguageModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
