import 'package:flutter/material.dart';
import 'chara_crud.dart';
import 'package:intl/intl.dart';
//import 'package:http/http.dart' as http;

class charaBookPage extends StatefulWidget {
  final String userid;
  const charaBookPage({Key? key, required this.userid}) : super(key: key);

  @override
  _charaBookPageState createState() => _charaBookPageState();
}

class _charaBookPageState extends State<charaBookPage> {
  List<Character> character = [];
  Firestore firestore = Firestore();

  @override
  void initState() {
    super.initState();
    // initStateメソッドでreadメソッドを呼び出し、データを取得する
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    // readメソッドを呼び出してデータを取得し、booksリストを更新する
    await firestore.read();
    setState(() {
      character = firestore.characters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        title: Text(
          'キャラクター図鑑',
          style: TextStyle(
            fontSize: 15, // フォントサイズを指定
            fontWeight: FontWeight.bold, // 太字にする
          ),
        ),
        centerTitle: true, // センターに配置
      ),
      backgroundColor: Color(0xFFF5DEB3), // 薄い茶色の背景色
      body: GridView.count(
        crossAxisCount: 2,
        children: character.map((character) {
          return GestureDetector(
            onTap: () {
              showCharaDetailsDialog(context, character);
            },
            child: Container(
              margin: EdgeInsets.all(8), // コンテナの外側の余白を追加
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // 角丸の半径を設定
                color: Colors.white, // 白い背景色
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2, // 影の拡がりを小さく
                    blurRadius: 5,
                    offset: Offset(2, 2), // 影の位置を調整
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0), // 白い背景の内側の余白を追加
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 160,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // 画像の角丸
                        image: DecorationImage(
                          image: NetworkImage(character.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  showCharaDetailsDialog(BuildContext context, Character character) {
    // 現在の日時を取得
    DateTime now = DateTime.now();
    // 日時をフォーマット
    String formattedDate = DateFormat('yyyy 年 MM 月 dd 日').format(now);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "No.${character.id}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // フォントサイズを大きくする
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "図鑑から削除しますか？",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("いいえ"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await firestore.delete(character.id);
                              _fetchCharacters();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text("はい"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 180,
                  child: Image.network(
                    character.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${character.genre}の本から誕生",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Text(
                          "あなたに会えた日：$formattedDate",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("閉じる"),
            ),
          ],
        );
      },
    );
  }
}
