import 'package:flutter/material.dart';
import 'CharacterDisplayWidget.dart'; // CharacterDisplayWidgetをインポート

class CharacterComponent extends StatelessWidget {
  final String genre1;
  final String genre2;
  final String genre3;

  final String pathToParts = 'assets/images/parts/';

  const CharacterComponent({
    required Key key,
    required this.genre1,
    required this.genre2,
    required this.genre3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CharacterDisplayWidgetを使用してキャラクターを表示
    return CharacterDisplayWidget(
      characterImagePath: 'assets/images/character.png', // キャラクターの基本画像パス
      headPartImagePath: pathToParts + genre1 + '_0.png', // 頭部パーツの画像パス
      bodyPartImagePath: pathToParts + genre2 + '_1.png', // 胴体パーツの画像パス
      legPartImagePath:  pathToParts + genre3 + '_2.png', // 足部パーツの画像パス
    );
  }
}
