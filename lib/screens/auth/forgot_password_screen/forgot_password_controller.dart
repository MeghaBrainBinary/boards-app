
import 'package:boards_app/utils/string_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {

  TextEditingController emailIdController = TextEditingController();



  RxBool loader = false.obs;


  String email = '';
  String emailErrorMessage = "";

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 Future<void> resetPassword({email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar(StringRes.passwordResetEmailSent.tr,
          StringRes.checkYourEmail.tr);
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  // email

  void setEmail(String value) {
    email = value.trim();
    update(['forgot']);
  }

  validateEmail() {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (email.isEmpty) {
      emailErrorMessage = StringRes.emailCanNot.tr;
    } else if (!emailRegex.hasMatch(email)) {
      emailErrorMessage =  StringRes.invalidEmailFormat.tr;
    } else {
      emailErrorMessage = "";
    }
    update(['forgot']);
  }




}
