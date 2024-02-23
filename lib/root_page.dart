import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('user not logined');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // エラーの出ていた処理
        Navigator.pushReplacementNamed(context, "/login");
      });
    } else {
      print('user already login');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // エラーの出ていた処理
        Navigator.pushReplacementNamed(context, "/home");
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
