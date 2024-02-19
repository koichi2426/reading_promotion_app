import 'package:flutter/material.dart';
import 'package:reading_promotion_app/relatedBookData/books.dart';
import 'package:reading_promotion_app/relatedBookData/crud.dart';

class ElementBarComponent extends StatelessWidget {
  const ElementBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GenreGauge(),
    );
  }
}

class GenreGauge extends StatefulWidget {
  @override
  _GenreGaugeState createState() => _GenreGaugeState();
}

class _GenreGaugeState extends State<GenreGauge> {
  List<Books> booksdata = [];
  Firestore firestore = Firestore();

    @override
  void initState() {
    super.initState();
    // initStateメソッドでreadメソッドを呼び出し、データを取得する
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    // readメソッドを呼び出してデータを取得し、booksリストを更新する
    await firestore.read();
    setState(() {
      booksdata = firestore.books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GenreBar(books: booksdata),
      );
  }
}

class GenreBar extends StatelessWidget {
  final List<Books> books;

  final Map<String, Color> colorMap = {
    "総記": Color.fromARGB(255, 172, 41, 30),
    "心理学": Color.fromARGB(255, 0, 66, 109),
    "歴史": Color.fromARGB(255, 243, 152, 0),
    "社会": Color.fromARGB(255, 211, 222, 241),
    "科学医学": Color.fromARGB(255, 153, 101, 53),
    "技術": Color.fromARGB(255, 238, 209, 63),
    "産業": Color.fromARGB(255, 174, 165, 161),
    "芸術": Color.fromARGB(255, 0, 111, 95),
    "体育": Color.fromARGB(255, 0, 111, 95),
    "言語": Color.fromARGB(255, 117, 109, 145),
    "文学": Color.fromARGB(255, 233, 195, 183),
  };

  GenreBar({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Map<String, double> genreTotalValues = {};
    for (var data in books) {
      if (!genreTotalValues.containsKey(data.genre)) {
        genreTotalValues[data.genre] = 0;
      }
      genreTotalValues[data.genre] = (genreTotalValues[data.genre] ?? 0) + 1.0;
    }

    // 全ジャンルの合計値を計算する
    double totalValue = 0;
    genreTotalValues.forEach((_, value) {
      totalValue += value;
    });

    return Container(
      width: 300,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Row(
            children: genreTotalValues.entries.map((entry) {
              final double width = 300 * (entry.value / totalValue);
              return Container(
                width: width,
                height: 30,
                child: Text(
                    entry.key,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(entry.key == genreTotalValues.keys.first ? 10.0 : 0),
                    bottomLeft: Radius.circular(entry.key == genreTotalValues.keys.first ? 10.0 : 0),
                    topRight: Radius.circular(entry.key == genreTotalValues.keys.last ? 10.0 : 0),
                    bottomRight: Radius.circular(entry.key == genreTotalValues.keys.last ? 10.0 : 0),
                  ),
                  color: entry.value > 0 ? colorMap[entry.key] : Colors.grey,
                ),
              );
            }).toList(),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: genreTotalValues.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

    Color _getColor(String genre) {
    // 同じジャンル名に同じ色を割り当てる
    final int hashCode = genre.hashCode;
    final int index = hashCode % Colors.primaries.length;
    return Colors.primaries[index];
  }
}