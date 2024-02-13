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
            return Dialog(
              backgroundColor: Color(0xFFD2B48C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: EdgeInsets.all(20.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BarcodeComponent(),
                    KindleComponent(),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/add_button.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.zero,
        primary: Colors.transparent, // ボタンの背景色を透明に設定
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent, // ボタンの影を透明に設定
      ),
    );
  }
}
