import 'dart:convert';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/splashScreen/model/add_device_token_model.dart';
import 'package:boards_app/services/http_servises.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddDeviceTokenApi {
  static Future addDeviceTokenApi() async {
    try {
      String url = ApiEndPoints.addDeviceToken;
      Map<String, String> param = {
        'device_token': PrefService.getString(PrefKeys.fcmToken),
      };

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});

      if (response != null && response.statusCode == 200) {


       return addDeviceTokenModelFromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
