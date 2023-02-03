import 'dart:async';
import 'package:http/http.dart' as http;

Future loadNews() async {
  try {
    final response =
        await http.get(Uri.parse('https://medium.com/feed/@TJgrapes'));
  } catch (e) {
    print(e);
    // handle any exceptions here
  }
  return null;
}
