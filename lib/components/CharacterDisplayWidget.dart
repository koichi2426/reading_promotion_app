import 'package:flutter/material.dart';

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath; // キャラクターの基本画像パス
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;
  final double headPositionX; // 頭部のX座標位置
  final double headPositionY; // 頭部のY座標位置
  final double bodyPositionX; // 胴体のX座標位置
  final double bodyPositionY; // 胴体のY座標位置
  final double legPositionX; // 足部のX座標位置
  final double legPositionY; // 足部のY座標位置

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath,
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
    this.headPositionX = 0,
    this.headPositionY = 0,
    this.bodyPositionX = 0,
    this.bodyPositionY = 0,
    this.legPositionX = 0,
    this.legPositionY = 0,
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
            Image.asset(characterImagePath),
            Positioned(
              left: headPositionX,
              top: headPositionY,
              child: Image.asset(headPartImagePath),
            ),
            Positioned(
              left: bodyPositionX,
              top: bodyPositionY,
              child: Image.asset(bodyPartImagePath),
            ),
            Positioned(
              left: legPositionX,
              top: legPositionY,
              child: Image.asset(legPartImagePath),
            ),
          ],
        );
      },
    );
  }
}
