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
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (favouriteController.isPageView) {
          favouriteController.isPageView = false;
          for (var element in favouriteController.videos) {
            if(element != null) {
              element.pause();
            }

          }

          favouriteController. isPlay = List.generate(favouriteController.storedFavorites?.length ??0, (index) => false);
          favouriteController.update(['favourite']);
        } else {
          Get.back();
          for (var element in favouriteController.videos) {
            if(element != null) {
              element.pause();
              element.dispose();
            }

          }
          favouriteController. isPlay = List.generate(favouriteController.storedFavorites?.length ??0, (index) => false);


          favouriteController.videos =[];
        }
        return false;
      },
      child: Scaffold(
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
            alignment: Alignment.center,
            children: [
              GetBuilder<FavouriteController>(
                id: "favourite",
                builder: (controller) => SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 13, right: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                            // SizedBox(height: Get.height * 0.025),

                            appBar(boardName: StringRes.favourite.tr),

                            const SizedBox(height: 10),

                            if ((controller.storedFavorites ?? []).isNotEmpty)
                            if (controller.isPageView == false && controller.isSelectOn == false)
                              GestureDetector(
                                onTap: () {
                                  controller.checkImage = List.generate(controller.storedFavorites?.length ?? 0, (index) => false);
                                  controller.isSelectOn = true;
                                  controller.isPageView = false;
                                  for (var element in favouriteController.videos) {
                                    if(element != null) {
                                      element.pause();
                                    }

                                  }
                                  favouriteController. isPlay = List.generate(favouriteController.storedFavorites?.length ??0, (index) => false);

                                  controller.update(['favourite']);
                                },
                                child: Text(
                                  StringRes.select.tr,
                                  style: appTextStyle(color: ColorRes.appColor, fontSize: 15, weight: FontWeight.w500),
                                ),
                              )
                            else const SizedBox()  else const SizedBox(),

                                controller.isSelectOn
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${controller.checkImage.where((e) => e == true).length} ${StringRes.imageSelected.tr}',
                                            style: appTextStyle(color: ColorRes.black, fontSize: 13, weight: FontWeight.w600),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.checkImage = List.generate(controller.checkImage.length ?? 0, (index) => false);
                                              controller.isSelectOn = false;
                                              controller.update(['favourite']);
                                              },
                                            child: Text(
                                              StringRes.cancel.tr,
                                              style: appTextStyle(color: ColorRes.appColor, fontSize: 15, weight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

                            SizedBox(height: Get.height * 0.03),

                            (controller.isPageView)
                                ? Container(
                                    height: Get.height * 0.6,
                                    width: Get.width,
                                    alignment: Alignment.topCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              controller.tapForwardButton();
                                            },
                                            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 25),
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          width: Get.width * 0.75,
                                          child: PageView.builder(
                                              controller: controller.pageController,
                                              itemCount: controller.storedFavorites?.length ?? 0,
                                              onPageChanged: (val) {
                                                controller.onImageChanged(val);
                                              },
                                              itemBuilder: (context, index) {
                                                controller.selectedIndex;
                                                return Stack(
                                                  alignment: Alignment.bottomRight,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        controller.onTapImage(index);
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: Container(
                                                          height: Get.height * 0.7,
                                                          width: Get.width * 0.75,
                                                          padding: const EdgeInsets.all(2),
                                                          decoration: BoxDecoration(
                                                            color: Colors.transparent,
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          child:  controller.storedFavorites![index]['fileType'] =="video" ?
                                                          controller.videos[index] != null?
                                                          Stack(
                                                            alignment:Alignment.center,
                                                            children: [
                                                              FijkView(
                                                                color: Colors.white,
                                                                player: controller.videos[index]!,

                                                              ),
                                                            /*  InkWell(
                                                                onTap:() async {

                                                                  if(controller.isPlay[index])
                                                                  {
                                                                    controller.isPlay[index] = false;
                                                                    controller.videos[index]?.pause();

                                                                  }
                                                                  else
                                                                  {
                                                                    controller.isPlay = List.generate( controller.storedFavorites?.length ?? 0, (index) => false);
                                                                    for (var e in controller.videos) {
                                                                      if(e != null)
                                                                      {
                                                                        e.pause();
                                                                      }
                                                                    }
                                                                    controller.isPlay[index] = true;

                                                                    controller.videos[index]?.start();

                                                                  }
                                                                  controller.update(['favourite']);

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
                                                              ),*/
                                                            ],
                                                          ):const SizedBox()
                                                              :CachedNetworkImage(
                                                            fit: BoxFit.fitWidth,
                                                            imageUrl: controller.storedFavorites![index]['image']!.toString(),
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
                                                            errorWidget: (context, url, error) => Container(),
                                                          ),
                                                          // child: Image.network(
                                                          //   controller.getBoardInfoModel.data![index]
                                                          //       .image!.toString(),
                                                          //   fit: BoxFit.fitWidth,
                                                          //
                                                          // ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.tapBackwardButton();
                                            },
                                            child: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: Get.height * 0.7,
                                    child: GridView.builder(
                                        padding: const EdgeInsets.all(0),
                                        itemCount: controller.storedFavorites?.length ?? 0,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 6,
                                          crossAxisSpacing: 19,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
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
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Stack(
                                                    alignment: controller.isSelectOn == false ? Alignment.topRight : Alignment.bottomRight,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: ()  {

                                                          print(index);

                                                          if(controller.isSelectOn == false) {
                                                            controller.onTapImage(index);
                                                            controller.update(['favourite']);
                                                          } else {
                                                            if (controller.checkImage[index] == false) {
                                                              controller.checkImage[index] = true;
                                                            } else {
                                                              controller.checkImage[index] = false;
                                                            }
                                                          }

                                                          controller.update(['favourite']);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(5),
                                                          child: Container(
                                                            padding: (controller.checkImage[index] == true)
                                                                ? const EdgeInsets.all(1)
                                                                : const EdgeInsets.all(1),
                                                            decoration: BoxDecoration(
                                                              color: controller.checkImage[index] == true
                                                                  ? ColorRes.appColor
                                                                  : Colors.transparent,
                                                              border: Border.all(
                                                                color: controller.checkImage[index] == true
                                                                    ? ColorRes.appColor
                                                                    : Colors.white,
                                                              ),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child:  controller.storedFavorites![index]['fileType'] =="video" ?
                                                            controller.videos[index] != null?
                                                            Stack(
                                                              alignment:Alignment.center,
                                                              children: [
                                                                FijkView(
                                                                  color: Colors.white,

                                                                  player: controller.videos[index]!,

                                                                  panelBuilder: (a,b,c,d,e){
                                                                    return Container();
                                                                  },
                                                                ),
                                                                InkWell(
                                                                  onTap:() async {
                                                                    controller.onTapImage(index);
                                                                    // if(controller.isPlay[index])
                                                                    // {
                                                                    //   controller.isPlay[index] = false;
                                                                    //   controller.videos[index]?.pause();
                                                                    //
                                                                    // }
                                                                    // else
                                                                    // {
                                                                    //
                                                                    //   controller.isPlay = List.generate( controller.storedFavorites?.length ?? 0, (index) => false);
                                                                    //   for (var e in controller.videos) {
                                                                    //     if(e != null)
                                                                    //     {
                                                                    //       e.pause();
                                                                    //     }
                                                                    //   }
                                                                    //   controller.isPlay[index] = true;
                                                                    //
                                                                    //   controller.videos[index]?.start();
                                                                    //
                                                                    // }
                                                                    controller.update(['favourite']);

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
                                                            ):const SizedBox():CachedNetworkImage(
                                                              height: 170,
                                                              width: Get.width,
                                                              fit: BoxFit.cover,
                                                              imageUrl: controller.storedFavorites?[index]['image'] ?? "",
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
                                                              errorWidget: (context, url, error) => Container(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      controller.checkImage[index] == true
                                                          ? Padding(
                                                              padding: const EdgeInsets.only(bottom: 10, right: 10),
                                                              child: Image.asset(AssetRes.selectedImage, scale: 4),
                                                            )
                                                          : const SizedBox(),
                                                      controller.isSelectOn == false
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                controller.removeFavorite(controller.storedFavorites?[index]['id'] ?? '');
                                                              },
                                                              child: Container(
                                                                height: 20,
                                                                width: 20,
                                                                margin: const EdgeInsets.only(top: 12, right: 12),
                                                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white),
                                                                child: Icon(Icons.favorite_outlined, size: 18, color: ColorRes.colorE16F55),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      // controller.addSelectedImage[index]==true? Padding(
                                                      //   padding: const EdgeInsets.only(bottom: 10,right: 10),
                                                      //   child: Image.asset(AssetRes.selectedImage,scale: 4,),
                                                      // ):SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                          ]),
                        ),


                        (controller.isPageView == true || (controller.isSelectOn == true && controller.checkImage.where((e) => e == true).length > 0))
                            ? Column(
                                children: [
                                  const SizedBox(height: 30),

                                  Container(
                                    height: 50,
                                    width: Get.width,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if(controller.isSelectOn == false) {
                                                await controller.removeFavorite(controller.storedFavorites?[controller.selectedIndex]['id'] ?? '');
                                              } else {
                                                await controller.removeFavoriteList();
                                              }
                                              controller.isPageView = false;
                                              controller.isSelectOn = false;
                                              controller.update(['favourite']);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: ColorRes.appColor,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: SizedBox(
                                                  height: 23,
                                                  width: 23,
                                                  child: (controller.isPageView)
                                                      ? const Icon(Icons.favorite_outlined, color: Colors.white, size: 25)
                                                      : const Icon(Icons.favorite_outline_sharp, color: Colors.white, size: 25),
                                              ),
                                            ),
                                          ),


                                          InkWell(
                                            onTap: () async {
                                              if(controller.isSelectOn == false) {
                                                await controller.saveImage(context);
                                              } else {
                                                await controller.saveSelectedImages(context);
                                                controller.isSelectOn = false;
                                              }
                                              controller.update(['favourite']);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: ColorRes.appColor,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: const SizedBox(
                                                height: 23,
                                                width: 23,
                                                child: Icon(Icons.file_download_outlined, color: Colors.white, size: 25),
                                              ),
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () async {
                                              if(controller.isSelectOn == false) {
                                                await controller.onTapShare();
                                              } else {
                                                await controller.onSelectedTapShare();
                                                controller.isSelectOn = false;
                                              }
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: ColorRes.appColor,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: SizedBox(
                                                height: 23,
                                                width: 23,
                                                child: Image.asset(AssetRes.shareIcon, color: ColorRes.white, scale: 3),
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
              ),
              Obx(() => favouriteController.loader.value
                  ? const CommonLoader()
                  : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  appBar({String? boardName}) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
      height: Get.height * 0.1,
      width: Get.width,
      // color: ColorRes.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (favouriteController.isPageView) {
                favouriteController.isPageView = false;
                for (var element in favouriteController.videos) {
                  if(element != null) {
                    element.pause();
                  }

                }
                favouriteController. isPlay = List.generate(favouriteController.storedFavorites?.length ??0, (index) => false);

                favouriteController.update(['favourite']);
              } else {
                Get.back();
                for (var element in favouriteController.videos) {
                  if(element != null) {
                    element.pause();
                    element.dispose();

                  }

                }

                favouriteController. isPlay = List.generate(favouriteController.storedFavorites?.length ??0, (index) => false);

                favouriteController.videos =[];

              }
            },
            child: const Icon(Icons.arrow_back_ios, size: 20),
          ),
          Text(
            boardName ?? '',
            style: appTextStyle(fontSize: 24, weight: FontWeight.w400, color: ColorRes.black),
          ),
          Text(
            '',
            style: appTextStyle(fontSize: 24, weight: FontWeight.w400, color: ColorRes.black),
          ),
        ],
      ),
    );
  }
}
