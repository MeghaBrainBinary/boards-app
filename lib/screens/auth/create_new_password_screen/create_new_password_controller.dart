
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateNewPasswordController extends GetxController {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  RxBool loader = false.obs;
  bool isObscureText = false;
  bool isObscureConfirmText = false;
  String password = '';
  String passwordErrorMessage = "";

  String confirmPassword = '';
  String confirmPasswordErrorMessage = "";
  bool rememberMe = false;



// password

  void setPassword(String value) {
    password = value.trim();
    update(['createNewPassword']);
  }

  validatePassword() {
    if (password.isEmpty) {
      passwordErrorMessage = 'Please enter your  password.';
    } else if (password.length < 8) {
      passwordErrorMessage = 'Password must be at least 8 characters';
    } else {
      passwordErrorMessage = "";
    }
    update(['createNewPassword']);
  }

  // confirm password

  void setConfirmNewPassword(String value) {
    confirmPassword = value.trim();
    update(['createNewPassword']);
  }

  validateConfirmNewPassword() {
    if (confirmPassword.isEmpty) {
      confirmPasswordErrorMessage = 'Please enter your Confirm password.';
    }  else if (confirmPassword != passwordController.text) {
      confirmPasswordErrorMessage = 'Passwords do not match.';
    } else {
      confirmPasswordErrorMessage = "";
    }
    update(['createNewPassword']);
  }


}
