import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tripwonder/main.dart';

import 'global_variables/fcm_token_manage.dart';

class FirebaseApi{
  final _firebaseMessageing = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await _firebaseMessageing.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await _localNotifications.initialize(initializationSettings);

    final fCMToken = await _firebaseMessageing.getToken();
    TokenManager().fcmToken = fCMToken;
    print('Token: $fCMToken');

    initPushNotification();

  }

  void handleMessage(RemoteMessage? message){
    if (message == null){
      return;
    }
    navigatorkey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // Future initPushNotification() async{
  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  // }

  Future<void> initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(message);
      }
    });
  }

  void showLocalNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    _localNotifications.show(
      0,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

}