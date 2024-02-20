import 'package:cloud_firestore/cloud_firestore.dart';

class UserCharacter {
  final String id;
  final List<String> chars;

  UserCharacter({
    required this.id,
    required this.chars,
  });

  factory UserCharacter.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserCharacter(id: doc.id, chars: data['chars']);
  }
}
