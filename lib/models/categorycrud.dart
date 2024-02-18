import 'package:cloud_firestore/cloud_firestore.dart';
import 'category.dart';

class Firestore {
    List<Category> categorie = [];
    final db = FirebaseFirestore.instance;

    Future<void> create(
        String name,
    ) async {
        final categorieInfo = <String, dynamic>{
            'name': name,
        };

        db.collection("categorie").add(categorieInfo).then((DocumentReference doc) => print("Added Data with ID: ${doc.id}"));
    }
    
    Future<void> read() async {
        final event = await db.collection("categorie").get();
        final docs = event.docs;
        final _categorie = docs.map((doc) => Category.fromFirestore(doc)).toList();
        this.categorie = _categorie;
    }

    Future<void> delete(String id) async {
        await db.collection("categorie").doc(id).delete();
    }
}
