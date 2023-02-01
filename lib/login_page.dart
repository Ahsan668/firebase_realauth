import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_realauth/main.dart';
import 'package:firebase_realauth/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
class LoginPage extends StatefulWidget {
final VoidCallback onClickedSignUp;
const LoginPage({
  Key? key,
  required this.onClickedSignUp}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
               const SizedBox(height: 40),
              TextField(
                controller: emailController,
              cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 4,),
              TextField(
                controller: passwordController,
                obscureText: true,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 4,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                  onPressed: signIn,
                  icon: Icon(Icons.lock,
                  size: 32,
                  ),
                  label: Text('SignIn',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  ),
              ),

              SizedBox(height: 16,),
              GestureDetector(
                child: Text(
                  "Forgot Password?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                ),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),)),
              ),
              SizedBox(height: 24,),
              RichText(text: TextSpan(
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                  text: "No account?   ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: "SignUp",
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
    );
  }

  Future signIn() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(),)
    );

    try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    );
        } on FirebaseAuthException catch (e){
    print(e);
    Utils.showSnackBar(e.message);

    }
    navigatorKeyz.currentState!.popUntil((route) => route.isFirst);
  }
}
