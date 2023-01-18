import 'package:boards_app/screens/boards_screen/boards_screen.dart';
import 'package:boards_app/screens/language_screen/language_screen.dart';
import 'package:boards_app/screens/splash_screen.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // WidgetsBinding.instance.addObserver(Handler());
  // await Firebase.initializeApp();
  // await PrefService.init();
  // NotificationService.init();
  // try {
  //   await FirebaseMessaging.instance.getToken().then((value) {
  //     PrefService.setValue(PrefKeys.userToken, value.toString());
  //     if (kDebugMode) {
  //       print("FCM Token => $value");
  //     }
  //   });
  // } catch (e) {
  //   print(e);
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.blue, textTheme: const TextTheme()),
        getPages: [
          GetPage(name: AppRoutes.splashPage, page: () => const SplashScreen()),
          GetPage(name: AppRoutes.languagePage, page: () => LanguageScreen()),
          GetPage(name: AppRoutes.boardsPage, page: () => BoardsScreen()),
        ],
        home: const SplashScreen()
        //  (PrefService.getBool(PrefKeys.isLogin))
        //     ? HomeScreen()
        //     : SignInScreen(),
        );
  }
}
