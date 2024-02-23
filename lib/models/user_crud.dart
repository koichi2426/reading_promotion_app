import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'users.dart';
import 'PersistenceService.dart' as GenreCount;
import 'genreCounter.dart';
import '../imageCreate/PersistenceService.dart' as getImageUrl;
import '../components/PartsConnectionWidget.dart';
import '../imageCreate/charCreate.dart';

class Firestore {
  List<Users> users = [];
  final db = FirebaseFirestore.instance;

  Future<void> userCreate(String userid, String userName) async {
    CollectionReference usersRef = db.collection('users');

    int documentCount = await getDocumentCount();

    // users コレクションが存在しない場合は、新しいコレクションを作成
    if (documentCount == 0) {
      await userDataCreate();
    }

    await usersRef.doc(userid).set({
      'name': userName,
      'uid': userid,
      'books': {},
      'characters': {},
    });
  }

  Future<void> userDataCreate() async {
    final int documentCount = await getDocumentCount();

    // 新しいIDを生成
    final String newDocumentId = (documentCount + 1).toString().padLeft(2, '0');

    await db.collection("users").doc(newDocumentId).set({
      'name': 'User',
      'books': {},
      'characters': {},
    });
  }

  Future<int> getDocumentCount() async {
    try {
      final snapshot = await db.collection("users").get();
      return snapshot.size;
    } catch (error) {
      return 0;
    }
  }
}

class BookCrud {
  List<Books> books = [];
  final db = FirebaseFirestore.instance;
  late String userDocId;

  Future<String?> getUserDocId(String uid) async {
    try {
      final QuerySnapshot querySnapshot = await db.collection('users').get();
      final List<DocumentSnapshot> userDocs = querySnapshot.docs.where((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return uid == data['uid'];
      }).toList();

      if (userDocs.isNotEmpty) {
        return userDocs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      print('error in user_crud getUDI: $e');
      throw Exception('error in user_crud getUDI: $e');
    }
  }

  Future<void> createBook(
    String uid,
    String title,
    String author,
    String genre,
    String imageUrl,
    String publishedDate,
    String description,
  ) async {
    final bookInfo = <String, dynamic>{
      'title': title,
      'author': author,
      'genre': genre,
      'publishedDate': publishedDate,
      'description': description,
      'imageUrl': imageUrl,
    };

    userDocId = await getUserDocId(uid) ?? '';

    if (userDocId != null) {
      await db
          .collection("users")
          .doc(userDocId)
          .collection("books")
          .add(bookInfo)
          .then((DocumentReference doc) =>
              print("Added Data with ID: ${doc.id}"));
    }
  }

  Future<void> getBooks(String uid) async {
    try {
      userDocId = await getUserDocId(uid) ?? '';
      if (userDocId != null && userDocId.isNotEmpty) {
        final QuerySnapshot event = await db
            .collection("users")
            .doc(userDocId)
            .collection("books")
            .get();
        final List<Books> _books =
            event.docs.map((doc) => Books.fromFirestore(doc)).toList();
        this.books = _books;
      } else {
        print('User document ID is null or empty');
      }
    } catch (e) {
      print('Error reading books: $e');
      throw Exception('Failed to read books');
    }
  }
}

class CharacterCrud {
  List<Characters> characters = [];
  final db = FirebaseFirestore.instance;
  late String userDocId;

  charCreate imageBook = charCreate();

  Future<String?> getUserDocId(String uid) async {
    try {
      final QuerySnapshot querySnapshot = await db.collection('users').get();
      final List<DocumentSnapshot> userDocs = querySnapshot.docs.where((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return uid == data['uid'];
      }).toList();

      if (userDocs.isNotEmpty) {
        return userDocs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      print('error in user_crud getUDI: $e');
      throw Exception('error in user_crud getUDI: $e');
    }
  }

  Future<void> genreUpdate(
      String uid, String genre, GenreCounter genreCounter) async {
    try {
      userDocId = await getUserDocId(uid) ?? '';

      CollectionReference charRef =
          db.collection("users").doc(userDocId).collection("characters");
      int documentCount = await getDocumentCount(uid);

      if (documentCount == 0) {
        await charDataCreate(userDocId);
      }

      if (genreCounter.count == 1) {
        documentCount = await getDocumentCount(uid);
        await GenreCount.PersistenceService().saveGenres(genre, genreCounter);
        final String Firstgenres =
            await GenreCount.PersistenceService().getPrevFirstGenre();

        await db
            .collection('users')
            .doc(userDocId)
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
        int documentCount = await getDocumentCount(uid);
        await GenreCount.PersistenceService().saveGenres(genre, genreCounter);
        final String Firstgenres =
            await GenreCount.PersistenceService().getPrevFirstGenre();
        final String Secondgenres =
            await GenreCount.PersistenceService().getPrevSecondGenre();

        await db
            .collection('users')
            .doc(userDocId)
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
        int documentCount = await getDocumentCount(uid);
        final String Firstgenres =
            await GenreCount.PersistenceService().getPrevFirstGenre();
        final String Secondgenres =
            await GenreCount.PersistenceService().getPrevSecondGenre();
        await db
            .collection('users')
            .doc(userDocId)
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
            .collection('users')
            .doc(userDocId)
            .collection('characters')
            .doc((documentCount).toString().padLeft(2, '0'))
            .update({
          'imageUrl': CharaImageUrl,
        });

        await charDataCreate(uid);
      }
    } catch (e) {
      print('Error in genreUpdate: $e');
    }
  }

  Future<void> charDataCreate(String uid) async {
    String userDocId = await getUserDocId(uid) ?? '';
    final Map<String, dynamic> characterInfo = {
      'genre': {
        'first': '',
        'second': '',
        'third': '',
      },
      'imageUrl': 'imageUrl',
    };

    // ドキュメント合計数を取得
    final int documentCount = await getDocumentCount(uid);

    // 新しいIDを生成
    final String newDocumentId = (documentCount + 1).toString().padLeft(2, '0');

    // 新しいIDでドキュメントを追加
    await db
        .collection('users')
        .doc(userDocId)
        .collection('characters')
        .doc(newDocumentId)
        .set(characterInfo);
  }

  Future<int> getDocumentCount(String uid) async {
    String userDocId = await getUserDocId(uid) ?? '';
    try {
      final snapshot = await db
          .collection('users')
          .doc(userDocId)
          .collection("characters")
          .get();
      return snapshot.size;
    } catch (error) {
      // コレクションがまだ存在しない場合はサイズが0として返す
      return 0;
    }
  }

  Future<void> getCharacters(String uid) async {
    String userDocId = await getUserDocId(uid) ?? '';
    final latestDocumentSnapshot = await db
        .collection('users')
        .doc(userDocId)
        .collection("characters")
        .orderBy(FieldPath.documentId, descending: true)
        .limit(1)
        .get();

    if (latestDocumentSnapshot.docs.isNotEmpty) {
      final latestDocId = latestDocumentSnapshot.docs.first.id;
      final latestDocNumber = int.parse(latestDocId);

      final event = await db
          .collection('users')
          .doc(userDocId)
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

  Future<void> delete(String uid, String id) async {
    String userDocId = await getUserDocId(uid) ?? '';
    await db
        .collection('users')
        .doc(userDocId)
        .collection('characters')
        .doc(id)
        .delete();
  }
}
