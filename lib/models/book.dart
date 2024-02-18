import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String title;
  final String writer;

  Book({
    required this.title,
    required this.writer,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book(title: data['title'], writer: data['writer']);
  }
}
