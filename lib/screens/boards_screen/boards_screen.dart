import 'dart:io';
import 'dart:math';

import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardsScreen extends StatelessWidget {
  BoardsScreen({super.key});

  BoardsController boardsController = Get.put(BoardsController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        body: Stack(
          children: [
            GetBuilder<BoardsController>(
                id: "all",
                builder: (con) {
                  return Stack(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height * 0.15,
                            ),

                            /// top
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.05,
                                  right: Get.width * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Visibility(
                                    visible: false,
                                    maintainState: true,
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    child: SizedBox(
                                      child: Icon(
                                        Icons.more_vert,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Image.asset(
                                      AssetRes.splashIcon,
                                      width: 96,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      boardsController.onTapMore();
                                    },
                                    child: Container(
                                      // alignment: Alignment.centerRight,
                                      // color: ColorRes.color305EBE,
                                      // height: 25,
                                      // width: 25,
                                      child: const Icon(
                                        Icons.more_vert,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.12,
                            ),

                            /// my boards
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.05,
                                  right: Get.width * 0.05),
                              child: Row(
                                children: [
                                  Text(
                                    StringRes.myBoards.tr,
                                    style: appTextStyle(
                                        color: ColorRes.black,
                                        fontSize: 23,
                                        weight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),

                            /// list
                            GetBuilder<BoardsController>(
                              id: 'board',
                              builder: (controller) => SizedBox(
                                height: Get.height * 0.55,
                                width: Get.width,
                                child: (controller.getBoardModel.data != null)
                                    ? ListView.builder(
                                        itemCount: controller
                                            .getBoardModel.data!.length,
                                        itemBuilder: (context, index) {
                                          List icons = List.generate(
                                            controller
                                                .getBoardModel.data!.length,
                                            (index) => Icon(
                                              Icons.arrow_right,
                                              color: ColorRes.black,
                                            ),
                                          );
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: Get.height * 0.03),
                                            child: InkWell(
                                              onTap: () {
                                                controller.onTapFolder(
                                                     controller
                                                        .getBoardModel
                                                        .data![
                                                    index]
                                                        .id
                                                        .toString());
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.035,
                                                        right:
                                                            Get.width * 0.05),
                                                    child: Row(
                                                      children: [
                                                        (controller.getBoardModel.data![index].subBoard!.isEmpty)
                                                            ? SizedBox()
                                                            : InkWell(
                                                                onTap: () {
                                                                  controller.onTapIcon(true, index);
                                                                },
                                                                child: (controller.isIcons[index] == true)
                                                                    ? Transform.rotate(
                                                                        angle:
                                                                            pi / 2,
                                                                        child: icons[index])
                                                                    : icons[
                                                                        index],
                                                              ),
                                                        SizedBox(
                                                          width: Get.width * 0.03,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                          width: 30,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                boardsController
                                                                    .getBoardModel
                                                                    .data![
                                                                        index]
                                                                    .icon!
                                                                    .toString(),
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(),
                                                          ),
                                                          // child: Image.network(
                                                          //   boardsController.getBoardModel.data![index].icon!,
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.06,
                                                        ),
                                                        Text(
                                                          controller
                                                              .getBoardModel
                                                              .data![index]
                                                              .name
                                                              .toString(),
                                                          style: appTextStyle(
                                                              fontSize: 17,
                                                              weight: FontWeight
                                                                  .w500,
                                                              color: ColorRes
                                                                  .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  (controller.getBoardModel.data![index].subBoard!.isNotEmpty) ?
                                                  (controller.isIcons[index] == true)
                                                      ? Column(
                                                    children: List.generate(controller.getBoardModel.data![index].subBoard!.length, (i){
                                                      return InkWell(
                                                        focusColor: ColorRes
                                                            .color305EBE,
                                                        hoverColor: ColorRes
                                                            .color305EBE,
                                                        splashColor: ColorRes
                                                            .color305EBE
                                                            .withOpacity(0.1),
                                                        overlayColor:
                                                        MaterialStateProperty
                                                            .all(ColorRes
                                                            .color305EBE
                                                            .withOpacity(
                                                            0.1)),
                                                        onTap: () {
                                                          controller.onTapFolder(
                                                              controller
                                                                  .getBoardModel
                                                                  .data![index].id.toString(),
                                                             subBoardId: controller
                                                                 .getBoardModel
                                                                 .data![index]
                                                                 .subBoard![i].id
                                                                 .toString(),
                                                          );


                                                        },
                                                        child: Container(
                                                          height: Get.height *
                                                              0.055,
                                                          color: Colors
                                                              .transparent,
                                                          padding:
                                                          EdgeInsets.only(
                                                            left: Get.width *
                                                                0.12,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {},
                                                                focusColor:
                                                                ColorRes
                                                                    .color305EBE,
                                                                hoverColor:
                                                                ColorRes
                                                                    .color305EBE,
                                                                splashColor: ColorRes
                                                                    .color305EBE
                                                                    .withOpacity(
                                                                    0.1),
                                                                overlayColor: MaterialStateProperty.all(ColorRes
                                                                    .color305EBE
                                                                    .withOpacity(
                                                                    0.1)),
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_right,
                                                                  color: ColorRes
                                                                      .black
                                                                      .withOpacity(
                                                                      0.7),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                Get.width *
                                                                    0.03,
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child: Image
                                                                    .asset(
                                                                  AssetRes
                                                                      .myfolderIcon,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                Get.width *
                                                                    0.06,
                                                              ),
                                                              Text(
                                                                controller.getBoardModel.data![index].subBoard![i].name.toString(),
                                                                style: appTextStyle(
                                                                    fontSize:
                                                                    14,
                                                                    weight: FontWeight
                                                                        .w500,
                                                                    color: ColorRes
                                                                        .black
                                                                        .withOpacity(
                                                                        0.7)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                      : const SizedBox()
                                                  : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                    : SizedBox(),
                              ),
                            ),

                            /* GetBuilder<BoardsController>(
                        id: 'board',
                        builder: (controller) => SizedBox(
                          height: Get.height * 0.55,
                          width: Get.width,
                          child: (controller.getBoardModel.data !=null)
                              ?ListView.builder(
                              itemCount: controller.getBoardModel.data!.length,
                              itemBuilder: (context, index) {
                                List icons = List.generate(
                                  controller.getBoardModel.data!.length,
                                  (index) => Icon(
                                    Icons.arrow_right,
                                    color: ColorRes.black,
                                  ),
                                );
                                return Padding(
                                  padding: EdgeInsets.only(bottom: Get.height * 0.03),
                                  child: InkWell(
                                    onTap: () {
                                      controller.onTapIcon(true, index);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.035,
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
                                                child: CachedNetworkImage(
                                                  imageUrl: boardsController.getBoardModel.data![index].icon!.toString(),

                                                  placeholder: (context, url) => Container(),
                                                  errorWidget: (context, url, error) => Container(),
                                                ),
                                                // child: Image.network(
                                                //   boardsController.getBoardModel.data![index].icon!,
                                                // ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.06,
                                              ),
                                              Text(
                                                controller.getBoardModel.data![index].name.toString(),
                                                style: appTextStyle(
                                                    fontSize: 17,
                                                    weight: FontWeight.w500,
                                                    color: ColorRes.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        (controller.isIcons[index] == true)
                                            ? InkWell(
                                                focusColor: ColorRes.color305EBE,
                                                hoverColor: ColorRes.color305EBE,
                                                splashColor:
                                                    ColorRes.color305EBE.withOpacity(0.1),
                                                overlayColor: MaterialStateProperty.all(
                                                    ColorRes.color305EBE.withOpacity(0.1)),
                                                onTap: () {
                                                  controller.onTapFolder(
                                                    id:controller.getBoardModel.data![index].id.toString()
                                                  );
                                                },
                                                child: Container(
                                                  height: Get.height * 0.055,
                                                  color: Colors.transparent,
                                                  padding: EdgeInsets.only(
                                                    left: Get.width * 0.12,
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
                                                        StringRes.myFolder.tr.toString(),
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
                              })
                              :SizedBox(),
                        ),
                      ),*/

                          ]),



                      (boardsController.isMore == true)
                          ? Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    boardsController.onTapMore();
                                  },
                                  child: Container(
                                    height: Get.height,
                                    width: Get.width,
                                    color: ColorRes.black.withOpacity(0.5),
                                  ),
                                ),
                                Positioned(
                                  left: Get.width * 0.55,
                                  top: Get.height * 0.12,
                                  child: InkWell(
                                    onTap: () {
                                      boardsController.isMore = false;
                                      boardsController.update(['fldr']);
                                      Get.offAndToNamed(
                                          AppRoutes.languageConfirmPage);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 153,
                                      color: ColorRes.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 14,
                                            width: 14,
                                            child:
                                                Image.asset(AssetRes.langIcon),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.03,
                                          ),
                                          Text(
                                            StringRes.language.tr,
                                            style: appTextStyle(
                                                fontSize: 15,
                                                weight: FontWeight.w500,
                                                color: ColorRes.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox()
                    ],
                  );
                }),
            Obx(() => (boardsController.loader.value)
                ? const CommonLoader()
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
