import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenreCounter extends ChangeNotifier {
  int _count = 0;
  static const String _keyCount = 'count';

  int get count => _count;

  GenreCounter() {
    // アプリが起動した際に保存された値を読み込む
    _loadCount();
  }

  void increment() {
    _count++;
    _saveCount();
    notifyListeners();
  }

  void reset() {
    _count = 0;
    _saveCount();
    notifyListeners();
  }

  // カウントを保存する
  Future<void> _saveCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCount, _count);
  }

  // 保存されたカウントを読み込む
  Future<void> _loadCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _count = prefs.getInt(_keyCount) ?? 0;
    notifyListeners();
  }
}
