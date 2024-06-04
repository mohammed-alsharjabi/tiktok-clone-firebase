import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tiktok/views/screens/home_screen.dart';

import 'constants.dart';
import 'controllers/auth_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
      options:const FirebaseOptions(
          apiKey: "AIzaSyBulpsG1WcES53IG2HKn8awjl67jzNQ4Wo",
          appId: "1:237904685522:android:641cde4ee4e4186131800b",
          messagingSenderId: "237904685522",
          projectId: "tiktok-a0215",
          storageBucket: "gs://tiktok-a0215.appspot.com"
          
          )).then((value) => Get.put(AuthController()))

      : await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

  

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok ',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const  HomeScreen(),
    );
  }
}
