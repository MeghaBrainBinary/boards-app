// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:boards_app/common/toast_msg.dart';
import 'package:boards_app/screens/auth/model/login_model.dart';
import 'package:boards_app/services/http_servises.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<LoginModel?> loginApi({required String deviseToken, required String password}) async {
    try {
      String url = ApiEndPoints.login;
      Map<String, String> param = {
        'device_token': deviseToken,
        'password': password,
      };

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["success"];
        if (status == false) {
          errorTost( jsonDecode(response!.body)["message"]);
          return LoginModel();

        }
        else if (status == true) {

          return loginModelFromJson(response.body);

        }
      }
      else if (response != null && response.statusCode == 500) {
        errorTost( jsonDecode(response!.body)["message"]);

        return LoginModel();
      }
      else {
        errorTost( jsonDecode(response!.body)["message"]);
        return LoginModel();

      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorTost( e.toString());

      return LoginModel();

    }
  }
}
