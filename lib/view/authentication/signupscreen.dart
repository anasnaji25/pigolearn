import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/authentication_controllers.dart';
import 'package:pigolearn_round1/values/app_fonts.dart';
import 'package:pigolearn_round1/view/authentication/loginscreen.dart';
import 'package:pigolearn_round1/view/home/homescreen.dart';
import 'package:pigolearn_round1/widget/text_fields.dart';



class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final authenticationController =  Get.find<AuthenticaionController>();

@override
void initState() {
  authenticationController.confirmPassWordCn.addListener(authenticationController.ispasswordMatch);
  authenticationController.registerEmailCn.addListener(() {
    authenticationController.isRegisterEmailValid(true);
   });
    authenticationController.fullNameCn.addListener(() {
      authenticationController.isFullNameNotEmpty(true);
    });
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150,),
              Text("Create Account",style: kloginTextstyle,),
              const SizedBox(height: 5,),
              const SizedBox(height:10),
              CustomWidgets.textField("Full Name",textController: authenticationController.fullNameCn),
              authenticationController.isFullNameNotEmpty.value ? Container(): Text(authenticationController.fullNameValidText.value,style: const TextStyle(color: Colors.red),),

               const SizedBox(height:10),
              CustomWidgets.textField("Email",textController: authenticationController.registerEmailCn),
              authenticationController.isRegisterEmailValid.value ? Container(): Text(authenticationController.registerEmailValidationText.value,style: const TextStyle(color: Colors.red),),
              const SizedBox(height:10),
              CustomWidgets.textField("Password",isPassword: true,textController: authenticationController.registerPassWordCn),
              authenticationController.isRegisterPassowrdCorrect.value? Container():  Text(authenticationController.registerPasswordValidationText.value,style: const TextStyle(color: Colors.red),),
              const SizedBox(height:10),
              CustomWidgets.textField("Confirm Password",isPassword: true,textController: authenticationController.confirmPassWordCn),
              const SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 5,),
                  RaisedButton(
                  onPressed: () { 

                    authenticationController.checkRegisterValidationandApprove();
                    // Get.to(HomeScreen());
                  },
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration:  const BoxDecoration(
              gradient:  LinearGradient(
            colors: [
                  Color.fromARGB(255, 148, 231, 225),
                  Color.fromARGB(255, 62, 182, 226)
            ],
          ),
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
            ),
            child: Container(
              constraints: const BoxConstraints(minWidth: 120.0, minHeight: 50.0), // min sizes for Material buttons
              alignment: Alignment.center,
              child:  Text(
          'Sign up  >',
          textAlign: TextAlign.center,
          style: kloginTextstyle2,
              ),
            ),
          ),
        ),
        ],
              ),

             const SizedBox(height: 30,),

             const Divider(),
             
             Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",style: kgreyText,),
            const SizedBox(width: 5,),
            InkWell(
              onTap: (){
                Get.to(LoginScreen());
              },
              child: Text("Login",style: khyperTextStyle,))
          ],
        ),
            ],
          ),),
        ),
      ),
      
    );
  }


  //   @override
  // void dispose() {
  //   // Clean up the controller when the Widget is disposed
  // authenticationController.fullNameCn.dispose();
  // authenticationController.registerEmailCn.dispose();
  // authenticationController.registerPassWordCn.dispose();
  // authenticationController.confirmPassWordCn.dispose();
  //   super.dispose();
  // }

}