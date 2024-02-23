import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_promotion_app/components/CharacterComponent.dart';

class UpdateCharacterWidget extends StatelessWidget {
  final String userid;
  const UpdateCharacterWidget({Key? key, required this.userid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (userid.isEmpty) {
      return Text('ユーザーIDが設定されていません');
    }

    final doc = firestore.collection('users').doc('user1');
    doc.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        // UserCharacterコレクションから最新の1件のドキュメントを取得するクエリ
        final userchar = firestore
            .collection('users')
            .doc('user1')
            .collection('characters')
            .snapshots()
            .listen((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            // ドキュメントが存在する場合の処理
            var latestCharacter = querySnapshot.docs.last.data();
            print('Latest character: $latestCharacter');
          } else {
            // ドキュメントが存在しない場合の処理
            print('No character found');
          }
        });
      } else {
        print('Document does not exist on the database');
      }
    }).catchError((error) {
      print('Failed to get document: $error');
    });

    try {
      return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('users')
            .doc('user1')
            .collection('characters')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('エラーが発生しました');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final document = snapshot.data!.docs.last;
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return CharacterComponent(
                key: UniqueKey(),
                genre1: data['genre']['first'],
                genre2: data['genre']['second'],
                genre3: data['genre']['third']);
          } else {
            return Text('キャラクターが見つかりませんでした');
          }
        },
      );
    } catch (e) {
      print(e);
      return Text('エラーが発生しました $e');
    }
  }
}
