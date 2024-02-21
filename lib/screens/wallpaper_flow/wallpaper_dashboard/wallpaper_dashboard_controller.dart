// ignore_for_file: non_constant_identifier_names
import 'package:boards_app/screens/wallpaper_flow/categories_screen/categories_screen.dart';
import 'package:boards_app/screens/wallpaper_flow/favorites_screen/favorites_screen.dart';
import 'package:boards_app/screens/wallpaper_flow/home_screen/home_screen_screen.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WallPaperDashBoardController extends GetxController {
  RxInt selectedIndex = 1.obs;
  RxInt selectedItem = 0.obs;
  RxBool isShowbuttomBar = false.obs;

  List imageList = [
    AssetRes.newBackGround,
    AssetRes.newBackGround,
    AssetRes.newBackGround,
    AssetRes.newBackGround,
    AssetRes.newBackGround,
    AssetRes.newBackGround,
    AssetRes.newBackGround,
    AssetRes.newBackGround,
  ];
  RxList<Widget> Screens = <Widget>[
    HomeScreen(),
    CategoriesScreen(),
    WFavoritesScreen(),
  ].obs;
  RxList<Widget> WallpaperScreens = <Widget>[
    // CategoriesScreen(),
    // FavoritesScreen(),
    // SignUpScreen(),
  ].obs;
}
