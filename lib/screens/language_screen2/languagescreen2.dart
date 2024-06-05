import 'package:boards_app/screens/language_screen2/language2_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/app_text_field.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../common/common_loader.dart';
import '../../utils/prefkeys.dart';

class LanguageScreen22 extends StatelessWidget {
  LanguageScreen22({super.key});
  Language2Controller2 languageController = Get.put(Language2Controller2());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,

          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetRes.background),
                fit: BoxFit.fill,
              )
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [

                      // Row(
                      //   children: [
                      //     Visibility(
                      //       visible: false,
                      //       maintainState: true,
                      //       maintainSize: true,
                      //       maintainAnimation: true,
                      //       child: InkWell(
                      //         child: Text(
                      //           StringRes.cancel.tr,
                      //           style: appTextStyle(
                      //               color: ColorRes.appColor,
                      //               fontSize: 12,
                      //               weight: FontWeight.w500),
                      //         ),
                      //       ),
                      //     ),
                      //     const Spacer(),
                      //     Text(
                      //       StringRes.language.tr,
                      //       style: appTextStyle(
                      //           color: ColorRes.black,
                      //           fontSize: 24,
                      //           weight: FontWeight.w400),
                      //     ),
                      //     const Spacer(),
                      //     InkWell(
                      //       onTap: () {
                      //         Get.offAndToNamed(AppRoutes.myFolderPage);
                      //       },
                      //       child: Text(
                      //         StringRes.cancel.tr,
                      //         style: appTextStyle(
                      //             color: ColorRes.appColor,
                      //             fontSize: 12,
                      //             weight: FontWeight.w500),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      appBar(boardName: StringRes.language.tr),
                      SizedBox(
                        height: Get.height * 0.0569,
                      ),
                      // Container(
                      //   height: Get.height * 0.065,
                      //   width: Get.width,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       border: Border.all(color: ColorRes.colorD9D9D9)),
                      //   child: appTextField(
                      //     controller: languageController.searchController,
                      //     onChanged: (value) {
                      //       languageController
                      //           .onSearch(value.toString().toLowerCase());
                      //     },
                      //     prefixIcon: Padding(
                      //       padding: const EdgeInsets.only(left: 10),
                      //       child: Transform.scale(
                      //         scale: 0.4,
                      //         child: Image.asset(
                      //           AssetRes.searchIcon,
                      //           height: 15,
                      //         ),
                      //       ),
                      //     ),
                      //     hintText: StringRes.searchLanguage.tr,
                      //     hintStyle: appTextStyle(
                      //       color: ColorRes.black.withOpacity(0.3),
                      //       fontSize: 13,
                      //       weight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: Get.height * 0.05,
                      // ),
                      GetBuilder<Language2Controller2>(
                          id: "lng",
                          builder: (con) {
                            con.update();
                            return SizedBox(
                                height: Get.height * 0.44,
                                child: (languageController.searchController.text.isNotEmpty)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: languageController.filterList.length,
                                        itemBuilder: ((context, index) {
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  languageController.onTapLanguage(languageController.filterList[index]['name'], index);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        shape:BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  languageController.filterList[index]['image']
                                                              ),
                                                            fit: BoxFit.cover

                                                          )
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20,),
                                                    Text(
                                                      languageController.filterList[index]['name'],
                                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                    ),
                                                    const Spacer(),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                       languageController.isCheck[index]
                                                            ? Container(
                                                                color: Colors.white,
                                                                height: Get.height * 0.020345,
                                                                width: Get.width * 0.03908,
                                                                child: Image.asset(AssetRes.aerrowIcon, color: ColorRes.appColor),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.0172,
                                              ),
                                            ],
                                          );
                                        }))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: languageController.language.length,
                                        itemBuilder: ((context, index) {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  languageController.onTapLanguage(
                                                      languageController
                                                          .language[index]['name'],index);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          shape:BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  languageController.language[index]['image']
                                                              ),
                                                              fit: BoxFit.cover

                                                          )
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20,),
                                                    Text(
                                                      languageController
                                                          .language[index]['name'],
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Spacer(),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        languageController.isCheck[index] ==true
                                                            ? Container(
                                                                color: Colors.white,
                                                                height: Get.height * 0.020345,
                                                                width: Get.width * 0.03908,
                                                                child: Image.asset(AssetRes.aerrowIcon, color:  ColorRes.appColor),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.0172,
                                              ),
                                            ],
                                          );
                                        })));
                          }),
                      SizedBox(
                        height: Get.height * 0.05552,
                      ),
                      GestureDetector(
                        onTap: () {
                          languageController.onTapConfirm();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 234,
                          decoration: BoxDecoration(
                            color: ColorRes.appColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            StringRes.confirm.tr,
                            style:
                                appTextStyle(fontSize: 18, weight: FontWeight.w600),
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
              Obx(() => (languageController.loader.value)?CommonLoader():SizedBox()),
            ],
          ),
        ),
      )
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
              Get.back();
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
