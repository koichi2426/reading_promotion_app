import 'package:flutter/material.dart';

class CharacterDisplayWidget extends StatelessWidget {
  final String characterImagePath;
  final String headPartImagePath;
  final String bodyPartImagePath;
  final String legPartImagePath;
  final Alignment headAlignment;
  final Alignment bodyAlignment;
  final Alignment legAlignment;
  final double headPartSize;
  final double bodyPartSize;
  final double legPartSize;

  const CharacterDisplayWidget({
    Key? key,
    required this.characterImagePath,
    required this.headPartImagePath,
    required this.bodyPartImagePath,
    required this.legPartImagePath,
    this.headAlignment = const Alignment(0.10, -0.3),
    this.bodyAlignment = const Alignment(0.5, 0.5),
    this.legAlignment = const Alignment(0.5, 0.5),
    this.headPartSize = 0.8,
    this.bodyPartSize = 0.3,
    this.legPartSize = 0.3,
  }) : super(key: key);

  //ジャンル判別処理
  //頭パーツの位置
  //胴体パーツの位置
  //脚パーツの位置
  //頭パーツのサイズ
  //胴体パーツのサイズ
  //脚パーツのサイズ
  


  String extractGenre(String imagePath) {
    // パスをスラッシュ('/')で分割し、最後の要素を取得
    List<String> parts = imagePath.split('/');
    String fileName = parts.last;

    // ファイル名をアンダースコア('_')で分割し、最初の部分を返す
    List<String> fileNameParts = fileName.split('_');
    if (fileNameParts.isNotEmpty) {
      return fileNameParts.first;
    } else {
      // アンダースコアで分割できなかった場合は空文字列を返す
      return '';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        final stackSize = maxWidth <= maxHeight ? maxWidth : maxHeight;

        print('Stack Size: width=$stackSize, height=$stackSize');

        List<Widget> stackChildren = [
          Image.asset(
            characterImagePath,
            width: stackSize,
            height: stackSize,
          ),
        ];

        if (headPartImagePath != 'null') {
          stackChildren.add(
            Positioned(
              left: stackSize * (0.5 + headAlignment.x) - stackSize / 2,
              top: stackSize
               * (0.5 + headAlignment.y) - stackSize / 2,
              child: Image.asset(
                headPartImagePath!,
                width: stackSize * headPartSize,
                height: stackSize * headPartSize,
              ),
            ),
          );
        }

        if (bodyPartImagePath != 'null') {
          stackChildren.add(
            Positioned(
              left: stackSize * (0.5 + bodyAlignment.x) - stackSize / 2,
              top: stackSize * (0.5 + bodyAlignment.y) - stackSize / 2,
              child: Image.asset(
                bodyPartImagePath!,
                width: stackSize * bodyPartSize,
                height: stackSize * bodyPartSize,
              ),
            ),
          );
        }

        if (legPartImagePath != 'null') {
          stackChildren.add(
            Positioned(
              left: stackSize * (0.5 + legAlignment.x) - stackSize / 2,
              top: stackSize * (0.5 + legAlignment.y) - stackSize / 2,
              child: Image.asset(
                legPartImagePath!,
                width: stackSize * legPartSize,
                height: stackSize * legPartSize,
              ),
            ),
          );
        }

        return Stack(
          alignment: Alignment.center,
          children: stackChildren,
        );
      },
    );
  }
}
