import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realauth/home_page.dart';
import 'package:firebase_realauth/utils.dart';
import 'package:flutter/material.dart';
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
@override
void initState(){
  super.initState();
  ////user needs to be created before
  isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  if(!isEmailVerified){
    sendVerificationEmail();

    timer =   Timer.periodic(
        Duration(seconds: 3),
            (_) =>  checkEmailVerified());
  }
}

void dispose(){
  timer?.cancel();
  super.dispose();
}

Future checkEmailVerified() async {
  // call after email verification
 await FirebaseAuth.instance.currentUser!.reload();
  setState(() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  });
  if(isEmailVerified) timer?.cancel();
}

Future sendVerificationEmail() async {
try{
  final user = FirebaseAuth.instance.currentUser!;
  await user.sendEmailVerification();

}
catch (e) {
  Utils.showSnackBar(e.toString());
}

}

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage() : Scaffold(
    appBar: AppBar(
      title: Text('Verify Email'),
    ),
  );
}
