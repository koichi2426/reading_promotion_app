import 'package:flutter/material.dart';

class CharacterComponent extends StatelessWidget {
  const CharacterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/character.png'); // assetsフォルダにcharacter.pngが存在することを想定
  }
}
