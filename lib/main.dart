import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:nitro_corn/const.dart';
import 'package:nitro_corn/loginPage.dart';
import 'package:nitro_corn/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // Step 1: Ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Step 2: Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBym4KF7NfekgWIFpauI25fJublBe4GMrM",
          authDomain: "nitro-a4a3f.firebaseapp.com",
          projectId: "nitro-a4a3f",
          storageBucket: "nitro-a4a3f.appspot.com",
          messagingSenderId: "62604446928",
          appId: "1:62604446928:web:0d005f22c0a45e9a2c62d5"),
    ).then((_) async {
      runApp(
        MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: Utils.messengerKey,
            navigatorKey: navigatorKey,
            title: "NITRO CORN",
            theme: ThemeData(
              primarySwatch: MaterialColor(0xFF35DC9F, appThemeColor),
            ),
            home: const LoginPage()),
      );
    });
  });
}
