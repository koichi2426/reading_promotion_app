import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_promotion_app/components/CharacterComponent.dart';

class UpdateCharacterWidget extends StatefulWidget {
  final String userid;
  const UpdateCharacterWidget({Key? key, required this.userid})
      : super(key: key);

  @override
  _UpdateCharacterWidgetState createState() => _UpdateCharacterWidgetState();
}

class _UpdateCharacterWidgetState extends State<UpdateCharacterWidget> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String userDocId;

  @override
  void initState() {
    super.initState();
    fetchUserDocId();
  }

  void fetchUserDocId() async {
    if (widget.userid.isEmpty) {
      print('ユーザーIDが設定されていません');
      return;
    }

    final QuerySnapshot querySnapshot =
        await firestore.collection('users').get();
    final List<DocumentSnapshot> userDocs = querySnapshot.docs.where((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return widget.userid == data['uid'];
    }).toList();

    if (userDocs.isNotEmpty) {
      setState(() {
        userDocId = userDocs[0].id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userDocId.isEmpty) {
      // ユーザーIDがまだ取得されていない場合はローディングなどのウィジェットを表示
      return CircularProgressIndicator();
    } else {
      return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('users')
            .doc(userDocId)
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
    }
  }
}
