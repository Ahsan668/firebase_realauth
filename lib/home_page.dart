import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import'package:firebase_auth/firebase_auth.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key,})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HomePage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              Text("Signed In as",
              style: TextStyle(fontSize: 32),
              ),
              SizedBox(height: 10,),
              Text(user!.email!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 10,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.lock,
                  size: 32,
                ),
                label: Text('SignOut',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
    ),
    );


  }
}
