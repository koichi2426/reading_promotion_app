import 'package:flutter/material.dart';
import 'package:reading_promotion_app/components/AlumniComponent.dart';
import 'package:reading_promotion_app/components/BarcodeComponent.dart';
import 'package:reading_promotion_app/components/ElementBarComponent.dart';
import 'package:reading_promotion_app/components/EncyclopediaComponent.dart';
import 'package:reading_promotion_app/components/KindleComponent.dart';
import 'package:reading_promotion_app/components/ReadComponent.dart';
import 'package:reading_promotion_app/components/CharacterComponent.dart';

void main() {

  final app = MaterialApp(
    home: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF5A4F3C), // #5A4F3C color
            width: 6.0,
          ),
          image: DecorationImage(
            image: AssetImage('images/background_image.png'), // Change to your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: CharacterComponent(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for the first button
                  },
                  child: Text('Button 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for the second button
                  },
                  child: Text('Button 2'),
                ),
                
                ReadComponent(), // ReadComponent instead of Button 3
              ],
            ),
          ],
        ),
      ),
    ),
  );

  runApp(app);

}
