import 'package:boards_app/common/toast_msg.dart';
import 'package:boards_app/screens/boards_screen/api/language_api.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class BoardsController extends GetxController {

  late TutorialCoachMark tutorialCoachMark;
  GlobalKey buttonKey = GlobalKey();
  GlobalKey secondButtonKey = GlobalKey();


  void showTutorial({context}) {
    tutorialCoachMark = TutorialCoachMark(
      pulseEnable: true,
      showSkipInLastTarget: true,
      targets: _createTargets(),
      colorShadow: Colors.black,
      textSkip: StringRes.next,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        debugPrint("Tutorial finished");
      },
      onClickTarget: (target) {
        debugPrint("Target clicked");
      },
      onSkip: () {
        debugPrint("Tutorial skipped");
        return false;
      },
      onClickOverlay: (target) {
        debugPrint("Overlay clicked");
      },
    )..show(context: context);
    // isSee = true;
  }

  List<TargetFocus> _createTargets() {
    return [
      TargetFocus(
        identify: "buttonKey",
        keyTarget: buttonKey,
        contents: [
          TargetContent(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: Get.height * 0.3),
                  Text(
                    StringRes.categorySubTitle.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0),
                  //   child: Text(
                  //     StringRes.categorySubTitle.tr,
                  //     style: const TextStyle(color: Colors.white),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "secondButtonKey",
        keyTarget: secondButtonKey,
        contents: [
          TargetContent(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: Get.height * 0.3),
                  Text(
                    StringRes.subCategorySubTitle.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0),
                  //   child: Text(
                  //     StringRes.subCategorySubTitle.tr,
                  //     style: const TextStyle(color: Colors.white),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }

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
    if (getBoardModelData != null) {
      isIcons = List.generate(
          getBoardModelData['data'].length ?? 0, (index) => false);
    }

    super.onInit();
  }


  init(language) async {
    loader.value = true;
    // getBoardModel =await GetBoardApi.getBoardApi(language);
    getBoardModelData = await GetBoardApi.getBoardApi(language);

    //print(getBoardModel.data![0].name);
    // print(getBoardModel.data!.length);

    // isIcons = List.generate(getBoardModel.data?.length??0, (index) => false);
    if (getBoardModelData != null) {
      isIcons = List.generate(getBoardModelData['data'].length ?? 0, (index) => false);
    }

    // serverData = getBoardModelData['data'];

    if (getBoardModelData['data'].length != 0) {
      DateTime maxDate = DateTime.parse(getBoardModelData['data'][0]['created_at']);

      getBoardModelData['data'].forEach((element) {
        if (DateTime.parse(getBoardModelData['data'][0]['created_at']).isAfter(maxDate)) {
          maxDate = DateTime.parse(getBoardModelData['data'][0]['created_at']);
        }
      });

      getBoardModelData['data'].forEach((element) {
        if (DateTime.parse(element['created_at']) == maxDate) {
          serverData.add({
            "id": element['id'],
            "name": element['name'],
            "icon" : element["icon"],
            "parent_id": "0",
            "sub_parent_id": "0",
            "isTop": true,
            "created_at": element['created_at'],
            "language": element['language'],
            "sub_board": element['sub_board'],
          });
        } else {
          serverData.add({
            "id": element['id'],
            "name": element['name'],
            "icon" : element["icon"],
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
    loader.value = false;

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

  RxBool categoryClickLoader = false.obs;

  onTapFolder(String id, String name, String icon ,{String? subBoardId, String? subName, TreeNodeData? node}) async{
    //isIcons = List.generate(6, (index) => false);
    isIcon = false;
    isMyfolder = false;
    categoryClickLoader.value = true;
    update(['board']);

    MyFolderController myFolderController = Get.put(MyFolderController());

    if (subBoardId == null) {
      await myFolderController.myInt(id);
    } else {
      await myFolderController.myInt(id, subBoardId: subBoardId);
    }

    myFolderController.isMore = false;

    print("--------------------------${myFolderController.getBoardInfoModel.data}");
    print("--------------------------${myFolderController.getBoardInfoModel.data?.length}");

    if (myFolderController.getBoardInfoModel.data != null
        && myFolderController.getBoardInfoModel.data!.length != 0
    ) {
      print("---------------------------->${myFolderController.getBoardInfoModel.data?.length}");
      myFolderController.isLike = List.generate(myFolderController.getBoardInfoModel.data?.length ?? 0, (index) => false);
      if (subBoardId == null) {
        //Get.toNamed(AppRoutes.myFolderPage, arguments: name);
        Get.to(() => MyFolderScreen(boardName: name, icon: icon, node: node));
        categoryClickLoader.value = false;
      } else {
        //Get.toNamed(AppRoutes.myFolderPage, arguments: subName);
        Get.to(() => MyFolderScreen(boardName: subName, icon: icon,  node: node));
        categoryClickLoader.value = false;
      }
    } else {
      errorTost("This category don't have images");
      categoryClickLoader.value = false;
    }
  }

  TreeNodeData mapServerDataToTreeData(Map data, {bool? isChild}) {
    if (isChild == null) {
      isChild = false;
    }
    if (isChild == false) {
      return TreeNodeData(
        parent_id: data['parent_id'].toString(),
        sub_parent_id: data['sub_parent_id'].toString(),
        id: data['id'],
        language: data['language'].toString(),
        name: data['name'].toString(),
        title: data['name'].toString(),
        icon: data["icon"].toString(),
        isTop: data['isTop'],
        expanded: false,
        checked: true,
        children: List.from(data['sub_board'].map((x) => mapServerDataToTreeData(x, isChild: true))),
      );
    } else {
      return TreeNodeData(
        parent_id: data['parent_id'].toString(),
        sub_parent_id: data['sub_parent_id'].toString(),
        id: data['id'],
        language: data['language'].toString(),
        name: data['name'].toString(),
        title: data['name'].toString(),
        icon: data["icon"].toString(),
        isTop: false,
        expanded: false,
        checked: true,
        children: List.from(data['sub_board'].map((x) => mapServerDataToTreeData(x, isChild: true))),
      );
    }
  }

  /// Generate tree data

}
