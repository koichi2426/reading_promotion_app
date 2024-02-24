import 'package:flutter/material.dart';
import '../models/genreCounter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  static final PersistenceService _instance = PersistenceService._internal();

  factory PersistenceService() => _instance;

  PersistenceService._internal();

  Future<void> saveGenres(String imageUrls, int count) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (count == 1) {
      await prefs.setString('prevFirstImageUrl', imageUrls);
    } else if (count == 2) {
      await prefs.setString('prevSecondImageUrl', imageUrls);
    } else if (count == 3) {
      await prefs.setString('prevThirdImageUrl', imageUrls);
    }
  }

  Future<List<String>> getPrevUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String prevFirstImageUrl = prefs.getString('prevFirstImageUrl') ?? '';
    final String prevSecondImageUrl =
        prefs.getString('prevSecondImageUrl') ?? '';
    final String prevThirdImageUrl = prefs.getString('prevThirdImageUrl') ?? '';

    return [prevFirstImageUrl, prevSecondImageUrl, prevThirdImageUrl];
  }
}
