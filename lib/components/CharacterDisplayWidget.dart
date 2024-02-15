import 'package:flutter/material.dart';

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath; // キャラクターの基本画像パス
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;
  final Alignment headAlignment; // 頭部の位置Alignment
  final double headWidth; // 頭部の幅
  final double headHeight; // 頭部の高さ
  final Alignment bodyAlignment; // 胴体の位置Alignment
  final double bodyWidth; // 胴体の幅
  final double bodyHeight; // 胴体の高さ
  final Alignment legAlignment; // 足部の位置Alignment
  final double legWidth; // 足部の幅
  final double legHeight; // 足部の高さ

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath,
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
    this.headAlignment = const Alignment(0.5, 0.5),
    this.headWidth = 500, // デフォルト値を設定
    this.headHeight = 500, // デフォルト値を設定
    this.bodyAlignment = const Alignment(0.5, 0.5),
    this.bodyWidth = 500, // デフォルト値を設定
    this.bodyHeight = 500, // デフォルト値を設定
    this.legAlignment = const Alignment(0.5, 0.5),
    this.legWidth = 500, // デフォルト値を設定
    this.legHeight = 500, // デフォルト値を設定
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // LayoutBuilderを使用してStackの最大サイズを取得
        final stackWidth = constraints.maxWidth;
        final stackHeight = constraints.maxHeight;

        // コンソールにStackのサイズを表示
        print('Stack Size: width=$stackWidth, height=$stackHeight');

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              characterImagePath,
              width: stackWidth, // キャラクター画像のサイズをStackのサイズに合わせる
              height: stackHeight,
            ),
            Positioned(
              left: stackWidth * headAlignment.x - headWidth / 2,
              top: stackHeight * headAlignment.y - headHeight / 2,
              child: Image.asset(
                headPartImagePath,
                width: headWidth,
                height: headHeight,
              ),
            ),
            Positioned(
              left: stackWidth * bodyAlignment.x - bodyWidth / 2,
              top: stackHeight * bodyAlignment.y - bodyHeight / 2,
              child: Image.asset(
                bodyPartImagePath,
                width: bodyWidth,
                height: bodyHeight,
              ),
            ),
            Positioned(
              left: stackWidth * legAlignment.x - legWidth / 2,
              top: stackHeight * legAlignment.y - legHeight / 2,
              child: Image.asset(
                legPartImagePath,
                width: legWidth,
                height: legHeight,
              ),
            ),
          ],
        );
      },
    );
  }
}
