import 'package:boards_app/screens/my_folder_screen/api/get_board_info.dart';
import 'package:boards_app/screens/my_folder_screen/model/get_board_info_model.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
// import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class MyFolderController extends GetxController {
  // late VideoPlayerController controller;
  // ChewieController? chewieController;

  GetBoardInfoModel getBoardInfoModel = GetBoardInfoModel();
  PageController pageController= PageController();
  RxBool loader = false.obs;
  List checkImg = List.generate(4, (index) => false);
  bool isPageView = false;
    String? selectedImage;

  int(String id)async{
    loader.value = true;
    getBoardInfoModel = await GetBoardInfoApi.getBoardInfoApi(id);
    loader.value = false;


   checkImg = List.generate(getBoardInfoModel.data?.length ??0, (index) => false);
  update(['fldr']);
  }
  List<String> simg = [];

  bool isSelect = false;
  bool selectedImg = false;
  bool isMore = false;

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
  onTapImage(){
      isPageView = true;

    update(['fldr']);
  }

  onImageChanged(i){


    if(getBoardInfoModel.data != null)
      {

    selectedImage = getBoardInfoModel.data![i].image.toString();

    print(selectedImage);

      }
  }

  tapBackwardButton(){
    if(pageController.page!.round() != getBoardInfoModel.data!.length - 1) {
      pageController.animateToPage(
          pageController.page!.round() +1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    }
  }
  tapForwardButton(){
    if(pageController.page!.round() != 0) {
      pageController.animateToPage(
          pageController.page!.round() -1, duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    }
  }

  saveImage()async{

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

  onTapShare()async{
    loader.value = true;
    print(selectedImage);
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
        print(e.toString());
        loader.value = false;
      }
     // Share.share(selectedImage ?? getBoardInfoModel.data![0].image.toString(),);
      selectedImage = null;
loader.value= false;
      print(selectedImage);
      update(['fldr']);
    }
  }

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
