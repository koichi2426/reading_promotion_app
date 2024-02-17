import 'package:flutter/material.dart';
import 'package:reading_promotion_app/components/AlumniComponent.dart';
import 'package:reading_promotion_app/components/BarcodeComponent.dart';
import 'package:reading_promotion_app/components/ElementBarComponent.dart';
import 'package:reading_promotion_app/components/EncyclopediaComponent.dart';
import 'package:reading_promotion_app/components/KindleComponent.dart';
import 'package:reading_promotion_app/components/ReadComponent.dart';
import 'package:reading_promotion_app/components/CharacterComponent.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'relatedBookData/pictureBook.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF5A4F3C), // #5A4F3C color
            width: 6.0,
          ),
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background_image.png'), // Change to your image path
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
                  onPressed: () {},
                  child: Text('Button 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pictureBookPage()),
                    );
                  },
                  child: Text('Button 2'),
                ),

                ReadComponent(), // ReadComponent instead of Button 3
              ],
            ),
          ],
        ),
      ),
    );
  }
}
