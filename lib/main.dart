import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';


Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geeks Demo',
      theme: ThemeData(
        // This is the theme
        // of your application.
        primarySwatch: Colors.green,
      ),
      home: Demo(),
    );
  }
}



class Demo extends StatefulWidget {
  const Demo({super.key});

@override
_DemoState createState() => _DemoState();
}
class _DemoState extends State<Demo> {
FirebaseMessaging messaging = FirebaseMessaging.instance;
late FlutterLocalNotificationsPlugin fltNotification;
void pushFCMtoken() async {
String? token=await messaging.getToken();
print(token);
//you will get token here in the console
}
@override
void initState() {
 super.initState();
 pushFCMtoken();
 initMessaging();
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(),
 body: Center(child: Text("Flutter Push Notifiction"),),);
}
void initMessaging() {
var androiInit = AndroidInitializationSettings("@mipmap/ic_launcher");
var iosInit = IOSInitializationSettings();
var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
fltNotification = FlutterLocalNotificationsPlugin();
fltNotification.initialize(initSetting);
var androidDetails =
 AndroidNotificationDetails("1", "channelName",);
var iosDetails = IOSNotificationDetails();
var generalNotificationDetails =
NotificationDetails(android: androidDetails, iOS: iosDetails);
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
RemoteNotification? notification=message.notification;
AndroidNotification? android=message.notification?.android;
if(notification!=null && android!=null){
fltNotification.show(
notification.hashCode, notification.title, notification.body, generalNotificationDetails);
}});}
}