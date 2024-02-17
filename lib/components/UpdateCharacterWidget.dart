import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          return Column(
            children: <Widget>[
              Text('ジャンル: ${data['genre']['first']}, ${data['genre']['second']}, ${data['genre']['third']}'),
              // 他のデータを表示するためのウィジェットを追加します
            ],
          );
        } else {
          return Text('キャラクターが見つかりませんでした');
        }
      },
    );
  }
}
