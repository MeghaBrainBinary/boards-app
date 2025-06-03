// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/common/common_textfild.dart';
import 'package:boards_app/screens/auth/login_screen/login_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/color_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());

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
              GetBuilder<LoginController>(
                id: "login",
                builder: (controller) => SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.07,
                            ),
                            Center(
                              child: Text(
                                StringRes.logIn.tr,
                                style: appTextStyle(
                                    fontSize: 30,
                                    weight: FontWeight.w600,
                                    color: ColorRes.appColor),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.07,
                            ),
                            Center(
                                child: Image.asset(
                              AssetRes.secureLogin,
                              height: Get.height * 0.3,
                            )),
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                        /*    CommonTextFeild(
                                controller: controller.emailIdController,
                                onChanged: (value) => controller.setEmail(value),
                                hintText: StringRes.emailID.tr,
                                PrefixIcon: AssetRes.emailIcon),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            controller.emailErrorMessage.isEmpty
                                ? const SizedBox()
                                : Text(controller.emailErrorMessage,
                                    style: TextStyle(
                                        color: const Color(0xFFA2000F),
                                        fontSize: Get.height * 0.02)),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),*/
                            CommonTextFeild(
                                onTapIcon: () {
                                  if (controller.isObscureText == false) {
                                    controller.isObscureText = true;
                                  } else {
                                    controller.isObscureText = false;
                                  }
                                  controller.update(['login']);
                                },
                                obscureText: controller.isObscureText,
                                onChanged: (value) =>
                                    controller.setPassword(value),
                                controller: controller.passwordController,
                                isShowViciblity: true,
                                hintText: StringRes.password.tr,
                                PrefixIcon: AssetRes.fileLoke),
                            // validation
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            controller.passwordErrorMessage.isEmpty
                                ? const SizedBox()
                                : Text(controller.passwordErrorMessage,
                                    style: TextStyle(
                                        color: const Color(0xFFA2000F),
                                        fontSize: Get.height * 0.02)),
                         /*   SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.forgotPasswordScreen);
                                },
                                child: Text(
                                  StringRes.forgetPassword.tr,
                                  style: appTextStyle(
                                      fontSize: 12,
                                      weight: FontWeight.w600,
                                      color: ColorRes.black),
                                ),
                              ),
                            ),
*/
                            SizedBox(
                              height: Get.height * 0.08,
                            ),
                            Center(
                              child: CommonButton(
                                  onTap: () async {

                                    controller.validatePassword();
                                    if (controller.passwordErrorMessage.isEmpty) {
                                      await controller
                                          .login(context);

                                    }
                                  },
                                  text: StringRes.logIn.tr),
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                        /*    Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  StringRes.dontHaveAccount.tr,
                                  style: appTextStyle(
                                      fontSize: 15,
                                      weight: FontWeight.w500,
                                      color: ColorRes.black),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.signUpScreen);
                                  },
                                  child: Text(
                                    StringRes.signUp.tr,
                                    style: appTextStyle(
                                        fontSize: 15,
                                        weight: FontWeight.w600,
                                        color: ColorRes.appColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),*/
                          ]),
                    ),
                  ),
                ),
              ),
              Obx(() => (loginController.loader.value)
                  ? const CommonLoader()
                  : const SizedBox())
            ],
          ),
        ),
      ),
    );
  }


}
