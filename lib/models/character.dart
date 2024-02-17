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

  static Future<Character> fromReference(DocumentReference ref) async {
    // DocumentReferenceからDocumentSnapshotを取得する
    DocumentSnapshot snapshot = await ref.get();

    // DocumentSnapshotからデータを取得する
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // キャラクターオブジェクトを作成して返す
    return Character(
      id: ref.id,
      description: data['description'],
      name: data['name'],
      head: data['head'],
      body: data['body'],
      foot: data['foot'],
    );
  }
}
