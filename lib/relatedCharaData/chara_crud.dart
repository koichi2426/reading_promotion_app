import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../relatedCharaData/characters.dart';
import '../relatedCharaData/genreCounter.dart';
import 'PersistenceService.dart';
import '../components/PartsConnectionWidget.dart';
import '../imageCreate/ImageBook.dart';

class Firestore {
  List<Character> characters = [];
  final db = FirebaseFirestore.instance;
  final PartsConnectionWidget partsConnectionWidget;
  ImageBook imageBook = ImageBook();

  Firestore({required this.partsConnectionWidget});
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
      await PersistenceService().saveGenres(genre, genreCounter);
      final String Firstgenres = await PersistenceService().getPrevFirstGenre();

      await db.collection('characters').doc(documentCount.toString()).update({
        'genre': {
          'first': Firstgenres,
          'second': '',
          'third': '',
        },
      });
    } else if (genreCounter.count == 2) {
      int documentCount = await getDocumentCount();
      await PersistenceService().saveGenres(genre, genreCounter);
      final String Firstgenres = await PersistenceService().getPrevFirstGenre();
      final String Secondgenres =
          await PersistenceService().getPrevSecondGenre();

      await db.collection('characters').doc(documentCount.toString()).update({
        'genre': {
          'first': Firstgenres,
          'second': Secondgenres,
          'third': '',
        },
      });
    } else if (genreCounter.count == 3) {
      genreCounter.reset();
      int documentCount = await getDocumentCount();
      final String Firstgenres = await PersistenceService().getPrevFirstGenre();
      final String Secondgenres =
          await PersistenceService().getPrevSecondGenre();
      await db.collection('characters').doc(documentCount.toString()).update({
        'genre': {
          'first': Firstgenres,
          'second': Secondgenres,
          'third': genre,
        },
      });
      /*
      await Future.delayed(Duration(seconds: 2));
      List<String> imageUrls = await partsConnectionWidget.getImageUrls();

      debugPrint(imageUrls[1]);

      String CharaImageUrl =
          await imageBook.uploadLocalImageToFirestore(imageUrls);

      debugPrint(CharaImageUrl);

      await db.collection('characters').doc(documentCount.toString()).update({
        'imageUrl': CharaImageUrl,
      });
      */
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
    final String newDocumentId = (documentCount + 1).toString();

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
    final event = await db.collection("characters").get();
    final List<Character> _characters =
        event.docs.map((doc) => Character.fromFirestore(doc)).toList();
    characters = _characters;
  }

  Future<void> delete(String id) async {
    await db.collection('characters').doc(id).delete();
  }
}
