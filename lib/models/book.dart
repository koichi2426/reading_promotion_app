import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
    final String id;
    final String title;
    final int categoryId;

    Book({
        required this.id,
        required this.title,
        required this.categoryId,
    });

    factory Book.fromFirestore(DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Book(
            id: doc.id,
            title: data.fromMap(data['title']),
            categoryId: data.fromMap(data['categorieID']),
        );
    }
}
