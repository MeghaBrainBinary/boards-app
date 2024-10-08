import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
}
