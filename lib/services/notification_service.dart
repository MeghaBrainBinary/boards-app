// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:boards_app/screens/boards_screen/boards_controller.dart';
import 'package:boards_app/screens/boards_screen/boards_screen.dart';
import 'package:boards_app/screens/my_folder_screen/my_folder_controller.dart';
import 'package:boards_app/services/pref_services.dart';
import 'package:boards_app/utils/approutes.dart';
import 'package:boards_app/utils/prefkeys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:get/get.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
  playSound: true,
  showBadge: true,

);
@pragma('vm:entry-point')
 Future<void> firebaseMessagingBackgroundHandler(
RemoteMessage message) async {

}


@pragma('vm:entry-point')
class NotificationService {
  static Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

 await FirebaseMessaging.instance.getNotificationSettings();

    await FirebaseMessaging.instance.requestPermission();

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings ,

    onDidReceiveNotificationResponse: (NotificationResponse message){
      Map<String,dynamic> data = jsonDecode(message.payload ??"{}");
      redirectNotification(data);

    }
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);



    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;

      if (notification != null && android != null) {
        Map<String, dynamic> payload = message!.data;
        flutterLocalNotificationsPlugin.show(

          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
            ),
          ),
          payload: jsonEncode(payload),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {
      redirectNotification(message.data);
    });






    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {

    });





    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  }


  static redirectNotification(Map<String,dynamic> message)async{
    if(message.containsKey("board_id")) {

      if(message['isImage']=="1") {


        if(Get.currentRoute != AppRoutes.boardsPage)
        {
        Get.offAll(()=>BoardsScreen());
        }

        TreeNodeData? treeData;
        BoardsController boardsController = Get.put(BoardsController());
        await boardsController.init(
            PrefService.getString(PrefKeys.languageCode));
        for (var element in boardsController.treeData) {
          if (element.id == int.parse(message['board_id'] ?? '0')) {
            if(message['sub_board_id'] !='') {
              if (element.children.length != 0) {
                for (var ele in element.children) {
                  if (ele.id == int.parse(message['sub_board_id'] ?? '0')) {
                    treeData = ele;
                  }
                }
              }

              else {
                treeData = element;
              }
            }else {
              treeData = element;
            }
          }
        }
        if (treeData != null) {
          await boardsController.onTapFolder(
            isFromNotification: true,
            node: treeData,
            treeData.id.toString(),
            treeData.name,
            (treeData.id.toString() == "0" && treeData.name == '') ? treeData.icon : treeData.icon,
            quote: treeData.quote,
            isFirst: (treeData.id.toString() == "0") ? true : false,
            quoteColor: treeData.quote_text_color,
            quoteFamily: treeData.quote_font_family,
            nameColor: treeData.name_text_color,
            nameFamily: treeData.name_font_family,
            mainCategory: (treeData.id.toString() == "0" &&
                treeData.name == '')
                ? treeData.name
                : treeData.name,
          );
        }

        int index = 0;
        MyFolderController myFolderController = Get.put(MyFolderController());
        if (myFolderController.getBoardInfoModel.data != null) {
          for (var element in myFolderController.getBoardInfoModel.data!) {
            if (element.id == int.parse(message['image_id'] ?? '0')) {
              index =
                  myFolderController.getBoardInfoModel.data!.indexOf(element);
            }
          }
          await myFolderController.onTapImage(index, fromNotification: true);
        }
      }


    }
  }




  static Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    if (kDebugMode) {
      print("Notification");
    }
  }

  static Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();

    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
