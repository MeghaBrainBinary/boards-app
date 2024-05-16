import 'package:boards_app/screens/select_flow_screen/select_flow_controller.dart';
import 'package:boards_app/screens/wallpaper_flow/wallpaper_dashboard/wallpaper_dashBoard_screen.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectFlowScreen extends StatelessWidget {
  SelectFlowScreen({Key? key, required this.language}) : super(key: key);
  final String language;
  final SelectFlowController selectFlowController =
      Get.put(SelectFlowController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SelectFlowController>(
      id: 'select',
      builder: (controller) {
        return Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AssetRes.gridImage,
                ),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: controller.isBoard
                          ? ColorRes.appColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                      border: Border.all(
                        color: ColorRes.appColor,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      StringRes.myBoards.tr,
                      style: appTextStyle(
                          color: controller.isBoard
                              ? ColorRes.white
                              : ColorRes.black,
                          fontSize: 20,
                          weight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    controller.isWallPaper = false;
                    controller.isBoard = true;
                    controller.update(['select']);
                    if (language != '') {
                      Get.offAndToNamed(AppRoutes.boardsPage,
                          arguments: language);
                    } else {
                      Get.offAndToNamed(AppRoutes.boardsPage);
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Or'.tr,
                  style: appTextStyle(
                      color: ColorRes.black,
                      fontSize: 20,
                      weight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    controller.isBoard = false;
                    controller.isWallPaper = true;
                    controller.update(['select']);
                    Get.to(() => WallPaperDashBoardScreen());
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: controller.isWallPaper
                          ? ColorRes.appColor
                          : ColorRes.white,
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                      border: Border.all(
                        color: ColorRes.appColor,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      StringRes.myWallpaper.tr,
                      style: appTextStyle(
                          color: controller.isWallPaper
                              ? ColorRes.white
                              : ColorRes.black,
                          fontSize: 20,
                          weight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.14,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
