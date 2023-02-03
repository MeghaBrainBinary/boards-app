import 'dart:async';

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
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {

      if(PrefService.getBool(PrefKeys.isLanguage)==false) {
        Get.offAndToNamed(AppRoutes.languagePage);
        PrefService.setValue(PrefKeys.isLanguage, true);
     }
     else
       {
         Get.offAndToNamed(AppRoutes.boardsPage);
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(AssetRes.splashIcon, width: Get.width * 0.5)),
        ],
      ),
    );
  }
}
