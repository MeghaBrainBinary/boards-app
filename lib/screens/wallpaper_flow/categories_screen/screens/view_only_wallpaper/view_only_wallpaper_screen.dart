// ignore_for_file: must_be_immutable, deprecated_member_use, depend_on_referenced_packages

import 'dart:io';

import 'package:boards_app/screens/wallpaper_flow/categories_screen/screens/view_only_wallpaper/view_only_wallpaper_controller.dart';
import 'package:boards_app/screens/wallpaper_flow/lock_screen/lock_screen.dart';
import 'package:boards_app/screens/wallpaper_flow/wallpaper_preview_screen/wallpaper_preview_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ViewOnlyWallpaperScreen extends StatelessWidget {
  List? imageList;
  String image;
  String? id;

  ViewOnlyWallpaperScreen(
      {Key? key,
      required this.image,
      required this.imageList,
      required this.id})
      : super(key: key);

  ViewOnlyWallpaperController viewOnlyWallpaperController =
      Get.put(ViewOnlyWallpaperController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(() {
          return Stack(
            children: [
              GetBuilder<ViewOnlyWallpaperController>(
                id: 'viewOnly',
                builder: (controller) {
                  return PageView.builder(
                    controller: viewOnlyWallpaperController.pageController,
                    itemCount: imageList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: CachedNetworkImage(
                              height: Get.height * 0.184,
                              width: Get.width * 0.86,
                              imageUrl: imageList![index]['imageLink'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                AssetRes.imagePlaceholder,
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AssetRes.imagePlaceholder,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Get.width * 0.08),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                        child: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                viewOnlyWallpaperController.isMenuOpen
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(LockScreen(
                                                image: imageList![index]
                                                    ['imageLink'],
                                              ));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                              ),
                                              child: const Icon(Icons.lock),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 15,
                                ),
                                viewOnlyWallpaperController.isMenuOpen
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(WallPaperPreviewScreen(
                                                  image: imageList![index]
                                                      ['imageLink']));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                              ),
                                              child: const Icon(Icons.home),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    viewOnlyWallpaperController.isMenuOpen
                                        ? GestureDetector(
                                            onTap: () {
                                              viewOnlyWallpaperController
                                                  .isMenuOpen = false;
                                              viewOnlyWallpaperController
                                                  .update(['viewOnly']);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              viewOnlyWallpaperController
                                                  .isMenuOpen = true;
                                              viewOnlyWallpaperController
                                                  .update(['viewOnly']);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                              ),
                                              child: const Icon(
                                                Icons.menu,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (imageList![index]['isFav']) {
                                          imageList![index]['isFav'] = false;
                                          viewOnlyWallpaperController
                                              .onTapUnlike(
                                                  imageList![index]
                                                      ['imageLink'],
                                                  id!,
                                                  false);
                                        } else {
                                          imageList![index]['isFav'] = true;

                                          viewOnlyWallpaperController.onTapLike(
                                              imageList![index]['imageLink'],
                                              id!,
                                              true);
                                        }
                                        viewOnlyWallpaperController
                                            .update(['viewOnly']);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                        child: imageList![index]['isFav']
                                            ? const Icon(
                                                Icons.favorite_outlined,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.favorite_outline_sharp,
                                                color: Colors.black,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        viewOnlyWallpaperController
                                            .loader.value = true;
                                        var response = await http.get(Uri.parse(
                                            imageList![index]['imageLink']));
                                        if (response.statusCode == 200) {
                                          List<int> bytes = response.bodyBytes;
                                          Directory tempDir =
                                              await getTemporaryDirectory();
                                          File tempFile = File(
                                              '${tempDir.path}/wallpaperpre1.png');
                                          debugPrint(
                                              'Temporary File Path: ${tempFile.path}');
                                          await tempFile.writeAsBytes(bytes);
                                          await Share.shareFiles(
                                              [tempFile.path],
                                              text: 'Check out this image!');
                                        } else {
                                          throw Exception(
                                              'Failed to load image');
                                        }
                                        viewOnlyWallpaperController
                                            .loader.value = false;
                                        viewOnlyWallpaperController
                                            .update(['viewOnly']);
                                      },
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                          child: SizedBox(
                                            height: Get.height * 0.05,
                                            child: Image.asset(
                                              AssetRes.shareIcon,
                                              height: 25,
                                              width: 25,
                                              color: Colors.black,
                                            ),
                                          )),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        viewOnlyWallpaperController
                                            .loader.value = true;
                                        var response = await Dio().get(
                                            imageList![index]['imageLink'],
                                            options: Options(
                                                responseType:
                                                    ResponseType.bytes));
                                        // var response = await Dio().get(
                                        //   selectedImage,
                                        //   options: Options(responseType: ResponseType.bytes),
                                        // );
                                        // var response = await Dio().get(
                                        //     selectedImage ?? storedFavorites![0]['image'].toString(),
                                        //     options: Options(responseType: ResponseType.bytes));
                                        final dir = await getApplicationDocumentsDirectory();

                                        final file = File('${dir.path}/${DateTime.now().millisecond}.jpg');
                                        //
                                        // // Write the bytes
                                        await file.writeAsBytes(Uint8List.fromList(response.data));

                                        // print(Uint8List.fromList(response.data));
                                        GallerySaver.saveImage(file.path).then((value) {
                                          print(value);
                                        });
                                        // await ImageGallerySaver.saveImage(
                                        //   Uint8List.fromList(response.data),
                                        //   quality: 60,
                                        //   name: "ohooho",
                                        // );
                                        viewOnlyWallpaperController
                                            .downloadImages
                                            .add(
                                                imageList![index]['imageLink']);
                                        await PrefService.setValue(
                                            PrefKeys.downloadImageList,
                                            viewOnlyWallpaperController
                                                .downloadImages);
                                        // var data = PrefService.getList(
                                        //     PrefKeys.downloadImageList);

                                        viewOnlyWallpaperController
                                            .loader.value = false;
                                        viewOnlyWallpaperController
                                            .update(['viewOnly']);
                                        // Get.to(DownloadScreen());
                                        Get.snackbar(
                                            'Yay!!', "Image is downloaded",
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: Colors.white);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_downward_sharp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              viewOnlyWallpaperController.loader.value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox(),
            ],
          );
        }));
  }
}
