import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language2Controller2 extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<bool> isCheck = List.generate(4, (index) => false);

List filterList =[];
  List language = [
    StringRes.latvian,
    StringRes.english,
    StringRes.estonian,
    StringRes.lithuanian,
  ];

  String selectedLanguage="English";
  String languageCode ="en";


  onSearch(dynamic val) {
    filterList = [];
    language.forEach((element) {
      if(element.toString().toLowerCase().contains(val.toString().toLowerCase()) )
      {
        filterList.add(element);
        List<bool> isCheck = List.generate(filterList.length, (index) => false);


      }});


    update(['lng']);
  }

  onTapLanguage(String language,int index){


    isCheck = List.generate(4, (index) => false);

    isCheck[index] =true;


    selectedLanguage = language;
    update(['lng']);
    update();

  }

  onTapConfirm(){

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // language.forEach((element) {
    //
    // if(PrefService.getString(PrefKeys.language) ==element)
    //   {
    //     isCheck[language.indexOf(element)] = true;
    //   }
    // });
  }
}
