import 'package:flutter/material.dart';
import './user_crud.dart' as UserCrud;
import './users.dart';
//import 'package:http/http.dart' as http;

class pictureBookPage extends StatefulWidget {
  final String userid;
  const pictureBookPage({Key? key, required this.userid}) : super(key: key);

  @override
  _pictureBookPageState createState() => _pictureBookPageState();
}

class _pictureBookPageState extends State<pictureBookPage> {
  List<Books> books = [];
  UserCrud.BookCrud firestore = UserCrud.BookCrud();
  late String userid;

  @override
  void initState() {
    super.initState();
    userid = widget.userid;
    // initStateメソッドでreadメソッドを呼び出し、データを取得する
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    // readメソッドを呼び出してデータを取得し、booksリストを更新する
    await firestore.getBooks(userid);
    setState(() {
      books = firestore.books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        title: Text(
          'これまで読んだ本',
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
        children: books
            .map(
              (book) => Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showBookDetailsDialog(context, book);
                        },
                        child: Container(
                          height: 170, // 画像とテキストの間に余白を追加
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0.01,
                                blurRadius: 5,
                                offset: Offset(8, 12),
                              ),
                            ],
                          ),
                          child: Image.network(
                            book.imageUrl,
                            height: 160,
                            width: 135,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 135, // 画像と同じ幅にする
                        child: Text(
                          book.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  showBookDetailsDialog(BuildContext context, Books book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" "),
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
                              "この書籍を図鑑から削除しますか？",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text("(キャラクターに反映されることはありません)",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
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
                              await firestore.delete(userid, book.id);
                              _fetchBooks();
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
                    book.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "${book.title}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("${book.author}"),
                SizedBox(height: 8),
                Divider(), // ラインを追加
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "作品情報",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text("${book.description}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "ジャンル",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${book.genre}"),
                      ],
                    ),
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          "発行日",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${book.publishedDate}"),
                      ],
                    )
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
