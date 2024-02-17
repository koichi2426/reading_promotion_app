import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:reading_promotion_app/models/character.dart';
import 'dart:convert';
import '../models/usercrud.dart';
import '../models/bookcrud.dart';
import '../models/categorycrud.dart';
import '../models/charactercrud.dart';

class DataTestComponent extends StatefulWidget {
  const DataTestComponent({Key? key}) : super(key: key);

  @override
  _DataTestComponentState createState() => _DataTestComponentState();
}

class _DataTestComponentState extends State<DataTestComponent> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _fetchUserData();
        _fetchBookData();
        _fetchCategoryData();
        _fetchCharacterData();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 55), // ボタンの最小サイズ
      ),
    );
  }

  Future<void> _fetchUserData() async {
    Book book;
    Character character;
    try{
      final fetchedUser = await UserCrud().read();

      setState(() {
        user = fetchedUser;
        Book book = user[0].book;
        Character character = user[0].character;
      })
    }
  }

}
