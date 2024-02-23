import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'user_crud.dart' as UserCrud;
import 'users.dart';
import 'package:intl/intl.dart';
//import 'package:http/http.dart' as http;

class charBookPage extends StatefulWidget {
  final String userid;
  const charBookPage({Key? key, required this.userid}) : super(key: key);

  @override
  _charaBookPageState createState() => _charaBookPageState();
}

class _charaBookPageState extends State<charBookPage> {
  UserCrud.CharacterCrud charCrud = UserCrud.CharacterCrud();

  late List<Chars> chars = [];
  late String userid;

  @override
  void initState() {
    super.initState();
    userid = widget.userid;
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    setState(() {
      chars = []; // データをリセット
    });
    List<Chars> fetchedChars = await charCrud.getCharacters(userid);
    setState(() {
      chars = fetchedChars;
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
        children: ((chars) {
          return GestureDetector(
            onTap: () {
              showCharaDetailsDialog(context, chars);
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
                          image: NetworkImage(chars.imageUrl),
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
        }).toList(), //error
      ),
    );
  }

  showCharaDetailsDialog(BuildContext context, Characters char) {
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
                "No.${char.id}", // error
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
                              await charCrud.delete(
                                  userid, char.id); // id error
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
                    char.imageUrl,
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
                          "${char.genre}の本から誕生",
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
