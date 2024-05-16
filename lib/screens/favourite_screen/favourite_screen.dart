
// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/favourite_screen/favourite_controller.dart';
import 'package:boards_app/screens/settings_screen/settings_controller.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(favouriteController.isPageView)
        {
          favouriteController.isPageView = false;
          favouriteController.update(['favourite']);
        }
        else
        {

          Get.back();
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            GetBuilder<FavouriteController>(
              id: "favourite",
              builder: (controller) => SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Column(children: [
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        appBar(boardName: StringRes.favourite.tr),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        (controller.isPageView)?

                        Container(
                          height: Get.height * 0.6,
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
                                  child: const Icon(
                                    Icons
                                        .arrow_back_ios_new_rounded,
                                    color: Colors.black,
                                    size: 25,
                                  )),
                              Container(
                                alignment:
                                Alignment.topCenter,
                                width: Get.width * 0.75,
                                child: PageView.builder(
                                    controller: controller
                                        .pageController,
                                    itemCount: controller.storedFavorites
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
                                              padding:  const EdgeInsets
                                                  .all(2),
                                              decoration:
                                              BoxDecoration(
                                                color: Colors
                                                    .transparent,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(5),
                                              ),
                                              child:
                                              CachedNetworkImage(
                                                fit: BoxFit
                                                    .fitWidth,
                                                imageUrl:  controller.storedFavorites![index]
                                                ['image']!
                                                    .toString(),
                                                progressIndicatorBuilder:
                                                    (context,
                                                    strings,
                                                    download) {
                                                  return Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.white,
                                                      enabled: true,
                                                      child: Container(
                                                        height:
                                                        Get.width,
                                                        width:
                                                        Get.width,
                                                        color:
                                                        Colors.white,
                                                      ));
                                                },
                                                errorWidget: (context,
                                                    url,
                                                    error) =>
                                                    Container(),
                                              ),
                                              // child: Image.network(
                                              //   controller.getBoardInfoModel.data![index]
                                              //       .image!.toString(),
                                              //   fit: BoxFit.fitWidth,
                                              //
                                              // ),
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
                                  child: const Icon(
                                    Icons
                                        .arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 25,
                                  )),
                            ],
                          ),
                        )
                            : Container(
                          height: Get.height *0.7,
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

                                    ClipRRect(
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
                                          // ColorRes.appColor:Colors.transparent,
                                          // border: Border.all(color:myFolderController.checkImg[index]==true?
                                          // ColorRes.appColor:Colors.white ),
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        child: Stack(alignment: Alignment.topRight,
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                controller.isPageView =true;
                                                controller.onTapImage(index);
                                                controller.update(['favourite']);
                                              },
                                              child: CachedNetworkImage(
                                                height: 170,
                                                width: Get.width,
                                                fit: BoxFit.cover,
                                                imageUrl:controller.storedFavorites?[index]['image'] ?? "",
                                                progressIndicatorBuilder: (context,strings,download){
                                                  return    Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.white,
                                                      enabled: true, child:
                                                  Container(
                                                    height: Get.width,width: Get.width,
                                                    color: Colors.white,
                                                  ));
                                                },
                                                errorWidget: (context, url, error) => Container(),
                                              ),
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
                                                controller.removeFavorite(controller.storedFavorites?[index]['id'] ?? '');
                                              },
                                              child: Container(height: 20,width: 20,
                                                margin: const EdgeInsets.only(top: 12,right: 12),
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
                                                  .appColor,
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
                    (controller.isPageView == true )
                        ? Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
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
                                // const SizedBox(
                                //   height: 23,
                                //   width: 23,
                                // ),
                                // SizedBox(
                                //   width: Get.width * 0.06,
                                // ),
                                // const SizedBox(
                                //   height: 23,
                                //   width: 23,
                                // ),
                                // SizedBox(
                                //   width: Get.width * 0.06,
                                // ),

                                InkWell(
                                  onTap: () async {
                                    controller.removeFavorite(controller.storedFavorites?[controller.selectedIndex]['id'] ?? '');
                                    controller.isPageView = false;
                                    controller.update(['favourite']);

                                  },
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: ColorRes.appColor,
                                      borderRadius:
                                      BorderRadius.circular(25),
                                    ),
                                    child:  SizedBox(
                                        height: 23,
                                        width: 23,
                                        child: (controller.isPageView)?
                                        // controller.isLike[controller.selectedIndex] == true?
                                        const Icon(
                                          Icons
                                              .favorite_outlined,
                                          color: Colors.white,
                                          size: 25,
                                        )
                                        //     :const Icon(
                                        //   Icons
                                        //       .favorite_outline_sharp,
                                        //   color: Colors.white,
                                        //   size: 25,
                                        // )
                                            :const Icon(
                                          Icons
                                              .favorite_outline_sharp,
                                          color: Colors.white,
                                          size: 25,
                                        )),
                                  ),
                                ),

                                // SizedBox(
                                //   width: Get.width * 0.06,
                                // ),

                                InkWell(
                                  onTap: () async {

                                      await controller.saveImage(context);


                                    controller.update(['favourite']);
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: ColorRes.appColor,
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
                                          size: 25,
                                        )),
                                  ),
                                ),

                                InkWell(
                                  onTap: () async {

                                      await  controller.onTapShare();


                                  },
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: ColorRes.appColor,
                                      borderRadius:
                                      BorderRadius.circular(25),
                                    ),
                                    child: SizedBox(
                                        height: 23,
                                        width: 23,
                                        child: Image.asset(
                                          AssetRes.shareIcon,
                                          color: ColorRes.white,
                                          scale: 3,
                                        )),
                                  ),
                                ),

                                // SizedBox(
                                //   width: Get.width * 0.06,
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            Obx(() => favouriteController.loader.value ?const CommonLoader():const SizedBox()),

          ],
        ),
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
              if(favouriteController.isPageView)
                {
                  favouriteController.isPageView = false;
                  favouriteController.update(['favourite']);
                }
              else
                {

              Get.back();
                }
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
