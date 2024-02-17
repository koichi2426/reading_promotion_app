import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final int id;
  final Book book;
  final Character character;

  User({
    required this.id,
    required this.book,
    required this.character,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: data['id'],
      book: data['book'],
      character: data['character'],
    );
  }
}
