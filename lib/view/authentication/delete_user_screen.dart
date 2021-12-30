import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/authentication_controllers.dart';
import 'package:pigolearn_round1/values/app_fonts.dart';
import 'package:pigolearn_round1/widget/text_fields.dart';




class DeleteAccount extends StatefulWidget {
  String email;
  DeleteAccount(this.email) ;

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final authenticationController =  Get.find<AuthenticaionController>();

  @override
  void initState() {
    super.initState();
    authenticationController.registerPassWordCn.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CustomWidgets.textField("Enter your Password",isPassword: true,textController: authenticationController.registerPassWordCn),
                  authenticationController.isRegisterPassowrdCorrect.value? Container():  Text(authenticationController.registerPasswordValidationText.value,style: const TextStyle(color: Colors.red),),
                  const SizedBox(
                    height: 30,
                  ),
                   RaisedButton(
                  onPressed: () { 
                    authenticationController.deleteuser(widget.email);
                  },
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration:  const BoxDecoration(
              gradient:  LinearGradient(
            colors: [
                  Color.fromARGB(255, 255, 92, 92),
                  Color.fromARGB(255, 244, 21, 21),
            ],
          ),
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
            ),
            child: Container(
              constraints: const BoxConstraints(minWidth: 120.0, minHeight: 50.0), // min sizes for Material buttons
              alignment: Alignment.center,
              child:  Text(
          'Delete my account',
          textAlign: TextAlign.center,
          style: kloginTextstyle2,
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}