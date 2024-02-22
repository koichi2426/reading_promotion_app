import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String author;
  final String description;
  final String genre;
  final String imageUrl;
  final String publishedDate;
  final String title;

  Book({
    required this.author,
    required this.description,
    required this.genre,
    required this.imageUrl,
    required this.publishedDate,
    required this.title,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book(author: data['author'],description: data['description'], genre: data['genre'],imageUrl: data['imageUrl'],publishedDate: data['publishedDate'],title: data['title']);
  }
}
