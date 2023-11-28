
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedLanguage="English";
  String languageCode ="en";

  List<bool> addSelectedImage = List.generate(4, (index) => false);

  RxBool loader = false.obs;


  List<String> settingTitleList = [
    StringRes.privacyPolicy,
    StringRes.changePassword,
    StringRes.deleteAccount,
  ];



  List<String> settingImageList = [
    AssetRes.privacyPolicy,
    AssetRes.lockIcon,
    AssetRes.deleteAcountIcon,

  ];

  List<String>? storedFavorites=[];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storedFavorites= PrefService.getList( PrefService.getString(PrefKeys.userId));
  }



}
