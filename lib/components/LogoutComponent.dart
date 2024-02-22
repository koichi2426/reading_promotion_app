import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutComponent extends StatelessWidget {
  const LogoutComponent({Key? key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        // ログアウト処理
        print('Logout!!');
        await FirebaseAuth.instance.signOut();
      },
      icon: Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
      label: Text(''),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        minimumSize: Size(0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
