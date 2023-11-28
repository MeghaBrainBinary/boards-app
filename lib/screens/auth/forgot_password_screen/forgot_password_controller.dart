
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
      Get.snackbar('Password Reset Email Sent',
          'Check your email for instructions to reset your password.');
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
      emailErrorMessage = 'Email can not be empty';
    } else if (!emailRegex.hasMatch(email)) {
      emailErrorMessage = 'Invalid email format';
    } else {
      emailErrorMessage = "";
    }
    update(['forgot']);
  }




}
