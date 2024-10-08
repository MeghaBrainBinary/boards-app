import 'dart:async';

import 'package:boards_app/screens/splashScreen/splash_screen_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController splashScreenController =
      Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();

    splashScreenController.addDeviceTokenApi();

    Timer(const Duration(seconds: 3), () {
      if (PrefService.getBool(PrefKeys.isLanguage) == false) {
       // Get.offAndToNamed(AppRoutes.introPage);
        Get.offAndToNamed( AppRoutes.languagePage);
      } else {
       // Get.to(() => SelectFlowScreen(language: ''));
         Get.offAndToNamed(AppRoutes.boardsPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Get.width,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetRes.background),
            fit: BoxFit.fill,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset(AssetRes.appNewLogo, width: Get.width * 0.5)),
          ],
        ),
      ),
    );
  }
}
