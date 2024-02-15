import 'package:flutter/material.dart';

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath; // キャラクターの基本画像パス
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath, // コンストラクタに追加
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(characterImagePath), // キャラクターの基本画像
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1, // 頭部パーツの位置調整
          child: Image.asset(headPartImagePath),
        ),
        Positioned(
          // 胴体パーツの位置調整、必要に応じて調整してください
          child: Image.asset(bodyPartImagePath),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.1, // 足部パーツの位置調整
          child: Image.asset(legPartImagePath),
        ),
      ],
    );
  }
}
