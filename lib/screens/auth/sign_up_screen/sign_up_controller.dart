
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  RxBool loader = false.obs;
  bool isObscureText = false;
  bool isObscureConfirmText = false;
  String password = '';
  String passwordErrorMessage = "";

  String email = '';
  String emailErrorMessage = "";

  String user = '';
  String userErrorMessage = "";

  String confirmPassword = '';
  String confirmPasswordErrorMessage = "";

  // user
  void setUser(String value) {
    user = value.trim();
    update(['signUp']);
  }

  validateUserName() {
    if (user.isEmpty) {
      userErrorMessage = 'Please enter your User name';
    }  else {
      userErrorMessage = "";
    }
    update(['signUp']);
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp(String email, String password,String userName) async {
    try {
      loader.value = true;
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      PrefService.setValue(PrefKeys.userId,email);
      // Store additional user information in Firestore
      // await _firestore.collection('users').doc(userCredential.user!.uid).set({
      //   'username': userName,
      //   'email': email,
      //   'favorites': [], // Initialize favorites as an empty array
      // });
      loader.value = false;
      Future.delayed(
        const Duration(seconds: 1),
            () async {
              PrefService.setValue(PrefKeys.login, true);
              Get.offAndToNamed(AppRoutes.boardsPage);
        },
      );
    } catch (e) {
      loader.value = false;

      Get.snackbar('Error', 'This account is already exits!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: CupertinoColors.destructiveRed,
          colorText: CupertinoColors.white);
    }
  }

// email



  void setEmail(String value) {
    email = value.trim();
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
    update(['signUp']);
  }


  // password

  void setPassword(String value) {
    password = value.trim();
    update(['signUp']);
  }

  validatePassword() {
    if (password.isEmpty) {
      passwordErrorMessage = 'Please enter your  password.';
    } else if (password.length < 8) {
      passwordErrorMessage = 'Password must be at least 8 characters';
    } else {
      passwordErrorMessage = "";
    }
    update(['signUp']);
  }

  // confirm password

  void setConfirmNewPassword(String value) {
    confirmPassword = value.trim();
    update(['signUp']);
  }

  validateConfirmNewPassword() {
    if (confirmPassword.isEmpty) {
      confirmPasswordErrorMessage = 'Please enter your Confirm password.';
    }  else if (confirmPassword != passwordController.text) {
      confirmPasswordErrorMessage = 'Passwords do not match.';
    } else {
      confirmPasswordErrorMessage = "";
    }
    update(['signUp']);
  }


}
