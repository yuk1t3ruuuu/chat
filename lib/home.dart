import 'package:flutter/material.dart';
import 'package:f_test/sign_up.dart';


class Home extends StatelessWidget {
  const Home({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('$userIdがログインしています'),
            Expanded(child: Container(
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return SignUp();
                          })),
                  child: const Text(
                      'ログイン画面へ', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.all(20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))
                  ),
                )
            )
            )
          ],
        ),
      ),
    );
  }
}

