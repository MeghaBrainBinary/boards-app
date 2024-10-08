import 'package:boards_app/localization/Estonian/Estonian.dart';
import 'package:boards_app/localization/Latvian/Latvian.dart';
import 'package:boards_app/localization/Lithuanian/Lithuanian.dart';
import 'package:boards_app/localization/Russian/Russian.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/language_screen/language_controller.dart';
import 'package:boards_app/screens/language_screen2/language2_controller.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LocalizationService extends Translations {
  static  var locale =
  (PrefService.getString(PrefKeys.code)== "")?const Locale('ru', 'RU')
      :
  Locale(PrefService.getString(PrefKeys.code),PrefService.getString(PrefKeys.code).toUpperCase());

  static const fallbackLocale = Locale('tr', 'TR');

  static final language = ["Latvian",
    //"English",
  "Estonian", "Lithuanian","Russian"];

  static final locales = [
    const Locale('lv', 'LV'),
   // const Locale('en', "EN"),
    const Locale('et', "ET"),
    const Locale('lt', 'LT'),
    const Locale('ru', 'RU')
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'lv_LV': Latvian,
   // 'en_EN': English,
    'et_ET': Estonian,
    'lt_LT': Lithuanian,
    'ru_RU': Russian,
  };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);

    if (kDebugMode) {
      print(locale);
    }

    LanguageController().update();
    BoardsController().update();
    MyFolderController().update();
    Language2Controller2().update();
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < language.length; i++) {
      debugPrint("You selected : ${language[i]}");
      if (lang == language[i]){
        if (kDebugMode) {
          print(language[i]);
        print(lang);
        }
        return locales[i];}
    }
    return Get.locale;
  }
}
