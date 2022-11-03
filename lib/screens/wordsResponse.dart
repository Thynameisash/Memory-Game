import 'dart:convert';

List<String> wordsResponseFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String wordsResponseToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
