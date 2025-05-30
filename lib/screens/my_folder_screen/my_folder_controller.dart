// ignore_for_file: unnecessary_overrides, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, prefer_is_empty, deprecated_member_use, empty_catches, unnecessary_null_comparison

import 'dart:core';
import 'dart:io';
import 'package:boards_app/common/toast_msg.dart';
import 'package:boards_app/screens/boards_screen/api/logout_api.dart';
import 'package:boards_app/screens/my_folder_screen/api/add_downlaod_api.dart';
import 'package:boards_app/screens/my_folder_screen/api/add_view_api.dart';
import 'package:boards_app/screens/my_folder_screen/api/get_board_info.dart';
import 'package:boards_app/screens/my_folder_screen/model/get_board_info_model.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/services/sqlite_helper.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../utils/appstyle.dart';

class MyFolderController extends GetxController {

  GetBoardInfoModel getBoardInfoModel = GetBoardInfoModel();
  PageController pageController= PageController();
  RxBool loader = false.obs;
  List checkImg = List.generate(4, (index) => false);
  bool isPageView = false;
  bool isSelectedPageView = false;
  List<bool> isLike = [];
  List<bool> initilized = [];
  List<bool> isPlay = [];
  List<bool> isLoad = [];
  String? selectedImage;
  String selectedId = "";
List<bool> isSelectedNode =[];
  var args = Get.arguments;

//
List<VideoPlayerController?> videos =[];

 List<String?> videosPath =[];
 List<String?> videosType =[];

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

    getBoardInfoModel.data?.forEach((element) {
      if(element.fileType =="video") {
        ImageProvider _imageProvider = NetworkImage(
            element.thumbnail ?? '');


        precacheImage(_imageProvider, Get.context!);
      }
    });

    isLoad= List.generate(getBoardInfoModel.data?.length ??0, (index) => false);

    initilized = List.generate(getBoardInfoModel.data?.length ??0, (index) => false);

    videos = List.generate(getBoardInfoModel.data?.length ??0, (index) => (getBoardInfoModel.data?[index].fileType =="video")?
    VideoPlayerController.networkUrl(Uri.parse(getBoardInfoModel.data?[index].image ??'')):null);

    loader.value = false;



   for(int i=0; i<videos.length;i++)
     {
       if(videos[i] != null)
       {

         videos[i]?.initialize().then((value) {}).catchError((error) {
           if (kDebugMode) {
             print('Error: $error');
           }

         });
         videos[i]?.notifyListeners();
         videos[i]?.setLooping(true);
         videos[i]?.addListener(() {
           if(videos[i]?.value.isBuffering == true)
           {
             isLoad[i] = true;

             update(['fldr']);
           }
           else {
             isLoad[i] = false;

             update(['fldr']);

           }
           if(videos[i]?.value.isInitialized == true)
           {
             initilized[i] = true;

             update(['fldr']);
           }

         });

         update(['fldr']);
       }
     }


    update(['fldr']);
    checkImg = List.generate(getBoardInfoModel.data?.length ??0, (index) => false);
   isPlay = List.generate(getBoardInfoModel.data?.length ??0, (index) => false);
    isLike = List.generate(getBoardInfoModel.data?.length ?? 0, (index) => false);


await init();
  update(['fldr']);
  }


  Future<File> downloadVideo(String url, String type) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Get temporary directory
      final directory = await getTemporaryDirectory();

      // Create a file to store the video
      // ignore: unnecessary_brace_in_string_interps
      final file = File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.${type}');

      // Write the video file to the file system
      return file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception("Failed to download video");
    }
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
    StringRes.logout.tr,
  ];

  List<String> drawerImageList = [
    //AssetRes.homeIcon,
    AssetRes.languageIcon,
  //  AssetRes.grid,
    AssetRes.FavouriteIcon,
    AssetRes.contactUs,
   // AssetRes.settingsIcon,
 //   AssetRes.faqIcon,
    AssetRes.loginIcon,
  ];
  List<bool> addSelectedImage = [];


