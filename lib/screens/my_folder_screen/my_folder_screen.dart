import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MyFolderScreen extends StatefulWidget {
  MyFolderScreen({super.key});

  @override
  State<MyFolderScreen> createState() => _MyFolderScreenState();
}

class _MyFolderScreenState extends State<MyFolderScreen> {
  MyFolderController myFolderController = Get.put(MyFolderController());

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
    return Scaffold(
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
                        appBar(),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.05, right: Get.width * 0.06),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.onTapSelect();
                                    },
                                    child: Container(
                                      child: (controller.isSelect == false)
                                          ? Text(
                                              StringRes.select,
                                              style: appTextStyle(
                                                  color: ColorRes.color305EBE,
                                                  fontSize: 15,
                                                  weight: FontWeight.w500),
                                            )
                                          : Text(
                                              StringRes.cancel,
                                              style: appTextStyle(
                                                  color: ColorRes.color305EBE,
                                                  fontSize: 15,
                                                  weight: FontWeight.w500),
                                            ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.7,
                                width: Get.width,
                                child:(controller.getBoardInfoModel.data!=null)? GridView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: controller.getBoardInfoModel.data!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 0,
                                            crossAxisSpacing: 19),
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                         /* (controller.folderImgs[index]['type'] ==
                                                  'img')
                                              ? */
                                          ClipRRect(
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
                                                      color: ColorRes.color305EBE,
                                                      borderRadius:
                                                          BorderRadius.circular(5),
                                                    ),
                                                    child: Image.network(
                                                      controller.getBoardInfoModel.data![index]
                                                          .image!.toString(),
                                                      fit: BoxFit.cover,
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
                                                    controller.onTapCheck(index);
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
                    (controller.simg.isEmpty)
                        ? const SizedBox()
                        : Container(
                            height: 50,
                            width: Get.width,
                            color: ColorRes.color305EBE,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 23,
                                  width: 23,
                                ),
                                SizedBox(
                                  width: Get.width * 0.06,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${controller.simg.length} ${StringRes.imageSelected}",
                                      style: appTextStyle(
                                          fontSize: 13, weight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: 23,
                                    width: 23,
                                    child: Image.asset(AssetRes.shareIcon)),
                                SizedBox(
                                  width: Get.width * 0.06,
                                ),
                              ],
                            ),
                          )
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
                                      StringRes.language,
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
    );
  }
}

appBar() {
  MyFolderController myFolderController = Get.put(MyFolderController());

  return Container(
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.only(
      left: Get.width * 0.07,
      right: Get.width * 0.025,
    ),
    height: Get.height * 0.18,
    width: Get.width,
    // color: ColorRes.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                StringRes.myFolder,
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
  );
}
