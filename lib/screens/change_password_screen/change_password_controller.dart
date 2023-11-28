
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String selectedLanguage="English";
  String languageCode ="en";

  RxBool loader = false.obs;
  bool isObscureText = false;
  bool isObscureNewText = false;
  bool isObscureConfirmText = false;

  String password = '';
  String passwordErrorMessage = "";

  String newPassword = '';
  String newPasswordErrorMessage = "";

  String confirmPassword = '';
  String confirmPasswordErrorMessage = "";

  void setPassword(String value) {
    password = value.trim();
    update(['changePassword']);
  }

  validatePassword() {
    if (password.isEmpty) {
      passwordErrorMessage = 'Please enter your current password.';
    }  else {
      passwordErrorMessage = "";
    }
    update(['changePassword']);
  }

  // new password

  void setNewPassword(String value) {
    newPassword = value.trim();
    update(['changePassword']);
  }

  validateNewPassword() {
    if (newPassword.isEmpty) {
      newPasswordErrorMessage = 'Please enter your new password.';
    }  else {
      newPasswordErrorMessage = "";
    }
    update(['changePassword']);
  }


  void setConfirmNewPassword(String value) {
    confirmPassword = value.trim();
    update(['changePassword']);
  }

  validateConfirmNewPassword() {
    if (confirmPassword.isEmpty) {
      confirmPasswordErrorMessage = 'Please enter your current password.';
    }  else if (confirmPassword != newPasswordController.text) {
      confirmPasswordErrorMessage = 'Passwords do not match.';
    } else {
      confirmPasswordErrorMessage = "";
    }
    update(['changePassword']);
  }


}
