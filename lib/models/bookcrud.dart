import 'package:cloud_firestore/cloud_firestore.dart';
import 'book.dart';

class Firestore {
    List<Book> book = [];
    final db = FirebaseFirestore.instance;

    Future<void> create(
        String title,
        int categoryId,
    ) async {
        final bookData = <String, dynamic> {
            'title': title,
            'categoryId': categorieId,
        };

        db.collection("book").add(bookData).then((DocumentReference doc) => print("Added Data with ID: ${doc.id}"));
    }

    Future<void> read() async {
        final event = await db.collection("book").get();
        final docs = event.docs;
        final _book = docs.map((doc) => Book.fromFirestore(doc)).toList();
        this.book = _book;
    }

    Future<void> delete(int id) async {
        await db.collection("book").doc(id).delete();
    }
}
