import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return FutureBuilder<DocumentSnapshot>(
      future: firestore.collection('characters').doc('2').get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // データを取得中の場合はローディングインジケータを表示
        }

        if (snapshot.data?.exists ?? false) {
          Map<String, dynamic> data = snapshot.data?.data() as Map<String, dynamic>;
          return Column(
            children: <Widget>[
              Text('Genre: ${data['genre']['first']}, ${data['genre']['second']}, ${data['genre']['third']}'),
              // 他のウィジェットもここに追加してデータを表示
            ],
          );
        } else {
          return Text('Character not found!');
        }
      },
    );
  }
}
