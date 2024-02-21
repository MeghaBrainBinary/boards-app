// ignore_for_file: must_be_immutable
// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:boards_app/screens/auth/forgot_password_screen/forgot_password_screen.dart';
import 'package:boards_app/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:boards_app/screens/contact_us_screen/contact_us_screen.dart';
import 'package:boards_app/screens/language_screen/language_screen.dart';
import 'package:boards_app/screens/language_screen2/languagescreen2.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_screen.dart';
import 'package:boards_app/screens/settings_screen/settings_screen.dart';
import 'package:boards_app/screens/wallpaper_flow/downloads_screen/download_screen.dart';
import 'package:boards_app/screens/wallpaper_flow/favorites_screen/favorites_screen.dart';
import 'package:boards_app/screens/wallpaper_flow/home_screen/home_controller.dart';
import 'package:boards_app/screens/wallpaper_flow/wallpaper_dashboard/wallpaper_dashboard_controller.dart';
import 'package:boards_app/screens/wallpaper_flow/wallpapers_screen/wallpaper_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

WallPaperDashBoardController dashBoardController =
    Get.put(WallPaperDashBoardController());

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController homeController = Get.put(HomeController());
  final MyController myController = MyController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: homeController.scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          if (homeController.scaffoldKey.currentState!.hasDrawer) {
            debugPrint("------------+++++++:  ");
          }
          myController.onOutsideTap();
          dashBoardController.isShowbuttomBar.value = false;
          Get.reload();
          Get.forceAppUpdate();
          debugPrint(
              "------------+++++++:  ${dashBoardController.isShowbuttomBar.value}");
        },
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: Get.height * 0.34,
                ),
                GetBuilder<HomeController>(
                  id: 'boolList',
                  builder: (controller) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('category')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        homeController.allCategory.clear();
                        homeController.allCategory
                            .add({"name": "All", "id": "1"});
                        snapshot.data?.docs.forEach((element) {
                          homeController.allCategory.add({
                            "name": element['name'],
                            "id": element.id,
                          });
                        });
                        if (homeController.aBoolList.length !=
                            (homeController.allCategory.length)) {
                          homeController
                              .boolGenerate(homeController.allCategory.length);
                          homeController.onTapCategory(
                              0, homeController.allCategory.length, "1");
                        } else {}
                        return snapshot.data != null &&
                                snapshot.data!.docs.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: SizedBox(
                                  height: Get.height * 0.07,
                                  child: ListView.separated(
                                    itemCount:
                                        homeController.allCategory.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: 10,
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          homeController.onTapCategory(
                                              index,
                                              homeController.allCategory.length,
                                              homeController.allCategory[index]
                                                  ['id']);
                                          homeController.update(['boolList']);
                                          homeController.update(['data']);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: Get.height * 0.07,
                                          width: Get.width * 0.3,
                                          decoration: BoxDecoration(
                                              color: homeController
                                                      .aBoolList[index]
                                                  ? ColorRes.splashButton
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(17)),
                                          child: Text(
                                            homeController.allCategory[index]
                                                ['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Get.width * 0.044,
                                                color: homeController
                                                        .aBoolList[index]
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontFamily: "regularfont"),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SizedBox();
                      },
                    );
                  },
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GetBuilder<HomeController>(
                  id: 'data',
                  builder: (controller) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: homeController.allImage.length + 3,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 15,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) {
                              if ((index ==
                                      homeController.allImage.length + 3 - 1) ||
                                  (index ==
                                      homeController.allImage.length + 3 - 2) ||
                                  (index ==
                                      homeController.allImage.length + 3 - 3)) {
                                return SizedBox(
                                  height: Get.height * 0.19,
                                  width: Get.width * 0.86,
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () async {
                                    if (homeController.aBoolList[0] == true) {
                                      await homeController.onTapImage2(
                                          '1', homeController.allImage.length);
                                    } else {
                                      await homeController.onTapImage2(
                                          homeController.allImage[index]['id'],
                                          homeController.allImage.length);
                                    }
                                    // Get.to(
                                    //     () => OnlyViewWallpaperScreen(
                                    //           image: homeController
                                    //                   .allImage[index]
                                    //               ['imageLink'],
                                    //           docId: homeController
                                    //               .allImage[index]['id'],
                                    //           imageList:
                                    //               homeController.allImage,
                                    //           favBoolList:
                                    //               homeController.myBoolList,
                                    //         ),
                                    //     arguments: index);
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: Get.height * 0.19,
                                          width: Get.width * 0.86,
                                          alignment: Alignment.bottomCenter,
                                          clipBehavior: Clip.hardEdge,
                                          margin:
                                              const EdgeInsets.only(bottom: 17),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white.withOpacity(
                                                  0.8,
                                                ),
                                                width: 0),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            height: Get.height * 0.19,
                                            width: Get.width * 0.86,
                                            imageUrl: homeController
                                                .allImage[index]['imageLink'],
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              AssetRes.imagePlaceholder,
                                              fit: BoxFit.fill,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              AssetRes.imagePlaceholder,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: Get.height * 0.19,
                                          width: Get.width * 0.86,
                                          alignment: Alignment.bottomCenter,
                                          clipBehavior: Clip.hardEdge,
                                          margin:
                                              const EdgeInsets.only(bottom: 17),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white.withOpacity(
                                                  0.8,
                                                ),
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )

                // SizedBox(height: Get.height * 0.04,),
              ],
            ),
            // SizedBox(height: Get.height * 0.07,),
            Positioned(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: 20, bottom: 30),
                decoration: BoxDecoration(
                  color: ColorRes.color305EBE,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(33),
                    bottomLeft: Radius.circular(33),
                  ),
                ),
                height: Get.height * 0.26,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          dashBoardController.isShowbuttomBar.value = true;
                          homeController.scaffoldKey.currentState?.openDrawer();
                        },
                        child: SizedBox(
                          child: Image.asset(
                            AssetRes.DroverIcon,
                            scale: 3,
                          ),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      StringRes.ExploreTheBest,
                      style: TextStyle(
                          fontSize: Get.width * 0.08,
                          color: Colors.white,
                          fontFamily: "regularfont"),
                    ),
                    //   SizedBox(height: Get.height * 0.02,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Get.height * 0.1,
            ),
            Image.asset(
              AssetRes.appLogo,
              scale: 3,
            ),

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeController.drawerImageList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 42,
                  alignment: Alignment.center,
                  child: ListTile(
                    onTap: () async {
                      dashBoardController.isShowbuttomBar.value = false;
                      Get.back();
                      index == 0
                          ? dashBoardController.selectedItem.value = 0
                          : index == 1
                              ? Get.to(LanguageScreen22())
                              : index == 2
                                  ? Get.to(WFavoritesScreen())
                                  : index == 3
                                      ? Get.to(() => ContactUsScreen())
                                      : index == 4
                                          ? Get.to(SettingsScreen())
                                          : index == 5
                                              ? Get.back()
                                              : index == 6
                                                  ? Get.to(() =>
                                                      const WallPaperScreen())
                                                  : showDialogs(context);
                      debugPrint(
                          "--------------: ${dashBoardController.selectedItem.value}");
                    },
                    leading: Image.asset(
                      homeController.drawerImageList[index],
                      color: ColorRes.color305EBE,
                      height: 23,
                      width: 23,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      homeController.drawerImageNameList[index],
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "regularfont"),
                    ),
                    trailing: Icon(
                      Icons.navigate_next_sharp,
                      color: ColorRes.black,
                      size: 18,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    color: ColorRes.black.withOpacity(0.30),
                  ),
                );
              },
            ),
            // GetBuilder<HomeController>(
            //   id: 'home',
            //   builder: (controller) {
            //     return GestureDetector(
            //       onTap: () {
            //         dashBoardController.isShowbuttomBar.value = false;
            //         Get.back();
            //         if (PrefService.getBool('isUser')) {
            //           openScreen(context);
            //         } else {
            //           Get.to(SignUpScreen());
            //         }
            //       },
            //       child: Container(
            //         height: Get.height * 0.105,
            //         width: Get.width * 0.4,
            //         alignment: Alignment.center,
            //         margin: EdgeInsets.only(
            //             left: Get.width * 0.1,
            //             right: Get.width * 0.1,
            //             top: Get.height * 0.05),
            //         decoration: BoxDecoration(
            //           color: ColorRes.splashButton,
            //           borderRadius: BorderRadius.circular(15),
            //         ),
            //         child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Padding(
            //                 padding:
            //                     const EdgeInsets.only(left: 4.0, right: 18.0),
            //                 child: SizedBox(
            //                   child: Image.asset(
            //                     AssetRes.LogOutIcon,
            //                     scale: 4,
            //                   ),
            //                 ),
            //               ),
            //               Text(
            //                 PrefService.getBool('isUser')
            //                     ? StringRes.LogOut
            //                     : "Login",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.w900,
            //                     fontSize: Get.width * 0.05,
            //                     color: Colors.black,
            //                     fontFamily: "regularfont"),
            //               ),
            //             ]),
            //       ),
            //     );
            //   },
            // )
          ],
        ),
      ),
      onDrawerChanged: (isOpened) {
        if (isOpened == false) {
          dashBoardController.isShowbuttomBar.value = false;
        }
      },
    );
  }

  openScreen(BuildContext context, {int? index}) {
    showDialog(
      context: context,
      builder: (context) {
        return OrientationBuilder(builder: (context, orientation) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            children: [
              Container(
                height: Get.height * 0.4,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        AssetRes.bigLogutIcon,
                        scale: 3,
                      )),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                        child: Text(
                          StringRes.AreYouSure,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Get.width * 0.06,
                              color: Colors.white,
                              fontFamily: "blackfont"),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          PrefService.setValue('isUser', false);
                          PrefService.setValue('docId', '');

                          Get.back();
                          Get.to(SignUpScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: Get.height * 0.08,
                          width: Get.width * 0.45,
                          decoration: BoxDecoration(
                              color: ColorRes.splashButton,
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            StringRes.Yes,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: Get.width * 0.06,
                                color: Colors.black,
                                fontFamily: "regularfont"),
                          ),
                        ),
                      ),
                      const Spacer()
                    ]),
              )
            ],
          );
        });
      },
    );
  }
}

class MyController {
  void onOutsideTap() {}

  void onDrawerItemTap(int index) {}
}
