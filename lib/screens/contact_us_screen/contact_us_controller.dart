
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedLanguage="English";
  String languageCode ="en";

  RxBool loader = false.obs;


  @override
  void onInit() {
emailIdController.text ="filuet.rus@gmail.com";
    super.onInit();
  }
}
