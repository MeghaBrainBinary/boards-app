import 'dart:convert';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/services/http_servises.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetBoardApi {
  static Future getBoardApi(String language) async {
    try {
      String url = ApiEndPoints.getBoards;
      Map<String, String> param = {
        'language': language,
      };

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["success"];
        if (status == false) {
          Get.snackbar(
            StringRes.error.tr,
            jsonDecode(response.body)["message"],
            duration: const Duration(seconds: 3),
            colorText: ColorRes.white,
            backgroundColor: Colors.red,
          );
        } else if (status == true) {
          Get.snackbar(
            StringRes.success.tr,
            jsonDecode(response.body)["message"],
            duration: const Duration(seconds: 3),
            colorText: ColorRes.white,
            backgroundColor: Colors.green,
          );
          return getBoardModelFromJson(response.body);


          //  } else {}
        } else if (response!.statusCode == 500) {
          Get.snackbar(
            StringRes.error.tr,
            jsonDecode(response.body)["message"],
            duration: const Duration(seconds: 3),
            colorText: ColorRes.white,
            backgroundColor: Colors.red,
          );
        }
        else {
          Get.snackbar(
            StringRes.error.tr,
            jsonDecode(response.body)["message"],
            duration: const Duration(seconds: 3),
            colorText: ColorRes.white,
            backgroundColor: Colors.red,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
