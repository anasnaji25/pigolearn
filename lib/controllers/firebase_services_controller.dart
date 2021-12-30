import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;





class FirebaseServicesController extends GetxController{
   
final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;


 Stream<QuerySnapshot<Map<String, dynamic>>> getProfileData() {
   _user = _auth.currentUser!;
  var documentStream =  FirebaseFirestore.instance.collection('users').doc(_user.uid).collection("profile").snapshots();
   return documentStream;
 }


FirebaseStorage storage = FirebaseStorage.instance;

 updateProfilePicture() async{

    CollectionReference users = FirebaseFirestore.instance.collection('users');
   _user = _auth.currentUser!;
var _image = await ImagePicker.platform.getImage(source: ImageSource.gallery);
      if (_image != null) 
{ 
 final String fileName = _image.path;
      File imageFile = File(_image.path);

      await storage.ref(fileName).putFile(
            imageFile,
           ).then((p0) async{

            String link = await p0.ref.getDownloadURL();
           

            users.doc(_user.uid).collection("profile").doc(_user.uid).set({
"profile_pic": link
            },SetOptions(merge: true));
           });
}



 }





 


}