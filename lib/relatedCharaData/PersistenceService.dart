import 'package:flutter/material.dart';
import '../relatedCharaData/genreCounter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  static final PersistenceService _instance = PersistenceService._internal();

  factory PersistenceService() => _instance;

  PersistenceService._internal();

  Future<void> saveGenres(String genre, GenreCounter genreCounter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (genreCounter.count == 1) {
      await prefs.setString('prevFirstGenre', genre);
    } else if (genreCounter.count == 2) {
      await prefs.setString('prevSecondGenre', genre);
    }
  }

  Future<String> getPrevFirstGenre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('prevFirstGenre') ?? '';
  }

  Future<String> getPrevSecondGenre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('prevSecondGenre') ?? '';
  }
}
