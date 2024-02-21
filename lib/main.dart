import 'package:flutter/material.dart';
import 'package:reading_promotion_app/components/AlumniComponent.dart';
import 'package:reading_promotion_app/components/BarcodeComponent.dart';
import 'package:reading_promotion_app/components/ElementBarComponent.dart';
import 'package:reading_promotion_app/components/EncyclopediaComponent.dart';
import 'package:reading_promotion_app/components/KindleComponent.dart';
import 'package:reading_promotion_app/components/ReadComponent.dart';
import 'package:reading_promotion_app/components/CharacterComponent.dart';
import 'package:reading_promotion_app/components/UpdateCharacterWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'relatedBookData/pictureBook.dart';
import 'relatedCharaData/genreCounter.dart';
import 'package:provider/provider.dart';

// import 'package:reading_promotion_app/components/DataTestComponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenreCounter()),
      ],
      child: MyApp(),
    ),
  );
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
  @override
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
                child: UpdateCharacterWidget(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80.0, left: 30),
                  child: GestureDetector(
                    onTap: () {
                      //キャラクター図鑑を表示する chip chip chapa chapa
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0), // パディングを追加
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 227, 197, 155),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/graduate_button.png',
                        width: 40, // 画像の幅
                        height: 40, // 画像の高さ
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40.0), // ボタン1とボタン2の間に余白を追加
                Container(
                  margin: EdgeInsets.only(top: 80.0, right: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pictureBookPage()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0), // パディングを追加
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 227, 197, 155),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/pictureBook.png',
                        width: 40, // 画像の幅
                        height: 40, // 画像の高さ
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40.0),
                // Container(
                //   margin: EdgeInsets.only(top: 80.0, right: 25),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => DataTestComponent(),
                //         ),
                //       );
                //     },
                //     child: Container(
                //       padding:
                //           EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                //       decoration: BoxDecoration(
                //         color: Color.fromARGB(255, 255, 255, 155),
                //         borderRadius: BorderRadius.circular(12.0),
                //         border: Border.all(color: Colors.white, width: 1.0),
                //       ),
                //       child: Image.asset(
                //         'assets/images/graduate_button.png',
                //         width: 30,
                //         height: 30,
                //       ),
                //     ),
                //   ),
                // ),

                Expanded(
                  child: TextButton(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BarcodeComponent(),
                                  KindleComponent(),
                                  // DataTestComponent(),
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
                            offset: Offset(0, 3), // 影の位置を変更
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight, // 右寄せ
                        child: Image.asset(
                          'assets/images/add_button.png',
                          width: 140, // 画像の幅を半分にする
                          height: 140, // 画像の高さを半分にする
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
