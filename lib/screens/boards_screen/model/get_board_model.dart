

import 'dart:convert';

GetBoardModel getBoardModelFromJson(String str) => GetBoardModel.fromJson(json.decode(str));

String getBoardModelToJson(GetBoardModel data) => json.encode(data.toJson());

class GetBoardModel {
  bool? success;
  List<Board>? data;
  String? message;

  GetBoardModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetBoardModel.fromJson(Map<String, dynamic> json) => GetBoardModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Board>.from(json["data"]!.map((x) => Board.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Board {
  int? id;
  String? name;
  String? icon;
  List<SubBoard>? subBoard;

  Board({
    this.id,
    this.name,
    this.icon,
    this.subBoard,
  });

  factory Board.fromJson(Map<String, dynamic> json) => Board(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    subBoard: json["sub_board"] == null ? [] : List<SubBoard>.from(json["sub_board"]!.map((x) => SubBoard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "sub_board": subBoard == null ? [] : List<dynamic>.from(subBoard!.map((x) => x.toJson())),
  };
}

class SubBoard {
  int? id;
  String? name;

  SubBoard({
    this.id,
    this.name,
  });

  factory SubBoard.fromJson(Map<String, dynamic> json) => SubBoard(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
