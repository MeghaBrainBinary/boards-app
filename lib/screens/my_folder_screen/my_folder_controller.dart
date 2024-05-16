

import 'dart:core';
import 'dart:io';


import 'package:boards_app/common/toast_msg.dart';
import 'package:boards_app/screens/my_folder_screen/api/get_board_info.dart';
import 'package:boards_app/screens/my_folder_screen/model/get_board_info_model.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/services/sqlite_helper.dart';
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

import '../../utils/appstyle.dart';

class MyFolderController extends GetxController {

   // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GetBoardInfoModel getBoardInfoModel = GetBoardInfoModel();
  PageController pageController= PageController();
  RxBool loader = false.obs;
  List checkImg = List.generate(4, (index) => false);
  bool isPageView = false;
  bool isSelectedPageView = false;
  List<bool> isLike = [];
    String? selectedImage;

    var args = Get.arguments;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //isLike = (PrefService.getList(PrefKeys.isLike) as List<bool>?) ?? [];



  }

  myInt(String id, {String? subBoardId})async{
    loader.value = true;
    if(subBoardId == null){
      getBoardInfoModel = await GetBoardInfoApi.getBoardInfoApi(id);
    }else{
      getBoardInfoModel = await GetBoardInfoApi.getBoardInfoApi(id, subBoardId: subBoardId);
    }

    loader.value = false;


   checkImg = List.generate(getBoardInfoModel.data?.length ??0, (index) => false);
    isLike = List.generate(getBoardInfoModel.data?.length ?? 0, (index) => false);
await init();
  update(['fldr']);
  }
  List<String> simg = [];

  bool isSelect = false;
  bool selectedImg = false;
  bool isMore = false;
  int selectedIndex = 0;

  List<String> drawerTitleList = [
   // StringRes.home.tr,
    StringRes.language.tr,
  //  StringRes.viewImages.tr,
    StringRes.favourite.tr,
    StringRes.contactUs.tr,
  //  StringRes.settings.tr,
   // StringRes.faq.tr,
  //  StringRes.loginLogout.tr,
  ];

  List<String> drawerImageList = [
    //AssetRes.homeIcon,
    AssetRes.languageIcon,
  //  AssetRes.grid,
    AssetRes.FavouriteIcon,
    AssetRes.contactUs,
   // AssetRes.settingsIcon,
 //   AssetRes.faqIcon,
   // AssetRes.loginIcon,
  ];
  List<bool> addSelectedImage = [];

  onTapSelect() {
    if (isSelect == false) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    checkImg = List.generate(getBoardInfoModel.data?.length??0, (index) => false);
    simg = [];
    update(['fldr']);
  }
