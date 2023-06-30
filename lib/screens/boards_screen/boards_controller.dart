import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/boards_screen/api/language_api.dart';
import 'package:boards_app/screens/boards_screen/model/get_board_model.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:get/get.dart';

class BoardsController extends GetxController {
  dynamic argumentData = Get.arguments;
RxBool loader = false.obs;
//GetBoardModel getBoardModel = GetBoardModel();
  var getBoardModelData;
  List isIcons = [];
  final serverData = [];
  List<TreeNodeData> treeData = [];

  @override
void onInit() {
  init(argumentData ?? PrefService.getString(PrefKeys.languageCode));

  // isIcons = List.generate(getBoardModel.data?.length ?? 6, (index) => false);
  if(getBoardModelData != null){

   isIcons = List.generate(getBoardModelData['data'].length ?? 0, (index) => false);
  }

  super.onInit();
}

  init(language)async{
    loader.value= true;
   // getBoardModel =await GetBoardApi.getBoardApi(language);
    getBoardModelData =await GetBoardApi.getBoardApi(language);


    //print(getBoardModel.data![0].name);
   // print(getBoardModel.data!.length);

    // isIcons = List.generate(getBoardModel.data?.length??0, (index) => false);
    if(getBoardModelData != null){

      isIcons = List.generate(getBoardModelData['data'].length ?? 0, (index) => false);
    }
   // serverData = getBoardModelData['data'];


    getBoardModelData['data'].forEach((element) {
      serverData.add({
        "id": element['id'],
        "name": element['name'],
        "parent_id": "0",
        "sub_parent_id":"0",
        "language": element['language'],
        "sub_board": element['sub_board'],
      });
    });


   treeData = List.generate(
      serverData.length,
          (index) => mapServerDataToTreeData(serverData[index]),
    ).toList();

    loader.value= false;

    update(['board']);
    update(['all']);

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

  bool isMore = false;

  onTapIcon(bool val, int index) {
    if (isIcons[index] == true) {
      isIcons[index] = false;
    } else {
      isIcons[index] = true;
    }
    isIcon = val;
    update(['board']);
  }

  onTapMore() {
    if (isMore == false) {
      isMore = true;
    } else {
      isMore = false;
    }
    update(['board']);
    update(['all']);
  }

  onTapFolder(String id, String name, {String? subBoardId, String? subName}) {
    //isIcons = List.generate(6, (index) => false);
    isIcon = false;
    isMyfolder = false;
    update(['board']);

    MyFolderController myFolderController = Get.put(MyFolderController());

    if(subBoardId == null){
      myFolderController.int(id);
    } else{
      myFolderController.int(id, subBoardId: subBoardId);
    }

    myFolderController.isMore = false;

    if(subBoardId == null){
      //Get.toNamed(AppRoutes.myFolderPage, arguments: name);
      Get.to(()=>MyFolderScreen(boardName: name,));
    }else{
      //Get.toNamed(AppRoutes.myFolderPage, arguments: subName);
      Get.to(()=>MyFolderScreen(boardName: subName,));
    }
  }

  TreeNodeData mapServerDataToTreeData(Map data) {
    return TreeNodeData(
parent_id: data['parent_id'],
      sub_parent_id:  data['sub_parent_id'],
      id: data['id'],
      language: data['language'],
      name: data['name'],
      title: data['name'],
      expanded: false,
      checked: true,
      children:
      List.from(data['sub_board'].map((x) => mapServerDataToTreeData(x))),
    );
  }

  /// Generate tree data


}
