import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'users.dart';
import 'PersistenceService.dart' as GenreCount;
import '../imageCreate/PersistenceService.dart' as getImageUrl;

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
}
