
import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/screens/settings_screen/settings_controller.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<SettingsController>(
            id: "contactUs",
            builder: (controller) => SizedBox(
              height: Get.height,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Column(children: [
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  appBar(boardName: StringRes.settings),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Expanded(
                    child: ListView.separated(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.settingTitleList.length,
                      itemBuilder: (context, index) {
                        return ListTile(onTap: () {
                          if(index==2)
                            {
                              _showDialog(context);
                            }
                        },
                          leading: Image.asset(controller.settingImageList[index],scale: 4,),
                          title: Text(controller.settingTitleList[index],style: TextStyle(color: Colors.black),),
                          trailing: const Icon(Icons.navigate_next,color: Colors.black),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(endIndent: Get.width * 0.06,indent: Get.width * 0.04,);
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(contentPadding: EdgeInsets.symmetric(horizontal: 20),children: [
          SizedBox(height: Get.height * 0.04,),
              Image.asset(AssetRes.deleteAcountIcon,height: Get.height * 0.1,),
              SizedBox(height: Get.height * 0.03,),
          Text(StringRes.areYouSure,textAlign: TextAlign.center,style: appTextStyle(weight: FontWeight.w500,fontSize: 20,color: Colors.black),),
          SizedBox(height: Get.height * 0.03,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Expanded(
              child: CommonButton(
                  onTap: () {
                  },
                  text: StringRes.yes),
            ),
            SizedBox(width: Get.width * 0.01,),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  height:  50,
                  width: 234,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorRes.color305EBE)
                  ),
                  child: Text(
                    StringRes.no,
                    style: appTextStyle(color: ColorRes.color305EBE,fontSize: 18, weight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],),
          SizedBox(height: Get.height * 0.04,),
        ],);
      },
    );
  }

  appBar({String? boardName}) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(
        left: Get.width * 0.05,
        right: Get.width * 0.05,
      ),
      height: Get.height * 0.18,
      width: Get.width,
      // color: ColorRes.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {

            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          Text(
            boardName ?? '',
            style: appTextStyle(
                fontSize: 24,
                weight: FontWeight.w400,
                color: ColorRes.black),
          ),
          Text(
             '',
            style: appTextStyle(
                fontSize: 24,
                weight: FontWeight.w400,
                color: ColorRes.black),
          ),
        ],
      ),
    );
  }
}
