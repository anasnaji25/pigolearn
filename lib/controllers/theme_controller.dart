



import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController{
   

   RxBool isDarkMode = false.obs;
   

   changeTheme(bool isDark) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool("isDark", isDark);
     chackTheme();
   }


   chackTheme()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? theme = prefs.getBool("isDark");
    if(theme == null ){
      isDarkMode(false);
    }else{
      isDarkMode(theme);
    }

   
   update();
   }


  
}