import 'package:boards_app/screens/vr_video_screen/vr_video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vr_player/vr_player.dart';

class VrVideoView extends StatefulWidget {
  const VrVideoView({super.key});

  @override
  State<VrVideoView> createState() => _VrVideoViewState();
}

class _VrVideoViewState extends State<VrVideoView> with TickerProviderStateMixin {

  VrVideoController vrVideoController = Get.put(VrVideoController());

  @override
  void initState() {
    super.initState();

    vrVideoController.animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    vrVideoController.animation = Tween<double>(begin: 0, end: 1).animate(vrVideoController.animationController);
    _toggleShowingBar();

    Future.delayed(const Duration(seconds: 2), () {
      vrVideoController.viewPlayerController.toggleVRMode();
    });

  }

  void _toggleShowingBar() {
    vrVideoController.switchVolumeSliderDisplay(show: false);

    vrVideoController.isShowingBar = !vrVideoController.isShowingBar;
    if (vrVideoController.isShowingBar) {
      vrVideoController.animationController.forward();
    } else {
      vrVideoController.animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {

    vrVideoController.playerWidth = MediaQuery.of(context).size.width;
    vrVideoController.playerHeight =
    vrVideoController.isFullScreen ? MediaQuery.of(context).size.height : vrVideoController.playerWidth / 2;
    vrVideoController.isLandscapeOrientation =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GetBuilder<VrVideoController>(
      id: "vr",
      builder: (controller) => AspectRatio(
        aspectRatio: 9/16,
        child:  VrPlayer(
          x: 0,
          y: 0,
          onCreated: vrVideoController.onViewPlayerCreated,
          width: vrVideoController.playerWidth,
          height: vrVideoController.playerHeight,
        ),
      ),
    );
  }

}
