// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_textfild.dart';
import 'package:boards_app/screens/auth/forgot_password_screen/forgot_password_controller.dart';
import 'package:boards_app/screens/auth/login_screen/login_controller.dart';
import 'package:boards_app/screens/contact_us_screen/contact_us_controller.dart';
import 'package:boards_app/utils/app_text_field.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            children: [
              GetBuilder<ForgotPasswordController>(
                id: "forgot",
                builder: (controller) => SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        SizedBox(
                          height: Get.height * 0.07,
                        ),
                        Center(
                          child: Text(
                            StringRes.forgotPassword.tr,
                            style: appTextStyle(
                                fontSize: 27,
                                weight: FontWeight.w600,
                                color: ColorRes.appColor),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Center(
                          child: Text(
                            StringRes.pleaseEnterYourValidEmail.tr,
                            textAlign: TextAlign.center,
                            style: appTextStyle(
                                fontSize: 12,
                                weight: FontWeight.w500,
                                color: ColorRes.black),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        CommonTextFeild(controller: controller.emailIdController,
                            onChanged: (value) => controller.setEmail(value),
                            hintText: StringRes.emailID.tr,PrefixIcon: AssetRes.emailIcon),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        controller
                            .emailErrorMessage.isEmpty
                            ? const SizedBox()
                            : Text(
                            controller.emailErrorMessage,
                            style: TextStyle(
                                color: const Color(0xFFA2000F),
                                fontSize: Get.height * 0.02)),


                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        Center(
                          child: CommonButton(
                              onTap: () {
                                print("vcv");
                                controller.validateEmail();
                                if (controller.emailErrorMessage.isEmpty) {
                                  controller.resetPassword(email: controller.emailIdController.text).then((value){
                                    Get.toNamed(AppRoutes.createNewPasswordScreen);
                                    controller.emailIdController.text = "";
                                  });
                                }
                              },
                              text: StringRes.next.tr),
                        ),

                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ]),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
