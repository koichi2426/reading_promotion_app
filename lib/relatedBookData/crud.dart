import 'package:cloud_firestore/cloud_firestore.dart';
import 'books.dart';

class Firestore {
  List<Books> books = [];
  final db = FirebaseFirestore.instance;

  Future<void> create(
    String title,
    String author,
    String genre,
    String imageUrl,
    String publishedDate,
    String description,
  ) async {
    final bookInfo = <String, dynamic>{
      'title': title,
      'author': author,
      'genre': genre,
      'publishedDate': publishedDate,
      'description': description,
      'imageUrl': imageUrl,
    };

    //ランダムな文字列をidとする。
    db.collection("book").add(bookInfo).then(
        (DocumentReference doc) => print("Added Data with ID: ${doc.id}"));
  }

  Future<void> read() async {
    final event = await db.collection("book").get();
    final docs = event.docs;
    final _books = docs.map((doc) => Books.fromFirestore(doc)).toList();
    this.books = _books;
  }

  Future<void> delete(String id) async {
    await db.collection('book').doc(id).delete();
  }
}
