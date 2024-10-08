// ignore_for_file: must_be_immutable, file_names

import 'package:boards_app/screens/wallpaper_flow/wallpaper_dashboard/wallpaper_dashboard_controller.dart';
import 'package:boards_app/screens/wallpaper_flow/wallpaper_dashboard/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WallPaperDashBoardScreen extends StatelessWidget {
  WallPaperDashBoardScreen({super.key});

  WallPaperDashBoardController dashBoardController =
      Get.put(WallPaperDashBoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(() => dashBoardController
              .Screens[dashBoardController.selectedItem.value]),
          Obx(
            () => dashBoardController.isShowbuttomBar.value == false
                ? Positioned(
                    bottom: Get.height * 0.04,
                    left: Get.width * 0.1,
                    child: bottomNavigationBar(context),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
