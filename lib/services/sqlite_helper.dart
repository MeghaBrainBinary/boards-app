import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SqliteHelper {
  SqliteHelper._();

  static final SqliteHelper sqliteHelper = SqliteHelper._();

  Database? db;

  String dbname = "FavoriteBOard.db";

String tablename ="Favorites";
  String uniqueId = "uniqueId";
  String imageIDName = "imageId";
  String imageUrlName = "imageUrl";
  String fileTypeName = "type";


  Future<Database?> initdb({String? tableName}) async {

      String databasepath = await getDatabasesPath();

      String path = join(databasepath, dbname);

      db = await openDatabase(path, version: 1, onCreate: (db, version) async {
        /*  String query1 = " CREATE TABLE IF NOT EXISTS $tableName($uniqueId INTEGER PRIMARY KEY AUTOINCREMENT,$categorryId INTEGER,$questionId INTEGER,$location_id INTEGER,$imageList TEXT,$questionName TEXT,$categoryName TEXT,$complianceStatus TEXT,$observationText TEXT,$imageListPath TEXT);";
        await db.execute(query1);*/


        String query1 = " CREATE TABLE IF NOT EXISTS $tablename($uniqueId INTEGER PRIMARY KEY AUTOINCREMENT,$imageIDName TEXT,$imageUrlName TEXT,$fileTypeName TEXT);";
        await db.execute(query1);
      }
      );

      return db;
    }


//------------------------------------------------------

  Future<int> insertDb({
    required String imageID,
    required String imageUrl,
    required String type,
  }) async {


    String query =
        'INSERT INTO $tablename($imageIDName,$imageUrlName,$fileTypeName)VALUES(?,?,?);';
    List args = [
    imageID,
      imageUrl,
      type
    ];

    return await db!.rawInsert(query, args);
  }

  Future<List> fetch() async {
    db = await initdb();
    String query = "SELECT * FROM $tablename";

    List data = await db!.rawQuery(query);print(data);
    List<SqliteModel> alldata =
    data.map((e) => SqliteModel.fromjson(e)).toList();
    print(alldata);
    return alldata ?? [];
    //return data;
  }

  Future<int> update({
    required String imageID,
    required String imageUrl,
  }) async {
    db = await initdb();

    String query =
        "UPDATE $tablename SET $imageIDName = ?,$imageUrlName = ? WHERE $imageIDName = ?";

    List args = [
      imageID,
     imageUrl,
      imageID
    ];
    return await db!.rawUpdate(query, args);
  }



  delete(
  {
    required String imageID,
}
      ) async {
    db = await initdb();
    String querry = "DELETE FROM $tablename WHERE $imageIDName = ?";
    List args = [
      imageID,
    ];
    return await db!.rawDelete(querry,args);
  }

}



class SqliteModel {
  int? uniqueId;
  String? imageId;
  String? imageUrl;
  String? fileType;

  static List star = [];

  SqliteModel({
    required this.uniqueId,
    required this.imageId,
    required this.imageUrl,
    required this.fileType,
  });

  factory SqliteModel.fromjson(Map<String, dynamic> data) {
    return SqliteModel(
      uniqueId: data['uniqueId'],
      imageId: data['imageId'],
      imageUrl: data['imageUrl'],
      fileType: data['fileType'],
    );
  }

  Map<String, dynamic> toSetJson() => {
    "uniqueId": uniqueId,
    "imageId": imageId,
    "imageUrl": imageUrl,
    "fileType": fileType,
  };

}




