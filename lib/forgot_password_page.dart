import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_realauth/main.dart';
import 'package:firebase_realauth/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key,}) : super(key: key);
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text("Receive an email to\n reset your password",
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 4,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.email_outlined,
                  size: 32,
                ),
                label: Text('Reset Password',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                onPressed: resetPassword,
              ),



            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      Utils.showSnackBar("Password reset Email sent");
      navigatorKeyz.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
