// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_textfild.dart';
import 'package:boards_app/screens/change_password_screen/change_password_controller.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<ChangePasswordController>(
            id: "changePassword",
            builder: (controller) => SizedBox(
              height: Get.height,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    appBar(boardName: StringRes.changePassword.tr),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    CommonTextFeild(onTapIcon: () {
                        if(controller.isObscureText==false)
                          {
                            controller.isObscureText=true;
                          }
                        else
                          {
                            controller.isObscureText=false;
                          }
                       controller.update(['changePassword']);
                    },
                        obscureText: controller.isObscureText,
                        onChanged: (value) => controller.setPassword(value),
                        controller: controller.passwordController,isShowViciblity: true,hintText: StringRes.enterCurrentPassword.tr,PrefixIcon: AssetRes.fileLoke),
                  // validation
                   controller
                        .passwordErrorMessage.isEmpty
                        ? const SizedBox()
                        : Text(
                        controller.passwordErrorMessage,
                        style: TextStyle(
                            color: const Color(0xFFA2000F),
                            fontSize: Get.height * 0.02)),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CommonTextFeild(onTapIcon: () {
                      if(controller.isObscureNewText==false)
                      {
                        controller.isObscureNewText=true;
                      }
                      else
                      {
                        controller.isObscureNewText=false;
                      }
                      controller.update(['changePassword']);
                    },obscureText: controller.isObscureNewText,   onChanged: (value) => controller.setNewPassword(value),controller: controller.newPasswordController,isShowViciblity: true,hintText: StringRes.enterNewPassword.tr,PrefixIcon: AssetRes.fileLoke),
                   // validation
                    controller
                        .newPasswordErrorMessage.isEmpty
                        ? const SizedBox()
                        : Text(
                        controller.newPasswordErrorMessage,
                        style: TextStyle(
                            color: const Color(0xFFA2000F),
                            fontSize: Get.height * 0.02)),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CommonTextFeild(onTapIcon: () {
                      if(controller.isObscureConfirmText==false)
                      {
                        controller.isObscureConfirmText=true;
                      }
                      else
                      {
                        controller.isObscureConfirmText=false;
                      }
                      controller.update(['changePassword']);
                    },obscureText: controller.isObscureConfirmText,
                        controller: controller.confirmNewPasswordController,
                        onChanged: (value) => controller.setConfirmNewPassword(value),
                        isShowViciblity: true,
                        hintText: StringRes.confirmNewPassword.tr,PrefixIcon: AssetRes.fileLoke),
                    // validation
                    controller
                        .confirmPasswordErrorMessage.isEmpty
                        ? const SizedBox()
                        : Text(
                        controller.confirmPasswordErrorMessage,
                        style: TextStyle(
                            color: const Color(0xFFA2000F),
                            fontSize: Get.height * 0.02)),
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    Center(
                      child: CommonButton(
                          onTap: () {
                                controller.validatePassword();
                                controller.validateNewPassword();
                                controller.validateConfirmNewPassword();
                          },
                          text: StringRes.send.tr),
                    ),
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
