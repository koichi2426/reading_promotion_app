import 'package:cloud_firestore/cloud_firestore.dart';

class Character {
  final String id;
  final String head;
  final String body;
  final String hand;

  Character({
    required this.id,
    required this.head,
    required this.body,
    required this.hand,
  });

  factory Character.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Character(
        id: doc.id, head: data['head'], body: data['body'], hand: data['hand']);
  }
}
