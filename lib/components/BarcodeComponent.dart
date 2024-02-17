import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';
import '../relatedBookData/crud.dart';
import '../relatedBookData/gptApi.dart';
import '../relatedBookData/crud.dart' as BookCrud;
import '../relatedCharaData/chara_crud.dart' as CharaCrud;
import '../relatedCharaData/genreCounter.dart';
import 'package:provider/provider.dart';

class BarcodeComponent extends StatefulWidget {
  const BarcodeComponent({Key? key}) : super(key: key);

  @override
  _BarcodeComponentState createState() => _BarcodeComponentState();
}

class _BarcodeComponentState extends State<BarcodeComponent> {
  String title = '';
  String author = '';
  String genre = '';
  String imageLink = '';

  String result = ''; // スキャン結果を格納する変数
  Book? book; // Book インスタンスを保持する変数

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _startBarcodeScanning();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 55), // ボタンの最小サイズ
      ),
      child: Container(
        width: 200,
        height: 55,
        child: ClipOval(
          child: Image.asset('assets/images/barcodeImage.jpg'),
        ),
      ),
    );
  }

  Future<void> _fetchBookInfo(String isbn) async {
    final genreCounter = Provider.of<GenreCounter>(context, listen: false);

    try {
      final fetchedBook = await BookRepository().fetchBookfromIsbn(isbn);

      setState(() {
        book = fetchedBook;
        title = book!.title;
        author = book!.author;
      });

      if (title.isNotEmpty) {
        genre = await ApiService().callApi(book!.author, book!.title);

        _showConfirmationDialog(genreCounter);
      } else {
        _showErrorDialog(genreCounter); // タイトルが空の場合はエラーダイアログを表示
      }
    } catch (error) {
      _showErrorDialog(genreCounter);
    }
  }

  void _showConfirmationDialog(GenreCounter genreCounter) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: '確認',
      desc: '書籍名: $title\n著者: $author\nジャンル: $genre',
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnCancelText: 'キャンセル',
      btnOkOnPress: () async {
        String imageLink = book!.smallThumbnail;
        String publishedDate = book!.publishedDate;
        String description = book!.description;

        genreCounter.increment();

        await CharaCrud.Firestore().genreUpdate(genre, genreCounter);

        print(genreCounter.count);

        await BookCrud.Firestore().create(
          title,
          author,
          genre,
          imageLink,
          publishedDate,
          description,
        );

        Navigator.pop(context); // Close dialog
        //Navigator.pop(context); // Close BarcodePage
      },
      btnOkText: '登録',
    )..show();
  }

  void _showErrorDialog(GenreCounter genreCounter) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'エラー',
      desc:
          'データを取得できませんでした。バーコードを読み込めない可能性がある為、再度スキャンするか、キーボードから情報を入力して登録してください。',
      btnCancelOnPress: () {
        //Navigator.of(context).pop();
      },
      btnCancelText: '閉じる',
      btnOkOnPress: () {
        _showKeyboardDialog(genreCounter);
        //Navigator.of(context).pop();
      },
      btnOkText: 'キーボードで登録',
    )..show();
  }

  void _showKeyboardDialog(GenreCounter genreCounter) {
    TextEditingController titleController = TextEditingController();
    TextEditingController authorController = TextEditingController();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: '本のタイトル'),
          ),
          TextField(
            controller: authorController,
            decoration: InputDecoration(labelText: '著者'),
          ),
        ],
      ),
      btnOkOnPress: () async {
        Navigator.of(context).pop();

        String title = titleController.text;
        String author = authorController.text;
        genre = await ApiService().callApi(title, author);

        genreCounter.increment();

        await CharaCrud.Firestore().genreUpdate(genre, genreCounter);

        print(genreCounter.count);

        String imageLink =
            'https://th.bing.com/th/id/R.1544a44cd6dff1c0219bca46e0f0a4a2?rik=ZkfnNczbKsww3Q&riu=http%3a%2f%2f4.bp.blogspot.com%2f-bwbcXAaqtTM%2fUZ7s_dXPVdI%2fAAAAAAAAEfw%2f4D-2cKz-f1g%2fs1600%2f001%2525E8%2525B5%2525A4.jpg&ehk=4fGOsb94XR5T%2bcoavVME%2fpRyKAs3y3T80LEW2p%2bmw2A%3d&risl=&pid=ImgRaw&r=0';
        debugPrint(imageLink);
        await BookCrud.Firestore().create(
            title, author, genre, imageLink, 'YYYY-MM-DD', '取得できませんでした');
      },
      btnOkText: '登録',
      btnCancelOnPress: () {},
      btnCancelText: 'キャンセル',
    )..show();
  }

  void _startBarcodeScanning() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );
    if (res is String) {
      setState(() {
        result = res; // スキャン結果で状態を更新
      });
      await _fetchBookInfo(result); // Bookの情報を取得
    }
  }
}

class Book {
  final String title;
  final String author;
  final String publishedDate;
  final String description;
  final String smallThumbnail;

  Book(
      {required this.title,
      required this.author,
      required this.publishedDate,
      required this.description,
      required this.smallThumbnail});

  factory Book.fromJsonResult(Map<String, dynamic> json) {
    final String smallThumbnail = json['imageLinks'] != null
        ? json['imageLinks']['smallThumbnail']
        : 'https://th.bing.com/th/id/R.1544a44cd6dff1c0219bca46e0f0a4a2?rik=ZkfnNczbKsww3Q&riu=http%3a%2f%2f4.bp.blogspot.com%2f-bwbcXAaqtTM%2fUZ7s_dXPVdI%2fAAAAAAAAEfw%2f4D-2cKz-f1g%2fs1600%2f001%2525E8%2525B5%2525A4.jpg&ehk=4fGOsb94XR5T%2bcoavVME%2fpRyKAs3y3T80LEW2p%2bmw2A%3d&risl=&pid=ImgRaw&r=0';

    final String publishedDate = json.containsKey('publishedDate')
        ? json['publishedDate']
        : 'YYYY-MM-DD'; // publishedDateフィールドが存在するか確認し、ない場合は「取得できませんでした」を返す

    final String description = json['description'] ?? '取得できませんでした';

    return Book(
      title: json['title'],
      author: json['authors'][0], // 少なくとも1人の著者がいると仮定
      publishedDate: publishedDate,
      description: description,
      smallThumbnail: smallThumbnail,
    );
  }
}

class BookRepository {
  BookAPI get _bookAPI => BookAPI();

  Future<Book> fetchBookfromIsbn(String isbn) async {
    final result = await _bookAPI.fetchBookfromIsbn(isbn);
    final node = json.decode(result);
    return Book.fromJsonResult(node['items'][0]['volumeInfo']);
  }
}

class BookAPI {
  Future<String> fetchBookfromIsbn(String isbn) async {
    const String baseUrl =
        'https://www.googleapis.com/books/v1/volumes?q=isbn:';

    final Uri uri = Uri.parse('$baseUrl$isbn');
    final response = await http.get(uri);
    return response.body;
  }
}
