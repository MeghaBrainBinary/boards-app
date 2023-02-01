import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  TextEditingController searchController = TextEditingController();

  String selectedLanguage="English";
  String languageCode ="en";

  List lngs = [
    StringRes.latvian,
    StringRes.english,
    StringRes.estonian,
    StringRes.lithuanian,
  ];
  List filterLst = [];
  List clrs = List.generate(9, (index) => false);

  onSearch(dynamic val) {
    filterLst = [];
    lngs.forEach((element) {
      if(element.toString().toLowerCase().contains(val.toString().toLowerCase()) )
      {
       filterLst.add(element);
      }});

        clrs = List.generate(filterLst.length, (index) => false);
        // clrs[i] = true;


    update(['lng']);
  }

  onTapContainer({required String language,required bool val, required int i}) {
    if (filterLst.isNotEmpty) {
      clrs = List.generate(filterLst.length, (index) => false);
    } else {
      clrs = List.generate(lngs.length, (index) => false);
    }
    clrs[i] = true;
    selectedLanguage = language;
    print(selectedLanguage);

    update(['lng']);
  }

  onTapContinue() {

if(selectedLanguage == "English")
  {
    languageCode ="en";
  }
if(selectedLanguage == "Latvian")
{
  languageCode ="lv";
}
if(selectedLanguage == "Estonian")
{
  languageCode ="et";
}
if(selectedLanguage == "Lithuanian")
{
  languageCode ="lt";
}


PrefService.setValue(PrefKeys.language, selectedLanguage);
 LocalizationService().changeLocale(selectedLanguage);


 BoardsController boardsController = Get.put(BoardsController());
 boardsController.init(languageCode);

    Get.offAndToNamed(AppRoutes.boardsPage,);
  }
}
