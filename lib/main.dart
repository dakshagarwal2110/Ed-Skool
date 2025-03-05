import 'dart:io';

import 'package:ed_skool/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAhR9-DgcEQy2zOJy4FokhP_J7kGp03kGk",
          appId: "1:145362882731:android:f9e3f67dfaf1ae79a527ee",
          messagingSenderId: "145362882731",
          projectId: "edskoolflutter",
          storageBucket: "edskoolflutter.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
