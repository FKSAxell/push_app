import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsProvider {
  
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)  async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print("Handling a background message: ${message.messageId}");
  }

  initNotifications() async {
    


    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print("=====TOKEN=====");
    print(token);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification notification = message.notification;
      // AndroidNotification android = message.notification?.android;
      
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }


      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //   notification.hashCode,
      //   notification.title,
      //   notification.body,
      //   NotificationDetails(
      //     android: AndroidNotificationDetails(
      //       channel.id,
      //       channel.name,
      //       channel.description,
      //       icon: android?.smallIcon,
      //       // other properties...
      //     ),
      //   ));
      // }
    });


  }






}
