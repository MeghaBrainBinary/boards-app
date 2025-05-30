// ignore_for_file: prefer_is_empty

import 'dart:async';

import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/splashScreen/splash_screen_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
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


    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {

      if (message!= null) {
        await Future.delayed(const Duration(seconds: 1),(){

          redirectNotification(message.data);
        });
      }
      else
      {
       // await splashScreenController.addDeviceTokenApi();

        Timer(const Duration(seconds: 3), () {
          if (PrefService.getBool(PrefKeys.isLanguage) == false) {
            // Get.offAndToNamed(AppRoutes.introPage);
            Get.offAllNamed( AppRoutes.languagePage);
          } else {
            // Get.to(() => SelectFlowScreen(language: ''));
            if(PrefService.getBool(PrefKeys.isLogin)) {
              Get.offAllNamed(AppRoutes.boardsPage);
            }
            else{
              Get.offAllNamed(AppRoutes.login);
            }
          }
        });
      }

    });


  }


  static redirectNotification(Map<String,dynamic> message)async{
    if(message.containsKey("board_id")) {


      if(message['isImage']=="1") {


        TreeNodeData? treeData;
        BoardsController boardsController = Get.put(BoardsController());
        await boardsController.init(
            PrefService.getString(PrefKeys.languageCode));
        for (var element in boardsController.treeData) {
          if (element.id == int.parse(message['board_id'] ?? '0')) {
            if(message['sub_board_id'] !='') {
            if (element.children.length != 0) {
              for (var ele in element.children) {
                if (ele.id == int.parse(message['sub_board_id'] ?? '0')) {
                  treeData = ele;
                }
              }
            }
            else {
              treeData = element;
            }

          }else {
            treeData = element;
          }
          }
        }
        if (treeData != null) {
          await boardsController.onTapFolder(
            isFromNotification: true,
            node: treeData,
            treeData.id.toString(),
            treeData.name,
            (treeData.id.toString() == "0" && treeData.name == '') ? treeData.icon : treeData.icon,
            quote: treeData.quote,
            isFirst: (treeData.id.toString() == "0") ? true : false,
            quoteColor: treeData.quote_text_color,
            quoteFamily: treeData.quote_font_family,
            nameColor: treeData.name_text_color,
            nameFamily: treeData.name_font_family,
            mainCategory: (treeData.id.toString() == "0" &&
                treeData.name == '')
                ? treeData.name
                : treeData.name,
          );
        }

        int index = 0;
        MyFolderController myFolderController = Get.put(MyFolderController());
        if (myFolderController.getBoardInfoModel.data != null) {
          for (var element in myFolderController.getBoardInfoModel.data!) {
            if (element.id == int.parse(message['image_id'] ?? '0')) {
              index =
                  myFolderController.getBoardInfoModel.data!.indexOf(element);
            }
          }
          await myFolderController.onTapImage(index, fromNotification: true);
        }
      }

    }
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
