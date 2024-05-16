import 'package:boards_app/screens/wallpaper_flow/wallpaper_dashboard/wallpaper_dashboard_controller.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomNavigationBar(BuildContext context) {
  WallPaperDashBoardController dashBoardController =
      Get.put(WallPaperDashBoardController());
  return Container(
    height: 67,
    width: Get.width * 0.8,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
            color: ColorRes.appColor.withOpacity(
              0.1,
            ),
            blurRadius: 20,
            spreadRadius: 20)
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(left: Get.width * 0.07, right: Get.width * 0.07),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Obx(
          () => GestureDetector(
              onTap: () {
                dashBoardController.selectedItem.value = 0;
              },
              child: SizedBox(
                height: (dashBoardController.selectedItem.value == 0)
                    ? Get.height * 0.04
                    : Get.height * 0.04,
                child: Image.asset(
                  (dashBoardController.selectedItem.value == 0)
                      ? AssetRes.homeFilled
                      : AssetRes.home,
                  color: (dashBoardController.selectedItem.value == 0)
                      ? ColorRes.appColor
                      : ColorRes.black,
                ),
              )),
        ),
        Obx(
          () => GestureDetector(
              onTap: () {
                dashBoardController.selectedItem.value = 1;
              },
              child: SizedBox(
                height: (dashBoardController.selectedItem.value == 1)
                    ? Get.height * 0.043
                    : Get.height * 0.04,
                child: Image.asset(
                  (dashBoardController.selectedItem.value == 1)
                      ? AssetRes.categoryFilled
                      : AssetRes.category,
                  color: (dashBoardController.selectedItem.value == 1)
                      ? ColorRes.appColor
                      : ColorRes.black,
                ),
              )),
        ),
        Obx(
          () => GestureDetector(
              onTap: () {
                dashBoardController.selectedItem.value = 2;
              },
              child: SizedBox(
                height: (dashBoardController.selectedItem.value == 2)
                    ? Get.height * 0.044
                    : Get.height * 0.036,
                child: Image.asset(
                  (dashBoardController.selectedItem.value == 2)
                      ? AssetRes.likeFilled
                      : AssetRes.like,
                  color: (dashBoardController.selectedItem.value == 2)
                      ? ColorRes.appColor
                      : ColorRes.black,
                ),
              )),
        )
      ]),
    ),
  );
}
