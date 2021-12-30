
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/view/authentication/loginscreen.dart';
import 'package:pigolearn_round1/view/home/homescreen.dart';
import 'package:pigolearn_round1/view/settings/settings_screen.dart';


class AuthenticaionController extends GetxController{
//text controllers  (login)
TextEditingController emailController = TextEditingController();
TextEditingController loginPassWordCn = TextEditingController();
//text controllers  (create account)
TextEditingController registerEmailCn = TextEditingController();
TextEditingController registerPassWordCn = TextEditingController();
TextEditingController fullNameCn = TextEditingController();
TextEditingController confirmPassWordCn = TextEditingController();


//validators(bool)
RxBool isEmailValid = true.obs;
RxBool isloginPassowrdCorrect = true.obs;
RxBool isRegisterEmailValid = true.obs;
RxBool isRegisterPassowrdCorrect = true.obs;
RxBool isFullNameNotEmpty = true.obs;
//validators(text)
RxString emailValidationText = "".obs;
RxString passwordValidationText = "".obs;
RxString registerEmailValidationText = "".obs;
RxString registerPasswordValidationText = "".obs;
RxString fullNameValidText = "".obs;

final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;


checkEmailValidation(){
  if(emailController.text.isEmail){
    isEmailValid(true);
    emailValidationText("");
  }else{
    isEmailValid(false);
    emailValidationText("please enter valid email");
  }

  if(loginPassWordCn.text.isNotEmpty && loginPassWordCn.text != ""){
    isloginPassowrdCorrect(true);
    passwordValidationText("");
  }else{
    isloginPassowrdCorrect(false);
     passwordValidationText("Password can't be empty");
  }



  if(emailController.text.isEmail && isloginPassowrdCorrect.value){
    _signInWithEmailAndPassword();
  }
}

checkRegisterValidationandApprove(){
  if(registerEmailCn.text.isEmail || registerEmailCn.text.isNotEmpty){
    isRegisterEmailValid(true);
    registerEmailValidationText("");
  }else {
    isRegisterEmailValid(false);
    registerEmailValidationText("please enter valid email");
  }
  if(registerPassWordCn.text == confirmPassWordCn.text || registerPassWordCn.text.isNotEmpty){
    isRegisterPassowrdCorrect(true);
    registerPasswordValidationText("");
  }else{
    isRegisterPassowrdCorrect(false);
    registerPasswordValidationText("Password is not match");
  }

  if(fullNameCn.text.isNotEmpty && fullNameCn.text != ""){
    isFullNameNotEmpty(true);
    fullNameValidText("");
  }else{
      isFullNameNotEmpty(false);
    fullNameValidText("Name can't be Empty");
  }


  if(isRegisterEmailValid.value && isRegisterPassowrdCorrect.value && isFullNameNotEmpty.value){
    registerUser() ;
  }
}

ispasswordMatch(){
  if(confirmPassWordCn.text.length > 2){
    if(registerPassWordCn.text == confirmPassWordCn.text){
    isRegisterPassowrdCorrect(true);
    registerPasswordValidationText("");
  }else{
     isRegisterPassowrdCorrect(false);
    registerPasswordValidationText("Password is not match");
  }
  }
}


void changePassword(String emailid) async{
   if(registerPassWordCn.text == confirmPassWordCn.text || registerPassWordCn.text.isNotEmpty){
    isRegisterPassowrdCorrect(true);
    registerPasswordValidationText("");
  }else{
    isRegisterPassowrdCorrect(false);
    registerPasswordValidationText("Password is not match");
  }

    if(loginPassWordCn.text.isNotEmpty && loginPassWordCn.text != ""){
    isloginPassowrdCorrect(true);
    passwordValidationText("");
  }else{
    isloginPassowrdCorrect(false);
     passwordValidationText("Password can't be empty");
  }


  if( isRegisterPassowrdCorrect.value&& isloginPassowrdCorrect.value){
    User user =  _auth.currentUser!;
   final cred = EmailAuthProvider.credential(
    email: emailid, password: loginPassWordCn.text);

user.reauthenticateWithCredential(cred).then((value) {
  user.updatePassword(registerPassWordCn.text).then((_) {
    //Success
      Get.snackbar("Successfully changed password", "",backgroundColor: Colors.green,colorText: Colors.white);
      Get.off(SettingsScreen());
  }).catchError((error) {
    //Error,
  });
}).catchError((err) {
      Get.snackbar("Password can't be changed",  err.toString(),backgroundColor: Colors.red,colorText: Colors.white);

 
});



  }
  
  }


//delete user
deleteuser(String email) async{
     if(registerPassWordCn.text.isNotEmpty && registerPassWordCn.text != ""){
     isRegisterPassowrdCorrect(true);
    registerPasswordValidationText("");
  }else{
    isRegisterPassowrdCorrect(false);
    registerPasswordValidationText("Password Can't be empty");
  }


  if(isRegisterPassowrdCorrect.value){

     User user =  _auth.currentUser!;
   final cred = EmailAuthProvider.credential(
    email: email, password: registerPassWordCn.text);

user.reauthenticateWithCredential(cred).then((value) async{
  try {
  await FirebaseAuth.instance.currentUser!.delete();
} on FirebaseAuthException catch (e) {
  if (e.code == 'requires-recent-login') {
    print('The user must reauthenticate before this operation can be executed.');
      Get.snackbar("Account cant be deleted",  'The user must reauthenticate before this operation can be executed.',backgroundColor: Colors.red,colorText: Colors.white);

  }
}
}).catchError((err) {
      Get.snackbar("Something went wrong",  err.toString(),backgroundColor: Colors.red,colorText: Colors.white);

 
});



  }

}


//Firebase Authentication Functions

registerUser() async{
  try{

   final User? user = (await _auth.createUserWithEmailAndPassword(
      email: registerEmailCn.text,
      password: registerPassWordCn.text,
    )).user;

     if (user != null) {
       _addUserDetails(user.uid);
      Get.snackbar("Account created Successfully", "Now you can login to your account",backgroundColor: Colors.green,colorText: Colors.white);
      Get.off(LoginScreen());
      // setState(() {
      //   _success = true;
      //   _userEmail = user.email ?? '';
      // });
    } else {
      // _success = false;
      Get.snackbar("Something Went wrong", "Please try again",backgroundColor: Colors.red,colorText: Colors.white);


    }
  }on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    Get.snackbar('The password provided is too weak.', "please enter a new password",backgroundColor: Colors.red,colorText: Colors.white);

  } else if (e.code == 'email-already-in-use') {

    Get.snackbar('The account already exists for that email.', "please enter a new email",backgroundColor: Colors.red,colorText: Colors.white);

  }
}catch(e){
    Get.snackbar("Something Went wrong", e.toString(),backgroundColor: Colors.red,colorText: Colors.white);
    print(e);
  }
}

_addUserDetails(var userID){
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc(userID).collection("profile").doc(userID).set({
            'userId': userID,
            'full_name': fullNameCn.text,
            'email': registerEmailCn.text,
            "profile_pic": ""
          });
}



Future<void> _signInWithEmailAndPassword() async {
  try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
        password: loginPassWordCn.text,
  );
      Get.snackbar("Signed in Successfully", "",backgroundColor: Colors.green,colorText: Colors.white);

   Get.off(HomeScreen());
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    // print('No user found for that email.');
    Get.snackbar('No user found for that email.', "please register a new account",backgroundColor: Colors.red,colorText: Colors.white);

  } else if (e.code == 'wrong-password') {
    // print('Wrong password provided for that user.');
    Get.snackbar('Wrong password provided for that user.',"please enter correct password",backgroundColor: Colors.red,colorText: Colors.white);

  }
} catch (e) {
         Get.snackbar("Failed to sign in with Email & Password", "please try again",backgroundColor: Colors.red,colorText: Colors.white);
    }
  }
checkforLOgin(){
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      Get.off(LoginScreen());
    } else {
     Get.off(HomeScreen());
    }
  });

}
}


