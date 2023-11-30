
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class IntroController extends GetxController {

  List<String> intoPhoneImages=[
    AssetRes.OnePlus101,
    AssetRes.OnePlus102,
    AssetRes.OnePlus103,
  ];
  List<String> intoTextList=[
    StringRes.seeEveryDetails.tr,
    StringRes.easilyShareImages.tr,
    StringRes.click.tr,
  ];
  PageController pageController= PageController();
  int currentPage = 0;
}
