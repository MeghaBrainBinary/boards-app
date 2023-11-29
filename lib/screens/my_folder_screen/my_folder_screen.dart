import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_drawer_bar.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/my_select_folder_screen/my_select_folder_controller.dart';
import 'package:boards_app/screens/my_select_folder_screen/my_select_folder_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MyFolderScreen extends StatefulWidget {
  String? boardName;
  MyFolderScreen({super.key, this.boardName});

  @override
  State<MyFolderScreen> createState() => _MyFolderScreenState();
}

class _MyFolderScreenState extends State<MyFolderScreen> {
  MyFolderController myFolderController = Get.put(MyFolderController());
  MySelectFolderController mySelectFolderController = Get.put(MySelectFolderController());
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;




/*   @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    chewieController = ChewieController(
      autoInitialize: true,
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      aspectRatio: 4 / 2,
      allowPlaybackSpeedChanging: false,
      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
 */
  @override

  Widget build(BuildContext context) {
    String userId = PrefService.getString(PrefKeys.userId);
    myFolderController.isLike = (PrefService.getList(PrefKeys.isLike + userId) ?? [])
        .map((liked) => liked == '1')
        .toList();
    print("fgfgd---------------------------------------------------${myFolderController.isLike}");

    return WillPopScope(
      onWillPop: ()async{
        if(myFolderController.isPageView){
          myFolderController.isPageView = false;
          myFolderController.isSelectedPageView = false;
          myFolderController.update(['fldr']);
          return false;
        }
        else
        {
          Get.back();
          myFolderController.onTapBack();
        return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: myFolderController.scaffoldKey,
        body: GetBuilder<MyFolderController>(
          id: 'fldr',
          builder: (controller) => Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          appBar(boardName: widget.boardName),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          (controller.getBoardInfoModel==null)?const SizedBox():Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.06),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                               /* Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.onTapSelect();
                                      },
                                      child: Container(
                                        child: (controller.isSelect == false)
                                            ? Text(
                                                StringRes.select.tr,
                                                style: appTextStyle(
                                                    color: ColorRes.color305EBE,
                                                    fontSize: 15,
                                                    weight: FontWeight.w500),
                                              )
                                            : Text(
                                                StringRes.cancel.tr,
                                                style: appTextStyle(
                                                    color: ColorRes.color305EBE,
                                                    fontSize: 15,
                                                    weight: FontWeight.w500),
                                              ),
                                      ),
                                    )
                                  ],
                                ),*/
                                SizedBox(height: 10,),



                                if (controller.isPageView==false && controller.isSelectedPageView==false)
                                  GestureDetector(onTap: () {

                                  MySelectFolderController mySelectFolderController = Get.put(MySelectFolderController());
                                  myFolderController.addSelectedImage = List.generate( controller.getBoardInfoModel?.data?.length ?? 0, (index) => false);
                               //   Get.to(MySelectFolderScreen( FolderData: controller.getBoardInfoModel?.data ?? [],));
                                    controller.isSelectedPageView = true;
                                    controller.isPageView = false;
                                    controller.update(['fldr']);
                                  },
                                      child: Text(StringRes.select,
                                        style: appTextStyle(color: ColorRes.color305EBE,fontSize: 15,weight: FontWeight.w500),)) else SizedBox(),



                                controller.isSelectedPageView ?  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${myFolderController.addSelectedImage.where((e) => e == true).length} ${StringRes.imageSelected}',style: appTextStyle(color: ColorRes.black,fontSize: 13,weight: FontWeight.w600),),
                                    GestureDetector(onTap: () {
                                      myFolderController.addSelectedImage = List.generate( controller.getBoardInfoModel.data?.length ?? 0, (index) => false);
                                      controller.update(['fldr']);
                                    },child: Text(StringRes.cancel,style: appTextStyle(color: ColorRes.color305EBE,fontSize: 15,weight: FontWeight.w500),)),
                                  ],
                                ):SizedBox(),




                                (controller.isPageView && !controller.isSelectedPageView)?
                                Container(
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
                                          child: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            color: Colors.black,
                                            size: 25,
                                          )),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        width: Get.width *0.75,
                                        child: PageView.builder(
                                          controller: controller.pageController,
                                            itemCount: controller.getBoardInfoModel.data!.length,
                                            onPageChanged: (val){
                                            controller.onImageChanged(val);
                                            },
                                            itemBuilder: (context,index){
                                              return Stack(
                                                alignment: Alignment.bottomRight,
                                                children: [
                                                  InkWell(
                                                    onTap:(){
                                                      controller.onTapImage();
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      child: Container(
                                                        height: Get.height*0.6,
                                                        width: Get.width*0.75,
                                                        padding: (controller
                                                            .checkImg[index] ==
                                                            false)
                                                            ? const EdgeInsets.all(0)
                                                            : const EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          color: Colors.transparent,
                                                          borderRadius:
                                                          BorderRadius.circular(5),
                                                        ),
                                                        child: CachedNetworkImage(
                                                          fit: BoxFit.fitWidth,

                                                          imageUrl:controller.getBoardInfoModel.data![index].image!.toString(),

                                                          placeholder: (context, url) => Container(),
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
                                                  (controller.isSelect == false)
                                                      ? const SizedBox()
                                                      : InkWell(
                                                    onTap: () {
                                                      controller.onTapCheck(controller.getBoardInfoModel.data![index].image,index);
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
                                                      child: (controller
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
                                          )),
                                    ],
                                  ),
                                )
                                :
                                (!controller.isPageView && controller.isSelectedPageView)?   SizedBox(
                                  height: Get.height * 0.7,
                                  width: Get.width,
                                  child:(controller.getBoardInfoModel?.data!=null)?
                               /*   GridView.builder(
                                      padding: const EdgeInsets.all(0),
                                      itemCount: controller.getBoardInfoModel?.data?.length ?? 0,
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
                                                if( myFolderController.addSelectedImage[index]==false)
                                                {
                                                  myFolderController.addSelectedImage[index]=true;
                                                }
                                                else
                                                {
                                                  myFolderController.addSelectedImage[index]=false;
                                                }
                                                myFolderController.update(['fldr']);
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
                                                    ColorRes.color305EBE:Colors.transparent,
                                                    border: Border.all(color:myFolderController.checkImg[index]==true?
                                                    ColorRes.color305EBE:Colors.white ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  child: Stack(alignment: Alignment.bottomRight,
                                                    children: [
                                                      CachedNetworkImage(

                                                        width: Get.width,
                                                        fit: BoxFit.fitWidth,
                                                        imageUrl:controller.getBoardInfoModel?.data?[index].image ?? "",

                                                        placeholder: (context, url) => Container(),
                                                        errorWidget: (context, url, error) => Container(),
                                                      ),
                                                      myFolderController.addSelectedImage[index]==true? Padding(
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
                                                          .color305EBE,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      })*/
                                  GridView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: controller.getBoardInfoModel?.data?.length ?? 0,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 6,
                                      crossAxisSpacing: 19,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (myFolderController.addSelectedImage[index] == false) {
                                                myFolderController.addSelectedImage[index] = true;
                                              } else {
                                                myFolderController.addSelectedImage[index] = false;
                                              }
                                              myFolderController.update(['fldr']);
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Container(
                                                height: Get.height * 0.199,
                                                width: Get.width * 0.45,
                                                padding: (myFolderController.checkImg[index] == false)
                                                    ? const EdgeInsets.all(0)
                                                    : const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: myFolderController.checkImg[index] == true
                                                      ? ColorRes.color305EBE
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color: myFolderController.checkImg[index] == true
                                                        ? ColorRes.color305EBE
                                                        : Colors.white,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Stack(
                                                  alignment: Alignment.bottomRight,
                                                  children: [
                                                    CachedNetworkImage(
                                                      width: Get.width,
                                                      fit: BoxFit.fitWidth,
                                                      imageUrl: controller.getBoardInfoModel?.data?[index].image ?? "",
                                                      placeholder: (context, url) => Container(),
                                                      errorWidget: (context, url, error) => Container(),
                                                    ),
                                                    myFolderController.addSelectedImage[index] == true
                                                        ? Padding(
                                                      padding: const EdgeInsets.only(bottom: 10, right: 10),
                                                      child: Image.asset(
                                                        AssetRes.selectedImage,
                                                        scale: 4,
                                                      ),
                                                    )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          (myFolderController.isSelect == false)
                                              ? const SizedBox()
                                              : InkWell(
                                            onTap: () {
                                              myFolderController.onTapCheck(
                                                  myFolderController.getBoardInfoModel.data![index].image,
                                                  index);
                                            },
                                            child: Container(
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
                                                    color: ColorRes.color305EBE,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )

                                     :const SizedBox(),
                                )
                                    :
                                SizedBox(
                                  height: Get.height * 0.7,
                                  width: Get.width,
                                  child:(controller.getBoardInfoModel.data!=null)? GridView.builder(
                                      padding: const EdgeInsets.all(0),
                                      itemCount: controller.getBoardInfoModel.data!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 6,
                                              crossAxisSpacing: 19),
                                      itemBuilder: (context, index) {

                                        return Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                           /* (controller.folderImgs[index]['type'] ==
                                                    'img')
                                                ? */
                                            InkWell(
                                              onTap:(){
                                                controller.onTapImage();
                                              },
                                              child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(5),
                                                      child: Container(
                                                        height: Get.height * 0.199,
                                                        width: Get.width * 0.45,
                                                        padding: (controller
                                                                    .checkImg[index] ==
                                                                false)
                                                            ? const EdgeInsets.all(0)
                                                            : const EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(5),
                                                        ),
                                                        child: Stack(alignment: Alignment.topRight,
                                                          children: [
                                                            CachedNetworkImage(
                                                              width: Get.width,
                                                              fit: BoxFit.fitWidth,
                                                              imageUrl:controller.getBoardInfoModel.data![index].image!.toString(),

                                                              placeholder: (context, url) => Container(),
                                                              errorWidget: (context, url, error) => Container(),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                // if(PrefService.getBool(PrefKeys.login)==false)
                                                                //   {
                                                                //     Get.toNamed( AppRoutes.login);
                                                                //   }
                                                                // else
                                                                //   {
                                                                //     if(  controller.isLike[index]==false)
                                                                //     {
                                                                //       controller.isLike[index]=true;
                                                                //     }
                                                                //     else
                                                                //     {
                                                                //       controller.isLike[index]=false;
                                                                //     }
                                                                //   }
                                                                if (PrefService.getBool(PrefKeys.login) == false) {
                                                                  Get.toNamed(AppRoutes.login);
                                                                } else {
                                                                  await toggleLike(index,controller,controller.getBoardInfoModel.data![index].image!.toString());

                                                                  // You can optionally check the new state of isLike from the controller
                                                                  List<String>? storedFavorites = PrefService.getList( PrefService.getString(PrefKeys.userId));
                                                                  print("storedFavorites--> ${storedFavorites}");
                                                                  controller.update(['fldr']);
                                                                }
                                                              controller.update(['fldr']);
                                                              },
                                                              child: Container(height: 20,width: 20,
                                                                margin: EdgeInsets.only(top: 12,right: 12),
                                                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                    color: Colors.white),
                                                              child:  controller.isLike[index]==true? Icon(Icons.favorite_outlined,size: 18,color: ColorRes.colorE16F55,):Icon(Icons.favorite_outline_sharp,size: 18,),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // child: Image.network(
                                                        //   controller.getBoardInfoModel.data![index]
                                                        //       .image!.toString(),
                                                        //   fit: BoxFit.cover,
                                                        // ),
                                                      ),
                                                    ),
                                            ),
                                                /*: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                        child: Container(
                                                          height: Get.height * 0.199,
                                                          width: Get.width * 0.45,
                                                          padding: (controller
                                                                          .checkImg[
                                                                      index] ==
                                                                  false)
                                                              ? const EdgeInsets.all(
                                                                  0)
                                                              : const EdgeInsets.all(
                                                                  2),
                                                          color: ColorRes.color305EBE,
                                                          child: Image.asset(
                                                            controller
                                                                    .folderImgs[index]
                                                                ['url'],
                                                            fit: BoxFit.cover,
                                                          ),
                                                          // VideoPlayer(
                                                          //     videoPlayerController),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 30,
                                                          width: 30,
                                                          child: Image.asset(
                                                            AssetRes.playIcon,
                                                          ))
                                                    ],
                                                  ),*/
                                            (controller.isSelect == false)
                                                ? const SizedBox()
                                                : InkWell(
                                                    onTap: () {
                                                      controller.onTapCheck(controller.getBoardInfoModel.data![index].image,index);
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
                                                      child: (controller
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
          (controller.isPageView ==false && controller.isSelectedPageView == false)
                          ? const SizedBox()
                          : Container(
                              height: 50,
                              width: Get.width,
                              color: ColorRes.color305EBE,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      onTap: (){
                                        Get.toNamed(AppRoutes.favourite);
                                      },
                                      child: const SizedBox(
                                          height: 23,
                                          width: 23,
                                          child: Icon(Icons.favorite_outline_sharp,color: Colors.white,size: 25,)),
                                    ),

                                    // SizedBox(
                                    //   width: Get.width * 0.06,
                                    // ),

                                    InkWell(
                                      onTap: (){
                                        controller.saveImage();
                                      },
                                      child: const SizedBox(
                                          height: 23,
                                          width: 23,
                                          child: Icon(Icons.file_download_outlined,color: Colors.white,size: 25,)),
                                    ),

                                    InkWell(
                                      onTap: ()async{
                                        if(controller.isSelectedPageView==false)
                                          {
                                            controller.onTapShare();
                                          }
                                        else
                                          {
                                            controller.onSelectedTapShare();
                                          }


                                       // Share.share();
                                        // controller.simg.forEach((element) {
                                        //
                                        // Share.share(element);
                                        // });
                                        // List<ShareItParameters> list =[];
                                        // controller.simg.forEach((element) {
                                        //   list.add(ShareItParameters(type: ShareItFileType.image,path: element));
                                        // });
                                        // ShareIt.list(parameters: list);

                                       // ShareExtend.shareMultiple(controller.simg, 'image');
                                     //   List i = [];
                                     // controller.simg.forEach((element) async{
                                     //  ByteData b = await rootBundle.load(element);
                                     //  Map io ={
                                     //    "image":element,
                                     //    "byteData":b
                                     //  };
                                     //   i.add(io);
                                     // });
                                     // Map data= {};
                                     //
                                     // i.forEach((element) {
                                     //   data['element'] = element['byteData'].buffer.asUint8List();
                                     // });
                                     //
                                     // print(data);
                                        // await
                                        // VocsyShare.files('esys images',
                                        //     {
                                        //     'esys.png': bytes1.buffer.asUint8List(),
                                        //     'bluedan.png': bytes2.buffer.asUint8List(),
                                        //     'addresses.csv': bytes3.buffer.asUint8List(),
                                        //     },
                                        //     '*/*',
                                        //     text: 'My optional text.'
                                        // );

                                        // Map i ={};
                                        // List bufferData=[];
                                        // controller.simg.forEach((element) async{
                                        //   await rootBundle.load(element);
                                        // });
                                      //  VocsyShare.files(, files, mimeType)
                                      },
                                      child: SizedBox(
                                          height: 23,
                                          width: 23,
                                          child: Image.asset(AssetRes.shareIcon)),
                                    ),



                                    // SizedBox(
                                    //   width: Get.width * 0.06,
                                    // ),
                                  ],
                                ),
                              ),
                            ),


                    ],
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
              ),
              Obx(() => (controller.loader.value)?const CommonLoader():const SizedBox())
            ],
          ),
        ),
        endDrawer: Drawer(shape: const OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft:
        Radius.circular(55),topLeft: Radius.circular(55))),child: Column(children: [
          SizedBox(height: Get.height * 0.1,),
          Center(
              child:
              Image.asset(AssetRes.boards, width: Get.width * 0.3)),
          SizedBox(height: Get.height * 0.08,),
          Expanded(flex: 2,
            child: ListView.separated(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: myFolderController.drawerTitleList.length,
              itemBuilder: (context, index) {
                return ListTile(onTap: () {
                  if(index==0)
                  {
                    Get.back();
                  }
                  else if (index == 1) {
                    Get.back();
                    Get.toNamed(AppRoutes.languageConfirmPage);
                  } else if (index == 2) {
                    Get.back();
                    Get.toNamed(AppRoutes.favourite);
                  } else if (index == 3) {
                    Get.back();
                    Get.toNamed(AppRoutes.contactUs);
                  } else if (index == 4) {
                    Get.back();
                    Get.toNamed(AppRoutes.setting);
                  } else {
                    Get.back();
                    showDialogs(context);
                  }

                },
                 leading: Image.asset(myFolderController.drawerImageList[index],scale: 4,),
                  title: Text(myFolderController.drawerTitleList[index]),
                  trailing: const Icon(Icons.navigate_next),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 1,width: 50,color: ColorRes.black.withOpacity(0.30),margin: EdgeInsets.symmetric(horizontal: 19),);
              },
            ),
          ),
          SizedBox(height: Get.height * 0.05,),
        ],)),
        // endDrawer: CommonDrawer(context),
      ),
    );
  }
}


// ...

Future<void> toggleLike(int index, MyFolderController controller, String image) async {
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
}


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





appBar({String? boardName}) {
  MyFolderController myFolderController = Get.put(MyFolderController());
  GetBoardModel getBoardModel = GetBoardModel();

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
            if(myFolderController.isPageView ||  myFolderController.isSelectedPageView){
              myFolderController.isPageView = false;
              myFolderController.isSelectedPageView = false;
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
            // myFolderController.onTapMore();
            myFolderController.scaffoldKey.currentState?.openEndDrawer();
          },
          child: Container(
            // alignment: Alignment.centerRight,
            // color: ColorRes.color305EBE,
            // height: 25,
            // width: 25,
            child:Image.asset(AssetRes.moreOption,scale: 3,)
          ),
        ),
      ],
    ),
  );
}
void showDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(contentPadding: EdgeInsets.symmetric(horizontal: 20),children: [
        SizedBox(height: Get.height * 0.04,),
        Image.asset(AssetRes.loginIcon,height: Get.height * 0.1,),
        SizedBox(height: Get.height * 0.03,),
        Text(StringRes.areYouSureLogOut,textAlign: TextAlign.center,style: appTextStyle(weight: FontWeight.w500,fontSize: 20,color: Colors.black),),
        SizedBox(height: Get.height * 0.03,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Expanded(
            child: CommonButton(
                onTap: () {
                  Get.offAllNamed( AppRoutes.login);
                },
                text: StringRes.yes),
          ),
          SizedBox(width: Get.width * 0.01,),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                height:  50,
                width: 234,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorRes.color305EBE)
                ),
                child: Text(
                  StringRes.no,
                  style: appTextStyle(color: ColorRes.color305EBE,fontSize: 18, weight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],),
        SizedBox(height: Get.height * 0.04,),
      ],);
    },
  );
}
