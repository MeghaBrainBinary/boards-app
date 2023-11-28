// ignore_for_file: must_be_immutable

import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/common/common_loader.dart';
import 'package:boards_app/common/common_textfild.dart';
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

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GetBuilder<LoginController>(
              id: "login",
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
                          StringRes.logIn,
                          style: appTextStyle(
                              fontSize: 30,
                              weight: FontWeight.w600,
                              color: ColorRes.color305EBE),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.07,
                      ),
                      Center(child: Image.asset(AssetRes.secureLogin,height: Get.height * 0.3,)),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      CommonTextFeild(controller: controller.emailIdController,
                          onChanged: (value) => controller.setEmail(value),
                          hintText: StringRes.emailID,PrefixIcon: AssetRes.emailIcon),
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
                        controller.update(['login']);
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
                        height: Get.height * 0.01,
                      ),
                      Align(alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed( AppRoutes.forgotPasswordScreen);
                          },
                          child: Text(
                            StringRes.forgetPassword,
                            style: appTextStyle(
                                fontSize: 12,
                                weight: FontWeight.w600,
                                color: ColorRes.black),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.08,
                      ),
                      Center(
                        child: CommonButton(
                            onTap: () {
                            controller.validateEmail();
                            controller.validatePassword();
                            if(controller.emailErrorMessage.isEmpty && controller.passwordErrorMessage.isEmpty)
                              {

                                controller.signIn(
                                    controller.emailIdController.text,
                                    controller.passwordController.text).then((value) {
                                  if(value)
                                        {
                                          _showDialog(context);
                                        }
                                  controller.emailIdController.text="";
                                  controller.passwordController.text="";
                                });

                              }

                            },
                            text: StringRes.logIn),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            StringRes.dontHaveAccount,
                            style: appTextStyle(
                                fontSize: 15,
                                weight: FontWeight.w500,
                                color: ColorRes.black),
                          ),
                          SizedBox(width: 2,),
                          GestureDetector(
                            onTap: () {
                                Get.toNamed( AppRoutes.signUpScreen);
                            },
                            child:  Text(
                               StringRes.signUp,
                              style:appTextStyle(
                                  fontSize: 15,
                                  weight: FontWeight.w600,
                                  color: ColorRes.color305EBE),
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
            Obx(() => (loginController.loader.value)?const CommonLoader():const SizedBox())
          ],
        ),
      ),
    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(contentPadding: EdgeInsets.symmetric(horizontal: 20),children: [
          SizedBox(height: Get.height * 0.04,),
          Image.asset(AssetRes.succesfullogin,height: Get.height * 0.14,),
          SizedBox(height: Get.height * 0.03,),
          Text(StringRes.successfully,textAlign: TextAlign.center,style: appTextStyle(weight: FontWeight.w600,fontSize: 16,color: Colors.black),),
          SizedBox(height: Get.height * 0.01,),
          Text(StringRes.successfullyCreate,textAlign: TextAlign.center,style: appTextStyle(weight: FontWeight.w400,fontSize: 12,color: Colors.black.withOpacity(0.60)),),
          SizedBox(height: Get.height * 0.03,),
          CommonButton(
              onTap: () {

                Get.offAndToNamed(AppRoutes.boardsPage);
              //  Get.back();
              },
              text: StringRes.yes),
          SizedBox(height: Get.height * 0.04,),
        ],);
      },
    );
  }

}
