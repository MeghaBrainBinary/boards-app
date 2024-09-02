import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/my_select_folder_screen/my_select_folder_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class MyFolderScreen extends StatefulWidget {
  String? boardName;
  String? icon;
  String? parentId;
  String? quote;
  String? quoteColor;
  String? nameColor;
  String? quoteFamily;
  String? nameFamily;
  String? mainCategory;

  bool? isFirst;
  bool? isFirstNode;
  List<TreeNodeData>? node;

  MyFolderScreen(
      {super.key,
      this.boardName,
      this.icon,
      this.parentId,
      this.quote,
      this.nameColor,
      this.nameFamily,
      this.mainCategory,
this.quoteColor,
        this.quoteFamily,
      this.isFirst,
      this.isFirstNode,
      this.node});

  @override
  State<MyFolderScreen> createState() => _MyFolderScreenState();
}

class _MyFolderScreenState extends State<MyFolderScreen> {
  MyFolderController myFolderController = Get.put(MyFolderController());
  BoardsController boardsController = Get.put(BoardsController());
  MySelectFolderController mySelectFolderController =
      Get.put(MySelectFolderController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print("------------------------${widget.node}");

    myFolderController.init();
    return WillPopScope(
      onWillPop: () async {
        if (myFolderController.isPageView ||
            myFolderController.isSelectedPageView) {
          myFolderController.isPageView = false;
          myFolderController.isSelectedPageView = false;
          myFolderController.update(['fldr']);
          return false;
        } else {
          Get.back();
          myFolderController.onTapBack();

          return true;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AssetRes.background),
            fit: BoxFit.fill,
          )),
          child: GetBuilder<MyFolderController>(
            id: 'fldr',
            builder: (controller) => Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                appBar(
                                    boardName: widget.mainCategory,
                                    icon: widget.icon),
                                SizedBox(height: Get.height * 0.01),
                                /*    Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text(
                                    ((widget.boardName ?? '').toLowerCase().contains(
                                            StringRes.holidays.tr.toLowerCase()))
                                        ? StringRes.holidayQuotes.tr
                                        : ((widget.boardName ?? '')
                                                .toLowerCase()
                                                .contains(StringRes.challenge.tr
                                                    .toLowerCase()))
                                            ? StringRes.challengesQuotes.tr
                                            : ((widget.boardName ?? '')
                                                    .toLowerCase()
                                                    .contains(StringRes.weekend.tr
                                                        .toLowerCase()))
                                                ? StringRes.weekendQuotes.tr
                                                : ((widget.boardName ?? '')
                                                        .toLowerCase()
                                                        .contains(StringRes
                                                            .motivation.tr
                                                            .toLowerCase()))
                                                    ? StringRes.motivationQuotes.tr
                                                    : StringRes.motivationQuotes.tr,
                                    textAlign: TextAlign.center,
                                    style: appTextStyleItalic(
                                        color: ColorRes.appColor,
                                        fontSize: 15,
                                        weight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.05),*/
                                (controller.getBoardInfoModel == null)
                                    ? const SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.05,
                                            right: Get.width * 0.06),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(height: 10),
                                            if ((controller.getBoardInfoModel.data ??
                                                    [])
                                                .isEmpty)
                                              const SizedBox()
                                            else if (controller.isPageView == false &&
                                                controller.isSelectedPageView ==
                                                    false)
                                              (widget.isFirstNode ?? false)
                                                  ? const SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        myFolderController
                                                                .addSelectedImage =
                                                            List.generate(
                                                                controller
                                                                        .getBoardInfoModel
                                                                        ?.data
                                                                        ?.length ??
                                                                    0,
                                                                (index) => false);
                                                        controller
                                                                .isSelectedPageView =
                                                            true;
                                                        controller.isPageView = false;
                                                        controller.update(['fldr']);
                                                      },
                                                      child: Text(
                                                        StringRes.select.tr,
                                                        style:
                                                           appTextStyle(
                                                                    color:  ColorRes
                                                                            .appColor,
                                                                    fontSize: 15,
                                                                  ),
                                                      ),
                                                    )
                                            else
                                              const SizedBox(),
                                            controller.isSelectedPageView
                                                ? (widget.isFirstNode ?? false)
                                                    ? const SizedBox()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${myFolderController.addSelectedImage.where((e) => e == true).length} ${StringRes.imageSelected.tr}',
                                                            style:
                                                            appTextStyle(color: ColorRes.black, fontSize: 13, weight: FontWeight.w600),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              myFolderController
                                                                      .addSelectedImage =
                                                                  List.generate(
                                                                      controller
                                                                              .getBoardInfoModel
                                                                              .data
                                                                              ?.length ??
                                                                          0,
                                                                      (index) =>
                                                                          false);
                                                              controller
                                                                      .isSelectedPageView =
                                                                  false;
                                                              controller
                                                                  .update(['fldr']);
                                                            },
                                                            child: Text(
                                                              StringRes.cancel.tr,
                                                              style:
                                                                 appTextStyle(
                                                                          color: ColorRes
                                                                                  .appColor,
                                                                          //fontFamily: widget.nameFamily,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                : const SizedBox(),
                                            const SizedBox(height: 20),
                                            (controller.isPageView &&
                                                    !controller.isSelectedPageView)
                                                ? Container(
                                                    height: Get.height * 0.7,
                                                    width: Get.width,
                                                    alignment: Alignment.topCenter,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .tapForwardButton();
                                                          },
                                                          child: Icon(
                                                              Icons
                                                                  .arrow_back_ios_new_rounded,
                                                              color: ColorRes.appColor,
                                                              size: 25),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.topCenter,
                                                          width: Get.width * 0.75,
                                                          child: PageView.builder(
                                                              controller: controller
                                                                  .pageController,
                                                              itemCount: controller
                                                                      .getBoardInfoModel
                                                                      .data
                                                                      ?.length ??
                                                                  0,
                                                              onPageChanged: (val) {
                                                                controller
                                                                    .onImageChanged(
                                                                        val);
                                                              },
                                                              itemBuilder:
                                                                  (context, index) {
                                                                controller
                                                                    .selectedIndex;
                                                                return Stack(
                                                                  alignment: Alignment
                                                                      .bottomRight,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        controller
                                                                            .onTapImage(
                                                                                index);
                                                                      },
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                    5),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              Get.height *
                                                                                  0.7,
                                                                          width:
                                                                              Get.width *
                                                                                  0.75,
                                                                          padding: (controller.checkImg[index] ==
                                                                                  false)
                                                                              ? const EdgeInsets.all(
                                                                                  0)
                                                                              : const EdgeInsets
                                                                                  .all(2),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color: Colors
                                                                                .transparent,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                                    5),
                                                                          ),
                                                                          child:
                                                                    controller. getBoardInfoModel.data?[index].fileType =="video" ?
                                                                    controller.videos[index] != null?

                                                                    Stack(
                                                                      alignment:Alignment.center,
                                                                      children: [
                                                                        VideoPlayer( controller.videos[index]!),
                                                                        InkWell(
                                                                          onTap:(){
                                                                            if(controller.isPlay[index])
                                                                              {
                                                                                controller.isPlay[index] = false;
                                                                                controller.videos[index]?.pause();

                                                                              }
                                                                            else
                                                                              {
                                                                                controller.isPlay = List.generate( controller.getBoardInfoModel.data?.length ??0, (index) => false);
                                                                                controller.videos.forEach((e){
                                                                                  if(e != null)
                                                                                  {
                                                                                    e.pause();
                                                                                  }
                                                                                });
                                                                                controller.isPlay[index] = true;

                                                                                controller.videos[index]?.play();
                                                                              }
                                                                            controller.update(['fldr']);
                                                                          },
                                                                          child: Container(
                                                                            height: 30,
                                                                            width: 30,
                                                                            decoration:const BoxDecoration(
                                                                    shape:BoxShape.circle,
                                                                    color:Colors.white,
                                                                    ),
                                                                            child: Icon(controller.isPlay[index]?Icons.pause:Icons.play_arrow,
                                                                            size: 20,),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ):const SizedBox()
                                                                        :   CachedNetworkImage(
                                                                            fit: BoxFit
                                                                                .fitWidth,
                                                                            imageUrl: controller
                                                                                .getBoardInfoModel
                                                                                .data![
                                                                                    index]
                                                                                .image!
                                                                                .toString(),
                                                                            progressIndicatorBuilder: (context,
                                                                                strings,
                                                                                download) {
                                                                              return Shimmer
                                                                                  .fromColors(
                                                                                baseColor: Colors
                                                                                    .grey
                                                                                    .shade300,
                                                                                highlightColor:
                                                                                    Colors.white,
                                                                                enabled:
                                                                                    true,
                                                                                child: Container(
                                                                                    height: Get.width,
                                                                                    width: Get.width,
                                                                                    color: Colors.white),
                                                                              );
                                                                            },
                                                                            errorWidget: (context,
                                                                                    url,
                                                                                    error) =>
                                                                                Container(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    (controller.isSelect ==
                                                                            false)
                                                                        ? const SizedBox()
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              controller.onTapCheck(
                                                                                  controller.getBoardInfoModel.data![index].image,
                                                                                  index);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.only(
                                                                                  right:
                                                                                      10,
                                                                                  bottom:
                                                                                      10),
                                                                              height:
                                                                                  25,
                                                                              width:
                                                                                  25,
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                color:
                                                                                    ColorRes.white,
                                                                                shape:
                                                                                    BoxShape.circle,
                                                                              ),
                                                                              child: (controller.checkImg[index] ==
                                                                                      false)
                                                                                  ? const SizedBox()
                                                                                  : SizedBox(
                                                                                      height: 8,
                                                                                      width: 11,
                                                                                      child: Transform.scale(
                                                                                        scale: 0.6,
                                                                                        child: Icon(
                                                                                          Icons.check_rounded,
                                                                                          color: ColorRes.appColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                  ],
                                                                );
                                                              }),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .tapBackwardButton();
                                                          },
                                                          child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios_rounded,
                                                              color:  ColorRes.appColor,
                                                              size: 25),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : (!controller.isPageView &&
                                                        controller.isSelectedPageView)
                                                    ? SizedBox(
                                                            height: Get.height * 0.67,
                                                            width: Get.width,
                                                            child: (controller
                                                                        .getBoardInfoModel
                                                                        ?.data !=
                                                                    null)
                                                                ? GridView.builder(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(0),
                                                                    itemCount: controller
                                                                            .getBoardInfoModel
                                                                            ?.data
                                                                            ?.length ??
                                                                        0,
                                                                    gridDelegate:
                                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          2,
                                                                      mainAxisSpacing:
                                                                          6,
                                                                      crossAxisSpacing:
                                                                          19,
                                                                    ),
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Stack(
                                                                        alignment:
                                                                            Alignment
                                                                                .bottomRight,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              if (myFolderController.addSelectedImage[index] ==
                                                                                  false) {
                                                                                myFolderController.addSelectedImage[index] =
                                                                                    true;
                                                                              } else {
                                                                                myFolderController.addSelectedImage[index] =
                                                                                    false;
                                                                              }
                                                                              myFolderController
                                                                                  .update([
                                                                                'fldr'
                                                                              ]);
                                                                            },
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(5),
                                                                              child:
                                                                                  Container(
                                                                                height:
                                                                                    Get.height * 0.199,
                                                                                width:
                                                                                    Get.width * 0.45,
                                                                                padding: (myFolderController.addSelectedImage[index] == true)
                                                                                    ? const EdgeInsets.all(2)
                                                                                    : const EdgeInsets.all(2),
                                                                                decoration:
                                                                                    BoxDecoration(
                                                                                  color: myFolderController.checkImg[index] == true
                                                                                      ?  ColorRes.appColor
                                                                                      : Colors.transparent,
                                                                                  border:
                                                                                      Border.all(
                                                                                    color: myFolderController.addSelectedImage[index] == true
                                                                                        ? ColorRes.appColor
                                                                                        : Colors.white,
                                                                                  ),
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(5),
                                                                                ),
                                                                                child:
                                                                                    Stack(
                                                                                  alignment:
                                                                                      Alignment.bottomRight,
                                                                                  children: [
                                                                                     CachedNetworkImage(
                                                                                      width: Get.width,
                                                                                      height: Get.height * 0.199,
                                                                                      fit: BoxFit.cover,
                                                                                      imageUrl: controller.getBoardInfoModel?.data?[index].image ?? "",
                                                                                      progressIndicatorBuilder: (context, strings, download) {
                                                                                        return Shimmer.fromColors(
                                                                                          baseColor: Colors.grey.shade300,
                                                                                          highlightColor: Colors.white,
                                                                                          enabled: true,
                                                                                          child: Container(height: Get.width, width: Get.width, color: Colors.white),
                                                                                        );
                                                                                      },
                                                                                      errorWidget: (context, url, error) => Container(),
                                                                                    ),
                                                                                    myFolderController.addSelectedImage[index] == true
                                                                                        ? Padding(
                                                                                            padding: const EdgeInsets.only(bottom: 10, right: 10),
                                                                                            child: Container(
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                                                                alignment: Alignment.center,
                                                                                                child: Image.asset(
                                                                                                  AssetRes.selectedImage,
                                                                                                  scale: 4,
                                                                                                  color:  ColorRes.appColor,
                                                                                                )),
                                                                                          )
                                                                                        : const SizedBox(),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          (myFolderController.isSelect ==
                                                                                  false)
                                                                              ? const SizedBox()
                                                                              : InkWell(
                                                                                  onTap:
                                                                                      () {
                                                                                    myFolderController.onTapCheck(myFolderController.getBoardInfoModel.data![index].image, index);
                                                                                  },
                                                                                  child:
                                                                                      Container(
                                                                                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                                                                                    height: 25,
                                                                                    width: 25,
                                                                                    decoration: BoxDecoration(
                                                                                      color: ColorRes.white,
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: (myFolderController.checkImg[index] == false)
                                                                                        ? const SizedBox()
                                                                                        : SizedBox(
                                                                                            height: 8,
                                                                                            width: 11,
                                                                                            child: Transform.scale(
                                                                                              scale: 0.6,
                                                                                              child: Icon(
                                                                                                Icons.check_rounded,
                                                                                                color: ColorRes.appColor,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  )
                                                                : Center(
                                                                    child: Text(
                                                                      StringRes
                                                                          .noDataFound
                                                                          .tr,
                                                                      style:  appTextStyle(
                                                                              color:  ColorRes.appColor,
                                                                              //fontFamily: widget.nameFamily,
                                                                              fontSize:
                                                                                  15,
                                                                            ),
                                                                    ),
                                                                  ),
                                                          )
                                                    : Column(
                                                        children: [
                                                          // widget.node!.isEmpty
                                                          //     ? const SizedBox()
                                                          //     : TreeViewHorizontal(
                                                          //         selectedId: controller.selectedId,
                                                          //         view: true,
                                                          //         leftIcon: Image.asset(AssetRes.success, scale: 1.5),
                                                          //         icon: Icon(Icons.keyboard_arrow_down_rounded, color: ColorRes.black),
                                                          //     textStyle: GoogleFonts.inter(
                                                          //       color: Colors.black,
                                                          //       fontSize: 17,
                                                          //       fontWeight: FontWeight.w500,
                                                          //     ),
                                                          //     onExpand: (d){
                                                          //           d.expanded =false;
                                                          //     },
                                                          //     data: widget.node!,
                                                          //     onTap: (node) {
                                                          //       boardsController.onTapFolder(
                                                          //         node: node,
                                                          //         node.id.toString(),
                                                          //         node.name,
                                                          //         node.icon,
                                                          //       );
                                                          //     },
                                                          //     onLastTap: (node) {
                                                          //       boardsController.onTapFolder(
                                                          //           node: node,
                                                          //           node.id.toString(),
                                                          //           node.name,
                                                          //           node.icon
                                                          //       );
                                                          //     }),

                                                          (widget.node ?? []).isEmpty
                                                              ? const SizedBox()
                                                              : Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          bottom: 10),
                                                                  height: 40,
                                                                  child: ListView
                                                                      .separated(
                                                                    separatorBuilder: (context,
                                                                            index) =>
                                                                        const SizedBox(
                                                                            width:
                                                                                10),
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    itemCount: widget
                                                                        .node!.length,
                                                                    itemBuilder:
                                                                        (context,
                                                                                index) =>
                                                                            InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        if (widget
                                                                                .isFirst ??
                                                                            false) {
                                                                          if (controller
                                                                                  .isSelectedNode[
                                                                              index]) {
                                                                            myFolderController.isSelectedNode = List.generate(
                                                                                widget.node?.length ??
                                                                                    0,
                                                                                (index) =>
                                                                                    false);
                                                                            controller
                                                                                    .isSelectedNode[index] =
                                                                                false;
                                                                            widget.isFirstNode =
                                                                                true;

                                                                            controller
                                                                                    .selectedId =
                                                                                widget
                                                                                    .parentId
                                                                                    .toString();
                                                                            // controller.myInt(
                                                                            //     widget.parentId.toString() ??
                                                                            //         "");
                                                                          } else {
                                                                            myFolderController.isSelectedNode = List.generate(
                                                                                widget.node?.length ??
                                                                                    0,
                                                                                (index) =>
                                                                                    false);
                                                                            controller
                                                                                    .isSelectedNode[index] =
                                                                                true;

                                                                            controller
                                                                                .selectedId = widget
                                                                                    .node?[index]
                                                                                    .id
                                                                                    .toString() ??
                                                                                "";
                                                                            await controller.myInt(widget
                                                                                    .node?[index]
                                                                                    .id
                                                                                    .toString() ??
                                                                                "");
                                                                            widget.isFirstNode =
                                                                                false;
                                                                          }
                                                                        } else {
                                                                          controller
                                                                              .selectedId = widget
                                                                                  .node?[index]
                                                                                  .id
                                                                                  .toString() ??
                                                                              "";
                                                                          controller.myInt(widget
                                                                                  .node?[index]
                                                                                  .id
                                                                                  .toString() ??
                                                                              "");
                                                                          widget.isFirstNode =
                                                                              false;
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        height: 40,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: (controller.selectedId ==
                                                                                  (widget.node?[index].id.toString() ??
                                                                                      ""))
                                                                              ?  ColorRes
                                                                                      .appColor
                                                                              : ColorRes
                                                                                  .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  15),
                                                                          border: Border.all(
                                                                              color: ColorRes.appColor),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  8),
                                                                          child:
                                                                              HtmlWidget(
                                                                            widget.node?[index]
                                                                                    .title ??
                                                                                "",
                                                                            textStyle:
                                                                            // widget.nameFamily !=
                                                                            //         ''
                                                                            //     ? TextStyle(
                                                                            //         fontFamily: widget.nameFamily,
                                                                            //         color: (controller.selectedId == (widget.node?[index].id.toString() ?? "")) ? ColorRes.white : ColorRes.appColor,
                                                                            //         fontSize: 15,
                                                                            //       )
                                                                            //     :
                                                                            appTextStyle(
                                                                                    color: (controller.selectedId == (widget.node?[index].id.toString() ?? "")) ? ColorRes.white : ColorRes.appColor,

                                                                                    fontSize: 15,
                                                                                    //  fontFamily: widget.family
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                          widget.isFirstNode ?? false
                                                              ? const SizedBox()
                                                              : SizedBox(
                                                                  height: Get.height *
                                                                      0.69,
                                                                  width: Get.width,
                                                                  child: ((controller
                                                                                  .getBoardInfoModel
                                                                                  .data ??
                                                                              [])
                                                                          .isNotEmpty)
                                                                      ? GridView
                                                                          .builder(
                                                                          padding:
                                                                              const EdgeInsets
                                                                                  .all(0),
                                                                          itemCount: controller
                                                                              .getBoardInfoModel
                                                                              .data!
                                                                              .length,
                                                                          gridDelegate:
                                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                2,
                                                                            mainAxisSpacing:
                                                                                6,
                                                                            crossAxisSpacing:
                                                                                19,
                                                                          ),
                                                                          itemBuilder:
                                                                              (context,
                                                                                  index) {
                                                                            return Stack(
                                                                              alignment:
                                                                                  Alignment.bottomRight,
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap:
                                                                                      () {
                                                                                    controller.selectedIndex = index;
                                                                                    controller.onTapImage(index);
                                                                                  },
                                                                                  child:
                                                                                      ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: Container(
                                                                                      height: Get.height * 0.199,
                                                                                      width: Get.width * 0.45,
                                                                                      padding: (controller.checkImg[index] == false) ? const EdgeInsets.all(0) : const EdgeInsets.all(2),
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                      child: controller.videos.length !=0?
                                                                                Stack(
                                                                                        alignment: Alignment.topRight,
                                                                                        children: [
                                                                                          controller. getBoardInfoModel.data?[index].fileType =="video" ?
                                                                                          controller.videos[index] != null?
                                                                                          Stack(
                                                                                            alignment:Alignment.center,
                                                                                            children: [
                                                                                              VideoPlayer( controller.videos[index]!),
                                                                                              InkWell(
                                                                                                onTap:(){
                                                                                                  if(controller.isPlay[index])
                                                                                                  {
                                                                                                    controller.isPlay[index] = false;
                                                                                                    controller.videos[index]?.pause();

                                                                                                  }
                                                                                                  else
                                                                                                  {
                                                                                                    controller.isPlay = List.generate( controller.getBoardInfoModel.data?.length ??0, (index) => false);
                                                                                                    controller.videos.forEach((e){
                                                                                                      if(e != null)
                                                                                                        {
                                                                                                          e.pause();
                                                                                                        }
                                                                                                    });
                                                                                                    controller.isPlay[index] = true;

                                                                                                    controller.videos[index]?.play();
                                                                                                  }
                                                                                                  controller.update(['fldr']);

                                                                                                },
                                                                                                child: Container(
                                                                                                  height: 30,
                                                                                                  width: 30,
                                                                                                  decoration:const BoxDecoration(
                                                                                                    shape:BoxShape.circle,
                                                                                                    color:Colors.white,
                                                                                                  ),
                                                                                                  child: Icon(controller.isPlay[index]?
                                                                                                  Icons.pause:Icons.play_arrow,size: 20,),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ):const SizedBox()
                                                                                              :  CachedNetworkImage(
                                                                                            width: Get.width,
                                                                                            fit: BoxFit.fitWidth,
                                                                                            imageUrl: controller.getBoardInfoModel.data![index].image!.toString(),
                                                                                            errorWidget: (context, url, error) => Container(),
                                                                                            progressIndicatorBuilder: (context, strings, download) {
                                                                                              return Shimmer.fromColors(
                                                                                                baseColor: Colors.grey.shade300,
                                                                                                highlightColor: Colors.white,
                                                                                                enabled: true,
                                                                                                child: Container(
                                                                                                  height: Get.width,
                                                                                                  width: Get.width,
                                                                                                  color: Colors.white,
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                          GestureDetector(
                                                                                            onTap: () async {
                                                                                              await controller.likeUnlike(index);
                                                                                              controller.update(['fldr']);
                                                                                            },
                                                                                            child: Container(
                                                                                              height: 20,
                                                                                              width: 20,
                                                                                              margin: const EdgeInsets.only(top: 12, right: 12),
                                                                                              decoration: const BoxDecoration(
                                                                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                              child: controller.isLike[index] == true
                                                                                                  ? Icon(Icons.favorite_outlined, size: 18, color:  ColorRes.colorE16F55)
                                                                                                  : Icon(
                                                                                                      Icons.favorite_outline_sharp,
                                                                                                      size: 18,
                                                                                                      color:  ColorRes.appColor,
                                                                                                    ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ):const SizedBox(),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                (controller.isSelect == false)
                                                                                    ? const SizedBox()
                                                                                    : InkWell(
                                                                                        onTap: () {
                                                                                          controller.onTapCheck(controller.getBoardInfoModel.data![index].image, index);
                                                                                        },
                                                                                        child: Container(
                                                                                          margin: const EdgeInsets.only(right: 10, bottom: 10),
                                                                                          height: 25,
                                                                                          width: 25,
                                                                                          decoration: BoxDecoration(color: ColorRes.white, shape: BoxShape.circle),
                                                                                          child: (controller.checkImg[index] == false)
                                                                                              ? const SizedBox()
                                                                                              : SizedBox(
                                                                                                  height: 8,
                                                                                                  width: 11,
                                                                                                  child: Transform.scale(
                                                                                                    scale: 0.6,
                                                                                                    child: Icon(
                                                                                                      Icons.check_rounded,
                                                                                                      color:  ColorRes.appColor,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                        ),
                                                                                      ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        )
                                                                      : Center(
                                                                          child: Text(
                                                                            StringRes
                                                                                .noDataFound
                                                                                .tr,
                                                                            style:appTextStyle(
                                                                                    color:  ColorRes.appColor,
                                                                                    //fontFamily: widget.nameFamily,
                                                                                    fontSize: 15,
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                ),
                                                        ],
                                                      ),
                                          ],
                                        ),
                                      ),
                                (controller.isPageView == true ||
                                        (controller.isSelectedPageView == true &&
                                            controller.addSelectedImage
                                                    .where((e) => e == true)
                                                    .length >
                                                0))
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 30),
                                          Container(
                                            height: 50,
                                            width: Get.width,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      if (controller
                                                              .isSelectedPageView ==
                                                          false) {
                                                        await controller.likeUnlike(
                                                            controller.selectedIndex);
                                                      } else {
                                                        await controller
                                                            .likeUnlikeList();
                                                      }
                                                      myFolderController
                                                              .addSelectedImage =
                                                          List.generate(
                                                              controller
                                                                      .getBoardInfoModel
                                                                      .data
                                                                      ?.length ??
                                                                  0,
                                                              (index) => false);
                                                      controller.isSelectedPageView =
                                                          false;
                                                      controller.update(['fldr']);
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color:  ColorRes.appColor,
                                                        borderRadius:
                                                            BorderRadius.circular(25),
                                                      ),
                                                      child: SizedBox(
                                                        height: 23,
                                                        width: 23,
                                                        child: (controller.isPageView)
                                                            ? controller.isLike[controller
                                                                        .selectedIndex] ==
                                                                    true
                                                                ? const Icon(
                                                                    Icons
                                                                        .favorite_outlined,
                                                                    color:
                                                                        Colors.white,
                                                                    size: 25)
                                                                : const Icon(
                                                                    Icons
                                                                        .favorite_outline_sharp,
                                                                    color:
                                                                        Colors.white,
                                                                    size: 25)
                                                            : const Icon(
                                                                Icons
                                                                    .favorite_outline_sharp,
                                                                color: Colors.white,
                                                                size: 25),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      if (controller
                                                              .isSelectedPageView ==
                                                          false) {
                                                        await controller
                                                            .saveImage(context);
                                                      } else {
                                                        await controller
                                                            .saveSelectedImages(
                                                                context);
                                                      }
                                                      myFolderController
                                                              .addSelectedImage =
                                                          List.generate(
                                                              controller
                                                                      .getBoardInfoModel
                                                                      .data
                                                                      ?.length ??
                                                                  0,
                                                              (index) => false);
                                                      controller.isSelectedPageView =
                                                          false;
                                                      controller.update(['fldr']);
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color:  ColorRes.appColor,
                                                        borderRadius:
                                                            BorderRadius.circular(25),
                                                      ),
                                                      child: const SizedBox(
                                                        height: 23,
                                                        width: 23,
                                                        child: Icon(
                                                            Icons
                                                                .file_download_outlined,
                                                            color: Colors.white,
                                                            size: 25),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      if (controller
                                                              .isSelectedPageView ==
                                                          false) {
                                                        await controller.onTapShare();
                                                      } else {
                                                        await controller
                                                            .onSelectedTapShare();
                                                      }
                                                      myFolderController
                                                              .addSelectedImage =
                                                          List.generate(
                                                              controller
                                                                      .getBoardInfoModel
                                                                      .data
                                                                      ?.length ??
                                                                  0,
                                                              (index) => false);
                                                      controller.isSelectedPageView =
                                                          false;
                                                      controller.update(['fldr']);
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color:  ColorRes.appColor,
                                                        borderRadius:
                                                            BorderRadius.circular(25),
                                                      ),
                                                      child: SizedBox(
                                                        height: 23,
                                                        width: 23,
                                                        child: Image.asset(
                                                            AssetRes.shareIcon,
                                                            color: ColorRes.white,
                                                            scale: 3),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        (controller.isMore == true)
                            ? Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      myFolderController.onTapMore();
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
                                        controller.isMore = false;
                                        controller.selectedImg = false;
                                        controller.isSelect = false;
                                        controller.isPageView = false;
                                        controller.update(['fldr']);
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
                                              child: Image.asset(AssetRes.langIcon),
                                            ),
                                            SizedBox(width: Get.width * 0.03),
                                            Text(
                                              StringRes.language.tr,
                                              style:  appTextStyle(
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
                    ),
                    widget.isFirstNode ?? false
                        ? Container(
                      height: Get.height * 0.67,
                      width: Get.width,
                      alignment:
                      Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: HtmlWidget(
                          (widget.quote ?? ''),
                          // customStylesBuilder: (element) {
                          //
                          //   if (element.localName == 'div' && element.attributes['style']?.contains('text-align: center;') == true) {
                          //     return {'text-align': 'center'};
                          //   }
                          //   return null;
                          // },
                          //
                          textStyle:
                          widget.quoteFamily !=
                              ''
                              ? TextStyle(
                            fontFamily:
                            widget
                                .quoteFamily,
                            color: (widget.quoteColor !=
                                '')
                                ? Color(int.parse(widget.quoteColor!.substring(1, 7), radix: 16) +
                                0xFF000000)
                                : ColorRes
                                .appColor,
                            fontSize:
                            20,
                          )
                              : appTextStyle(
                            color: (widget.quoteColor !=
                                '')
                                ? Color(int.parse(widget.quoteColor!.substring(1, 7), radix: 16) +
                                0xFF000000)
                                : ColorRes
                                .appColor,
                            //fontFamily: widget.nameFamily,
                            fontSize:
                            20,
                          ),
                        ),
                      ),
                    )
                        :const SizedBox()
                  ],
                ),
                Obx(() => (controller.loader.value)
                    ? const CommonLoader()
                    : const SizedBox())
              ],
            ),
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(55), topLeft: Radius.circular(55)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(AssetRes.appNewLogo, scale: 3),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                flex: 2,
                child: ListView.separated(
                  itemCount: myFolderController.drawerTitleList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (myFolderController.drawerTitleList[index] ==
                            StringRes.home.tr) {
                          Get.back();
                        } else if (myFolderController.drawerTitleList[index] ==
                            StringRes.language.tr) {
                          Get.back();
                          Get.toNamed(AppRoutes.languageConfirmPage);
                        } else if (myFolderController.drawerTitleList[index] ==
                            StringRes.viewImages.tr) {
                          Get.back();
                          Get.toNamed(AppRoutes.viewImagesScreen,
                              arguments: []);
                        } else if (myFolderController.drawerTitleList[index] ==
                            StringRes.favourite.tr) {
                          Get.back();
                          Get.toNamed(AppRoutes.favourite)?.then((e) {
                            myFolderController.init();
                          });
                        } else if (myFolderController.drawerTitleList[index] ==
                            StringRes.contactUs.tr) {
                          Get.back();
                          Get.toNamed(AppRoutes.contactUs);
                        } else if (myFolderController.drawerTitleList[index] ==
                            StringRes.settings.tr) {
                          Get.back();
                          Get.toNamed(AppRoutes.setting);
                        } else {
                          Get.back();
                          showDialogs(context);
                        }
                      },
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                            myFolderController.drawerImageList[index],
                            scale: 4,
                            color: ColorRes.appColor),
                      ),
                      title: Text(myFolderController.drawerTitleList[index]),
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
          ),
        ),
        // endDrawer: CommonDrawer(context),
      ),
    );
  }

  appBar({String? boardName, String? icon}) {
    MyFolderController myFolderController = Get.put(MyFolderController());
    GetBoardModel getBoardModel = GetBoardModel();

    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
      height: Get.height * 0.1,
      width: Get.width,
      // color: ColorRes.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              if (myFolderController.isPageView ||
                  myFolderController.isSelectedPageView) {
                myFolderController.isPageView = false;
                myFolderController.isSelectedPageView = false;
                myFolderController.update(['fldr']);
              } else {
                Get.back();
                myFolderController.onTapBack();
              }
            },
            child: const Icon(Icons.arrow_back_ios, size: 20),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 20,
                  width: 20,
                  child: icon != ''
                      ? Image.network(icon ?? "")
                      : Image.asset(AssetRes.myfolderIcon),
                ),
                const SizedBox(width: 15),
                HtmlWidget(
                  boardName ?? "My folder",
                  textStyle: widget.nameFamily != ''
                      ? TextStyle(
                          fontFamily: widget.nameFamily,
                          color: (widget.nameColor != '')
                              ? Color(int.parse(
                                      widget.nameColor!.substring(1, 7),
                                      radix: 16) +
                                  0xFF000000)
                              : ColorRes.appColor,
                          fontSize: 24,
                        )
                      : appTextStyle(
                          color: (widget.nameColor != '')
                              ? Color(int.parse(
                                      widget.nameColor!.substring(1, 7),
                                      radix: 16) +
                                  0xFF000000)
                              : ColorRes.black,
                          fontSize: 24,
                          // fontFamily: widget.nameFamily
                        ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            child: Image.asset(AssetRes.moreOption,
                scale: 3, color: ColorRes.appColor),
          ),
        ],
      ),
    );
  }
}

// ...

/*Future<void> toggleLike(
    int index, MyFolderController controller, String image, int imageId) async {
  try {
    if (PrefService.getBool(PrefKeys.login) == false) {
      Get.toNamed(AppRoutes.login);
    } else {
      String userId = PrefService.getString(PrefKeys.userId);

      // Get the current user's favorites from shared preferences
      List<String> favorites = PrefService.getList(userId) ?? [];

      // Check if the image is already in favorites based on imageId
      bool isAlreadyLiked = favorites.any((fav) => fav.startsWith('$imageId:'));

      if (!isAlreadyLiked) {
        // If not liked, add the image to favorites in shared preferences
        favorites.add('$imageId:$image');
      } else {
        // If already liked, remove the image from favorites in shared preferences
        favorites.removeWhere((fav) => fav.startsWith('$imageId:'));
      }

      // Save the updated favorites to shared preferences
      PrefService.setValue(userId, favorites);

      // Update the local state
      controller.isLike[index] = !isAlreadyLiked;
      //   PrefService.setValue(PrefKeys.isLike + userId, controller.isLike.map((liked) => liked ? '1' : '0').toList());
      PrefService.setValue(
          '$imageId:$userId', controller.isLike[index] ? '1' : '0');
      controller.update(['fldr']);
    }
  } catch (e) {
    print('Error toggling like: $e');
  }
}*/

/*Future<void> toggleLike(int index, MyFolderController controller, String image, int imageId) async {
  try {

    if (PrefService.getBool(PrefKeys.login) == false) {
      Get.toNamed(AppRoutes.login);
    } else {
      // String image = controller.getBoardInfoModel.data![index].image!.toString();
      String userId = PrefService.getString(PrefKeys.userId);

      // Get the current user's favorites from shared preferences
      List<String> favorites = PrefService.getList(userId) ?? [];

      // Check if the image is already in favorites
      bool isAlreadyLiked = favorites.contains(image);

      if (!isAlreadyLiked) {
        // If not liked, add the image to favorites in shared preferences
        favorites.add(image);
      } else {
        // If already liked, remove the image from favorites in shared preferences
        favorites.remove(image);
      }

      // Save the updated favorites to shared preferences
      PrefService.setValue(userId, favorites);

      // Update the local state
      controller.isLike[index] = !isAlreadyLiked;
      PrefService.setValue(PrefKeys.isLike + userId, controller.isLike.map((liked) => liked ? '1' : '0').toList());


      controller.update(['fldr']);
    }
  } catch (e) {
    print('Error toggling like: $e');
  }
}*/

/*Future<void> toggleLike(int index, MyFolderController controller, String image) async {
  try {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;


    if (PrefService.getBool(PrefKeys.login)==false) {
      Get.toNamed(AppRoutes.login);
    } else {

      if (controller.isLike[index] == false) {
        controller.isLike[index] = true;

        // Add the image to favorites in Firestore
        await _firestore.collection('users').doc(PrefService.getString(PrefKeys.userId)).update({
          'favorites': FieldValue.arrayUnion([{
            'imageUrl': image,
          }])
        });
      } else {
        controller.isLike[index] = false;

        // Remove the image from favorites in Firestore
        await _firestore.collection('users').doc(PrefService.getString(PrefKeys.userId)).update({
          'favorites': FieldValue.arrayRemove([{
            'imageUrl': image,
          }])
        });
      }

      controller.update(['fldr']);
    }
  } catch (e) {
    print('Error toggling like: $e');
  }
}*/

/*Future<void> toggleLike(int index, MyFolderController controller, String image) async {
  try {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    if (PrefService.getBool(PrefKeys.login) == false) {
      Get.toNamed(AppRoutes.login);
    } else {
      String userId = PrefService.getString(PrefKeys.userId);

      // Get the current user's document reference
      DocumentReference userRef = _firestore.collection('users').doc(userId);

      // Fetch the current favorites array
      DocumentSnapshot userSnapshot = await userRef.get();
      List<Map<String, dynamic>> favorites = List<Map<String, dynamic>>.from(userSnapshot.get('favorites'));

      // Check if the image is already in favorites
      bool isAlreadyLiked = favorites.any((fav) => fav['imageUrl'] == image);

      if (!isAlreadyLiked) {
        // If not liked, add the image to favorites in Firestore
        favorites.add({'imageUrl': image});
      } else {
        // If already liked, remove the image from favorites in Firestore
        favorites.removeWhere((fav) => fav['imageUrl'] == image);
      }

      // Update the favorites array in Firestore
      await userRef.update({'favorites': favorites});

      // Update the local state
      controller.isLike[index] = !isAlreadyLiked;

      controller.update(['fldr']);
    }
  } catch (e) {
    print('Error toggling like: $e');
  }
}*/

void showDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: Get.height * 0.04),
          Image.asset(AssetRes.loginIcon, height: Get.height * 0.1),
          SizedBox(height: Get.height * 0.03),
          Text(
            StringRes.areYouSureLogOut.tr,
            textAlign: TextAlign.center,
            style: appTextStyle(
                weight: FontWeight.w500, fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: Get.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonButton(
                    onTap: () {
                      PrefService.setValue(PrefKeys.login, false);
                      PrefService.setValue('isUser', false);
                      PrefService.setValue('docId', '');
                      Get.offAllNamed(AppRoutes.login);
                    },
                    text: StringRes.yes.tr),
              ),
              SizedBox(width: Get.width * 0.01),
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
          SizedBox(height: Get.height * 0.04),
        ],
      );
    },
  );
}
