import 'package:cloud_firestore/cloud_firestore.dart';
import 'book.dart';
import 'character.dart';
import 'user.dart';

class Firestore {
  List<User> user = [];
  final db = FirebaseFirestore.instance;

  Future<void> create(
    Book book,
    Character character,
  ) async {
    final userInfo = <String, dynamic>{
      'book': book,
      'character': character,
    };

    db.collection("user").add(userInfo).then(
        (DocumentReference doc) => print("Added Data with ID: ${doc.id}"));
  }

  Future<void> read() async {
    final event = await db.collection("user").get();
    final docs = event.docs;
    final _user = docs.map((doc) => User.fromFirestore(doc)).toList();
    this.user = _user;
  }

  Future<void> delete(String id) async {
    await db.collection("user").doc(id).delete();
  }
}
