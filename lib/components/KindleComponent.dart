import 'package:flutter/material.dart';

class KindleComponent extends StatelessWidget {
  const KindleComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {},
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 55), // ボタンの最小サイズ
      ),
      child: Container(
        width: 200,
        height: 55,
        alignment: Alignment(0.0, 0.0),
        child: Text(
          "Kindle",
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Verdana',
            color: Color.fromARGB(255, 253, 175, 23),
          ),
        ),
      ),
    );
  }
}
