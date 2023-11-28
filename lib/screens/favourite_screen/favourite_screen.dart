
// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/screens/favourite_screen/favourite_controller.dart';
import 'package:boards_app/screens/settings_screen/settings_controller.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<FavouriteController>(
            id: "favourite",
            builder: (controller) => SizedBox(
              height: Get.height,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Column(children: [
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  appBar(boardName: StringRes.favourite),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Expanded(
                    child: GridView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: controller.storedFavorites?.length ?? 0,
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

                                },
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  child: Container(
                                    height: Get.height * 0.219,
                                    width: Get.width * 0.45,
                                    // padding: (myFolderController.checkImg[index] == false)
                                    //     ? const EdgeInsets.all(0)
                                    //     : const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      // color:myFolderController.checkImg[index]==true?
                                      // ColorRes.color305EBE:Colors.transparent,
                                      // border: Border.all(color:myFolderController.checkImg[index]==true?
                                      // ColorRes.color305EBE:Colors.white ),
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    child: Stack(alignment: Alignment.topRight,
                                      children: [
                                        CachedNetworkImage(
                                          height: 170,
                                          width: Get.width,
                                          fit: BoxFit.fill,
                                          imageUrl:controller.storedFavorites?[index] ?? "",

                                          placeholder: (context, url) => Container(),
                                          errorWidget: (context, url, error) => Container(),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // if(  controller.isLike[index]==false)
                                            // {
                                            //   controller.isLike[index]=true;
                                            // }
                                            // else
                                            // {
                                            //   controller.isLike[index]=false;
                                            // }
                                            // controller.update(['fldr']);
                                          },
                                          child: Container(height: 20,width: 20,
                                            margin: EdgeInsets.only(top: 12,right: 12),
                                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
                                                color: Colors.white),
                                            child:  Icon(Icons.favorite_outlined,size: 18,color: ColorRes.colorE16F55,)
                                          ),
                                        ),
                                        // controller.addSelectedImage[index]==true? Padding(
                                        //   padding: const EdgeInsets.only(bottom: 10,right: 10),
                                        //   child: Image.asset(AssetRes.selectedImage,scale: 4,),
                                        // ):SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                           /*   (myFolderController.isSelect == false)
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
                                            .color305EBE,
                                      ),
                                    ),
                                  ),
                                ),
                              ),*/
                            ],
                          );
                        }),
                  ),
                ]),
              ),
            ),
          ),

        ],
      ),
    );
  }


  appBar({String? boardName}) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          Text(
            boardName ?? '',
            style: appTextStyle(
                fontSize: 24,
                weight: FontWeight.w400,
                color: ColorRes.black),
          ),
          Text(
             '',
            style: appTextStyle(
                fontSize: 24,
                weight: FontWeight.w400,
                color: ColorRes.black),
          ),
        ],
      ),
    );
  }
}
