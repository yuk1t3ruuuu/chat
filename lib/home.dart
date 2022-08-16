import 'package:flutter/material.dart';
import 'package:f_test/sign_up.dart';
import 'package:f_test/post.dart';


class Home extends StatelessWidget {
  const Home({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text('$userIdがログインしています'),
            Expanded(
                child:
                  Container(
                    width: 180,
                    padding: EdgeInsets.only(top: 130,bottom: 130),
                    child:
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return SignUp();})),
                        child: const Text('ログイン画面へ', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                           padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                      )
                    )
                  )
            ),
          Expanded(
              child:
                Container(
                    width: 180,
                    padding: EdgeInsets.only(top: 130,bottom: 130),
                    child:
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Posts();})),
                        child: const Text('チャット画面へ', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                         )
                )
          )
          ]
        ),
      ),
    );
  }
}

