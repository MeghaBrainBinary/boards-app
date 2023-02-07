import 'package:boards_app/localization/Estonian/Estonian.dart';
import 'package:boards_app/localization/Latvian/Latvian.dart';
import 'package:boards_app/localization/Lithuanian/Lithuanian.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/language_screen/language_controller.dart';
import 'package:boards_app/screens/language_screen2/language2_controller.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'English/English.dart';

class LocalizationService extends Translations {
  static const locale = Locale('en', 'EN');

  static const fallbackLocale = Locale('tr', 'TR');

  static final language = ["Latvian".tr, "English".tr, "Estonian".tr, "Lithuanian".tr];

  static final locales = [
    const Locale('lv', 'LV'),
    const Locale('en', "EN"),
    const Locale('et', "ET"),
    const Locale('lt', 'LT')
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'lv_LV': Latvian,
    'en_EN': English,
    'et_ET': Estonian,
    'lt_LT': Lithuanian,
  };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);

    print(locale!);

    LanguageController().update();
    BoardsController().update();
    MyFolderController().update();
    Language2Controller2().update();
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < language.length; i++) {
      debugPrint("You selected : ${language[i]}");
      if (lang == language[i]){
        print(language[i]);
        print(lang);
        return locales[i];}
    }
    return Get.locale;
  }
}
