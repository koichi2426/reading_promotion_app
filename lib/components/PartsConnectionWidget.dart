import 'package:flutter/material.dart';
class PartsConnectionWidget extends StatelessWidget {
  final List<String> imagePaths;

  PartsConnectionWidget({required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (String path in imagePaths)
          Container(
            margin: EdgeInsets.all(0), // ここでマージンをゼロに設定して隙間をなくす
            child: Image.asset(path),
          ),
      ],
    );
  }
}
