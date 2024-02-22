import 'package:cloud_firestore/cloud_firestore.dart';

class character {
  final Map<String, String> genre;
  final String imageUrl;

  character({
    required this.genre,
    required this.imageUrl,
  });

  factory character.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    Map<String, String> genreData = {
      'first': data['genre']['first'] as String,
      'second': data['genre']['second'] as String,
      'third': data['genre']['third'] as String,
    };

    return character(
      genre: genreData,
      imageUrl: data['imageUrl'],
    );
  }
}
