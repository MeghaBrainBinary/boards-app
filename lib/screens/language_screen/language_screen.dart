import 'package:boards_app/screens/language_screen/language_controller.dart';
import 'package:boards_app/utils/app_text_field.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LanguageController>(
        id: "lng",
        builder: (controller) => SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
              Center(
                  child:
                      Image.asset(AssetRes.lngaugeImg, width: Get.width * 0.3)),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                StringRes.chooseTheLanguage,
                style: appTextStyle(
                    color: ColorRes.black,
                    fontSize: 20,
                    weight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Container(
                height: Get.height * 0.055,
                width: Get.width,
                margin: EdgeInsets.only(
                    left: Get.width * 0.05, right: Get.width * 0.05),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorRes.colorD9D9D9)),
                child: appTextField(
                  controller: languageController.searchController,
                  onChanged: (val) {
                    languageController.onSearch(val);
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Transform.scale(
                      scale: 0.4,
                      child: Image.asset(
                        AssetRes.searchIcon,
                        height: 15,
                        // color: ColorRes.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  hintText: StringRes.searchLanguage,
                  hintStyle: appTextStyle(
                    color: ColorRes.black.withOpacity(0.3),
                    fontSize: 13,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              SizedBox(
                  height: Get.height * 0.54,
                  child: (languageController.searchController.text.isNotEmpty)
                      ? ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: languageController.filterLst.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                languageController.onTapContainer(
                                    val: true, i: index);
                              },
                              focusColor: ColorRes.color305EBE,
                              hoverColor: ColorRes.color305EBE,
                              splashColor:
                                  ColorRes.color305EBE.withOpacity(0.1),
                              overlayColor: MaterialStateProperty.all(
                                  ColorRes.color305EBE.withOpacity(0.1)),
                              child: Row(
                                children: [
                                  (languageController.clrs[index] == true)
                                      ? Container(
                                          width: Get.width,
                                          alignment: Alignment.centerLeft,
                                          color: ColorRes.color305EBE
                                              .withOpacity(0.1),
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.05),
                                          height: Get.height * 0.055,
                                          child: Text(
                                            languageController.filterLst[index]
                                                .toString(),
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 15,
                                                weight: FontWeight.w500),
                                          ))
                                      : Container(
                                          width: Get.width,
                                          alignment: Alignment.centerLeft,
                                          color: Colors.transparent,
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.05),
                                          height: Get.height * 0.055,
                                          child: Text(
                                            languageController.filterLst[index]
                                                .toString(),
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 15,
                                                weight: FontWeight.w500),
                                          )),
                                ],
                              ),
                            );
                          })
                      : ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: languageController.lngs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                languageController.onTapContainer(
                                    val: true, i: index);
                              },
                              focusColor: ColorRes.color305EBE,
                              hoverColor: ColorRes.color305EBE,
                              splashColor:
                                  ColorRes.color305EBE.withOpacity(0.1),
                              overlayColor: MaterialStateProperty.all(
                                  ColorRes.color305EBE.withOpacity(0.1)),
                              child: Row(
                                children: [
                                  (languageController.clrs[index] == true)
                                      ? Container(
                                          width: Get.width,
                                          alignment: Alignment.centerLeft,
                                          color: ColorRes.color305EBE
                                              .withOpacity(0.1),
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.05),
                                          height: Get.height * 0.055,
                                          child: Text(
                                            languageController.lngs[index]
                                                .toString(),
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 15,
                                                weight: FontWeight.w500),
                                          ))
                                      : Container(
                                          width: Get.width,
                                          alignment: Alignment.centerLeft,
                                          color: Colors.transparent,
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.05),
                                          height: Get.height * 0.055,
                                          child: Text(
                                            languageController.lngs[index]
                                                .toString(),
                                            style: appTextStyle(
                                                color: ColorRes.black,
                                                fontSize: 15,
                                                weight: FontWeight.w500),
                                          )),
                                ],
                              ),
                            );
                          })),
              GestureDetector(
                onTap: controller.onTapContinue,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 234,
                  decoration: BoxDecoration(
                    color: ColorRes.color305EBE,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    StringRes.continu,
                    style: appTextStyle(fontSize: 18, weight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
