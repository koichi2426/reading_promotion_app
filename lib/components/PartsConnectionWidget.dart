import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../relatedCharaData/genreCounter.dart';
import '../imageCreate/imageBook.dart';

class PartsConnectionWidget extends StatelessWidget {
  final List<String> genres;

  PartsConnectionWidget({required this.genres});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<String>>(
      future: getImageUrls(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // データ取得中はローディングを表示
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // エラーが発生した場合はエラーメッセージを表示
        }
        // 画像URLが取得できた場合は、それらの画像を表示
        return Column(
          children: snapshot.data!.map((imageUrl) {
            return Container(
              margin: EdgeInsets.all(0),
              child: Image.network(imageUrl),
            );
          }).toList(),
        );
      },
    );
  }

  // Firebase Storageから画像URLを取得する非同期関数
  Future<List<String>> getImageUrls() async {
    try {
      // Firebase Storageのリファレンスを取得する
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref();

      // 画像のURLを取得する
      String downloadUrl_Head =
          await storageRef.child('parts/${genres[0]}_0.png').getDownloadURL();

      String downloadUrl_body =
          await storageRef.child('parts/${genres[1]}_1.png').getDownloadURL();

      String downloadUrl_foot =
          await storageRef.child('parts/${genres[2]}_2.png').getDownloadURL();


      // 画像URLをリストに追加して返す
      return [
        downloadUrl_Head,
        downloadUrl_body,
        downloadUrl_foot,
      ];
    } catch (e) {
      // エラーが発生した場合は、エラーメッセージを表示し、空のリストを返す
      print('Error fetching image URLs: $e');
      return [];
    }
  }
}
