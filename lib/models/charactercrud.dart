import 'package:cloud_firestore/cloud_firestore.dart';
import 'character.dart';

class Firestore {
    List<Character> character = [];
    final db = FirebaseFirestore.instance;

    Future<void> create(
        String description,
        String head,
        String body,
        String foot,
    ) async {
        final characterInfo = <String, dynamic>{
            'description': description,
            'head': head,
            'body': body,
            'foot': foot,
        };

        db.collection("character").add(characterInfo).then((DocumentReference doc) => print("Added Data with ID: ${doc.id}"));
    }

    Future<void> read() async {
        final event = await db.collection("character").get();
        final docs = event.docs;
        final _character = docs.map((doc) => Character.fromFirestore(doc)).toList();
        this.character = _character;
    }

    Future<void> delete(String id) async {
        await db.collection("character").doc(id).delete();
    }
    
}
