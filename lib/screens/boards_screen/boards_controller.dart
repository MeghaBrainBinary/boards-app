import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/boards_screen/api/language_api.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:get/get.dart';

class BoardsController extends GetxController {

RxBool loader = false.obs;
GetBoardModel getBoardModel = GetBoardModel();
List isIcons = List.generate(6, (index) => false);
  init(language)async{
    loader.value= true;
    getBoardModel =await GetBoardApi.getBoardApi(language);

    //List isIcons = List.generate(getBoardModel.data?.length??0, (index) => false);

    loader.value= false;

    update(['board']);

  }
  // List boards = [
  //   StringRes.motivation,
  //   StringRes.challenge,
  //   StringRes.weekend,
  //   StringRes.holidays,
  //   StringRes.tasty,
  //   StringRes.events,
  // ];
  // List boardsIcons = [
  //   AssetRes.motivationIcon,
  //   AssetRes.challengeIcon,
  //   AssetRes.weekendIcon,
  //   AssetRes.holidaysIcon,
  //   AssetRes.testyIcon,
  //   AssetRes.eventsIcon,
  // ];

  bool isMyfolder = false;
  bool isIcon = false;

  onTapIcon(bool val, int index) {
    if (isIcons[index] == true) {
      isIcons[index] = false;
    } else {
      isIcons[index] = true;
    }
    isIcon = val;
    update(['board']);
  }

  onTapFolder({required String id}) {

    MyFolderController myFolderController = Get.put(MyFolderController());
    myFolderController.int(id);
    myFolderController.isMore = false;

    Get.toNamed(AppRoutes.myFolderPage);
  }
}
