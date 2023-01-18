import 'package:boards_app/utils/approutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List lngs = [
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
  List filterLst = [];
  List clrs = List.generate(9, (index) => false);

  onSearch(dynamic val) {
    filterLst = [];
    for (int i = 0; i < lngs.length; i++) {
      if (lngs[i].contains(val) ||
          lngs[i].contains(val.toString().toLowerCase()) ||
          lngs[i].contains(val.toString().toUpperCase())) {
        filterLst.add(lngs[i]);
        filterLst = filterLst.toSet().toList();
        clrs = List.generate(filterLst.length, (index) => false);
        // clrs[i] = true;
      }
    }
    update(['lng']);
  }

  onTapContainer({required bool val, required int i}) {
    if (filterLst.isNotEmpty) {
      clrs = List.generate(filterLst.length, (index) => false);
    } else {
      clrs = List.generate(lngs.length, (index) => false);
    }
    clrs[i] = true;
    update(['lng']);
  }

  onTapContinue() {
    Get.offAndToNamed(AppRoutes.boardsPage);
  }
}
