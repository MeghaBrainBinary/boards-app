// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:boards_app/services/http_servises.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LogoutApi {
  static Future logoutApi() async {
    try {
      String url = ApiEndPoints.logout;
      Map<String, String> param = {
        'device_token': PrefService.getString(PrefKeys.fcmToken),
      };

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          // Get.snackbar(
          //   StringRes.error.tr,
          //   jsonDecode(response.body)["message"],
          //   duration: const Duration(seconds: 3),
          //   colorText: ColorRes.white,
          //   backgroundColor: Colors.red,
          // );
        } else if (status == true) {
          PrefService.clear();
          PrefService.setValue(PrefKeys.login, false);
          PrefService.setValue('isUser', false);
          PrefService.setValue('docId', '');
          Get.offAllNamed(AppRoutes.login);
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
