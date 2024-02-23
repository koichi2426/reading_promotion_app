import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class charCreate {
  List<String> imageUrls = [];

  Future<String?> uploadLocalImageToFirestore(List<String> imagePaths) async {
    try {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      double totalImageHeight = 0.0;
      double maxWidth = 0.0; // 画像の最大幅を追加
      final List<int> imageWidths = [];
      final List<Uint8List> imageBytes = [];

      // 画像をダウンロードしてバイトデータに変換
      for (String imageUrl in imagePaths) {
        Uint8List imageData = await _downloadImage(imageUrl);
        imageBytes.add(imageData);
        ui.Image image = await decodeImageFromList(imageData);
        imageWidths.add(image.width);
        totalImageHeight += image.height.toDouble(); // 各画像の高さを合計する
        maxWidth = maxWidth > image.width.toDouble()
            ? maxWidth
            : image.width.toDouble(); // 最大幅を更新
      }

      // トリミングする左右の余白の幅
      double leftTrim = 20.0;
      double rightTrim = 20.0;

      // キャンバスのサイズを決定
      Size canvasSize = Size(
        maxWidth, // 画像の最大幅に合わせる
        totalImageHeight, // 画像の合計高さ
      );

      // 画像をキャンバスに描画
      double offsetY = 0.0;
      for (int i = 0; i < imageBytes.length; i++) {
        Uint8List imageData = imageBytes[i];
        ui.Image image = await decodeImageFromList(imageData);

        // トリミングする範囲を計算
        Rect srcRect = Rect.fromLTRB(
          leftTrim, // 左側のトリミング幅
          0, // 上端
          image.width.toDouble() - rightTrim, // 右側のトリミング幅を適用
          image.height.toDouble(), // 下端
        );

        // 描画する範囲を計算
        Rect destRect = Rect.fromLTRB(
          0, // 左端
          offsetY, // 上端
          image.width.toDouble(), // 右端
          offsetY + image.height.toDouble(), // 下端
        );

        canvas.drawImageRect(
          image,
          srcRect,
          destRect,
          Paint(),
        );

        offsetY += image.height.toDouble(); // 次の画像の高さを加算する
      }

      // キャンバスを画像に変換
      final ui.Image combinedImage = await recorder.endRecording().toImage(
            canvasSize.width.toInt(),
            canvasSize.height.toInt(),
          );

      // ビットマップをバイトデータにエンコード
      final ByteData? byteData =
          await combinedImage.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return null; // Handle null case
      final Uint8List bytes = byteData.buffer.asUint8List();

      // Firebase Storage にアップロード
      final String filename =
          'combined_image_${DateTime.now().millisecondsSinceEpoch}.png';
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/$filename');

      await ref.putData(bytes);

      // 画像URLを取得
      final String imageUrl = await ref.getDownloadURL();

      return imageUrl; // 画像URLを返す
    } catch (e) {
      print('Error uploading combined image: $e');
      throw e; // エラーをスローする
    }
  }

  Future<Uint8List> _downloadImage(String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      return response.bodyBytes;
    } catch (e) {
      print('Error downloading image: $e');
      return Uint8List(0);
    }
  }
}
