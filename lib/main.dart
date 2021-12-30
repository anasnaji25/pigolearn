import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/authentication_controllers.dart';
import 'package:pigolearn_round1/controllers/bookmark_controller.dart';
import 'package:pigolearn_round1/controllers/firebase_services_controller.dart';
import 'package:pigolearn_round1/controllers/search_controller.dart';
import 'package:pigolearn_round1/controllers/theme_controller.dart';
import 'package:pigolearn_round1/view/authentication/check_for_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(BookMarkController());
  Get.put(SearchController());
  Get.put(AuthenticaionController());
  Get.put(FirebaseServicesController());
  Get.put(ThemeController());

  runApp( MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final themeCn = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
   themeCn.chackTheme();
    return GetBuilder<ThemeController>(
                builder: (themecontroller) => GetMaterialApp(
      title: 'PingoLearn Round-2',
      debugShowCheckedModeBanner: false,
      theme: themecontroller.isDarkMode.value? ThemeData.dark(): ThemeData.light() ,
      home: CheckForLogin(),
    ));
  }
}



