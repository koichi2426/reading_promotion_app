import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(id: doc.id, name: data['name']);
  }
}
