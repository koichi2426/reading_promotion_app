import 'package:cloud_firestore/cloud_firestore.dart';
import 'book.dart';
import 'character.dart';

class User {
  final String id;
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
      id: doc.id,
      book: Book.fromReference(data['book']),
      character: Character.fromReference(data['character']),
    );
  }
}
