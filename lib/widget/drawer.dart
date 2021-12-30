import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/theme_controller.dart';
import 'package:pigolearn_round1/values/app_fonts.dart';
import 'package:pigolearn_round1/view/history/history_screen.dart';
import 'package:pigolearn_round1/view/settings/settings_screen.dart';

class DrawerWidget extends StatelessWidget {
   DrawerWidget({Key? key}) : super(key: key);
   

  final themeCn = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {

    return Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
        Container(
          height: 100,
          child: DrawerHeader(
          decoration:  BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Text('PingoLearn Round-2',style: kDrawerHeaderstyle,),
      ),
        ),
      
      ListTile(
        leading: const Icon(Icons.history),
        title: const Text('History'),
        onTap: () {
         Get.to(HistoryScreen());
        },
      ),
       
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {
          Get.to(SettingsScreen());
        },
      ),
       Obx(()=>ListTile(
        leading: const Icon(Icons.dark_mode),
        trailing: Switch(value: themeCn.isDarkMode.value, onChanged: (value){
         themeCn.changeTheme(value);
        }),
        title: const Text('Dark Mode'),
        onTap: () {
         
        },
      ),),
    ],
  ),
);
  }
}