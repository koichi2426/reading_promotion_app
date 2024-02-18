import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Category(
      id: data['id'],
      name: data['name'],
    );
  }
}
