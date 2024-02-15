import 'package:flutter/material.dart';
import 'CharacterDisplayWidget.dart'; // CharacterDisplayWidgetをインポート

class CharacterComponent extends StatelessWidget {
  const CharacterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // CharacterDisplayWidgetを使用してキャラクターを表示
    return CharacterDisplayWidget(
      characterImagePath: 'assets/images/character.png', // キャラクターの基本画像パス
      headPartImagePath: 'assets/images/parts/0_1.png', // 頭部パーツの画像パス
      bodyPartImagePath: 'assets/images/parts/0_1.png', // 胴体パーツの画像パス
      legPartImagePath: 'assets/images/parts/0_1.png', // 足部パーツの画像パス
    );
  }
}
