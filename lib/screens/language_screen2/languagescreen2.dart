import 'package:boards_app/screens/language_screen2/language2_controller.dart';
import 'package:boards_app/utils/app_text_field.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen22 extends StatelessWidget {
  LanguageScreen22({super.key});
  Language2Controller2 languageController = Get.put(Language2Controller2());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx((() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
           
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.26,
                    ),
                    Text(
                      StringRes.language,
                      style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 24,
                          weight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Text(
                      StringRes.cancel,
                      style: appTextStyle(
                          color: ColorRes.color305EBE,
                          fontSize: 15,
                          weight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.0569,
                ),
                Container(
                  height: Get.height * 0.055,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: ColorRes.colorD9D9D9)),
                  child: appTextField(
                    controller: languageController.searchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        languageController.list.clear();
                        languageController.onoffindex.value = -1;
                      } else {
                        languageController.list.clear();
                        languageController.onoffindex.value = -1;
                        for (var element in languageController.name) {
                          languageController.onoffindex.value++;
                          languageController.name2 = element;
                          if (languageController.name2
                              .toLowerCase()
                              .startsWith(value.toLowerCase())) {
                            languageController.list
                                .add(languageController.onoffindex.value);
                          }
                        }
                      }
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Transform.scale(
                        scale: 0.4,
                        child: Image.asset(
                          AssetRes.searchIcon,
                          height: 15,
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
                  
                    height: Get.height * 0.55,
                    child: ListView.builder(
                        itemCount: languageController.onoffindex.value == -1
                            ? languageController.name.length
                            : languageController.list.length,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("Tapped");
                                  languageController.number.value = index;
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                      
                                        height: Get.height * 0.041,

                                        child: languageController
                                                    .onoffindex.value ==
                                                -1
                                            ? Text(
                                                languageController.name[index],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Text(languageController.name[
                                                languageController
                                                    .list[index]]),
                                      ),
                                      const Spacer(),
                                      Obx((() {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            languageController.number.value ==
                                                    index
                                                ? Container(
                                                    color: Colors.white,
                                                    height:
                                                        Get.height * 0.020345,
                                                    width: Get.width * 0.03908,
                                                    child: Image.asset(
                                                        AssetRes.aerrowIcon),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        );
                                      }))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.0172,
                              ),
                            ],
                          );
                        }))),
                SizedBox(
                  height: Get.height * 0.05552,
                ),
                GestureDetector(
                  //   onTap: controller.onTapContinue,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 234,
                    decoration: BoxDecoration(
                      color: ColorRes.color305EBE,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      StringRes.confirm,
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
      );
    })));
  }
}
