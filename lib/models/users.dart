import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String name;
  final List<Books> books;
  final List<Characters> characters;

  Users({
    required this.id,
    required this.name,
    required this.books,
    required this.characters,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Users(
      id: doc.id,
      name: data['name'],
      books: (data['books'] as List)
          .map((book) => Books.fromFirestore(book))
          .toList(),
      characters: (data['characters'] as List)
          .map((character) => Characters.fromFirestore(character))
          .toList(),
    );
  }
}

class Books {
  final String id;
  final String title;
  final String author;
  final String genre;

  Books({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
  });

  factory Books.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Books(
      id: doc.id,
      title: data['title'],
      author: data['author'],
      genre: data['genre'],
    );
  }
}

class Characters {
  final String id;
  final Map<String, String> genre;
  final String imageUrl;

  Characters({
    required this.id,
    required this.genre,
    required this.imageUrl,
  });

  factory Characters.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    Map<String, String> genreData = {
      'first': data['genre']['first'] as String,
      'second': data['genre']['second'] as String,
      'third': data['genre']['third'] as String,
    };
    return Characters(
      id: doc.id,
      genre: genreData,
      imageUrl: data['imageUrl'],
    );
  }
}
