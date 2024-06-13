
import 'dart:io';

import 'package:boards_app/screens/contact_us_screen/api/contact_us_api.dart';
import 'package:boards_app/screens/contact_us_screen/api/contct_us_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  TextEditingController englishNumber = TextEditingController();
  TextEditingController estonianNumber = TextEditingController();
  TextEditingController latvianNumber = TextEditingController();
  TextEditingController lithuanianNumber = TextEditingController();
  TextEditingController telegramController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();

  String selectedLanguage="English";
  String languageCode ="en";

  RxBool loader = false.obs;


  @override
  void onInit() {
//emailIdController.text ="filuet.rus@gmail.com";

  init();
    super.onInit();
  }
  ContactUsModel contactUsModel = ContactUsModel();
  init()async{
    loader.value =true;
  contactUsModel =   await ContactUsApi.contactUsApi();

    englishNumber.text  = contactUsModel.data?.englishNumber ?? "";
    estonianNumber.text  = contactUsModel.data?.estonianNumber ?? "";
    latvianNumber.text  = contactUsModel.data?.latvianNumber ?? "";
    lithuanianNumber.text  = contactUsModel.data?.lithuanianNumber ?? "";
    telegramController.text  = contactUsModel.data?.telegram ?? "";
    emailIdController.text  = contactUsModel.data?.email ?? "";

    loader.value = false;
    update(['contactUs']);
  }


}
