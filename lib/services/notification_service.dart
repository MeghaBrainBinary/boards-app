import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  static Future<void> init() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

 await FirebaseMessaging.instance.getNotificationSettings();


    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );


    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessageOpenedApp;

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;

      /// If `onMessage` is triggered with a notification, construct our own
      /// local notification to show to users using the created channel.
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
      if (true) {
        Future.delayed(8.seconds,(){});
      }
    });


    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        Future.delayed(5.seconds,(){});
      }
    });



    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        Future.delayed(5.seconds, () {

        });
      }
    });


    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);



    flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
       );



  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

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
