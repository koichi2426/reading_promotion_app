import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// ジャンルごとの調整情報を格納するクラス
class GenreAdjustment {
  final Alignment headAlignment;
  final Alignment bodyAlignment;
  final Alignment legAlignment;
  final double headPartSize;
  final double bodyPartSize;
  final double legPartSize;

  GenreAdjustment({
    required this.headAlignment,
    required this.bodyAlignment,
    required this.legAlignment,
    required this.headPartSize,
    required this.bodyPartSize,
    required this.legPartSize,
  });
}

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath;
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;
  final Alignment headAlignment;
  final Alignment bodyAlignment;
  final Alignment legAlignment;
  final double headPartSize;
  final double bodyPartSize;
  final double legPartSize;

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath,
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
    this.headAlignment = const Alignment(0, -0),
    this.bodyAlignment = const Alignment(0, 0),
    this.legAlignment = const Alignment(0, 0),
    this.headPartSize = 0,
    this.bodyPartSize = 0,
    this.legPartSize = 0,
  }) : super(key: key);

  
  Future<GenreAdjustment> getGenreAdjustment({
  required String headImagePath,
  required String bodyImagePath,
  required String legImagePath,
  }) async {
    // 調整データを一度だけ読み込む
    Map<String, dynamic> adjustmentData = await loadAdjustmentData();

    // 頭部のジャンルに基づく調整データを取得
    String headGenre = extractGenre(headImagePath);
    Map<String, dynamic> headGenreData = adjustmentData['genres'][headGenre];

    // 体部のジャンルに基づく調整データを取得
    String bodyGenre = extractGenre(bodyImagePath);
    Map<String, dynamic> bodyGenreData = adjustmentData['genres'][bodyGenre];

    // 脚部のジャンルに基づく調整データを取得
    String legGenre = extractGenre(legImagePath);
    Map<String, dynamic> legGenreData = adjustmentData['genres'][legGenre];

    // 各パーツの配置とサイズを取得してGenreAdjustmentオブジェクトを作成
    return GenreAdjustment(
      headAlignment: Alignment(
        headGenreData['headAlignment']['x'],
        headGenreData['headAlignment']['y'],
      ),
      bodyAlignment: Alignment(
        bodyGenreData['bodyAlignment']['x'],
        bodyGenreData['bodyAlignment']['y'],
      ),
      legAlignment: Alignment(
        legGenreData['legAlignment']['x'],
        legGenreData['legAlignment']['y'],
      ),
      headPartSize: headGenreData['headPartSize'],
      bodyPartSize: bodyGenreData['bodyPartSize'],
      legPartSize: legGenreData['legPartSize'],
    );
  }

  Future<Map<String, dynamic>> loadAdjustmentData() async {
  String jsonString = await rootBundle.loadString('assets/parts_adjustment.json');
  return json.decode(jsonString);
}

  String extractGenre(String imagePath) {
    // パスをスラッシュ('/')で分割し、最後の要素を取得
    List<String> parts = imagePath.split('/');
    String fileName = parts.last;

    // ファイル名をアンダースコア('_')で分割し、最初の部分を返す
    List<String> fileNameParts = fileName.split('_');
    if (fileNameParts.isNotEmpty) {
      return fileNameParts.first;
    } else {
      // アンダースコアで分割できなかった場合は空文字列を返す
      return '';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GenreAdjustment>(
      future: getGenreAdjustment(
        headImagePath: headPartImagePath,
        bodyImagePath: bodyPartImagePath,
        legImagePath: legPartImagePath,
      ),
      builder: (BuildContext context, AsyncSnapshot<GenreAdjustment> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final genreAdjustment = snapshot.data!;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final maxWidth = constraints.maxWidth;
              final maxHeight = constraints.maxHeight;
              final stackSize = maxWidth <= maxHeight ? maxWidth : maxHeight;

              print('Stack Size: width=$stackSize, height=$stackSize');

              List<Widget> stackChildren = [
                Image.asset(
                  characterImagePath,
                  width: stackSize,
                  height: stackSize,
                ),
              ];

              if (headPartImagePath != 'null') {
                stackChildren.add(
                  Positioned(
                    left: stackSize * (0.5 + genreAdjustment.headAlignment.x) - stackSize / 2,
                    top: stackSize * (0.5 + genreAdjustment.headAlignment.y) - stackSize / 2,
                    child: Image.asset(
                      headPartImagePath!,
                      width: stackSize * genreAdjustment.headPartSize,
                      height: stackSize * genreAdjustment.headPartSize,
                    ),
                  ),
                );
              }

              if (bodyPartImagePath != 'null') {
                stackChildren.add(
                  Positioned(
                    left: stackSize * (0.5 + genreAdjustment.bodyAlignment.x) - stackSize / 2,
                    top: stackSize * (0.5 + genreAdjustment.bodyAlignment.y) - stackSize / 2,
                    child: Image.asset(
                      bodyPartImagePath!,
                      width: stackSize * genreAdjustment.bodyPartSize,
                      height: stackSize * genreAdjustment.bodyPartSize,
                    ),
                  ),
                );
              }

              if (legPartImagePath != 'null') {
                stackChildren.add(
                  Positioned(
                    left: stackSize * (0.5 + genreAdjustment.legAlignment.x) - stackSize / 2,
                    top: stackSize * (0.5 + genreAdjustment.legAlignment.y) - stackSize / 2,
                    child: Image.asset(
                      legPartImagePath!,
                      width: stackSize * genreAdjustment.legPartSize,
                      height: stackSize * genreAdjustment.legPartSize,
                    ),
                  ),
                );
              }

              return Stack(
                alignment: Alignment.center,
                children: stackChildren,
              );
            },
          );
        }
      },
    );
  }

}
