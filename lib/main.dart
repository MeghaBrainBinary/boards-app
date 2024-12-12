import 'dart:io';

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
import 'package:boards_app/screens/settings_screen/settings_screen.dart';
import 'package:boards_app/screens/splashScreen/splash_screen.dart';
import 'package:boards_app/screens/view/view_full_image.dart';
import 'package:boards_app/screens/view/view_screen.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'screens/intro_screen/intro_screen.dart';
import 'screens/language_screen/language_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isIOS)
    {
      await Firebase.initializeApp(
          options: const FirebaseOptions(apiKey: "AIzaSyBcR-pjKdjMqfd-CC2DyMcVQKEbXWJSVrY",
              appId: "1:660250529556:ios:822441d2663a89469d7c01", messagingSenderId: "660250529556", projectId: "inspiration-by-filuet")
      );
    }
  else
    {

  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyCNuLX-rBFRVqZVL29-ZCpENu59HydCUzQ",
        appId: "1:660250529556:android:0f540b475d0605b99d7c01", messagingSenderId: "660250529556", projectId: "inspiration-by-filuet")
  );
    }
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
    if (kDebugMode) {
      print(e);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // @override
  // void initState() {
  //   super.initState();
  //   // Future.delayed(
  //   //   const Duration(microseconds: 500),
  //   //       () async {
  //   //     await PrefService.init();
  //   //     if (Platform.isIOS) {
  //   //       final res = await Permission.notification.request();
  //   //       await  requestIOSPermissions();
  //   //       await _initializeNotificationService();
  //   //     } else {
  //   //       final res = await Permission.notification.request();
  //   //
  //   //       print("-------------------------------- $res");
  //   //       await _initializeNotificationService();
  //   //     }
  //   //   },
  //   // );
  //   super.initState();
  // }
  // Future<void> requestIOSPermissions() async {
  //   NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }
  // Future<void> _initializeNotificationService() async {
  //   await NotificationService.init();
  //   if (Platform.isIOS) {
  //     await FirebaseMessaging.instance.getAPNSToken().then((value) async {
  //       debugPrint("APNS token is =================== $value");
  //       await FirebaseMessaging.instance.getToken().then((value) {
  //         PrefService.setValue(PrefKeys.fcmToken, value.toString());
  //         if (kDebugMode) {
  //           print("FCM Token => $value");
  //         }
  //       });
  //
  //     });
  //   } else {
  //     await FirebaseMessaging.instance.getToken().then((value) {
  //       PrefService.setValue(PrefKeys.fcmToken, value.toString());
  //       if (kDebugMode) {
  //         print("FCM Token => $value");
  //       }
  //     });
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: (PrefService.getString(PrefKeys.code) == " ")
            ? const Locale("ru,RU")
            : LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, textTheme: const TextTheme()),
        getPages: [
          GetPage(name: AppRoutes.splashPage, page: () => const SplashScreen()),
          GetPage(name: AppRoutes.languagePage, page: () => LanguageScreen()),
          GetPage(name: AppRoutes.boardsPage, page: () => BoardsScreen()),
          GetPage(name: AppRoutes.myFolderPage, page: () => MyFolderScreen()),
          GetPage(name: AppRoutes.introPage, page: () => const IntroScreen()),
          GetPage(name: AppRoutes.favourite, page: () => FavouriteScreen()),
          GetPage(name: AppRoutes.viewImagesScreen, page: () => ViewImagesScreen(), arguments: const []),
          GetPage(name: AppRoutes.viewFullImagesScreen, page: () => const ViewFullImageScreen(), arguments: ""),
          GetPage(name: AppRoutes.contactUs, page: () => ContactUsScreen()),
          GetPage(name: AppRoutes.setting, page: () => SettingsScreen()),
          GetPage(name: AppRoutes.login, page: () => LoginScreen()),
          GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
          GetPage(name: AppRoutes.forgotPasswordScreen, page: () => ForgotPasswordScreen()),
          GetPage(name: AppRoutes.createNewPasswordScreen, page: () => CreateNewPasswordScreen()),
          GetPage(name: AppRoutes.languageConfirmPage, page: () => LanguageScreen22()),
        ],
        home: const SplashScreen()
        // home: SelectFlowScreen()
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
