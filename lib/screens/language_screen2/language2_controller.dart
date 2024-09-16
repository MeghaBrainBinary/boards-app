import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/boards_screen/api/language_api.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language2Controller2 extends GetxController {
  TextEditingController searchController = TextEditingController();
RxBool loader = false.obs;

GetBoardModel getBoardModel  = GetBoardModel();
List filterList =[];
  List language = [
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
  List<bool> isCheck =[];

  String selectedLanguage="English";
  String languageCode ="en";


  @override
  void onInit() {
    super.onInit();
    // Initialize isCheck and selectedLanguage when the controller is created
    isCheck = List.generate(language.length, (index) => false);
   // selectedLanguage = '';

    // Load the state from storage
    _loadState();
  }
  onSearch(dynamic val) {
    filterList = [];
    language.forEach((element) {
      if(element['name'].toString().toLowerCase().contains(val.toString().toLowerCase()) )
      {
        filterList.add(element);
       isCheck = List.generate(language.length, (index) => false);


      }});


    update(['lng']);
  }

  void _loadState() async {
    int? storedIndex = PrefService.getInt(PrefKeys.selectedLanguageIndex);
    String? storedLanguage =PrefService.getString(PrefKeys.selectedLanguage);

    if (storedIndex != null && storedLanguage != null) {
      // Update the controller state with the retrieved values
      isCheck = List.generate(language.length, (index) => index == storedIndex);
      selectedLanguage = storedLanguage;
      update(['lng']);
    }
  }

  List<String> languageList = [
    "Latvian",
    "Estonian",
    "Lithuanian",
    "English",
    "Russian",
  ];

  onTapLanguage(String language1,int index){


    isCheck = List.generate(language.length, (index) => false);

    isCheck[index] =true;


    // selectedLanguage = language1;
    selectedLanguage = languageList[index];
    PrefService.setValue(PrefKeys.selectedLanguageIndex,index);
    PrefService.setValue(PrefKeys.selectedLanguage,selectedLanguage);
    update(['lng']);
    update();

  }
  bool isTaped = false;

  onTapConfirm()async{
   if(isTaped == false) {
     isTaped = true;

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
     if (selectedLanguage == "Russian") {
       languageCode = "ru";
     }
     loader.value = true;

     PrefService.setValue(PrefKeys.language, selectedLanguage);
     PrefService.setValue(PrefKeys.code, languageCode);

     PrefService.setValue(PrefKeys.languageCode, languageCode);

     LocalizationService().changeLocale(selectedLanguage);

     //getBoardModel =await GetBoardApi.getBoardApi(languageCode);

     // print(getBoardModel.data![0].name);



     BoardsController boardsController = Get.put(BoardsController());
     Get.deleteAll(force: true);
     await boardsController.init(languageCode);
     loader.value = false;
     Get.offAndToNamed(AppRoutes.boardsPage, arguments: languageCode);
   }
  }


}
