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

GetBoardModel getBoardModel  = GetBoardModel();
List filterList =[];
  List language = [
    StringRes.latvian,
    StringRes.estonian,
    StringRes.lithuanian,
    StringRes.english,
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
      if(element.toString().toLowerCase().contains(val.toString().toLowerCase()) )
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

  onTapLanguage(String language1,int index){


    isCheck = List.generate(language.length, (index) => false);

    isCheck[index] =true;


    selectedLanguage = language1;
    PrefService.setValue(PrefKeys.selectedLanguageIndex,index);
    PrefService.setValue(PrefKeys.selectedLanguage,selectedLanguage);
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
    PrefService.setValue(PrefKeys.code, languageCode);

    PrefService.setValue(PrefKeys.languageCode, languageCode);

    LocalizationService().changeLocale(selectedLanguage);

    //getBoardModel =await GetBoardApi.getBoardApi(languageCode);

   // print(getBoardModel.data![0].name);

    loader.value = false;

BoardsController boardsController  = Get.put(BoardsController());
    Get.deleteAll(force: true);
 await boardsController.init(languageCode);

    Get.offAndToNamed(AppRoutes.boardsPage,arguments: languageCode);

  }


}
