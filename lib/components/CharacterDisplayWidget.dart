import 'package:flutter/material.dart';

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath; // キャラクターの基本画像パス
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;
  final double headPositionX; // 頭部のX座標位置
  final double headPositionY; // 頭部のY座標位置
  final double headWidth; // 頭部の幅
  final double headHeight; // 頭部の高さ
  final double bodyPositionX; // 胴体のX座標位置
  final double bodyPositionY; // 胴体のY座標位置
  final double bodyWidth; // 胴体の幅
  final double bodyHeight; // 胴体の高さ
  final double legPositionX; // 足部のX座標位置
  final double legPositionY; // 足部のY座標位置
  final double legWidth; // 足部の幅
  final double legHeight; // 足部の高さ

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath,
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
    this.headPositionX = 0,
    this.headPositionY = 0,
    this.headWidth = 500, // デフォルト値を設定
    this.headHeight = 500, // デフォルト値を設定
    this.bodyPositionX = 0,
    this.bodyPositionY = 0,
    this.bodyWidth = 500, // デフォルト値を設定
    this.bodyHeight = 500, // デフォルト値を設定
    this.legPositionX = 0,
    this.legPositionY = 0,
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
              left: headPositionX,
              top: headPositionY,
              child: Image.asset(
                headPartImagePath,
                width: headWidth,
                height: headHeight,
              ),
            ),
            Positioned(
              left: bodyPositionX,
              top: bodyPositionY,
              child: Image.asset(
                bodyPartImagePath,
                width: bodyWidth,
                height: bodyHeight,
              ),
            ),
            Positioned(
              left: legPositionX,
              top: legPositionY,
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
