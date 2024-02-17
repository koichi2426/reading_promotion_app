import 'package:cloud_firestore/cloud_firestore.dart';

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
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      genre: data['genre'] ?? '',
      publishedDate: data['publishedDate'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
