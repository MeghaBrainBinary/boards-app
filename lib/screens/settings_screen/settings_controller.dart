
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedLanguage="English";
  String languageCode ="en";

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



}
