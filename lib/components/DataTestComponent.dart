import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_promotion_app/models/book.dart';
import 'package:reading_promotion_app/models/categorybook.dart';
import 'package:reading_promotion_app/models/category.dart';

class DataTestComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //button create
    return ElevatedButton(
      onPressed: () {
        //call function
        _printFirestoreData();
      },
      child: Text('Print Firestore Data'),
    );
  }

  //function called by build child
  Future<void> _printFirestoreData() async {
    try {
      //categorybookの取得
      CollectionReference ref =
          FirebaseFirestore.instance.collection('CategoryBook');
      QuerySnapshot qsnap = await ref.get();

      qsnap.docs.forEach((element) {
        //データの一覧表示
        print(element.data());
      });
      if (qsnap.docs.isEmpty) {
        print("empty catch");
      }

      //データからdocumentの名前を取得 (Stringリスト型)
      List<String> docname = qsnap.docs.map((doc) => doc.id).toList();
      print(docname);

      //取得したdocument nameから関連DBのようにデータ呼び出し
      CollectionReference ref2 =
          FirebaseFirestore.instance.collection('Category');
      docname.forEach((dname) async {
        var datas = await ref2.doc(dname).get();
        print(datas.data());
      });
    } catch (e) {
      print('Error data: $e');
    }
  }
}
