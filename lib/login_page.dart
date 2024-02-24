import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'models/users.dart';
import 'models/user_crud.dart' as UserCrud;

enum FormType { login, register }

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final db = FirebaseFirestore.instance;

  String _name = '';
  String _email = '';
  String _password = '';

  UserCrud.Firestore userCrud = UserCrud.Firestore();

  Future<void> _fetchUsers(String userid, String name) async {
    await userCrud.userCreate(userid, name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              // 2行目 パスワード入力用テキストフィールド
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),

              // 4行目 ログインボタン
              ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final User? user = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password))
                        .user;
                    if (user != null) {
                      print("ログインしました ${user.email} , ${user.uid}, ${_name}");
                      Navigator.of(context).pushNamed('/home');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              // 3行目 ユーザ登録ボタン
              ElevatedButton(
                child: const Text('ユーザ登録'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final User? user = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password))
                        .user;
                    if (user != null) {
                      print("ログインしました ${user.email} , ${user.uid}, ${_name}");
                      Navigator.of(context).pushNamed('/home');
                    }
                    // ユーザ登録画面へ遷移
                    Navigator.of(context).pushNamed('/create');
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              // // 5行目 パスワードリセット登録ボタン
              // ElevatedButton(
              //     child: const Text('パスワードリセット'),
              //     onPressed: () async {
              //       try {
              //         await FirebaseAuth.instance
              //             .sendPasswordResetEmail(email: _email);
              //         print("パスワードリセット用のメールを送信しました");
              //       } catch (e) {
              //         print(e);
              //       }
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
