// To parse this JSON data, do
//
//     final getBoardModel = getBoardModelFromJson(jsonString);

import 'dart:convert';

GetBoardModel getBoardModelFromJson(String str) => GetBoardModel.fromJson(json.decode(str));

String getBoardModelToJson(GetBoardModel data) => json.encode(data.toJson());

class GetBoardModel {
  bool? success;
  List<Datum>? data;
  String? message;

  GetBoardModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetBoardModel.fromJson(Map<String, dynamic> json) => GetBoardModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  int? id;
  String? name;
  String? nameTextColor;
  String? nameFontFamily;
  String? quote;
  String? quoteTextColor;
  String? quoteFontFamily;
  String? icon;
  String? language;
  DateTime? createdAt;
  List<SubBoard>? subBoard;

  Datum({
    this.id,
    this.name,
    this.nameTextColor,
    this.nameFontFamily,
    this.quote,
    this.quoteTextColor,
    this.quoteFontFamily,
    this.icon,
    this.language,
    this.createdAt,
    this.subBoard,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    nameTextColor: json["name_text_color"],
    nameFontFamily: json["name_font_family"],
    quote: json["quote"],
    quoteTextColor: json["quote_text_color"],
    quoteFontFamily: json["quote_font_family"],
    icon: json["icon"],
    language: json["language"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    subBoard: json["sub_board"] == null ? [] : List<SubBoard>.from(json["sub_board"]!.map((x) => SubBoard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_text_color": nameTextColor,
    "name_font_family": nameFontFamily,
    "quote": quote,
    "quote_text_color": quoteTextColor,
    "quote_font_family": quoteFontFamily,
    "icon": icon,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "sub_board": subBoard == null ? [] : List<dynamic>.from(subBoard!.map((x) => x.toJson())),
  };
}

class SubBoard {
  int? id;
  String? name;
  String? nameTextColor;
  String? nameFontFamily;
  String? icon;
  String? language;
  int? parentId;
  int? subParentId;

  SubBoard({
    this.id,
    this.name,
    this.nameTextColor,
    this.nameFontFamily,
    this.icon,
    this.language,
    this.parentId,
    this.subParentId,
  });

  factory SubBoard.fromJson(Map<String, dynamic> json) => SubBoard(
    id: json["id"],
    name: json["name"],
    nameTextColor: json["name_text_color"],
    nameFontFamily: json["name_font_family"],
    icon: json["icon"],
    language: json["language"],
    parentId: json["parent_id"],
    subParentId: json["sub_parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_text_color": nameTextColor,
    "name_font_family": nameFontFamily,
    "icon": icon,
    "language": language,
    "parent_id": parentId,
    "sub_parent_id": subParentId,
  };
}
