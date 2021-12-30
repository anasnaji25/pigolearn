import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/authentication_controllers.dart';
import 'package:pigolearn_round1/values/app_fonts.dart';
import 'package:pigolearn_round1/widget/text_fields.dart';


class ChangePassword extends StatefulWidget {
  String email;
  ChangePassword(this.email) ;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final authenticationController =  Get.find<AuthenticaionController>();

  @override
  void initState() {
    super.initState();
    authenticationController.loginPassWordCn.text = "";
    authenticationController.registerPassWordCn.text = "";
     authenticationController.confirmPassWordCn.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height:20),
             CustomWidgets.textField("Old Password*",isPassword: true,textController: authenticationController.loginPassWordCn),
             authenticationController.isloginPassowrdCorrect.value? Container(): Text(authenticationController.passwordValidationText.value,style: const TextStyle(color: Colors.red),),

                CustomWidgets.textField("New Password",isPassword: true,textController: authenticationController.registerPassWordCn),
                authenticationController.isRegisterPassowrdCorrect.value? Container():  Text(authenticationController.registerPasswordValidationText.value,style: const TextStyle(color: Colors.red),),
                const SizedBox(height:10),
                CustomWidgets.textField("Confirm New Password",isPassword: true,textController: authenticationController.confirmPassWordCn),
                const SizedBox(height:30),
                 RaisedButton(
                  onPressed: () { 
                    authenticationController.changePassword(widget.email);
                   
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
          'Confirm',
          textAlign: TextAlign.center,
          style: kloginTextstyle2,
              ),
            ),
          ),
        ),
          ],
        ),
      )
    );
  }
}