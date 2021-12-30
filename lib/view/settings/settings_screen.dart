import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/firebase_services_controller.dart';
import 'package:pigolearn_round1/controllers/theme_controller.dart';
import 'package:pigolearn_round1/values/app_fonts.dart';
import 'package:pigolearn_round1/view/authentication/change_password_screen.dart';
import 'package:pigolearn_round1/view/authentication/delete_user_screen.dart';




class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final firebaseServiceCN = Get.find<FirebaseServicesController>();
   final themeCn = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),

      body: Container(
        height: size.height,
        width: size.width,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firebaseServiceCN.getProfileData(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(
                child: Text("Something went wrong"),
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else{

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Stack(
                  children: [
                      snapshot.data!.docs[0]["profile_pic"]   == ""?   Container(width: 120,
                                                  height: 120,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/image_not_found.png"),
                                                          fit: BoxFit.cover)),
                                              ): Container(width: 120,
                                                  height: 120,
                                                  decoration:  BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              snapshot.data!.docs[0]["profile_pic"]),
                                                          fit: BoxFit.cover)),
                                              ),
                                               Positioned(
                                                bottom: 2,
                                                right: 5,
                                                child: InkWell(
                                                  onTap: (){
                                                      firebaseServiceCN.updateProfilePicture();
                                                  },
                                                  child: const Icon(Icons.add_circle,color: Colors.blue,)))
                  ],
                ),
                const SizedBox(height: 10,),
                Text(snapshot.data!.docs[0]["full_name"],style: kProfileNamestyle,),
                Text(snapshot.data!.docs[0]["email"],style: themeCn.isDarkMode.value ? kgreyemailText2: kgreyemailText,),
               const SizedBox(height: 80,),
                 InkWell(
                   onTap: (){
                     Get.to(ChangePassword(snapshot.data!.docs[0]["email"]));
                   },
                   child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                    horizontalTitleGap: 5,
                    title: Text("Change Password",style: themeCn.isDarkMode.value ? kSettingsMenuStyle3:kSettingsMenuStyle,),
                    leading: const Icon(Icons.lock),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 16,),
                                 ),
                 ),
                 InkWell(
                   onTap: (){
                     Get.to(DeleteAccount(snapshot.data!.docs[0]["email"]));
                   },
                   child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                    horizontalTitleGap: 5,
                    title: Text("Delete Account",style: kSettingsMenuStyle2,),
                    leading: const Icon(Icons.delete,color: Colors.red,),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 16,color: Colors.red,),
                                 ),
                 ),
                 InkWell(
                    onTap: ()async{
                     await FirebaseAuth.instance.signOut();
                   },
                   child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                    horizontalTitleGap: 5,
                    title: Text("Logout",style:themeCn.isDarkMode.value ? kSettingsMenuStyle3: kSettingsMenuStyle,),
                    leading: const Icon(Icons.logout),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 16),
                                 ),
                 )
              ],
            );
            }
          }
        ),
      ),
    );
  }
}