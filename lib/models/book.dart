import 'package:cloud_firestore/cloud_firestore.dart';
import 'category.dart';

class Book {
  final int id;
  final String title;
  final String writer;
  final Category categoryId;

  Book({
    required this.id,
    required this.title,
    required this.writer,
    required this.categoryId,
  });

  static Future<Book> fromReference(DocumentReference ref) async {
    DocumentSnapshot snap = await ref.get();
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    return Book(
      id: data['id'],
      title: data['title'],
      writer: data['writer'],
      categoryId: data['categoryId'],
    );
  }
}
