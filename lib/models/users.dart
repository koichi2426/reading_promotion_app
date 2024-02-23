import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String name;
  final Books books;
  final Chars charactors;

  Users({
    required this.id,
    required this.name,
    required this.books,
    required this.charactors,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final booksdata = Books.fromFirestore(doc);
    final charactersdata = Chars.fromFirestore(doc);
    return Users(
      id: doc.id,
      name: data['name'],
      books: booksdata,
      charactors: charactersdata,
    );
  }
}

class Books {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String publishedDate;
  final String description;
  final String imageUrl;

  Books({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.publishedDate,
    required this.description,
    required this.imageUrl,
  });

  factory Books.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Books(
      id: data['id'],
      title: data['title'],
      author: data['author'],
      genre: data['genre'],
      publishedDate: data['publishedDate'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }
}

class Chars {
  final String id;
  final Map<String, String> genre;
  final String imageUrl;

  Chars({
    required this.id,
    required this.genre,
    required this.imageUrl,
  });

  factory Chars.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    Map<String, String> genreData = {
      'first': data['genre']['first'] as String,
      'second': data['genre']['second'] as String,
      'third': data['genre']['third'] as String,
    };
    return Chars(
      id: data['id'],
      genre: genreData,
      imageUrl: data['imageUrl'],
    );
  }
}
