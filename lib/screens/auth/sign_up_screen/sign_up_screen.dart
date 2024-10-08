// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/common/common_textfild.dart';
import 'package:boards_app/screens/auth/sign_up_screen/sign_up_controller.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  SignUpController signUpController = Get.put(SignUpController());

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
              GetBuilder<SignUpController>(
                id: "signUp",
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
                            StringRes.signUp.tr,
                            style: appTextStyle(
                                fontSize: 30,
                                weight: FontWeight.w600,
                                color: ColorRes.appColor),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Center(child: Image.asset(AssetRes.signUp,height: Get.height * 0.3,)),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        CommonTextFeild(controller: controller.userNameController,
                            onChanged: (value) => controller.setUser(value),
                            hintText: StringRes.userName.tr,PrefixIcon: AssetRes.userIcon),
                        // user validation
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        controller
                            .userErrorMessage.isEmpty
                            ? const SizedBox()
                            : Text(
                            controller.userErrorMessage,
                            style: TextStyle(
                                color: const Color(0xFFA2000F),
                                fontSize: Get.height * 0.02)),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        CommonTextFeild(controller: controller.emailIdController,
                            onChanged: (value) => controller.setEmail(value),
                            hintText: StringRes.emailID.tr,PrefixIcon: AssetRes.emailIcon),
                        // email id validation
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
                          height: Get.height * 0.03,
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
                          controller.update(['signUp']);
                        },
                            obscureText: controller.isObscureText,
                            onChanged: (value) => controller.setPassword(value),
                            controller: controller.passwordController,isShowViciblity: true,hintText: StringRes.password.tr,PrefixIcon: AssetRes.fileLoke),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
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
                          controller.update(['signUp']);
                        },
                            obscureText: controller.isObscureConfirmText,
                            onChanged: (value) => controller.setConfirmNewPassword(value),
                            controller: controller.confirmPasswordController,isShowViciblity: true,hintText: StringRes.confirmPassword.tr,PrefixIcon: AssetRes.fileLoke),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        // validation
                        controller
                            .confirmPasswordErrorMessage.isEmpty
                            ? const SizedBox()
                            : Text(
                            controller.confirmPasswordErrorMessage,
                            style: TextStyle(
                                color: const Color(0xFFA2000F),
                                fontSize: Get.height * 0.02)),
                        // SizedBox(
                        //   height: Get.height * 0.01,
                        // ),
                        // Align(alignment: Alignment.centerRight,
                        //   child: Text(
                        //     StringRes.forgetPassword,
                        //     style: appTextStyle(
                        //         fontSize: 12,
                        //         weight: FontWeight.w600,
                        //         color: ColorRes.black),
                        //   ),
                        // ),
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        Center(
                          child: CommonButton(
                              onTap: () {
                              controller.validateUserName();
                              controller.validateEmail();
                              controller.validatePassword();
                              controller.validateConfirmNewPassword();
                              if(controller.userErrorMessage.isEmpty && controller.emailErrorMessage.isEmpty && controller.passwordErrorMessage.isEmpty && controller.confirmPasswordErrorMessage.isEmpty)
                                {
                                  controller.signUp(controller.emailIdController.text, controller.confirmPasswordController.text,controller.userNameController.text).then((value) {
                                    controller.userNameController.text = "";
                                    controller.emailIdController.text = "";
                                    controller.passwordController.text = "";
                                    controller.confirmPasswordController.text = "";
                                  });
                                }
                              },
                              text: StringRes.signUp.tr),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              StringRes.alreadyHaveAccount.tr,
                              style: appTextStyle(
                                  fontSize: 15,
                                  weight: FontWeight.w500,
                                  color: ColorRes.black),
                            ),
                            const SizedBox(width: 2,),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed( AppRoutes.login);
                              },
                              child:  Text(
                                 StringRes.logIn.tr,
                                style:appTextStyle(
                                    fontSize: 15,
                                    weight: FontWeight.w600,
                                    color: ColorRes.appColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              Obx(() => (signUpController.loader.value)?const CommonLoader():const SizedBox())
            ],
          ),
        ),
      ),
    );
  }

}
