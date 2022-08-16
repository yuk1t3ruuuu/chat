import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:f_test/post.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key }) : super(key: key);
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool alreadySignedUp = false;


  void handleSignUp()async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text
      );
    }on FirebaseAuthException catch(e){
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('既に使用されているメールアドレスです'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));

      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('パスワードは最低でも６文字必要です'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));

      }else if(e.code=='invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('メールアドレスが正しくありません'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
    }
  }


  void handleSignIn()async{
    try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text
      );
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('登録されていないメールアドレスです'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));

      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('パスワードが違います'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));

      }else if(e.code=='invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('メールアドレスが正しくありません'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(
                child:
                Container(
                  alignment: Alignment.center,
                  width: 500,
                  padding: EdgeInsets.only(top: 100),
                  child:
                  TextField(
                    controller: emailEditingController,
                    decoration: const InputDecoration(labelText: 'メールアドレス', border: OutlineInputBorder()),
                  ),
                )
              ),
             Expanded(
                child:
                Container(
                  padding: EdgeInsets.only(top: 30),
                  width: 500,
                  child:
                    TextField(
                      obscureText: true,
                      controller: passwordEditingController,
                      decoration: const InputDecoration(labelText: 'パスワード', border: OutlineInputBorder()),
                    ),
                )
             ),
            alreadySignedUp?ElevatedButton(
                      onPressed: () {
                        handleSignIn();
                      },
                      child: const Text('サインイン', style: TextStyle(color: Colors.white),),
                      style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                      )
                : ElevatedButton(
                      onPressed: () {
                      handleSignUp();
                      },
                      child: const Text('ユーザー登録', style: TextStyle(color: Colors.white),),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                      ),
            const SizedBox(
                    height: 200,
                  ),
            Container(
              padding: EdgeInsets.only(bottom: 100),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      alreadySignedUp = !alreadySignedUp;
                    });
                  },
                  child: Text(alreadySignedUp ? '新しくアカウントを作成' : '既にアカウントをお持ちですか？',
                    style: const TextStyle(color: Colors.grey, decoration: TextDecoration.underline,),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}