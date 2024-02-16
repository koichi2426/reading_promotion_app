import 'dart:convert';
import 'package:http/http.dart' as http;
import 'env.dart';

class ApiService {
  static String _apiText = '';

  //gptのapiKey
  final apiKey = Env.key;

  String get apiText => _apiText;

  Future<String> callApi(String authorText, String searchText) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(<String, dynamic>{
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content":
                "総記、心理学、歴史、社会、科学医学、技術、産業、芸術、体育、言語、文学、の中で$authorText,$searchTextの本のジャンルを該当するものを1つ選べ。",
          },
        ],
      }),
    );

    final body = response.bodyBytes;
    final jsonString = utf8.decode(body);
    final json = jsonDecode(jsonString);
    final choices = json['choices'];
    final ansText = choices[0]['message']['content'];
    _apiText = ansText;

    return ansText;
  }
}
