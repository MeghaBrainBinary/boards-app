import 'dart:io';
import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BoardsScreen extends StatelessWidget {
  BoardsScreen({super.key});

  final BoardsController boardsController = Get.put(BoardsController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialogs(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        endDrawer: Drawer(
          backgroundColor: Colors.white,
            shape: const OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55), topLeft: Radius.circular(55))),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(AssetRes.appNewLogo, scale: 3,),
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  flex: 2,
                  child: ListView.separated(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: boardsController.drawerTitleList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if (boardsController.drawerTitleList[index] ==  StringRes.home.tr) {
                            Get.back();
                          } else if (boardsController.drawerTitleList[index] ==  StringRes.language.tr) {
                            Get.back();
                            Get.toNamed(AppRoutes.languageConfirmPage);
                          } else if (boardsController.drawerTitleList[index] ==  StringRes.viewImages.tr) {
                            Get.back();
                            Get.toNamed(
                              AppRoutes.viewImagesScreen,
                              arguments: []
                            );
                          } else if (boardsController.drawerTitleList[index] ==  StringRes.favourite.tr) {
                            Get.back();
                            Get.toNamed(AppRoutes.favourite);
                          } else if (boardsController.drawerTitleList[index] ==  StringRes.contactUs.tr) {
                            Get.back();
                            Get.toNamed(AppRoutes.contactUs);
                          } else if (boardsController.drawerTitleList[index] ==  StringRes.settings.tr) {
                            Get.back();
                            Get.toNamed(AppRoutes.setting);
                          } else {
                            Get.back();
                            showDialogsLogout(context);
                          }
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Image.asset(
                            boardsController.drawerImageList[index],
                            color: ColorRes.appColor,
                            scale: 4,
                          ),
                        ),
                        title: Text(boardsController.drawerTitleList[index]),
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
                SizedBox(height: Get.height * 0.05),
              ],
            )),
        body: Container(
          height: Get.height,
          width: Get.width,

          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetRes.background),
                fit: BoxFit.fill,
              )
          ),
          child: Stack(
            children: [
              GetBuilder<BoardsController>(
                  id: "all",
                  builder: (con) {
                    return Stack(
                      children: [
                        SizedBox(
                         height:Get.height,
                         width:Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                height: Get.height *0.35,
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                  const SizedBox(height: 30,),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Image.asset(AssetRes.appNewLogo,scale: 2.2),
                                      ),
                                    ),
                                    const SizedBox(height: 30,),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.end,
                                          children: [


                                            InkWell(
                                              onTap: () {
                                                scaffoldKey.currentState?.openEndDrawer();
                                              },
                                              child: Image.asset(AssetRes.moreOption, scale: 3, color: ColorRes.appColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


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
                                          */
                                    /*const Visibility(
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
                                          const Spacer(),*/
                                    /*
                                          InkWell(
                                            onTap: () {
                                              boardsController.onTapMore();
                                            },
                                            child: Container(
                                              // alignment: Alignment.centerRight,
                                              // color: ColorRes.appColor,
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
                                                                    .appColor,
                                                                hoverColor: ColorRes
                                                                    .appColor,
                                                                splashColor: ColorRes
                                                                    .appColor
                                                                    .withOpacity(0.1),
                                                                overlayColor:
                                                                MaterialStateProperty
                                                                    .all(ColorRes
                                                                    .appColor
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
                                                                            .appColor,
                                                                        hoverColor:
                                                                        ColorRes
                                                                            .appColor,
                                                                        splashColor: ColorRes
                                                                            .appColor
                                                                            .withOpacity(
                                                                            0.1),
                                                                        overlayColor: MaterialStateProperty.all(ColorRes
                                                                            .appColor
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
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20),
                                    //   child: Text(
                                    //     StringRes.myBoards.tr,
                                    //     style: GoogleFonts.inder(
                                    //       color: ColorRes.black,
                                    //       fontSize: 23,
                                    //       fontWeight: FontWeight.w600,
                                    //     ),
                                    //   ),
                                    // ),

                                    // InkWell(
                                    //   onTap: () {
                                    //
                                    //   },
                                    //   child: Container(
                                    //     height: 100,
                                    //     width: 100,
                                    //     color: Colors.black,
                                    //   ),
                                    // ),

                                    /// list dynamic
                                    (con.getBoardModelData != null)
                                        ? Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  const SizedBox(height: 9),
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 29),
                                                      SizedBox(
                                                        height: 5,
                                                        width: 5,
                                                        key: boardsController.buttonKey,
                                                      ),

                                                      const SizedBox(width: 31),

                                                      SizedBox(
                                                        height: 15,
                                                        width: 32,
                                                        key: boardsController.secondButtonKey,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              GetBuilder<BoardsController>(
                                                id: 'board',
                                                initState: (state) {
                                                  // if(con.getBoardModelData != null) {
                                                  //   if((PrefService.getBool(PrefKeys.firstTimeOrSecond) ?? true) == false) {
                                                  //     boardsController.showTutorial(context: context);
                                                  //     PrefService.setValue(PrefKeys.firstTimeOrSecond, true);
                                                  //   }
                                                  //   boardsController.update(['board']);
                                                  // }
                                                },
                                                builder: (controller) => SizedBox(

                                                  width: Get.width,
                                                  height: Get.height - (Get.height *0.08 + Get.height *0.35),
                                                  child: (controller.getBoardModelData['data'] != null)
                                                      ? SingleChildScrollView(
                                                        child: TreeView(
                                                          selectedId: "",
                                                          view: false,
                                                          leftIcon: Image.asset(
                                                              AssetRes.success,
                                                              scale: 1.5
                                                          ),
                                                          icon: Icon(
                                                            Icons.keyboard_arrow_down_rounded,
                                                            color: ColorRes.black,
                                                          ),
                                                          textStyle: GoogleFonts.inter(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          data: controller.treeData,
                                                          onTap: (p,node) {

                                                            controller.onTapFolder(
                                                              isFromNotification: false,
                                                              node: (p.id.toString() =="0") ?node:p,
                                                              node.id.toString(),
                                                              node.name,
                                                              (p.id.toString() =="0" && p.name =='') ?node.icon:p.icon,
                                                              quote:node.quote,
                                                              isFirst:(p.id.toString() =="0") ?true:false,
                                                              quoteColor:node.quote_text_color,
                                                              quoteFamily:node.quote_font_family,
                                                              nameColor: node.name_text_color,
                                                              nameFamily: node.name_font_family,
                                                              mainCategory:(p.id.toString() =="0" && p.name =='') ?node.name:p.name,
                                                            );
                                                          },
                                                          onLastTap: (p,node) {
                                                            controller.onTapFolder(
                                                              isFromNotification: false,
                                                              node:  (p.id.toString() =="0") ?node:p,
                                                              node.id.toString(),
                                                              node.name,
                                                              (p.id.toString() =="0" && p.name =='') ?node.icon:p.icon,
                                                              isFirst:p.id.toString() =="0"?true:false,
                                                              quote:node.quote,
                                                              quoteColor:node.quote_text_color,
                                                              quoteFamily:node.quote_font_family,
                                                              nameColor: node.name_text_color,
                                                              nameFamily: node.name_font_family,
                                                              mainCategory:(p.id.toString() =="0" && p.name =='') ?node.name:p.name,
                                                            );
                                                          }),
                                                      )
                                                      : const SizedBox(),
                                                ),
                                              ),
                                            ],
                                        )
                                        : const SizedBox(),
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
                                                        focusColor: ColorRes.appColor,
                                                        hoverColor: ColorRes.appColor,
                                                        splashColor:
                                                            ColorRes.appColor.withOpacity(0.1),
                                                        overlayColor: MaterialStateProperty.all(
                                                            ColorRes.appColor.withOpacity(0.1)),
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
                                                                focusColor: ColorRes.appColor,
                                                                hoverColor: ColorRes.appColor,
                                                                splashColor: ColorRes.appColor
                                                                    .withOpacity(0.1),
                                                                overlayColor:
                                                                    MaterialStateProperty.all(ColorRes
                                                                        .appColor
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



                              SizedBox(
                                height: Get.height *0.05,
                                child: Column(
                                  children: [
                                 /*   Padding(
                                      padding: const EdgeInsets.only(right: 30.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {},
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
                                            onTap: () {},
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
                                    ),*/
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          StringRes.inspire,
                                          style: GoogleFonts.inder(
                                            color: ColorRes.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        // Text(
                                        //   StringRes.filuet.tr,
                                        //   style: GoogleFonts.inder(
                                        //     color: ColorRes.black,
                                        //     fontSize: 18,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        Image.asset(AssetRes.filuetLogo,height: 15,),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
                  : const SizedBox()),

              // Obx(() => (boardsController.categoryClickLoader.value)
              //     ? const CommonLoader()
              //     : const SizedBox())
            ],
          ),
        ),
      ),
    );
  }

  void showDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: Get.height * 0.04,
            ),
            Text(
              StringRes.areYouSureExit.tr,
              textAlign: TextAlign.center,
              style: appTextStyle(
                  weight: FontWeight.w500, fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonButton(
                      onTap: () {
                        exit(0);
                      },
                      text: StringRes.yes.tr),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 234,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorRes.appColor)),
                      child: Text(
                        StringRes.no.tr,
                        style: appTextStyle(
                            color: ColorRes.appColor,
                            fontSize: 18,
                            weight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
          ],
        );
      },
    );
  }
  void showDialogsLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: Get.height * 0.04),
            Image.asset(AssetRes.loginIcon, height: Get.height * 0.1,color: ColorRes.appColor,),
            SizedBox(height: Get.height * 0.03),
            Text(
              StringRes.areYouSureLogOut.tr,
              textAlign: TextAlign.center,
              style: appTextStyle(
                  weight: FontWeight.w500, fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonButton(
                      onTap: () async {
                       await boardsController.logoutApi();


                      },
                      text: StringRes.yes.tr),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 234,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorRes.appColor)),
                      child: Text(
                        StringRes.no.tr,
                        style: appTextStyle(
                            color: ColorRes.appColor,
                            fontSize: 18,
                            weight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
          ],
        );
      },
    );
  }
}
