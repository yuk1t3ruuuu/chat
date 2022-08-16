import 'package:f_test/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:f_test/sign_up.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _Auth();
}

class _Auth extends State<Auth> {
  bool _isSignedIn = false;
  String userId = '';


  void checkSignInState(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        setState(() {
          _isSignedIn = false;
        });
      } else {
        userId = user.uid;
        setState(() {
          _isSignedIn = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    checkSignInState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: _isSignedIn?Posts():const SignUp(),
    );
  }
}