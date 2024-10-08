// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/my_select_folder_screen/my_select_folder_controller.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../my_folder_screen/model/get_board_info_model.dart';

class MySelectFolderScreen extends StatelessWidget {
  String? boardName;
  List<Datum> FolderData;
  MySelectFolderScreen({super.key, required this.FolderData});

  MyFolderController myFolderController = Get.put(MyFolderController());
  MySelectFolderController mySelectFolderController = Get.put(MySelectFolderController());

  late VideoPlayerController videoPlayerController;


  @override

  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<MySelectFolderController>(
        id: 'fldr',
        builder: (controller) => Stack(
          alignment: Alignment.center,
          children: [
       /*     Stack(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        appBar(boardName: boardName),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.05, right: Get.width * 0.06),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${mySelectFolderController.addSelectedImage.where((e) => e == true).length} ${StringRes.imageSelected}',style: appTextStyle(color: ColorRes.black,fontSize: 13,weight: FontWeight.w600),),
                                  GestureDetector(onTap: () {
                                    mySelectFolderController.addSelectedImage = List.generate( FolderData?.length ?? 0, (index) => false);
                                    controller.update(['fldr']);
                                  },child: Text(StringRes.cancel,style: appTextStyle(color: ColorRes.appColor,fontSize: 15,weight: FontWeight.w500),)),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.7,
                                width: Get.width,
                                child:(FolderData!=null)? GridView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: FolderData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 19),
                                    itemBuilder: (context, index) {

                                      return Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [

                                          InkWell(
                                            onTap:(){
                                             if( mySelectFolderController.addSelectedImage[index]==false)
                                               {
                                                 mySelectFolderController.addSelectedImage[index]=true;
                                               }
                                             else
                                               {
                                                 mySelectFolderController.addSelectedImage[index]=false;
                                               }
                                             mySelectFolderController.update(['fldr']);
                                            },
                                            child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    child: Container(
                                                      height: Get.height * 0.199,
                                                      width: Get.width * 0.45,
                                                      padding: (myFolderController.checkImg[index] == false)
                                                          ? const EdgeInsets.all(0)
                                                          : const EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                        color:myFolderController.checkImg[index]==true?
                                                        ColorRes.appColor:Colors.transparent,
                                                        border: Border.all(color:myFolderController.checkImg[index]==true?
                                                        ColorRes.appColor:Colors.white ),
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                      ),
                                                      child: Stack(alignment: Alignment.bottomRight,
                                                        children: [
                                                          CachedNetworkImage(

                                                            width: Get.width,
                                                            fit: BoxFit.fitWidth,
                                                            imageUrl:FolderData![index].image!.toString(),

                                                            placeholder: (context, url) => Container(),
                                                            errorWidget: (context, url, error) => Container(),
                                                          ),
                                                          mySelectFolderController.addSelectedImage[index]==true? Padding(
                                                            padding: const EdgeInsets.only(bottom: 10,right: 10),
                                                            child: Image.asset(AssetRes.selectedImage,scale: 4,),
                                                          ):SizedBox()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ),

                                          (myFolderController.isSelect == false)
                                              ? const SizedBox()
                                              : InkWell(
                                                  onTap: () {
                                                    myFolderController.onTapCheck(myFolderController.getBoardInfoModel.data![index].image,index);
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10, bottom: 10),
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      color: ColorRes.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: (myFolderController
                                                                .checkImg[index] ==
                                                            false)
                                                        ? const SizedBox()
                                                        : SizedBox(
                                                            height: 8,
                                                            width: 11,
                                                            child: Transform.scale(
                                                              scale: 0.6,
                                                              child: Icon(
                                                                Icons.check_rounded,
                                                                color: ColorRes
                                                                    .appColor,
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                        ],
                                      );
                                    }):const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                (myFolderController.isMore == true)
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
                                myFolderController.isMore = false;
                                myFolderController.selectedImg = false;
                                myFolderController.isSelect = false;
                                myFolderController.isPageView = false;
                                myFolderController.update(['fldr']);
                                Get.offAndToNamed(AppRoutes.languageConfirmPage);
                              },
                              child: Container(
                                height: 45,
                                width: 153,
                                color: ColorRes.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 14,
                                      width: 14,
                                      child: Image.asset(AssetRes.langIcon),
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
            )*/
            Obx(() => (myFolderController.loader.value)?const CommonLoader():const SizedBox())
          ],
        ),
      ),
    );
  }
}

appBar({String? boardName}) {
  MyFolderController myFolderController = Get.put(MyFolderController());

  return Container(
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.only(
      left: Get.width * 0.05,
      right: Get.width * 0.05,
    ),
    height: Get.height * 0.18,
    width: Get.width,
    // color: ColorRes.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            if(myFolderController.isPageView){
              myFolderController.isPageView = false;
              myFolderController.update(['fldr']);
            }
            else
              {
            Get.back();
            myFolderController.onTapBack();
              }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(AssetRes.myfolderIcon)),
              const SizedBox(
                width: 15,
              ),
              Text(
                boardName ?? "My folder",
                style: appTextStyle(
                    fontSize: 24,
                    weight: FontWeight.w400,
                    color: ColorRes.black),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            myFolderController.onTapMore();
          },
          child: Image.asset(AssetRes.moreOption,scale: 3,),
        ),
      ],
    ),
  );
}
