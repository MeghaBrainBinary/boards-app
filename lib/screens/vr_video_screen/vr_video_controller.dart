import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vr_player/vr_player.dart';

class VrVideoController extends GetxController {

  late VrPlayerController viewPlayerController;
  late AnimationController animationController;
  late Animation<double> animation;
  bool isShowingBar = false;
  bool isPlaying = false;
  bool isFullScreen = false;
  bool isVideoFinished = false;
  bool isLandscapeOrientation = false;
  bool isVolumeSliderShown = false;
  bool isVolumeEnabled = true;
  late double playerWidth;
  late double playerHeight;
  String? duration;
  int? intDuration;
  bool isVideoLoading = false;
  bool isVideoReady = false;
  String? currentPosition;
  double currentSliderValue = 0.1;
  double seekPosition = 0;

  cardBoardPressed() {
    viewPlayerController.toggleVRMode();
    update(["vr"]);
  }

  Future<void> fullScreenPressed() async {
    await viewPlayerController.fullScreen();
      isFullScreen = !isFullScreen;

    update(["vr"]);

    if (isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }

    update(["vr"]);
  }

  Future<void> playAndPause() async {
    if (isVideoFinished) {
      await viewPlayerController.seekTo(0);
    }

    if (isPlaying) {
      await viewPlayerController.pause();
    } else {
      await viewPlayerController.play();
    }

    isPlaying = !isPlaying;
    isVideoFinished = false;
    update(["vr"]);
  }


  void onViewPlayerCreated(
      VrPlayerController controller,
      VrPlayerObserver observer,
      ) {
      viewPlayerController = controller;
      observer
        ..onStateChange = onReceiveState
        ..onDurationChange = onReceiveDuration
        ..onPositionChange = onChangePosition
        ..onFinishedChange = onReceiveEnded;
    viewPlayerController.loadVideo(
      videoUrl: "https://res.cloudinary.com/deqviyanh/video/upload/v1737520098/TURBOPOSTAI/VIDEO_TESTIMONIAL_DATA/1737520095148-441992819VID20250122095739.mp4",
    );
     update(["vr"]);

  }


  void onReceiveState(VrState state) {
    switch (state) {
      case VrState.loading:
        isVideoLoading = true;
        update(["vr"]);
        break;
      case VrState.ready:
        isVideoLoading = false;
        isVideoReady = true;
        update(["vr"]);
        break;
      case VrState.buffering:
      case VrState.idle:
        break;
    }
  }

  void onReceiveDuration(int millis) {
    intDuration = millis;
    duration = millisecondsToDateTime(millis);
    update(["vr"]);
  }

  void onChangePosition(int millis) {
    currentPosition = millisecondsToDateTime(millis);
    seekPosition = millis.toDouble();
    update(["vr"]);
  }

  void onReceiveEnded(bool isFinished) {
    isVideoFinished = isFinished;
    update(["vr"]);
  }

  void onChangeVolumeSlider(double value) {
    viewPlayerController.setVolume(value);
    isVolumeEnabled = value != 0;
    currentSliderValue = value;
    update(["vr"]);
  }

  void switchVolumeSliderDisplay({required bool show}) {
    isVolumeSliderShown = show;
    update(["vr"]);
  }

  String millisecondsToDateTime(int milliseconds) =>
      setDurationText(Duration(milliseconds: milliseconds));

  String setDurationText(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

}