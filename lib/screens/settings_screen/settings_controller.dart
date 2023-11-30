
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/asset_res.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:boards_app/utils/string_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedLanguage="English";
  String languageCode ="en";

  RxBool loader = false.obs;


  List<String> settingTitleList = [
    StringRes.privacyPolicy.tr,
    StringRes.changePassword.tr,
    StringRes.deleteAccount.tr,
  ];



  List<String> settingImageList = [
    AssetRes.privacyPolicy,
    AssetRes.lockIcon,
    AssetRes.deleteAcountIcon,

  ];

  Future<void> resetPassword({email}) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar('Password Reset Email Sent',
          'Check your email for instructions to reset your password.');
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  deleteAccount() async {

    if(FirebaseAuth.instance.currentUser?.email == PrefService.getString(PrefKeys.userId))
      {
    var user = await FirebaseAuth.instance.currentUser;
    user?.delete();

      }
    Get.offAllNamed( AppRoutes.login);
  }

}
