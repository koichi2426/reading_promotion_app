import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryBook {
  final int categoryId;
  final int bookId;

  CategoryBook({
    required this.categoryId,
    required this.bookId,
  });

  factory CategoryBook.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return CategoryBook(categoryId: data['categoryId'], bookId: data['bookId']);
  }
}
