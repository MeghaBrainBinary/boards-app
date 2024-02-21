// ignore_for_file: must_be_immutable

import 'package:boards_app/screens/wallpaper_flow/downloads_screen/download_controller.dart';
import 'package:boards_app/screens/wallpaper_flow/only_view_wallpaper_screen/only_view_wallpaper_screen.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({Key? key}) : super(key: key);
  DownloadController downloadController = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    downloadController.onInit();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              StringRes.DownLoads,
              style: TextStyle(
                  fontSize: Get.width * 0.06,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: "spleshfont"),
            ),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: downloadController.imageFinalList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await downloadController.onTapDownloadImage2(
                        downloadController.imageFinalList.length);
                    Get.to(
                        () => OnlyViewWallpaperScreen(
                              image: '',
                              docId: '',
                              imageList: downloadController.imageFinalList,
                              favBoolList: downloadController.myBoolList,
                            ),
                        arguments: index);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height * 0.18,
                        width: Get.width * 0.25,
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.5), width: 0),
                        ),
                        child: CachedNetworkImage(
                          height: Get.height * 0.3,
                          width: Get.width * 0.28,
                          imageUrl: downloadController.imageFinalList[index]
                              ['imageLink'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                            AssetRes.imagePlaceholder,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AssetRes.imagePlaceholder,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: Get.height * 0.18,
                        width: Get.width * 0.25,
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.5), width: 0.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
