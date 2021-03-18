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


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      PushNotificationsProvider pushProvider = new PushNotificationsProvider();
      pushProvider.initNotifications();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
      // Show error message if initialization failed
    if(_error) {
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

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push App',
      home: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  
  /*
  doZnkQGeQtC1uTGhMY58jH:APA91bGviLp37CjzhoZ9L8ZGdx3vH67VZtWJPCAx5dDx0Lbrcnc4TaC3J5Dk6i_xOFIWDvVex7EaR1Y_5h8Q0ndeSV5V3CxFxfUmvFx9U0srBAa9WMCu5XPoJ4DkamNXgAK5E9Bst29r
  */

  }
}