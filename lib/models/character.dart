import 'package:cloud_firestore/cloud_firestore.dart';

class Character {
  final int id;
  final String description;
  final String head;
  final String body;
  final String foot;

  Character({
    required this.id,
    required this.description,
    required this.head,
    required this.body,
    required this.foot,
  });

  factory Character.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Character(
      id: doc['id'],
      description: data['description'],
      head: data['head'],
      body: data['body'],
      foot: data['foot'],
    );
  }
}
