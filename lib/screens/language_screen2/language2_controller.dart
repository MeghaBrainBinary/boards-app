import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/boards_screen/api/language_api.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language2Controller2 extends GetxController {
  TextEditingController searchController = TextEditingController();
RxBool loader = false.obs;
  List<bool> isCheck = List.generate(4, (index) => false);
GetBoardModel getBoardModel  = GetBoardModel();
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
       isCheck = List.generate(filterList.length, (index) => false);


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

  onTapConfirm()async{

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
loader.value = true;

    PrefService.setValue(PrefKeys.language, selectedLanguage);
    LocalizationService().changeLocale(selectedLanguage);

    //getBoardModel =await GetBoardApi.getBoardApi(languageCode);

   // print(getBoardModel.data![0].name);

    loader.value = false;

BoardsController boardsController  = Get.put(BoardsController());
boardsController.init(languageCode);
    Get.offAndToNamed(AppRoutes.boardsPage,arguments: languageCode);
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
