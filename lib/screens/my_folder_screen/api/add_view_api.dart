// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:boards_app/services/http_servises.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ViewApi {
  static Future viewApi(String boardImageId) async {
    try {
      String url = ApiEndPoints.view;
      Map<String, String> param = {
        'board_image_id': boardImageId,
      };

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {

        }
        else if (status == true) {

          return jsonDecode(response.body);

        } else if (response.statusCode == 500) {

        }
        else {

        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
