import 'package:flutter/material.dart';

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath; // キャラクターの基本画像パス
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;
  final Alignment headAlignment; // 頭部の位置Alignment
  final Alignment bodyAlignment; // 胴体の位置Alignment
  final Alignment legAlignment; // 足部の位置Alignment

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath,
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
    this.headAlignment = const Alignment(0.5, 0.5),
    this.bodyAlignment = const Alignment(0.5, 0.5),
    this.legAlignment = const Alignment(0.5, 0.5),
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
              left: stackWidth * headAlignment.x - stackWidth / 2,
              top: stackHeight * headAlignment.y - stackHeight / 2,
              child: Image.asset(
                headPartImagePath,
                width: stackWidth,
                height: stackHeight,
              ),
            ),
            Positioned(
              left: stackWidth * bodyAlignment.x - stackWidth / 2,
              top: stackHeight * bodyAlignment.y - stackHeight / 2,
              child: Image.asset(
                bodyPartImagePath,
                width: stackWidth,
                height: stackHeight,
              ),
            ),
            Positioned(
              left: stackWidth * legAlignment.x - stackWidth / 2,
              top: stackHeight * legAlignment.y - stackHeight / 2,
              child: Image.asset(
                legPartImagePath,
                width: stackWidth,
                height: stackHeight,
              ),
            ),
          ],
        );
      },
    );
  }
}
