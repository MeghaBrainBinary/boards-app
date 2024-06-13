// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/screens/contact_us_screen/contact_us_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/app_text_field.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  ContactUsController contactUsController = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,

        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetRes.background),
              fit: BoxFit.fill,
            )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GetBuilder<ContactUsController>(
              id: "contactUs",
              builder: (controller) => SizedBox(
                height: Get.height,
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      appBar(boardName: StringRes.contactUs.tr),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      // Container(
                      //   height: Get.height * 0.075,
                      //   width: Get.width,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       border: Border.all(color: ColorRes.colorD9D9D9)),
                      //   child: appTextField(
                      //     controller: controller.nameController,
                      //     hintText: StringRes.name.tr,
                      //     hintStyle: appTextStyle(
                      //       color: ColorRes.black.withOpacity(0.3),
                      //       fontSize: 13,
                      //       weight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: Get.height * 0.03,
                      // ),

                      /// ------- email -----------
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${StringRes.emailID.tr} :",style: appTextStyle(
                            color: ColorRes.black,
                            fontSize: 13,
                            weight: FontWeight.w400,
                          ),),
                          const SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              launch("mailto:${contactUsController.emailIdController.text}");
                            },
                            splashFactory: NoSplash.splashFactory,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                             focusColor: Colors.transparent,

                            child: Container(
                              height: Get.height * 0.075,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: ColorRes.colorD9D9D9)),
                              child: appTextField(
                                enabled: false,
                                controller: controller.emailIdController,
                                hintText: '',
                                hintStyle: appTextStyle(
                                  color: ColorRes.black.withOpacity(0.3),
                                  fontSize: 13,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                        ],
                      ),

                      /// ------- english ----------
                   PrefService.getString(PrefKeys.code) =="en"||PrefService.getString(PrefKeys.code) =="ru"?  Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("${StringRes.phoneNo.tr} :",style: appTextStyle(
                           color: ColorRes.black,
                           fontSize: 13,
                           weight: FontWeight.w400,
                         ),),
                         const SizedBox(height: 8,),
                         InkWell(
                           onTap: (){
                             launch("tel:${contactUsController.englishNumber.text}");
                           },
                           splashFactory: NoSplash.splashFactory,
                           hoverColor: Colors.transparent,
                           splashColor: Colors.transparent,
                           highlightColor: Colors.transparent,
                           focusColor: Colors.transparent,

                           child: Container(
                             height: Get.height * 0.075,
                             width: Get.width,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: ColorRes.colorD9D9D9)),
                             child: appTextField(
                               enabled: false,
                               prefixIcon: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   height: 10,
                                   width: 10,
                                   decoration: const BoxDecoration(
                                     shape: BoxShape.circle,
                                     image: DecorationImage(
                                       image: AssetImage(AssetRes.english),
                                       fit: BoxFit.cover
                                     )
                                   ),
                                 ),
                               ),
                               controller: controller.englishNumber,
                               hintText: '',
                               hintStyle: appTextStyle(
                                 color: ColorRes.black.withOpacity(0.3),
                                 fontSize: 13,
                                 weight: FontWeight.w400,
                               ),
                             ),
                           ),
                         ),
                         SizedBox(
                           height: Get.height * 0.03,
                         ),
                       ],
                     ):const SizedBox(),

                      /// ------- estonian ----------
                      PrefService.getString(PrefKeys.code) =="et" ||PrefService.getString(PrefKeys.code) =="ru"?   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${StringRes.phoneNo.tr} :",style: appTextStyle(
                          color: ColorRes.black,
                          fontSize: 13,
                          weight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 8,),
                        InkWell(
                          onTap: (){
                            launch("tel:${contactUsController.estonianNumber.text}");
                          },
                          splashFactory: NoSplash.splashFactory,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,

                          child: Container(
                            height: Get.height * 0.075,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: ColorRes.colorD9D9D9)),
                            child: appTextField(
                              enabled: false,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(AssetRes.estonian),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                              ),
                              controller: controller.estonianNumber,
                              hintText: "",
                              hintStyle: appTextStyle(
                                color: ColorRes.black.withOpacity(0.3),
                                fontSize: 13,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ],
                    ):const SizedBox(),

                      /// ------- latvin ----------
                      PrefService.getString(PrefKeys.code) =="lv" ||PrefService.getString(PrefKeys.code) =="ru"?  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("${StringRes.phoneNo.tr} :",style: appTextStyle(
                            color: ColorRes.black,
                            fontSize: 13,
                            weight: FontWeight.w400,
                          ),),
                          const SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              launch("tel:${contactUsController.latvianNumber.text}");
                            },
                            splashFactory: NoSplash.splashFactory,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,

                            child: Container(
                              height: Get.height * 0.075,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: ColorRes.colorD9D9D9)),
                              child: appTextField(
                                enabled: false,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(AssetRes.latvin),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                                controller: controller.latvianNumber,
                                hintText: "",
                                hintStyle: appTextStyle(
                                  color: ColorRes.black.withOpacity(0.3),
                                  fontSize: 13,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),

                        ],
                      ):const SizedBox(),

                      /// ------- lithunian ----------
                      PrefService.getString(PrefKeys.code) =="lt"||  PrefService.getString(PrefKeys.code) =="ru"? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("${StringRes.phoneNo.tr} :",style: appTextStyle(
                            color: ColorRes.black,
                            fontSize: 13,
                            weight: FontWeight.w400,
                          ),),
                          const SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              launch("tel:${contactUsController.lithuanianNumber.text}");
                            },
                            splashFactory: NoSplash.splashFactory,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,

                            child: Container(
                              height: Get.height * 0.075,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: ColorRes.colorD9D9D9)),
                              child: appTextField(
                                enabled: false,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(AssetRes.lithunian),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                                controller: controller.lithuanianNumber,
                                hintText: "",
                                hintStyle: appTextStyle(
                                  color: ColorRes.black.withOpacity(0.3),
                                  fontSize: 13,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),

                        ],
                      ):const SizedBox(),


                      /// ------- telegram ----------
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("${StringRes.telegram.tr} :",style: appTextStyle(
                            color: ColorRes.black,
                            fontSize: 13,
                            weight: FontWeight.w400,
                          ),),
                          const SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              launch("https://t.me/${contactUsController.telegramController.text}");
                            },
                            splashFactory: NoSplash.splashFactory,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,

                            child: Container(
                              height: Get.height * 0.075,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: ColorRes.colorD9D9D9)),
                              child: appTextField(
                                enabled: false,
                                controller: controller.telegramController,
                                hintText:"",
                                hintStyle: appTextStyle(
                                  color: ColorRes.black.withOpacity(0.3),
                                  fontSize: 13,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: Get.height * 0.03,
                      // ),
                      // Container(
                      //   height: Get.height * 0.3,
                      //   width: Get.width,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       border: Border.all(color: ColorRes.colorD9D9D9)),
                      //   child: appTextField(
                      //     maxLines: 5,
                      //     contentPaddingTop: 20,
                      //     controller: controller.descriptionController,
                      //     hintText: StringRes.description.tr,
                      //     hintStyle: appTextStyle(
                      //       color: ColorRes.black.withOpacity(0.3),
                      //       fontSize: 13,
                      //       weight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: Get.height * 0.08,
                      ),
                     /* CommonButton(
                          onTap: () {
                            launch("mailto:${contactUsController.emailIdController.text}");
                          },
                          text: StringRes.send.tr),*/
                    ]),
                  ),
                ),
              ),
            ),
            Obx(() => contactUsController.loader.value ?CommonLoader():const SizedBox()),

          ],
        ),
      ),
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
