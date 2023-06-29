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
  int? id;
  String? name;
  String? language;
  List<SubBoard>? subBoard;

  Datum({
     this.id,
     this.name,
     this.language,
     this.subBoard,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    language: json["language"],
    subBoard: List<SubBoard>.from(json["sub_board"].map((x) => SubBoard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "language": language,
    "sub_board": List<dynamic>.from(subBoard!.map((x) => x.toJson())),
  };
}

class SubBoard {
  int? id;
  String? name;
  String? language;
  String? parentId;
  String? subParentId;
  List<SubBoard>? subBoard;

  SubBoard({
     this.id,
     this.name,
     this.language,
     this.parentId,
     this.subParentId,
     this.subBoard,
  });

  factory SubBoard.fromJson(Map<String, dynamic> json) => SubBoard(
    id: json["id"],
    name: json["name"],
    language: json["language"],
    parentId: json["parent_id"],
    subParentId: json["sub_parent_id"],
    subBoard: List<SubBoard>.from(json["sub_board"].map((x) => SubBoard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "language": language,
    "parent_id": parentId,
    "sub_parent_id": subParentId,
    "sub_board": List<dynamic>.from(subBoard!.map((x) => x.toJson())),
  };
}
