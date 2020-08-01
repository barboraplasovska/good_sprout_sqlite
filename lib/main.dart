// main.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:good_sprout/screens/home/home_screen.dart';
import 'constants.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FirebaseCore.instance.initializeApp();
  // await FirebaseFirestore.instance
  //     .settings(Settings(host: "localhost:8080", sslEnabled: false));
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Good sprout',
        home: HomeScreen(),
        theme: ThemeData(
            scaffoldBackgroundColor: lightGreenColor,
            textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.white,
                fontSize: 44,
                fontFamily: primaryFont,
                fontWeight: FontWeight.bold,
              ),
              headline3: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: primaryFont,
              ),
              headline5: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: primaryFont,
              ),
              bodyText1: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: primaryFont,
              ),
              bodyText2: TextStyle(
                  color: darkGreenColor,
                  fontSize: 16.5,
                  fontFamily: primaryFont,
                  fontWeight: FontWeight.bold),
            )));
  }
}
