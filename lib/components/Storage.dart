import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageWidget extends StatefulWidget {
  @override
  _StorageWidgetState createState() => _StorageWidgetState();
}

class _StorageWidgetState extends State<StorageWidget> {
  final String imagePath = 'gs://coriander-app-f5b22.appspot.com/parts'; // Storage内の画像のパス

  FirebaseStorage _storage = FirebaseStorage.instance;
  late Image image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    // Storageから画像をダウンロード
    Reference ref = _storage.ref().child(imagePath);
    final String url = await ref.getDownloadURL();

    // ダウンロードした画像を表示するImageウィジェットを作成
    setState(() {
      image = Image.network(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage Image Example'),
      ),
      body: Center(
        child: image == null ? CircularProgressIndicator() : image,
      ),
    );
  }
}