onTapBack(){
  isSelect = false;
  simg =[];
  selectedImg = false;
  checkImg = List.generate(getBoardInfoModel.data?.length??0, (index) => false);
  addSelectedImage = List.generate(getBoardInfoModel.data?.length??0, (index) => false);

  update(['fldr']);

}
  onTapMore() {
    if (isMore == false) {
      isMore = true;
    } else {
      isMore = false;
    }
    update(['fldr']);
  }

  onTapCheck(data,index) {
    if (checkImg[index] == false) {
      checkImg[index] = true;
      simg.add(data);
    } else {
      checkImg[index] = false;
      simg.remove(data);
    }
    update(['fldr']);
  }
  onTapImage(index)async{
      isPageView = true;
      await Future.delayed(Duration(seconds: 1),(){});
pageController =PageController(initialPage: index);
      selectedImage = getBoardInfoModel.data![index].image.toString();
    update(['fldr']);
  }

  onImageChanged(i){


    if(getBoardInfoModel.data != null)
      {

    selectedImage = getBoardInfoModel.data![i].image.toString();
        selectedIndex =  pageController.page!.round();



      }
    update(['fldr']);
  }

  tapBackwardButton(){
    if(pageController.page!.round() != getBoardInfoModel.data!.length - 1) {

      pageController.animateToPage(
          pageController.page!.round() +1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
      selectedIndex =  pageController.page!.round();
    }
    update(['fldr']);
  }
  tapForwardButton(){
    if(pageController.page!.round() != 0) {
      pageController.animateToPage(
          pageController.page!.round() -1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
      selectedIndex =  pageController.page!.round();
    }
    update(['fldr']);
  }

  saveImage(context)async{

    if(getBoardInfoModel.data!=null && getBoardInfoModel.data!.length !=0) {
      loader.value = true;


      var response = await Dio()
          .get(
          selectedImage ?? getBoardInfoModel.data![0].image.toString(), options: Options(responseType: ResponseType.bytes));
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
                title:  Text(
                  "Success",
                  style: appTextStyle(
                      weight: FontWeight.w500, fontSize: 20, color: ColorRes.appColor),
                ),
                content:  Text(
                  "Images Downloaded Successfully",
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
                      "Okay",
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
      selectedImage = null;

      // loader.value = true;
      //
      // simg.forEach((element) async{
      //   var response = await Dio()
      //       .get(element, options: Options(responseType: ResponseType.bytes));
      //   await ImageGallerySaver.saveImage(
      //     Uint8List.fromList(response.data),
      //     quality: 60,
      //     name: "ra",
      //   );
      // });
      // loader.value = false;

      // Get.snackbar(
      //   "Success",
      //   "Images Downloaded Successfully",
      //   backgroundColor: Colors.green,
      //   colorText: ColorRes.white,
      // );
      checkImg =
          List.generate(getBoardInfoModel.data?.length ?? 0, (index) => false);
      selectedImg = false;
      isSelect = false;
      simg = [];
      update(['fldr']);
    }

  }

  Future<void> saveSelectedImages(context) async {
    if (getBoardInfoModel.data != null && getBoardInfoModel.data!.length != 0) {
      loader.value = true;

      List<String> selectedImages = [];

      for (int i = 0; i < addSelectedImage.length; i++) {
        if (addSelectedImage[i]) {
          selectedImages.add(getBoardInfoModel.data?[i].image ?? "");
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
                  "Success",
                  style: appTextStyle(
                      weight: FontWeight.w500, fontSize: 20, color: ColorRes.appColor),
                ),
                content:  Text(
                  "Images Downloaded Successfully",
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
                      "Okay",
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
      // Get.snackbar(
      //   "Success",
      //   "Images Downloaded Successfully",
      //   backgroundColor: Colors.green,
      //   colorText: ColorRes.white,
      // );
      // Reset selected images
      addSelectedImage = List.generate(getBoardInfoModel.data?.length ?? 0, (index) => false);
      update(['fldr']);
    }
  }


  onTapShare()async{
    loader.value = true;

    if(getBoardInfoModel.data!=null && getBoardInfoModel.data!.length !=0) {

      try {
        http.Response response = await http.get(Uri.parse(
            selectedImage ?? getBoardInfoModel.data![0].image.toString()));
        final bytes = response.bodyBytes;

        await WcFlutterShare.share(
            sharePopupTitle: 'share',
            fileName: "share.${selectedImage?.split(".").last ?? getBoardInfoModel.data![0].image.toString().split(".").last}",
            mimeType: 'image/${selectedImage?.split(".").last ??
                getBoardInfoModel.data![0].image
                    .toString()
                    .split(".")
                    .last}',
            bytesOfFile: bytes);
      }catch(e){

        loader.value = false;
      }
     // Share.share(selectedImage ?? getBoardInfoModel.data![0].image.toString(),);
      selectedImage = null;
loader.value= false;

      update(['fldr']);
    }
  }
  Future<void> onSelectedTapShare() async {
    if (addSelectedImage.any((selected) => selected)) {
      loader.value = true;

      List<String> selectedImages = [];

      for (int i = 0; i < addSelectedImage.length; i++) {
        if (addSelectedImage[i]) {
          selectedImages.add(getBoardInfoModel.data?[i].image ?? "");
        }
      }

      if (selectedImages.isNotEmpty) {
        try {
          // Share the selected images
          await shareMultipleImages(selectedImages);
        } catch (e) {

        }

        loader.value = false;
        // myFolderController.resetSelectedImages();
        update(['fldr']);
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
        text: 'Share Multiple Images',
        subject: 'Share Multiple Images Subject',
      );
    } catch (e) {

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


init() async {
  isLike = List.generate(getBoardInfoModel.data?.length ?? 0, (index) => false);
   var listLike =  await SqliteHelper.sqliteHelper.fetch();

   if(getBoardInfoModel.data != null)
     {
       getBoardInfoModel.data!.forEach((e) {
         if(listLike != null && listLike.length !=0)
         {
           listLike.forEach((element) {

             if(element.imageId ==e.id.toString())
               {
                 isLike[getBoardInfoModel.data!.indexOf(e)] = true;
               }
           });
         }
       });
     }
update(['fldr']);
}


  likeUnlike(index){
    var image =  getBoardInfoModel.data![index].image.toString();
    var imageId =  getBoardInfoModel.data![index].id.toString();
    if(isLike[index])
      {


        SqliteHelper.sqliteHelper.delete(imageID: imageId);
        isLike[index] = false;
      }
    else
      {
        SqliteHelper.sqliteHelper.insertDb(imageID: imageId, imageUrl: image);
        isLike[index] = true;
      }
  }
  likeUnlikeList () async {


List allIndex =[];
List allIndexData =[];
    if (getBoardInfoModel.data != null && getBoardInfoModel.data!.length != 0) {
      loader.value = true;


      for (int i = 0; i < addSelectedImage.length; i++) {
        if (addSelectedImage[i]) {
       allIndexData.add(i);
        }

        }
      }


    var data  = await SqliteHelper.sqliteHelper.fetch();


    allIndexData.forEach((element) {

      data.forEach((e) {
        if(e.imageId == (getBoardInfoModel.data?[element].id.toString()  ?? ''))
          {

            allIndex.add(element);
          }
      });

    });

    allIndex.forEach((element) {
      allIndexData.remove(element);
    });
allIndexData.forEach((element) {
  SqliteHelper.sqliteHelper.insertDb(
      imageID: getBoardInfoModel.data?[element].id.toString()  ?? '',
      imageUrl: getBoardInfoModel.data?[element].image ?? '');
  isLike[element] = true;
});




      loader.value = false;



  }


  /*onSelectedTapShare() async {
    if(addSelectedImage.any((selected) => selected)){


    loader.value = true;

    List<String> selectedImages = [];

    for (int i = 0; i < addSelectedImage.length; i++) {
      if (addSelectedImage[i]) {
        selectedImages.add(getBoardInfoModel.data?[i].image ?? "");
      }
    }

    if (selectedImages.isNotEmpty) {
      try {
        // Share the selected images
        for (String selectedImage in selectedImages) {
          http.Response response = await http.get(Uri.parse(selectedImage));
          final bytes = response.bodyBytes;

          await WcFlutterShare.share(
            sharePopupTitle: 'share',
            fileName: "share.${selectedImage.split(".").last}",
            mimeType: 'image/${selectedImage.split(".").last}',
            bytesOfFile: bytes,
          );
        }
      } catch (e) {

      }

      loader.value = false;
      // myFolderController.resetSelectedImages();
      update(['fldr']);
    }
    }
    else
      {
        errorTost("Please select an image to share");
      }
  }
*/

  @override
  void dispose() {
selectedImage =null;
isPageView= false;
isSelect = false;
selectedImg = false;


    // TODO: implement dispose
    super.dispose();
  }
  // List folderImgs = [
  //   {
  //     "url": AssetRes.folderImg1,
  //     "type": "img",
  //   },
  //   {
  //     "url": AssetRes.folderImg2,
  //     "type": "img",
  //   },
  //   {
  //     "url": AssetRes.folderImg3,
  //     "type": "img",
  //   },
  //   {
  //     "url": AssetRes.folderImg4,
  //     // ChewieController(
  //     //   autoPlay: false,
  //     //   videoPlayerController: VideoPlayerController.network(
  //     //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
  //     //     ..initialize().then((_) {
  //     //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //     //     }),
  //     // ),
  //     "type": "video",
  //   },
  // ];

  // @override
  // void onInit() {
  //   super.onInit();
  //   controller = VideoPlayerController.network(
  //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //     });

  //   chewieController = ChewieController(
  //     autoInitialize: true,
  //     videoPlayerController: controller,
  //     autoPlay: false,
  //     looping: true,
  //     aspectRatio: 4 / 3,
  //     allowPlaybackSpeedChanging: false,
  //     // Try playing around with some of these other options:

  //     // showControls: false,
  //     // materialProgressColors: ChewieProgressColors(
  //     //   playedColor: Colors.red,
  //     //   handleColor: Colors.blue,
  //     //   backgroundColor: Colors.grey,
  //     //   bufferedColor: Colors.lightGreen,
  //     // ),
  //     // placeholder: Container(
  //     //   color: Colors.grey,
  //     // ),
  //     // autoInitialize: true,
  //   );
  // }



}
