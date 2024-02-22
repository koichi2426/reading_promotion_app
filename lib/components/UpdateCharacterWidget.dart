import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_promotion_app/components/CharacterComponent.dart';

class UpdateCharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('characters').snapshots(), // クエリの結果をストリームで受け取る
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('エラーが発生しました');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        
        if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
          // 最後のドキュメントを取得
          DocumentSnapshot document = snapshot.data!.docs.last;
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          return CharacterComponent(
            key: UniqueKey(),
            genre1:data['genre']['first'],
            genre2:data['genre']['second'],
            genre3:data['genre']['third']
          );
        } else {
          return Text('キャラクターが見つかりませんでした');
        }
      },
    );
  }
}

