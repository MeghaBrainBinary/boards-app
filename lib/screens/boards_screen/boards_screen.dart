import 'dart:io';

import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 SizedBox(
                                  height: Get.height * 0.13,
                                ),

                                /// top
                                Align(alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.05,
                                        right: Get.width * 0.05),
                                    child: Image.asset(
                                      AssetRes.boards,
                                      width: 110,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height:30
                                ),
                               /* const SizedBox(
                                  height:20
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Get.width * 0.05,
                                      right: Get.width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      *//*const Visibility(
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
                                      const Spacer(),*//*
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
                                const SizedBox(
                                    height:30
                                ),*/
                                /// my boards
                             /*   Padding(
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
*/
                                /// list
                                /*    GetBuilder<BoardsController>(
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
                                                            .toString(),
                                                        controller
                                                            .getBoardModel
                                                            .data![
                                                        index]
                                                            .name
                                                            .toString()

                                                    );
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
                                                            (controller.getBoardModel.data![index].sub_board!.isEmpty || controller.getBoardModel.data![index].sub_board!.length == 0)
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
                                                         */
                                /*   SizedBox(
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
                                                            ),*/
                                /*
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
                                                      (controller.getBoardModel.data![index].sub_board!.isNotEmpty) ?
                                                      (controller.isIcons[index] == true)
                                                          ? Column(
                                                        children: List.generate(controller.getBoardModel.data![index].sub_board!.length, (i){
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
                                                                  controller
                                                                      .getBoardModel
                                                                      .data![index].name.toString(),
                                                                 sub_boardId: controller
                                                                     .getBoardModel
                                                                     .data![index]
                                                                     .sub_board![i].id
                                                                     .toString(),
                                                                subName: controller
                                                                    .getBoardModel
                                                                    .data![index]
                                                                    .sub_board![i].name
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
                                                                    controller.getBoardModel.data![index].sub_board![i].name.toString(),
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
                                ),*/
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(StringRes.myBoards.tr,style: GoogleFonts.inder(
                                    color: ColorRes.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                ),
                                SizedBox(height: 10,),
                                /// list dynamic
                                // create structure of list of sublist of sublist of sublist
                                // now 28
                                (con.getBoardModelData != null)
                                    ? GetBuilder<BoardsController>(
                                        id: 'board',
                                        builder: (controller) => SizedBox(
                                          height: Get.height * 0.55,
                                          width: Get.width,
                                          child: (controller
                                                      .getBoardModelData['data'] !=
                                                  null)
                                              ? TreeView(
                                                  leftIcon:Image.asset(AssetRes.success,scale:1.5,),
                                                  icon: Icon(
                                                    Icons.arrow_right,
                                                    color: ColorRes.black,
                                                  ),
                                                  textStyle: GoogleFonts.inter(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  data: controller.treeData,
                                                  onTap: (node) {
                                                    print(node.id);
                                                    controller.onTapFolder(
                                                      node.id
                                                          .toString(),
                                                      node.name,);
                                                  },
                                                  onLastTap: (node) {
                                                    print(node.name);

                                                      controller.onTapFolder(
                                                          node.id
                                                              .toString(),
                                                          node.name,);

                                                  })
                                              : SizedBox(),
                                        ),
                                      )
                                    : SizedBox(),
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
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                      },
                                      child: Icon(
                                        Icons.telegram,
                                        color: ColorRes.black,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          color: ColorRes.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.cleaning_services,
                                          color: ColorRes.white,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(StringRes.inspire,style: GoogleFonts.inder(
                                    color: ColorRes.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                  const SizedBox(width: 5,),
                                  Text(StringRes.filuet,style: GoogleFonts.inder(
                                    color: ColorRes.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                              const SizedBox(height: 40,),
                            ],
                          )
                        ],
                      ),
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