onTapBack(){
  isSelect = false;
  simg =[];
  selectedImg = false;
  checkImg = List.generate(getBoardInfoModel.data?.length??0, (index) => false);
  addSelectedImage = List.generate(getBoardInfoModel.data?.length??0, (index) => false);
for (var element in videos) {
  if(element != null) {
    element.pause();
    element.dispose();
  }

}
videos =[];
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
  onTapImage(index, {bool? fromNotification})async{
      isPageView = true;
      await Future.delayed(const Duration(seconds: 1),(){});


      if(fromNotification ?? false)
        {
          await Future.delayed(const Duration(seconds: 2),(){});

          pageController.animateToPage(index, duration: const Duration(milliseconds: 500
          ), curve: Curves.easeInOut);
          selectedImage = getBoardInfoModel.data?[index].image.toString();
          selectedIndex =index;
        }
      else {
        pageController = PageController(initialPage: index);
        selectedImage = getBoardInfoModel.data?[index].image.toString();
        selectedIndex =index;

      }


      await ViewApi.viewApi((getBoardInfoModel.data?[selectedIndex].id ??0 ).toString());
    update(['fldr']);
  }

  onImageChanged(i) async {


    if(getBoardInfoModel.data != null)
      {

    selectedImage = getBoardInfoModel.data![i].image.toString();
        selectedIndex =  pageController.page!.round();


    await ViewApi.viewApi((getBoardInfoModel.data?[selectedIndex].id ?? 0).toString());

      }
    update(['fldr']);
  }

  tapBackwardButton() async {
    if(pageController.page!.round() != getBoardInfoModel.data!.length - 1) {

      pageController.animateToPage(
          pageController.page!.round() +1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
      selectedIndex =  pageController.page!.round();
      selectedImage = getBoardInfoModel.data![selectedIndex].image.toString();
      await ViewApi.viewApi((getBoardInfoModel.data?[selectedIndex].id ??0).toString());

    }
    update(['fldr']);
  }
  tapForwardButton() async {
    if(pageController.page!.round() != 0) {
      pageController.animateToPage(
          pageController.page!.round() -1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
      selectedIndex =  pageController.page!.round();
      selectedImage = getBoardInfoModel.data![selectedIndex].image.toString();
      await ViewApi.viewApi((getBoardInfoModel.data?[selectedIndex].id ?? 0).toString());

    }
    update(['fldr']);
  }

  saveImage(context)async{

    if(getBoardInfoModel.data!=null && getBoardInfoModel.data!.length !=0) {
      loader.value = true;

if((selectedImage ?? getBoardInfoModel.data![0].image) !.split(".").last == "mp4")
  {
    var appDocDir = await getApplicationDocumentsDirectory();
    String savePath = "${appDocDir.path}/${DateTime.now().millisecond}.mp4";
    String fileUrl =
        selectedImage ?? getBoardInfoModel.data![0].image.toString();
    await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
      if (kDebugMode) {
        print("${(count / total * 100).toStringAsFixed(0)}%");
      }
    });
    GallerySaver.saveVideo(savePath).then((value) {
      print(value);
    });
   // final result = await ImageGallerySaver.saveFile(savePath);
   //  if (kDebugMode) {
   //    print(result);
   //  }
  }
else {
  var response = await Dio()
      .get(
      selectedImage ?? getBoardInfoModel.data![0].image.toString(),
      options: Options(responseType: ResponseType.bytes));

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
  //   name: "ra",
  // );
}
      await addDownloadApi(getBoardInfoModel.data![selectedIndex].id.toString());

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
      //   "Images are downloaded successfully",
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
      List<int> selectedImagesIDS = [];

      for (int i = 0; i < addSelectedImage.length; i++) {
        if (addSelectedImage[i]) {
          selectedImages.add(getBoardInfoModel.data?[i].image ?? "");
          selectedImagesIDS.add(getBoardInfoModel.data?[i].id  ?? 0);
        }
      }

      try {
        // Save the selected images
        for (String selectedImage in selectedImages) {
          if (selectedImage.split(".").last =="mp4") {
            var appDocDir = await getApplicationDocumentsDirectory();
            String savePath = "${appDocDir.path}/${DateTime.now().millisecond}.mp4";
            String fileUrl =
                selectedImage;
            await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
              if (kDebugMode) {
                print("${(count / total * 100).toStringAsFixed(0)}%");
              }
            });
            GallerySaver.saveVideo(savePath).then((value) {
              print(value);
            });
            // final result = await ImageGallerySaver.saveFile(savePath);
            // if (kDebugMode) {
            //   print(result);
            // }
          }
          else {
            var response = await Dio().get(
              selectedImage,
              options: Options(responseType: ResponseType.bytes),
            );
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
            //   name: "ra",
            // );
          }
        }

        for(int ids in selectedImagesIDS)
          {
            await addDownloadApi(ids.toString());
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
      // Get.snackbar(
      //   "Success",
      //   "Images are downloaded successfully",
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

      // try {
      //   http.Response response = await http.get(Uri.parse(
      //       selectedImage ?? getBoardInfoModel.data![0].image.toString()));
      //   final bytes = response.bodyBytes;
      //
      //   await WcFlutterShare.share(
      //       sharePopupTitle: 'share',
      //       fileName: "share.${selectedImage?.split(".").last ?? getBoardInfoModel.data![0].image.toString().split(".").last}",
      //       mimeType: 'image/${selectedImage?.split(".").last ??
      //           getBoardInfoModel.data![0].image
      //               .toString()
      //               .split(".")
      //               .last}',
      //       bytesOfFile: bytes);
      // }catch(e){
      //
      //   loader.value = false;
      // }
      http.Response response = await http.get(Uri.parse(
              selectedImage ?? getBoardInfoModel.data![0].image.toString()));
      final bytes = response.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = "${temp.path}/${DateTime.now().millisecond}.${selectedImage?.split(".").last ?? getBoardInfoModel.data![0].image.toString().split(".").last}";
      File(path).writeAsBytesSync(bytes);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(path)],
        ),
      );
