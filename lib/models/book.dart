import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final int id;
  final String title;
  final String writer;
  final Category categoryId;

  Book({
    required this.id,
    required this.title,
    required this.writer,
    required this.categorieId,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book(
      id: data['id'],
      title: data['title'],
      writer: data['writer'],
      categorieId: data['categorieID'],
    );
  }
}
