import 'package:flutter/material.dart';
import 'ElementBarComponent.dart';
import 'PartsConnectionWidget.dart';

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
              PartsConnectionWidget(
                imagePaths: [
                  pathToParts + 'null' + '_0.png', // 画像ファイルのパスをここに指定してください
                  pathToParts + 'null' + '_1.png', // 画像ファイルのパスをここに指定してください
                  pathToParts + 'null' + '_2.png', // 画像ファイルのパスをここに指定してください
                ],
              ),
            ],
    );
  }
}
