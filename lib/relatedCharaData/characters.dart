// import 'package:cloud_firestore/cloud_firestore.dart';

// class Character {
//   final String id;
//   final List<String> genre;
//   final String imageUrl;

//   Character({
//     required this.id,
//     required this.genre,
//     required this.imageUrl,
//   });

//   factory Character.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     final List<String> genreList = [
//       data['genre']['first'] ?? '',
//       data['genre']['second'] ?? '',
//       data['genre']['third'] ?? '',
//     ];
//     return Character(
//       id: doc.id,
//       genre: genreList,
//       imageUrl: data['imageUrl'] ?? '',
//     );
//   }
// }
