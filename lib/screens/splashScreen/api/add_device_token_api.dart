// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:boards_app/screens/splashScreen/model/add_device_token_model.dart';
import 'package:boards_app/services/http_servises.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AddDeviceTokenApi {
  static Future addDeviceTokenApi() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;

String persistentID =allInfo['id'] ?? '';
      String url = ApiEndPoints.addDeviceToken;
      Map<String, String> param = {
        'device_token': PrefService.getString(PrefKeys.fcmToken),
        "lang":PrefService.getString(PrefKeys.languageCode)==""?"ru":PrefService.getString(PrefKeys.languageCode),
        "persistent_id":persistentID,
        "platform":Platform.isIOS?"ios":"android",
        "country":"usa"
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
