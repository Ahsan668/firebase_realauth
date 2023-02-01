import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_realauth/home_page.dart';
import 'package:firebase_realauth/utils.dart';
import 'package:firebase_realauth/verify_email_page.dart';
import 'package:flutter/material.dart';

import 'authpage.dart';
import 'login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorKeyz = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
 static final title = "Setup Firebase";
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKeyz,
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text("Something Went Wrong!"),);
          }
          else if(snapshot.hasData){
            return VerifyEmailPage();
          }
          else{
                return AuthPage();
          }
          }
          ),
    );
  }
}


