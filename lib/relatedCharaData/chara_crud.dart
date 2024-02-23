import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../relatedCharaData/characters.dart';
import '../relatedCharaData/genreCounter.dart';
import 'PersistenceService.dart' as GenreCount;
import '../imageCreate/PersistenceService.dart' as getImageUrl;
import '../components/PartsConnectionWidget.dart';
import '../imageCreate/charaCreate.dart';

class Firestore {
  //List<Character> characters = [];
  final db = FirebaseFirestore.instance;

  charaCreate imageBook = charaCreate();

  // コンストラクターで PartsConnectionWidget のインスタンスを受け取る

  Future<void> genreUpdate(String genre, GenreCounter genreCounter) async {
    // characters コレクションの参照を取得
    CollectionReference charactersRef = db.collection('characters');

    // characters コレクションのドキュメント数を取得
    int documentCount = await getDocumentCount();

    // characters コレクションが存在しない場合は、新しいコレクションを作成
    if (documentCount == 0) {
      await charaDataCreate();
    }

    if (genreCounter.count == 1) {
      int documentCount = await getDocumentCount();
      await GenreCount.PersistenceService().saveGenres(genre, genreCounter);
      final String Firstgenres =
          await GenreCount.PersistenceService().getPrevFirstGenre();

      await db
          .collection('characters')
          .doc((documentCount).toString().padLeft(2, '0'))
          .update({
        'genre': {
          'first': Firstgenres,
          'second': '',
          'third': '',
        },
      });
    } else if (genreCounter.count == 2) {
      int documentCount = await getDocumentCount();
      await GenreCount.PersistenceService().saveGenres(genre, genreCounter);
      final String Firstgenres =
          await GenreCount.PersistenceService().getPrevFirstGenre();
      final String Secondgenres =
          await GenreCount.PersistenceService().getPrevSecondGenre();

      await db
          .collection('characters')
          .doc((documentCount).toString().padLeft(2, '0'))
          .update({
        'genre': {
          'first': Firstgenres,
          'second': Secondgenres,
          'third': '',
        },
      });
    } else if (genreCounter.count == 3) {
      int documentCount = await getDocumentCount();
      final String Firstgenres =
          await GenreCount.PersistenceService().getPrevFirstGenre();
      final String Secondgenres =
          await GenreCount.PersistenceService().getPrevSecondGenre();
      await db
          .collection('characters')
          .doc((documentCount).toString().padLeft(2, '0'))
          .update({
        'genre': {
          'first': Firstgenres,
          'second': Secondgenres,
          'third': genre,
        },
      });

      await Future.delayed(Duration(seconds: 1));
      List<String> imageUrls =
          await getImageUrl.PersistenceService().getPrevUrl();

      String? CharaImageUrl =
          await imageBook.uploadLocalImageToFirestore(imageUrls);

      // URLを表示
      debugPrint('Uploaded image URL: $CharaImageUrl');

      await db
          .collection('characters')
          .doc((documentCount).toString().padLeft(2, '0'))
          .update({
        'imageUrl': CharaImageUrl,
      });

      await charaDataCreate();
    }
  }

  Future<void> charaDataCreate() async {
    final Map<String, dynamic> characterInfo = {
      'genre': {
        'first': '',
        'second': '',
        'third': '',
      },
      'imageUrl': 'imageUrl',
    };

    // ドキュメント合計数を取得
    final int documentCount = await getDocumentCount();

    // 新しいIDを生成
    final String newDocumentId = (documentCount + 1).toString().padLeft(2, '0');

    // 新しいIDでドキュメントを追加
    await db.collection("characters").doc(newDocumentId).set(characterInfo);
  }

  Future<int> getDocumentCount() async {
    try {
      final snapshot = await db.collection("characters").get();
      return snapshot.size;
    } catch (error) {
      // コレクションがまだ存在しない場合はサイズが0として返す
      return 0;
    }
  }

  Future<void> read() async {
    final latestDocumentSnapshot = await db
        .collection("characters")
        .orderBy(FieldPath.documentId, descending: true)
        .limit(1)
        .get();

    if (latestDocumentSnapshot.docs.isNotEmpty) {
      final latestDocId = latestDocumentSnapshot.docs.first.id;
      final latestDocNumber = int.parse(latestDocId);

      final event = await db
          .collection("characters")
          .where(FieldPath.documentId, isLessThan: latestDocNumber.toString())
          .get();

      //final List<Character> _characters =
          //event.docs.map((doc) => Character.fromFirestore(doc)).toList();
      //characters = _characters.where((character) {
        // 最新のドキュメント以外のみを返す
      //   return character.id != latestDocId;
      // }).toList();
    } else {
      // ドキュメントが存在しない場合の処理
      print("ドキュメントが見つかりませんでした。");
    }
  }

  Future<void> delete(String id) async {
    await db.collection('characters').doc(id).delete();
  }
}
