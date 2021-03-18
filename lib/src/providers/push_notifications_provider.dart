
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


initNotifications() async{

  await _firebaseMessaging.requestPermission();
  final token = await _firebaseMessaging.getToken();
  print("=====TOKEN=====");
  print(token);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });


}


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print("Handling a background message: ${message.messageId}");
// }
  


}
