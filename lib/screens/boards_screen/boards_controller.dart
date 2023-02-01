import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:get/get.dart';

class BoardsController extends GetxController {
  List boards = [
    StringRes.motivation,
    StringRes.challenge,
    StringRes.weekend,
    StringRes.holidays,
    StringRes.tasty,
    StringRes.events,
  ];
  List boardsIcons = [
    AssetRes.motivationIcon,
    AssetRes.challengeIcon,
    AssetRes.weekendIcon,
    AssetRes.holidaysIcon,
    AssetRes.testyIcon,
    AssetRes.eventsIcon,
  ];

  bool isMyfolder = false;
  bool isIcon = false;
  List isIcons = List.generate(6, (index) => false);

  onTapIcon(bool val, int index) {
    if (isIcons[index] == true) {
      isIcons[index] = false;
    } else {
      isIcons[index] = true;
    }
    isIcon = val;
    update(['board']);
  }

  onTapFolder() {
    Get.toNamed(AppRoutes.myFolderPage);
  }
}
