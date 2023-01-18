import 'dart:math';

import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardsScreen extends StatelessWidget {
  BoardsScreen({super.key});

  BoardsController boardsController = Get.put(BoardsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: Get.height * 0.15,
        ),
        Center(
          child: Image.asset(
            AssetRes.splashIcon,
            width: 96,
          ),
        ),
        SizedBox(
          height: Get.height * 0.12,
        ),
        Padding(
          padding:
              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
          child: Row(
            children: [
              Text(
                StringRes.myBoards,
                style: appTextStyle(
                    color: ColorRes.black,
                    fontSize: 23,
                    weight: FontWeight.w600),
              )
            ],
          ),
        ),
        GetBuilder<BoardsController>(
          id: 'board',
          builder: (controller) => SizedBox(
            height: Get.height * 0.55,
            width: Get.width,
            child: ListView.builder(
                itemCount: controller.boards.length,
                itemBuilder: (context, index) {
                  List icons = List.generate(
                    controller.boards.length,
                    (index) => Icon(
                      Icons.arrow_right,
                      color: ColorRes.black,
                    ),
                  );
                  return Container(
                    // height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Get.height * 0.03),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05,
                                right: Get.width * 0.05),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.onTapIcon(true, index);
                                  },
                                  child: (controller.isIcons[index] == true)
                                      ? Transform.rotate(
                                          angle: pi / 2, child: icons[index])
                                      : icons[index],
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    boardsController.boardsIcons[index],
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.06,
                                ),
                                Text(
                                  controller.boards[index].toString(),
                                  style: appTextStyle(
                                      fontSize: 17,
                                      weight: FontWeight.w500,
                                      color: ColorRes.black),
                                ),
                              ],
                            ),
                          ),
                          (controller.isIcons[index] == true && index == 0)
                              ? InkWell(
                                  child: Container(
                                    height: Get.height * 0.055,
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.1,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          focusColor: ColorRes.color305EBE,
                                          hoverColor: ColorRes.color305EBE,
                                          splashColor: ColorRes.color305EBE
                                              .withOpacity(0.1),
                                          overlayColor:
                                              MaterialStateProperty.all(ColorRes
                                                  .color305EBE
                                                  .withOpacity(0.1)),
                                          child: Icon(
                                            Icons.arrow_right,
                                            color:
                                                ColorRes.black.withOpacity(0.7),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.03,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                            AssetRes.myfolderIcon,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.06,
                                        ),
                                        Text(
                                          StringRes.myFolder.toString(),
                                          style: appTextStyle(
                                              fontSize: 14,
                                              weight: FontWeight.w500,
                                              color: ColorRes.black
                                                  .withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
