import 'package:boards_app/common/common_button.dart';
import 'package:boards_app/screens/auth/api/login_api.dart';
import 'package:boards_app/screens/auth/model/login_model.dart';
import 'package:boards_app/screens/splashScreen/api/add_device_token_api.dart';
import 'package:boards_app/screens/splashScreen/model/add_device_token_model.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/appstyle.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();

  RxBool loader = false.obs;
  bool isObscureText = false;
  String password = '';
  String passwordErrorMessage = "";

  String email = '';
  String emailErrorMessage = "";

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference user = FirebaseFirestore.instance.collection('user');
  Future<bool> signIn(String email, String password) async {
    try {
      loader.value = true;
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      getUserDocId(email);
      loader.value = false;
      Future.delayed(
        const Duration(seconds: 1),
        () {
          PrefService.setValue(PrefKeys.userId, email);
          PrefService.setValue(PrefKeys.login, true);
          PrefService.setValue('isUser', true);
        },
      );

      return true;
    } catch (e) {
      loader.value = false;

      Get.snackbar(StringRes.error.tr, StringRes.invalidUserName.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: CupertinoColors.destructiveRed,
          colorText: CupertinoColors.white);
      return false;
    }
  }

// email
  getUserDocId(String email) async {
    await user.get().then((value) {
      for (var element in value.docs) {
        if (element['email'] == email) {
          var id = element.id;
          PrefService.setValue('docId', id);
        } else {}
      }
    });
  }

  void setEmail(String value) {
    email = value.trim();
  }

  validateEmail() {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (email.isEmpty) {
      emailErrorMessage = StringRes.emailCanNot.tr;
    } else if (!emailRegex.hasMatch(email)) {
      emailErrorMessage = StringRes.invalidEmailFormat.tr;
    } else {
      emailErrorMessage = "";
    }
    update(['login']);
  }

  // password

  void setPassword(String value) {
    password = value.trim();
    update(['login']);
  }

  validatePassword() {
    if (password.isEmpty) {
      passwordErrorMessage = StringRes.pleaseEnterCurrentPassword.tr;
    } else {
      passwordErrorMessage = "";
    }
    update(['login']);
  }

LoginModel loginModel =LoginModel();
  login(context) async {
    loader.value =true;
    await addDeviceTokenApi();
    loginModel =   await LoginApi.loginApi(email: email, deviseToken: PrefService.getString(PrefKeys.fcmToken), password: password) ?? LoginModel();

    if(loginModel.success ==true)
      {
        PrefService.setValue(PrefKeys.isLogin, true);
        _showDialog(context);
        emailIdController.text = "";
        passwordController.text = "";
      }
    loader.value =false;

  }

  AddDeviceTokenModel addDeviceTokenModel = AddDeviceTokenModel();
  addDeviceTokenApi () async{
    addDeviceTokenModel = await AddDeviceTokenApi.addDeviceTokenApi();

    if (kDebugMode) {
      print("Add device token => ${addDeviceTokenModel.message}");
    }
  }
  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
         onWillPop: ()async{
           return false;
         },
          child: SimpleDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
              Image.asset(
                AssetRes.succesfullogin,
                height: Get.height * 0.14,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                StringRes.successfully.tr,
                textAlign: TextAlign.center,
                style: appTextStyle(
                    weight: FontWeight.w600, fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                StringRes.successfullyCreate.tr,
                textAlign: TextAlign.center,
                style: appTextStyle(
                    weight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.60)),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              CommonButton(
                  onTap: () {
                    Get.offAndToNamed(AppRoutes.boardsPage,
                        arguments: PrefService.getString(PrefKeys.code));
                  },
                  text: StringRes.yes.tr),
              SizedBox(
                height: Get.height * 0.04,
              ),
            ],
          ),
        );
      },
    );
  }
}
