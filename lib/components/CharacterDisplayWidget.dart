import 'package:flutter/material.dart';

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath; // キャラクターの基本画像パス
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;
  final Alignment headAlignment; // 頭部の位置Alignment
  final Alignment bodyAlignment; // 胴体の位置Alignment
  final Alignment legAlignment; // 足部の位置Alignment
  final double headPartSize; // 頭部のサイズ
  final double bodyPartSize; // 胴体のサイズ
  final double legPartSize; // 足部のサイズ

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath,
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
    this.headAlignment = const Alignment(0.10, -0.3),
    this.bodyAlignment = const Alignment(0.5, 0.5),
    this.legAlignment = const Alignment(0.5, 0.5),
    this.headPartSize = 0.8, // デフォルトのパーツサイズ
    this.bodyPartSize = 0.3, // デフォルトのパーツサイズ
    this.legPartSize = 0.3, // デフォルトのパーツサイズ
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
              left: stackWidth * (0.5 + headAlignment.x) - stackWidth / 2,
              top: stackHeight * (0.5 + headAlignment.y) - stackHeight / 2,
              child: Image.asset(
                headPartImagePath,
                width: stackWidth * headPartSize, // パーツのサイズを調整する
                height: stackHeight * headPartSize,
              ),
            ),
            Positioned(
              left: stackWidth * (0.5 + bodyAlignment.x) - stackWidth / 2,
              top: stackHeight * (0.5 + bodyAlignment.y) - stackHeight / 2,
              child: Image.asset(
                bodyPartImagePath,
                width: stackWidth * bodyPartSize,
                height: stackHeight * bodyPartSize,
              ),
            ),
            Positioned(
              left: stackWidth * (0.5 + legAlignment.x) - stackWidth / 2,
              top: stackHeight * (0.5 + legAlignment.y) - stackHeight / 2,
              child: Image.asset(
                legPartImagePath,
                width: stackWidth * legPartSize,
                height: stackHeight * legPartSize,
              ),
            ),
          ],
        );
      },
    );
  }
}
