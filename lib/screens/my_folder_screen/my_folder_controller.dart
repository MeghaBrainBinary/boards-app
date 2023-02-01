import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MyFolderController extends GetxController {
  // late VideoPlayerController controller;
  // ChewieController? chewieController;

  List checkImg = List.generate(4, (index) => false);
  List simg = [];

  bool isSelect = false;
  bool selectedImg = false;
  bool isMore = false;

  onTapSelect() {
    if (isSelect == false) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    checkImg = List.generate(4, (index) => false);
    simg = [];
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

  onTapCheck(int index) {
    if (checkImg[index] == false) {
      checkImg[index] = true;
      simg.add(index);
    } else {
      checkImg[index] = false;
      simg.remove(index);
    }
    update(['fldr']);
  }

  List folderImgs = [
    {
      "url": AssetRes.folderImg1,
      "type": "img",
    },
    {
      "url": AssetRes.folderImg2,
      "type": "img",
    },
    {
      "url": AssetRes.folderImg3,
      "type": "img",
    },
    {
      "url": AssetRes.folderImg4,
      // ChewieController(
      //   autoPlay: false,
      //   videoPlayerController: VideoPlayerController.network(
      //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      //     ..initialize().then((_) {
      //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      //     }),
      // ),
      "type": "video",
    },
  ];

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
