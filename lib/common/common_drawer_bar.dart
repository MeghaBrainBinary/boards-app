// ignore_for_file: non_constant_identifier_names

import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_screen.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget CommonDrawer(BuildContext context) {
  MyFolderController myFolderController = Get.put(MyFolderController());
  return Drawer(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(55), topLeft: Radius.circular(55))),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.1,
          ),
          Center(child: Image.asset(AssetRes.boards, width: Get.width * 0.3)),
          SizedBox(
            height: Get.height * 0.08,
          ),
          Expanded(
            flex: 2,
            child: ListView.separated(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: myFolderController.drawerTitleList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if (kDebugMode) {
                      print("Index: $index");
                    }

                    if(index==0)
                      {
                        Get.back();
                      }
                    else if (index == 1) {
                      if (kDebugMode) {
                        print("Index: $index");
                      }

                      Get.toNamed(AppRoutes.languageConfirmPage);

                      Get.back();
                    } else if (index == 2) {
                      Get.toNamed(AppRoutes.favourite);
                    } else if (index == 3) {
                      Get.toNamed(AppRoutes.contactUs);
                    } else if (index == 4) {
                      Get.toNamed(AppRoutes.setting);
                    } else {

                      showDialogs(context);
                    }

                  },
                  leading: Image.asset(
                    myFolderController.drawerImageList[index],
                    scale: 4,
                  ),
                  title: Text(myFolderController.drawerTitleList[index]),
                  trailing: const Icon(Icons.navigate_next),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  width: 50,
                  color: ColorRes.black.withOpacity(0.30),
                  margin: const EdgeInsets.symmetric(horizontal: 19),
                );
              },
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
        ],
      ));
}
