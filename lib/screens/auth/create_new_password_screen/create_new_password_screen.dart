// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_textfild.dart';
import 'package:boards_app/screens/auth/create_new_password_screen/create_new_password_controller.dart';
import 'package:boards_app/screens/auth/forgot_password_screen/forgot_password_controller.dart';
import 'package:boards_app/screens/auth/login_screen/login_controller.dart';
import 'package:boards_app/screens/contact_us_screen/contact_us_controller.dart';
import 'package:boards_app/utils/app_text_field.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});

  CreateNewPasswordController createNewPasswordController = Get.put(CreateNewPasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GetBuilder<CreateNewPasswordController>(
              id: "createNewPassword",
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
                          StringRes.createNewPassword,
                          style: appTextStyle(
                              fontSize: 27,
                              weight: FontWeight.w600,
                              color: ColorRes.color305EBE),
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.06,
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
                        controller.update(['createNewPassword']);
                      },
                          obscureText: controller.isObscureText,
                          onChanged: (value) => controller.setPassword(value),
                          controller: controller.passwordController,isShowViciblity: true,hintText: StringRes.password,PrefixIcon: AssetRes.fileLoke),
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
                        if(controller.isObscureConfirmText==false)
                        {
                          controller.isObscureConfirmText=true;
                        }
                        else
                        {
                          controller.isObscureConfirmText=false;
                        }
                        controller.update(['createNewPassword']);
                      },
                          obscureText: controller.isObscureConfirmText,
                          onChanged: (value) => controller.setConfirmNewPassword(value),
                          controller: controller.confirmPasswordController,isShowViciblity: true,hintText: StringRes.confirmPassword,PrefixIcon: AssetRes.fileLoke),
                      // validation
                      controller
                          .confirmPasswordErrorMessage.isEmpty
                          ? const SizedBox()
                          : Text(
                          controller.confirmPasswordErrorMessage,
                          style: TextStyle(
                              color: const Color(0xFFA2000F),
                              fontSize: Get.height * 0.02)),
                      Row(
                        children: [
                          Checkbox(
                            side: BorderSide(width: 1),
                            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                            value: controller.rememberMe,
                            hoverColor: ColorRes.black,  activeColor: ColorRes.black,
                            onChanged: (bool? value) {

                              controller.rememberMe = value ?? false;
                              controller.update(['createNewPassword']);
                            },
                          ),
                          Text(StringRes.rememberMe,style: appTextStyle(color: Colors.black.withOpacity(0.50),fontSize: 12,weight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.08,
                      ),
                      Center(
                        child: CommonButton(
                            onTap: () {
                            controller.validatePassword();
                            controller.validateConfirmNewPassword();
                            },
                            text: StringRes.next),
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
    );
  }

}
