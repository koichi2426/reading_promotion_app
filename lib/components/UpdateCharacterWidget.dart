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

    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('UserCharacter')
          .doc(userid)
          .collection('characters')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('エラーが発生しました');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          // 最後のドキュメントを取得
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
  }
}
