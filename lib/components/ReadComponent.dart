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
        ),
        child: Container(
          width: 180,
          height: 180,
          alignment: Alignment.center,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 0.5,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        //onSurface: Colors.transparent, // ボタンの影を透明に設定
      ),
    );
  }
}
