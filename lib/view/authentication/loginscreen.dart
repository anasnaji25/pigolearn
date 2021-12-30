import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/authentication_controllers.dart';
import 'package:pigolearn_round1/values/app_fonts.dart';
import 'package:pigolearn_round1/view/authentication/signupscreen.dart';
import 'package:pigolearn_round1/widget/text_fields.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authenticationController =  Get.find<AuthenticaionController>();




  @override
  void initState() {
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
             const SizedBox(height: 200,),
             Text("Login",style: kloginTextstyle,),
             const SizedBox(height: 5,),
             Text("please sign in to continue",style: kloginRequestTextstyle,),
             const SizedBox(height:10),
             CustomWidgets.textField("Email",textController: authenticationController.emailController),
             authenticationController.isEmailValid.value ? Container(): Text(authenticationController.emailValidationText.value,style: const TextStyle(color: Colors.red),),
             const SizedBox(height:9),
              CustomWidgets.textField("Password",isPassword: true,textController: authenticationController.loginPassWordCn ),
             authenticationController.isloginPassowrdCorrect.value? Container(): Text(authenticationController.passwordValidationText.value,style: const TextStyle(color: Colors.red),),
             const SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const SizedBox(width: 5,),
                  RaisedButton(
                  onPressed: () {
                    authenticationController.checkEmailValidation();

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
          'Login  >',
          textAlign: TextAlign.center,
          style: kloginTextstyle2,
              ),
            ),
          ),
        ),
                ],
              )
        
            ],
          ),),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?",style: kgreyText,),
            const SizedBox(width: 5,),
            InkWell(
              onTap: (){
                Get.to(SignUpScreen());
              },
              child: Text("Register",style: khyperTextStyle,))
          ],
        ),
      ),
    );
  }

}