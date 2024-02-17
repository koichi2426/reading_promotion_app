import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
    final int id;
    final String title;
    final int categoryId;

    Book({
        required this.id,
        required this.title,
        required this.categorieId,
    });

    factory Book.fromFirestore(DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Book(
            id: doc.id,
            title: data.fromMap(data['title']),
            categorieId: data.fromMap(data['categorieID']),
        );
    }
}
