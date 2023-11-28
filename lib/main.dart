import 'package:boards_app/localization/localization.dart';
import 'package:boards_app/screens/auth/create_new_password_screen/create_new_password_screen.dart';
import 'package:boards_app/screens/auth/forgot_password_screen/forgot_password_screen.dart';
import 'package:boards_app/screens/auth/login_screen/login_screen.dart';
import 'package:boards_app/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:boards_app/screens/contact_us_screen/contact_us_screen.dart';
import 'package:boards_app/screens/favourite_screen/favourite_screen.dart';
import 'package:boards_app/screens/language_screen2/languagescreen2.dart';
import 'package:boards_app/screens/boards_screen/boards_screen.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_screen.dart';
import 'package:boards_app/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:boards_app/screens/settings_screen/settings_screen.dart';
import 'package:boards_app/screens/splashScreen/splash_screen.dart';
import 'package:boards_app/services/notification_service.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'screens/change_password_screen/change_password_screen.dart';
import 'screens/intro_screen/intro_screen.dart';
import 'screens/language_screen/language_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PrefService.init();


  try {
    await FirebaseMessaging.instance.getToken().then((value) {
      PrefService.setValue(PrefKeys.fcmToken, value.toString());
      if (kDebugMode) {
        print("FCM Token => $value");
      }
    });
  } catch (e) {
    print(e);
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: (PrefService.getString(PrefKeys.code) ==" ")?Locale("en,EN"):
        LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.blue, textTheme: const TextTheme()),
        getPages: [
          GetPage(name: AppRoutes.splashPage, page: () => const SplashScreen()),
          GetPage(name: AppRoutes.languagePage, page: () => LanguageScreen()),
          GetPage(name: AppRoutes.boardsPage, page: () => BoardsScreen()),
          GetPage(name: AppRoutes.myFolderPage, page: () => MyFolderScreen()),
          GetPage(name: AppRoutes.introPage, page: () => IntroScreen()),
          GetPage(name: AppRoutes.favourite, page: () => FavouriteScreen()),
          GetPage(name: AppRoutes.contactUs, page: () => ContactUsScreen()),
          GetPage(name: AppRoutes.setting, page: () => SettingsScreen()),
          GetPage(name: AppRoutes.login, page: () => LoginScreen()),
          GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
          GetPage(name: AppRoutes.forgotPasswordScreen, page: () => ForgotPasswordScreen()),
          GetPage(name: AppRoutes.createNewPasswordScreen, page: () => CreateNewPasswordScreen()),
          GetPage(
              name: AppRoutes.languageConfirmPage,
              page: () => LanguageScreen22()),
        ],
        home: LoginScreen()
        //SignUpScreen
        // LoginScreen
        // LanguageScreen22
        //ChangePasswordScreen
        //PrivacyPolicyScreen
        // SettingsScreen
        // ContactUsScreen
        //  (PrefService.getBool(PrefKeys.isLogin))
        //     ? HomeScreen()
        //     : SignInScreen(),
        );
  }
}
