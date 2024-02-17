import 'package:flutter/material.dart';
import 'CharacterDisplayWidget.dart'; // CharacterDisplayWidgetをインポート
import 'ElementBarComponent.dart';

class CharacterComponent extends StatelessWidget {
  final String genre1;
  final String genre2;
  final String genre3;

  final String pathToParts = 'assets/images/parts/';

  String convertCategoryToEnglish(String category) {
    switch (category) {
      case "総記":
        return "generalities";
      case "心理学":
        return "psychology";
      case "歴史":
        return "history";
      case "社会":
        return "socialsciences";
      case "科学医学":
        return "science-medicine";
      case "技術":
        return "technology";
      case "産業":
        return "industry";
      case "芸術":
        return "arts";
      case "体育":
        return "sports";
      case "言語":
        return "language";
      case "文学":
        return "literature";
      default:
        return "null";
    }
  }

  const CharacterComponent({
    required Key key,
    required this.genre1,
    required this.genre2,
    required this.genre3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CharacterDisplayWidgetを使用してキャラクターを表示
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElementBarComponent(),
              CharacterDisplayWidget(
                characterImagePath: 'assets/images/character.png', // キャラクターの基本画像パス
                headPartImagePath: (convertCategoryToEnglish(genre1) != 'null' ? pathToParts + convertCategoryToEnglish(genre1) + '_0.png' : 'null'), // 頭部パーツの画像パス
                bodyPartImagePath: (convertCategoryToEnglish(genre2) != 'null' ? pathToParts + convertCategoryToEnglish(genre2) + '_1.png' : 'null'), // 胴体パーツの画像パス
                legPartImagePath:  (convertCategoryToEnglish(genre3) != 'null' ? pathToParts + convertCategoryToEnglish(genre3) + '_2.png' : 'null'), // 足部パーツの画像パス
              ),
            ],
    );
  }
}
