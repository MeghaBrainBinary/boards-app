import 'dart:io';

import 'package:boards_app/common/toast_msg.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/services/sqlite_helper.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class FavouriteController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isPageView = false;
  bool isSelectOn = false;
  String selectedLanguage = "English";
  String languageCode = "en";

  RxBool loader = false.obs;

  List<Map<String, dynamic>>? storedFavorites = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // storedFavorites= PrefService.getList( PrefService.getString(PrefKeys.userId));
    init();
  }

  PageController pageController = PageController();
  int selectedIndex = 0;
  String? selectedImage;

  onImageChanged(i) {
    if (storedFavorites?[i]['image'] != null) {
      selectedImage = storedFavorites![i]['image'].toString();
      selectedIndex = pageController.page!.round();

    }
    update(['favourite']);
  }

  onTapImage(index)async{
    // await Future.delayed(const Duration(seconds: 1),(){});
    isPageView = true;
    pageController = PageController(initialPage: index);
    selectedImage = storedFavorites![index]['image'].toString();

    update(['favourite']);
  }

  tapBackwardButton() {
    if (pageController.page!.round() != storedFavorites!.length - 1) {
      pageController.animateToPage(pageController.page!.round() + 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      selectedIndex = pageController.page!.round();
      selectedImage = storedFavorites![selectedIndex]['image'].toString();
    }
    update(['favourite']);
  }

  tapForwardButton() {
    if (pageController.page!.round() != 0) {
      pageController.animateToPage(pageController.page!.round() - 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      selectedIndex = pageController.page!.round();
      selectedImage = storedFavorites![selectedIndex]['image'].toString();
    }
    update(['favourite']);
  }

  saveImage(context) async {
    if (storedFavorites != null && storedFavorites!.length != 0) {
      loader.value = true;

      var response = await Dio().get(
          selectedImage ?? storedFavorites![0]['image'].toString(),
          options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "ra",
      );
      loader.value = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: AlertDialog(
                title: Text(
                  StringRes.success.tr,
                  style: appTextStyle(
                      weight: FontWeight.w500,
                      fontSize: 20,
                      color: ColorRes.appColor),
                ),
                content: Text(
                  StringRes.download.tr,
                  style: appTextStyle(color: ColorRes.black, fontSize: 18, weight: FontWeight.w600),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          );
                        },
                      ),
                      side: MaterialStateProperty.all(const BorderSide(color: ColorRes.blue)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      return Get.back();
                    },
                    child: Text(
                      StringRes.okay.tr,

                      style: appTextStyle(color: ColorRes.appColor, fontSize: 18, weight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          });
      selectedImage = null;
      update(['favourite']);
    }
  }

  Future<void> saveSelectedImages(context) async {
    if (storedFavorites != null && storedFavorites?.length != 0) {
      loader.value = true;

      List<String> selectedImages = [];

      for (int i = 0; i < checkImage.length; i++) {
        if (checkImage[i]) {
          selectedImages.add(storedFavorites?[i]['image'] ?? "");
        }
      }

      try {
        // Save the selected images
        for (String selectedImage in selectedImages) {
          var response = await Dio().get(
            selectedImage,
            options: Options(responseType: ResponseType.bytes),
          );

          await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: "ra",
          );
        }


      } catch (e) {

        Get.snackbar(
          "Error",
          "",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      loader.value = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: AlertDialog(
                title:  Text(
                  StringRes.success.tr,

                  style: appTextStyle(
                      weight: FontWeight.w500, fontSize: 20, color: ColorRes.appColor),
                ),
                content:  Text(
                  StringRes.download.tr,
                  style: appTextStyle(
                      color: ColorRes.black,
                      fontSize: 18,
                      weight: FontWeight.w600),
                ),
                actions: <Widget>[

                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          );
                        },
                      ),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: ColorRes.blue)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white),
                    ),
                    onPressed: () {
                      return Get.back();
                    },
                    child:  Text(
                      StringRes.okay.tr,

                      style: appTextStyle(
                          color: ColorRes.appColor,
                          fontSize: 18,
                          weight: FontWeight.w600),
                    ),
                  ),

                ],
              ),
            );
          }
      );
      checkImage = List.generate(storedFavorites?.length ?? 0, (index) => false);
      update(['fldr']);
    }
  }

  onTapShare() async {
    loader.value = true;

    if (storedFavorites != null && storedFavorites!.length != 0) {
      try {
        // http.Response response = await http.get(Uri.parse(
        //     selectedImage ?? storedFavorites![0]['image'].toString()));
        // final bytes = response.bodyBytes;
        //
        // await WcFlutterShare.share(
        //     sharePopupTitle: 'share',
        //     fileName:
        //         "share.${selectedImage?.split(".").last ?? storedFavorites![0]['image'].toString().split(".").last}",
        //     mimeType:
        //         'image/${selectedImage?.split(".").last ?? storedFavorites![0]['image'].toString().split(".").last}',
        //     bytesOfFile: bytes);

        http.Response response = await http.get(Uri.parse(
            selectedImage ?? storedFavorites![0]['image'].toString()));
        final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = "${temp.path}/${DateTime.now().millisecond}.${selectedImage?.split(".").last ?? storedFavorites![0]['image'].toString().split(".").last}";
        File(path).writeAsBytesSync(bytes);
        Share.shareFiles([
          path
        ],
          text: '',
          subject: '',
        );
      } catch (e) {
        loader.value = false;
      }
      // Share.share(selectedImage ?? getBoardInfoModel.data![0].image.toString(),);
      selectedImage = null;
      loader.value = false;

      update(['fldr']);
    }
  }

  Future<void> onSelectedTapShare() async {
    if (checkImage.any((selected) => selected)) {
      loader.value = true;

      List<String> selectedImages = [];

      for (int i = 0; i < checkImage.length; i++) {
        if (checkImage[i]) {
          selectedImages.add(storedFavorites?[i]['image'] ?? "");
        }
      }

      if (selectedImages.isNotEmpty) {
        try {
          await shareMultipleImages(selectedImages);
        } catch (e) {
          debugPrint(e.toString());
        }

        loader.value = false;
        update(['favourite']);
      }
    } else {
      errorTost("Please select an image to share");
    }
  }

  Future<void> shareMultipleImages(List<String> selectedImages) async {
    List<String> filePaths = [];

    // Save images temporarily and get file paths
    for (int i = 0; i < selectedImages.length; i++) {
      String filePath = await saveImageLocally(selectedImages[i], "image$i.jpg");
      filePaths.add(filePath);
    }

    try {
      // Share the images using share_plus
      await Share.shareFiles(
        filePaths,
        text: '',
        subject: '',
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> saveImageLocally(String imageUrl, String fileName) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = '$tempPath/$fileName';

    File file = File(filePath);
    await file.writeAsBytes(bytes);

    return filePath;
  }


  List<bool> checkImage = [];

  init() async {
    storedFavorites = [];
    var data = await SqliteHelper.sqliteHelper.fetch();
    data.forEach((element) {
      storedFavorites?.add({
        "id": element.imageId,
        "image": element.imageUrl,
      });
    });
    checkImage = List.generate((storedFavorites ?? []).length, (index) => false);
    print("--------------------------------${checkImage.length}");
    update(['favourite']);
  }

  removeFavorite(id) async {
    await SqliteHelper.sqliteHelper.delete(
      imageID: id,
    );
    await init();
    update(['favourite']);
  }

  removeFavoriteList () async {
    if (checkImage != null && checkImage.length != 0) {
      loader.value = true;


      for (int i = 0; i < (checkImage ?? []).length; i++) {
        if (checkImage[i]) {
          await SqliteHelper.sqliteHelper.delete(
            imageID: storedFavorites?[i]['id'] ?? '',
          );
        }
      }
      loader.value = false;
      await init();
      update(['favourite']);
    }
  }



}
