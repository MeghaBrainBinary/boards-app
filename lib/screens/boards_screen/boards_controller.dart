// ignore_for_file: prefer_typing_uninitialized_variables, unused_element, unnecessary_null_comparison, prefer_conditional_assignment

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:boards_app/common/toast_msg.dart';
import 'package:boards_app/screens/boards_screen/api/language_api.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_screen.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/foundation.dart';
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
      textSkip: StringRes.next.tr,
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
            "name":element['name'],
            "icon" : element["icon"],
            "quote":element['quote'],
            "name_text_color":element['name_text_color'],
            "name_font_family":element['name_font_family'],
            "quote_font_family":element['quote_font_family'],
            "quote_text_color":element['quote_text_color'],
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
            "name":element['name'],
            "icon" : element["icon"],
            "quote":element['quote'],
            "name_text_color":element['name_text_color'],
            "name_font_family":element['name_font_family'],
            "quote_font_family":element['quote_font_family'],
            "quote_text_color":element['quote_text_color'],
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

  onTapFolder(String id, String name, String icon ,{String? subBoardId, String? subName,String? quote, TreeNodeData? node,bool isFirst = false,
    String? mainCategory,

   String?  nameColor,
    String? nameFamily,
    String?  quoteColor,
    String? quoteFamily,

    required bool isFromNotification
  }) async{
    //isIcons = List.generate(6, (index) => false);

    isIcon = false;
    isMyfolder = false;
    categoryClickLoader.value = true;
    loader.value = true;
    update(['board']);

    MyFolderController myFolderController = Get.put(MyFolderController());

    myFolderController.selectedId = id;

    if (kDebugMode) {
      print("-------------------------------------------------${myFolderController.selectedId}");
    }

    if (subBoardId == null) {
      await myFolderController.myInt(id);
    } else {
      await myFolderController.myInt(id, subBoardId: subBoardId);
    }

    myFolderController.isMore = false;

    if (kDebugMode) {
    print("--------------------------${myFolderController.getBoardInfoModel.data}");
      print("--------------------------${myFolderController.getBoardInfoModel.data?.length}");
    }

    if (myFolderController.getBoardInfoModel.data != null
        // && myFolderController.getBoardInfoModel.data!.length != 0
    ) {


      if (kDebugMode) {
        print("-------------------------$node");
      }

      TreeNode<dynamic> convertTreeNodeDataToDynamic(TreeNodeData nodeData) {
        // Convert the current node
        TreeNode<dynamic> treeNode = TreeNode<dynamic>(
          data: nodeData,

          // Store TreeNodeData directly in the data property
         // isExpanded: nodeData.expanded, // Use the expanded property from TreeNodeData
        );

        // Convert and attach children
        if (nodeData.children != null && nodeData.children.isNotEmpty) {
          for (TreeNodeData childData in nodeData.children) {
            TreeNode<dynamic> childNode = convertTreeNodeDataToDynamic(childData);
            treeNode.children[childData.id.toString()] = childNode; // Add child to the parent TreeNode's children map
            if (kDebugMode) {
              print("--------------------$childNode");
            }
          }
        }

        return treeNode;
      }



      if (kDebugMode) {
        print("---------------------------->${myFolderController.getBoardInfoModel.data?.length}");
      }
      myFolderController.isLike = List.generate(myFolderController.getBoardInfoModel.data?.length ?? 0, (index) => false);
      Future.delayed(const Duration(milliseconds: 100),() async {
        if (subBoardId == null) {
          //Get.toNamed(AppRoutes.myFolderPage, arguments: name);

          myFolderController.selectedId =id.toString();
        await  myFolderController.myInt(id.toString());
          myFolderController.isSelectedNode = List.generate(node?.children.length ?? 0, (index) => false);
          Get.to(() => MyFolderScreen(boardName: name, icon: icon, node: node?.children ?? [],isFirst :isFirst,parentId: id.toString(),
            quote:quote ?? '',isFirstNode: isFirst,
            quoteColor:quoteColor,
            quoteFamily:quoteFamily,
            nameFamily:nameFamily,
            nameColor:nameColor,
            mainCategory:mainCategory,
            isFromNotification: isFromNotification,
          ));
          categoryClickLoader.value = false;
        } else {
          //Get.toNamed(AppRoutes.myFolderPage, arguments: subName);
          myFolderController.selectedId =id.toString();
         await myFolderController.myInt(id.toString());
          myFolderController.isSelectedNode = List.generate(node?.children.length ?? 0, (index) => false);

          Get.to(() => MyFolderScreen(boardName: subName, icon: icon,  node: node?.children ?? [],isFirst :isFirst,parentId: id.toString(),quote:quote ?? '',isFirstNode: isFirst,
            quoteColor:quoteColor,
            quoteFamily:quoteFamily,
            nameFamily:nameFamily,
            nameColor:nameColor,
            mainCategory:mainCategory,
            isFromNotification: isFromNotification,


          ));
          categoryClickLoader.value = false;
        }
      },);

      loader.value = false;

    } else {
      loader.value = false;
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
        quote: data['quote'] ?? '',
        name_text_color: data['name_text_color'] ?? '',
        name_font_family: data['name_font_family'] ?? '',
        quote_text_color:data['quote_text_color'] ?? "",
        quote_font_family:data['quote_font_family'] ?? '',
        expanded: false,
        checked: true,
        children: data['sub_board'] != null ? List.from(data['sub_board'].map((x) => mapServerDataToTreeData(x, isChild: true))) : [],
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
        quote: data['quote'] ?? '',
        name_text_color: data['name_text_color'] ?? '',
        name_font_family: data['name_font_family'] ?? '',
        quote_text_color:data['quote_text_color'] ?? "",
        quote_font_family:data['quote_font_family'] ?? '',
        isTop: false,
        expanded: false,
        checked: true,
        children: data['sub_board'] != null ? List.from(data['sub_board'].map((x) => mapServerDataToTreeData(x, isChild: true))) : [],
      );
    }
  }

  /// Generate tree data

}
