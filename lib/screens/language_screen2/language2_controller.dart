import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language2Controller2 extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxInt number = 0.obs;
  RxInt onoff = 0.obs;
  RxInt onoffindex = 0.obs;
  RxList list = <int>[].obs;
  List name = [
    "Arabic",
    "Bengali",
    "Chinese",
    "French",
    "German",
    "Hindi",
    "English (US)",
    "English (UK)",
    "Japanese"
  ];
  String name2 = "";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onoff.value = 0;
      onoffindex.value = -1;
    });
  }
}
