import 'package:cloud_firestore/cloud_firestore.dart';

class Character {
  final String id;
  final Map<String, String> genre;
  final String imageUrl;

  Character({
    required this.id,
    required this.genre,
    required this.imageUrl,
  });

  factory Character.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    Map<String, String> genreData = {
      'first': data['genre']['first'] as String,
      'second': data['genre']['second'] as String,
      'third': data['genre']['third'] as String,
    };

    return Character(
      id: doc.id,
      genre: genreData,
      imageUrl: data['imageUrl'],
    );
  }
}
