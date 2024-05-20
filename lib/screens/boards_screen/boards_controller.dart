import 'dart:convert';

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
  List<String> drawerTitleList = [
    //StringRes.home.tr,
    StringRes.language.tr,
   // StringRes.viewImages.tr,
    StringRes.favourite.tr,
    StringRes.contactUs.tr,
   // StringRes.settings.tr,
    // StringRes.faq.tr,
   // StringRes.loginLogout.tr,
  ];

  List<String> drawerImageList = [
   // AssetRes.homeIcon,
    AssetRes.languageIcon,
   // AssetRes.grid,
    AssetRes.FavouriteIcon,
    AssetRes.contactUs,
   // AssetRes.settingsIcon,
    //   AssetRes.faqIcon,
  //  AssetRes.loginIcon,
  ];
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
    if(getBoardModelData != null ){

      isIcons = List.generate(getBoardModelData['data'].length ?? 0, (index) => false);
    }



   // serverData = getBoardModelData['data'];

    if(getBoardModelData['data'].length != 0) {
      DateTime maxDate = DateTime.parse(
          getBoardModelData['data'][0]['created_at']);

      getBoardModelData['data'].forEach((element) {
        if (DateTime.parse(getBoardModelData['data'][0]['created_at']).isAfter(
            maxDate)) {
          maxDate = DateTime.parse(getBoardModelData['data'][0]['created_at']);
        }
      });

      getBoardModelData['data'].forEach((element) {
        if (DateTime.parse(element['created_at']) == maxDate) {
          serverData.add({
            "id": element['id'],
            "name": element['name'],
            "parent_id": "0",
            "sub_parent_id": "0",
            "isTop": true,
            "created_at": element['created_at'],
            "language": element['language'],
            "sub_board": element['sub_board'],
          });
        }
        else {
          serverData.add({
            "id": element['id'],
            "name": element['name'],
            "parent_id": "0",
            "sub_parent_id": "0",
            "isTop": false,
            "created_at": element['created_at'],
            "language": element['language'],
            "sub_board": element['sub_board'],
          });
        }
      });
    }

   treeData = List.generate(serverData.length, (index) => mapServerDataToTreeData(serverData[index])).toList();
    loader.value= false;

    update(['board']);
    update(['all']);

  }

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

  onTapFolder(String id, String name, {String? subBoardId, String? subName}) async{
    //isIcons = List.generate(6, (index) => false);
    isIcon = false;
    isMyfolder = false;
    update(['board']);

    MyFolderController myFolderController = Get.put(MyFolderController());

    if(subBoardId == null){
      await myFolderController.myInt(id);
    } else{
      await myFolderController.myInt(id, subBoardId: subBoardId);
    }

    myFolderController.isMore = false;

    if(myFolderController.getBoardInfoModel.data != null && myFolderController.getBoardInfoModel.data!.length != 0 ){
      print("---------------------------->${myFolderController.getBoardInfoModel.data?.length}");
      myFolderController.isLike = List.generate(myFolderController.getBoardInfoModel.data?.length ?? 0, (index) => false);
    if(subBoardId == null){
      //Get.toNamed(AppRoutes.myFolderPage, arguments: name);
      Get.to(()=>MyFolderScreen(boardName: name,));
    }else{
      //Get.toNamed(AppRoutes.myFolderPage, arguments: subName);
      Get.to(()=>MyFolderScreen(boardName: subName,));
    }
    }
  }

  TreeNodeData mapServerDataToTreeData(Map data,{bool? isChild}){

    if(isChild == null){
      isChild = false;
    }
    if(isChild == false) {
      return TreeNodeData(
        parent_id: data['parent_id'].toString(),
        sub_parent_id: data['sub_parent_id'].toString(),
        id: data['id'],
        language: data['language'].toString(),
        name: data['name'].toString(),
        title: data['name'].toString(),
        isTop: data['isTop'],
        expanded: false,
        checked: true,
        children: List.from(data['sub_board'].map((x) =>
            mapServerDataToTreeData(x, isChild: true))),
      );
    }else{
      return TreeNodeData(
        parent_id: data['parent_id'].toString(),
        sub_parent_id: data['sub_parent_id'].toString(),
        id: data['id'],
        language: data['language'].toString(),
        name: data['name'].toString(),
        title: data['name'].toString(),
        isTop:false,
        expanded: false,
        checked: true,
        children: List.from(data['sub_board'].map((x) =>
            mapServerDataToTreeData(x, isChild: true))),
      );
    }
  }

  /// Generate tree data


}
