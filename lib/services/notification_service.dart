import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  /// Call this in main  to set up all notification features
  Future<void> initNotifications() async {
    //  Ask for notification permission
    await _messaging.requestPermission();

    //  Get FCM token
    String? token = await _messaging.getToken();
    print("FCM Token: $token");

    //  Store token in Firestore under 'users' collection
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'fcmToken': token}, SetOptions(merge: true));
    }
    //  Initialize local notification channel
    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidInit);
    await _localNotifications.initialize(initSettings); 

    //  Show local notification when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(
        message.notification?.title ?? 'New Notification',
        message.notification?.body ?? '',
      );
    });
  }

  ///  Show local notification with title and body
  Future<void> _showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(0, title, body, notificationDetails);
  }

  ///  Show custom "Thank You" message after donation
  Future<void> showLocalThankYou() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'donation_channel',
      'Donations',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0,
      'Thank You!',
      'Your donation has been received successfully.',
      notificationDetails,
    );
  }
}
