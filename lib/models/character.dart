import 'package:cloud_firestore/cloud_firestore.dart';

class Character {
  final String id;
  final String name;
  final String description;
  final String head;
  final String body;
  final String foot;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.head,
    required this.body,
    required this.foot,
  });

  factory Character.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Character(
      id: doc.id,
      name: data.fromMap(data['name']),
      description: data.fromMap(data['description']),
      head: data.fromMap(data['head']),
      body: data.fromMap(data['body']),
      foot: data.fromMap(data['foot']),
    );
  }
}
