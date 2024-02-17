import 'package:cloud_firestore/cloud_firestore.dart';
import 'book.dart';
import 'character.dart';
import 'user.dart';

class User{
    final String id;
    final Book book;
    final Character character;

    User({
        required this.id,
        required this.book,
        required this.character
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
