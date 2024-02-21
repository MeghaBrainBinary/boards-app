// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:boards_app/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnlyViewWallpaperController extends GetxController {
  RxBool selectLike = false.obs;

  bool isLike = false;
  RxBool loader = false.obs;

  bool isMenuOpen = false;

  PageController pageController = PageController();
  List<String> downloadImages = PrefService.getList(PrefKeys.downloadImageList);

  int initialIndex = 0;
  List imageList = [
    AssetRes.wallpaperpre1,
    AssetRes.wallpaperpre2,
    AssetRes.wallpaperpre3,
    AssetRes.wallpaperpre4,
    AssetRes.wallpaperpre5,
    AssetRes.wallpaperpre6,
  ];
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  @override
  void onInit() {
    // TODO: implement onInit
    initialIndex = Get.arguments ?? 0;
    pageController = PageController(initialPage: initialIndex);
    super.onInit();
  }

  Future<void> onTapLike(String image, String categoryDocId, bool like) async {
    var id = PrefService.getString('docId');
    var isUser = PrefService.getBool('isUser');

    List favList = [];
    if (isUser == true) {
      favList.clear();
      await user.get().then((value) {
        value.docs.forEach((element) {
          if (element.id == id) {
            element['favourite'].forEach((e) {
              favList.add({
                'image': e['image'],
                "isFav": e['isFav'],
              });
            });
          } else {}
        });
        favList.add({
          'image': image,
          'isFav': true,
        });
      });
      user.doc(id).update({
        'favourite': favList,
      });
    } else {
      isLike = false;
      update(['onlyView']);
      Get.to(SignUpScreen());
    }
  }

  updateToCategory(String categoryDocId, String image, bool isLike) async {
    List list = [];
    CollectionReference category =
        FirebaseFirestore.instance.collection('category');
    await category.doc(categoryDocId).get().then((value) {
      value['image'].forEach((element) {
        if (element['imageLink'] == image) {
          list.add({
            'imageLink': element['imageLink'],
            'isFav': isLike,
          });
        } else {
          list.add({
            'imageLink': element['imageLink'],
            'isFav': element['isFav'],
          });
        }
      });
    });

    await category.doc(categoryDocId).update({
      'image': list,
    });
  }

  Future<void> onTapUnlike(
      String image, String categoryDocId, bool like) async {
    var id = PrefService.getString('docId');
    var isUser = PrefService.getBool('isUser');

    List favList = [];
    if (isUser == true) {
      favList.clear();
      await user.get().then((value) {
        value.docs.forEach((element) {
          if (element.id == id) {
            element['favourite'].forEach((e) {
              favList.add({
                'image': e['image'],
                "isFav": e['isFav'],
              });
            });
          } else {}
        });
        for (int i = 0; i < favList.length; i++) {
          if (image == favList[i]['image']) {
            favList.removeAt(i);
          }
        }
      });
      user.doc(id).update({
        'favourite': favList,
      });
      // Get.off(FavoritesScreen());
    } else {
      Get.to(SignUpScreen());
    }
  }
}
