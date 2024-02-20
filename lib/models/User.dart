import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.token,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(id: doc.id, name: data['name'], token: data['token']);
  }
}
