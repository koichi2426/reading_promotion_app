import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:reading_promotion_app/models/character.dart';
import 'dart:convert';
import '../models/character.dart';

class DataTestComponent extends StatelessWidget {
  final String description;
  final String head;
  final String body;
  final String foot;

  const DataTestComponent({
    required this.description,
    required this.head,
    required this.body,
    required this.foot,
  });

  @override
  Widget build(BuildContext context) {
    return DataTestComponent(
        description: description, head: head, body: body, foot: foot);
  }
}