//       Share.shareFiles([
// path
//       ],
//         text: '',
//         subject: '',
//       );

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
    List<XFile> filePaths = [];

    // Save images temporarily and get file paths
    for (int i = 0; i < selectedImages.length; i++) {
      String filePath = await saveImageLocally(selectedImages[i], "image$i.${selectedImages[i].split(".").last}");
      filePaths.add(XFile(filePath));
    }

    try {
      // Share the images using share_plus
      await SharePlus.instance.share(
        ShareParams(
          files: filePaths,
        ),
      );
      // await Share.shareFiles(
      //   filePaths,
      //   text: '',
      //   subject: '',
      // );
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
       for (var e in getBoardInfoModel.data!) {
         if(listLike != null && listLike.length !=0)
         {
           for (var element in listLike) {

             if(element.imageId ==e.id.toString())
               {
                 isLike[getBoardInfoModel.data!.indexOf(e)] = true;
               }
           }
         }
       }
     }
update(['fldr']);
}


  likeUnlike(index){
    var image =  getBoardInfoModel.data![index].image.toString();
    var imageId =  getBoardInfoModel.data![index].id.toString();
    var type =  getBoardInfoModel.data![index].fileType.toString();
    var thumbnail =  getBoardInfoModel.data![index].thumbnail.toString();
    if(isLike[index])
      {


        SqliteHelper.sqliteHelper.delete(imageID: imageId);
        isLike[index] = false;
      }
    else
      {
        SqliteHelper.sqliteHelper.insertDb(imageID: imageId, imageUrl: image,fileType: type,thumbnail: thumbnail);
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


    for (var element in allIndexData) {

      for (var e in data) {
        if(e.imageId == (getBoardInfoModel.data?[element].id.toString()  ?? ''))
          {

            allIndex.add(element);
          }
      }

    }

    for (var element in allIndex) {
      allIndexData.remove(element);
    }
for (var element in allIndexData) {
  SqliteHelper.sqliteHelper.insertDb(
      imageID: getBoardInfoModel.data?[element].id.toString()  ?? '',
      imageUrl: getBoardInfoModel.data?[element].image ?? '',
    fileType:   getBoardInfoModel.data?[element].fileType ?? '',
    thumbnail:   getBoardInfoModel.data?[element].thumbnail ?? '',
  );
  isLike[element] = true;
}




      loader.value = false;



  }


  addDownloadApi(boardImageId)async{
  loader.value =true;
  await DownloadApi.downloadApi(boardImageId);
  loader.value =false;
  }
  addViewApi(boardImageId)async{
    loader.value =true;
    await ViewApi.viewApi(boardImageId);
    loader.value =false;
  }

  logoutApi()async{
    loader.value =true;
    await LogoutApi.logoutApi();

    loader.value =false;
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

for (var element in videos) {
  if(element != null)
    {
      element.dispose();

    }
}
videos =[];

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
