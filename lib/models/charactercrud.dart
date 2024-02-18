import 'package:cloud_firestore/cloud_firestore.dart';
import 'character.dart';

class Firestore {
  static Future<Character> fromReference(DocumentReference ref) async {
    DocumentSnapshot snapshot = await ref.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Character(
      id: data['id'],
      description: data['description'],
      head: data['head'],
      body: data['body'],
      foot: data['foot'],
    );
  }
}
