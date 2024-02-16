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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        final stackSize = maxWidth <= maxHeight ? maxWidth : maxHeight;

        print('Stack Size: width=$stackSize, height=$stackSize');

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              characterImagePath,
              width: stackSize, // Use stackSize for both width and height
              height: stackSize,
            ),
            Positioned(
              left: stackSize * (0.5 + headAlignment.x) - stackSize / 2,
              top: stackSize * (0.5 + headAlignment.y) - stackSize / 2,
              child: Image.asset(
                headPartImagePath,
                width: stackSize * headPartSize,
                height: stackSize * headPartSize,
              ),
            ),
            Positioned(
              left: stackSize * (0.5 + bodyAlignment.x) - stackSize / 2,
              top: stackSize * (0.5 + bodyAlignment.y) - stackSize / 2,
              child: Image.asset(
                bodyPartImagePath,
                width: stackSize * bodyPartSize,
                height: stackSize * bodyPartSize,
              ),
            ),
            Positioned(
              left: stackSize * (0.5 + legAlignment.x) - stackSize / 2,
              top: stackSize * (0.5 + legAlignment.y) - stackSize / 2,
              child: Image.asset(
                legPartImagePath,
                width: stackSize * legPartSize,
                height: stackSize * legPartSize,
              ),
            ),
          ],
        );
      },
    );
  }
}
