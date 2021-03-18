import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_app/src/pages/home_page.dart';
import 'package:push_app/src/pages/mensaje_page.dart';
import 'package:push_app/src/providers/push_notifications_provider.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  
  print("Handling a background message: ${message.messageId}");
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final pushProvider = new PushNotificationsProvider();
  pushProvider.initNotifications();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  
  
  @override
  Widget build(BuildContext context) {

    

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("Push App NO FF");
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Push App NO FF',
            initialRoute: 'home',
            routes: {
              'home'    : (BuildContext context) => HomePage(),
              'mensaje' : (BuildContext context) => MensajePage(),
            },
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Push App',
            initialRoute: 'home',
            routes: {
              'home'    : (BuildContext context) => HomePage(),
              'mensaje' : (BuildContext context) => MensajePage(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}