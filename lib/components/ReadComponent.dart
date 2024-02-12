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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Kindleボタン
                    BarcodeComponent(),
                    // バーコードボタン
                    KindleComponent()
                    ],
                ),
              ),
            );
          },
        );
      },
      child: Text('Read'), // ボタンのテキスト
    );
  }
}
