import 'package:memorygame/screens/wordsResponse.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<String>> callApi() async {
    String url =
        "http://10.0.2.2:4444/wordsgame/getwords"; //localhost for phone is -> 10.0.2.2
    var response = await http.get(Uri.parse(url));
    // print(response.statusCode);
    // print(response.body);
    List<String> words = wordsResponseFromJson(response.body);
    // print("list $words");
    return words;
  }
}
