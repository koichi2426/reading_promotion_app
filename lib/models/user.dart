import 'package:cloud_firestore/cloud_firestore.dart';

class User{
    final int id;
    final Book book;
    final Character charcter;

    User({
        required this.id,
        required this.books,
        required this.characters,
    });

    factory User.fromFirestore(DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return User(
            id: doc.id,
            book: Book.fromMap(data['book']),
            character: Character.fromMap(data['character']),
        );
    }
}
