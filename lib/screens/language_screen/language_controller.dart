import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/boards_screen/api/language_api.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/select_flow_screen/select_flow_controller.dart';
import 'package:boards_app/screens/select_flow_screen/select_flow_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  TextEditingController searchController = TextEditingController();

  String selectedLanguage = "English";
  String languageCode = "en";
  GetBoardModel getBoardModel = GetBoardModel();
  RxBool loader = false.obs;

  List lngs = [

    {
      "image":AssetRes.latvin,
      "name":StringRes.latvian.tr,
    },
    {
      "image":AssetRes.estonian,
      "name":StringRes.estonian.tr,
    },
    {
      "image":AssetRes.lithunian,
      "name":StringRes.lithuanian.tr,
    },
    {
      "image":AssetRes.english,
      "name":StringRes.english.tr,
    },
    {
      "image":AssetRes.russia,
      "name":StringRes.russian.tr,
    }

  ];
  List filterLst = [];
  List clrs = List.generate(5, (index) => false);

  onSearch(dynamic val) {
    filterLst = [];
    lngs.forEach((element) {
      if (element['name']
          .toString()
          .toLowerCase()
          .contains(val.toString().toLowerCase())) {
        filterLst.add(element);
      }
    });

    clrs = List.generate(filterLst.length, (index) => false);
    // clrs[i] = true;

    update(['lng']);
  }

  onTapContainer(
      {required String language, required bool val, required int i}) {
    if (filterLst.isNotEmpty) {
      clrs = List.generate(filterLst.length, (index) => false);
    } else {
      clrs = List.generate(lngs.length, (index) => false);
    }
    clrs[i] = true;
    selectedLanguage = language;
    PrefService.setValue(PrefKeys.selectedLanguageIndex, i);
    PrefService.setValue(PrefKeys.selectedLanguage, selectedLanguage);
    print(selectedLanguage);

    update(['lng']);
  }

  onTapContinue() async {
    if (selectedLanguage == "English") {
      languageCode = "en";
    }
    if (selectedLanguage == "Latvian") {
      languageCode = "lv";
    }
    if (selectedLanguage == "Estonian") {
      languageCode = "et";
    }
    if (selectedLanguage == "Lithuanian") {
      languageCode = "lt";
    }
    if(selectedLanguage == "Russian")
    {
      languageCode ="ru";
    }
    loader.value = true;

    PrefService.setValue(PrefKeys.language, selectedLanguage);
    PrefService.setValue(PrefKeys.code, languageCode);
    LocalizationService().changeLocale(selectedLanguage);

    PrefService.setValue(PrefKeys.languageCode, languageCode);

//getBoardModel =await GetBoardApi.getBoardApi(languageCode);
    loader.value = false;
    PrefService.setValue(PrefKeys.isLanguage, true);

    Get.offAndToNamed(AppRoutes.boardsPage,arguments: languageCode);
    //
    // Get.to(() => SelectFlowScreen(
    //       language: languageCode,
    //     ));
  }
}
