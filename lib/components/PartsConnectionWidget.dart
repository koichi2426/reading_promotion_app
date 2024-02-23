import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import '../models/genreCounter.dart';
import '../imageCreate/PersistenceService.dart';

class PartsConnectionWidget extends StatelessWidget {
  final List<String> genres;

  PartsConnectionWidget({required this.genres});

  @override
  Widget build(BuildContext context) {
    final genreCounter = Provider.of<GenreCounter>(context);
    return FutureBuilder<List<String>>(
      future: getImageUrls(context),
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
  Future<List<String>> getImageUrls(BuildContext context) async {
    final genreCounter = Provider.of<GenreCounter>(context);
    int count = Provider.of<GenreCounter>(context).count;

    try {
      // Firebase Storageのリファレンスを取得する
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref();

      String downloadUrl_Head =
          await storageRef.child('parts/${genres[0]}_0.png').getDownloadURL();

      String downloadUrl_body =
          await storageRef.child('parts/${genres[1]}_1.png').getDownloadURL();

      String downloadUrl_foot =
          await storageRef.child('parts/${genres[2]}_2.png').getDownloadURL();

      debugPrint("genreCounter: $count");

      if (count == 1) {
        await PersistenceService().saveGenres(downloadUrl_Head, count);
      } else if (count == 2) {
        await PersistenceService().saveGenres(downloadUrl_body, count);
      } else if (count == 3) {
        genreCounter.reset();
        await PersistenceService().saveGenres(downloadUrl_foot, count);
      }

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
