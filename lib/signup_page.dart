import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_realauth/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;
   const SignUpPage({
    Key? key,
    required this.onClickedSignIn}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Auth"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) => email != null && !EmailValidator.validate(email)
                ? "Enter a valid Email" : null,
              ),
              const SizedBox(height: 4,),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Password'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? "Enter minimum 6 digit" : null,
              ),
              const SizedBox(height: 4,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: signUp,
                icon: Icon(Icons.lock,
                  size: 32,
                ),
                label: Text('SignUp',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),

              SizedBox(height: 10,),
              RichText(text: TextSpan(
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                  text: "There's already an account?   ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: "LoginIn",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),

                    )
                  ]
              )),

            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e){
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKeyz.currentState!.popUntil((route) => route.isCurrent);
  }
}
