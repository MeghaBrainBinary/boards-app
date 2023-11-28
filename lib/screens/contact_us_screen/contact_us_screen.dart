// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/screens/contact_us_screen/contact_us_controller.dart';
import 'package:boards_app/utils/app_text_field.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  ContactUsController contactUsController = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    appBar(boardName: StringRes.contactUs),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Container(
                      height: Get.height * 0.075,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorRes.colorD9D9D9)),
                      child: appTextField(
                        controller: controller.nameController,
                        hintText: StringRes.name.tr,
                        hintStyle: appTextStyle(
                          color: ColorRes.black.withOpacity(0.3),
                          fontSize: 13,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Container(
                      height: Get.height * 0.075,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorRes.colorD9D9D9)),
                      child: appTextField(
                        controller: controller.emailIdController,
                        hintText: StringRes.emailID.tr,
                        hintStyle: appTextStyle(
                          color: ColorRes.black.withOpacity(0.3),
                          fontSize: 13,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Container(
                      height: Get.height * 0.3,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorRes.colorD9D9D9)),
                      child: appTextField(
                        maxLines: 5,
                        contentPaddingTop: 20,
                        controller: controller.descriptionController,
                        hintText: StringRes.description.tr,
                        hintStyle: appTextStyle(
                          color: ColorRes.black.withOpacity(0.3),
                          fontSize: 13,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    CommonButton(
                        onTap: () {

                        },
                        text: StringRes.send),
                  ]),
                ),
              ),
            ),
          ),

        ],
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
