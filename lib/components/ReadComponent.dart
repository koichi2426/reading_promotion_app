import 'package:flutter/material.dart';
import 'package:reading_promotion_app/components/BarcodeComponent.dart';
import 'package:reading_promotion_app/components/KindleComponent.dart';

class ReadComponent extends StatelessWidget {
  const ReadComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // ダイアログの内容をここに書く
            return Dialog(
              backgroundColor: Color(0xFFD2B48C), // 薄い茶色の背景色
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: EdgeInsets.all(20.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Kindleボタン
                    BarcodeComponent(),
                    // バーコードボタン
                    KindleComponent(),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset(
          'assets/images/add_button.png',
          width: 200, // 横幅を100ピクセルに設定
          height: 200, // 高さを100ピクセルに設定
          ),
      ), // ボタンのテキスト
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
