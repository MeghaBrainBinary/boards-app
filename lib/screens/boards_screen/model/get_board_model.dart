// To parse this JSON data, do
//
//     final getBoardModel = getBoardModelFromJson(jsonString);

import 'dart:convert';

GetBoardModel getBoardModelFromJson(String str) => GetBoardModel.fromJson(json.decode(str));

String getBoardModelToJson(GetBoardModel data) => json.encode(data.toJson());

class GetBoardModel {
  GetBoardModel({
     this.success,
     this.data,
     this.message,
  });

  bool? success;
  List<Board>? data;
  String? message;

  factory GetBoardModel.fromJson(Map<String, dynamic> json) => GetBoardModel(
    success: json["success"],
    data: List<Board>.from(json["data"].map((x) => Board.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Board {
  Board({
     this.id,
     this.name,
     this.icon,
  });

  int? id;
  String? name;
  String? icon;

  factory Board.fromJson(Map<String, dynamic> json) => Board(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}
