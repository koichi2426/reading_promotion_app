import 'package:cloud_firestore/cloud_firestore.dart';

class UserBook {
  final String id;
  final List<String> books;

  UserBook({
    required this.id,
    required this.books,
  });

  factory UserBook.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserBook(id: doc.id, books: data['books']);
  }
}
