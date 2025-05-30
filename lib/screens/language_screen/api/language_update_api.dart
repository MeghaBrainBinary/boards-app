// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:boards_app/common/toast_msg.dart';
import 'package:boards_app/screens/auth/model/login_model.dart';
import 'package:boards_app/screens/language_screen/model/language_model.dart';
import 'package:boards_app/services/http_servises.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LanguageUpdateApi {
  static Future<UpdateLanguageModel?> languageUpdateApi() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      String persistentID ="";
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        persistentID = androidInfo.id.toString();

      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        persistentID= iosInfo.identifierForVendor.toString();

      }


      String url = ApiEndPoints.uploadLanguage;
      Map<String, String> param = {
        "lang":PrefService.getString(PrefKeys.languageCode)==""?"ru":PrefService.getString(PrefKeys.languageCode),
        "persistent_id":persistentID,

      };

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          return UpdateLanguageModel();

        }
        else if (status == true) {

          return updateLanguageModelFromJson(response.body);

        }
      }
      else if (response != null && response.statusCode == 500) {


        return UpdateLanguageModel();
      }
      else {
        return UpdateLanguageModel();

      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }


      return UpdateLanguageModel();

    }
  }
}
