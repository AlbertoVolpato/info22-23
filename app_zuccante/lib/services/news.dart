import 'dart:async';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;



  Future<RssFeed?> loadNews() async {
    try {
      final response = await http.get(Uri.parse('https://medium.com/feed/@TJgrapes') );
      return RssFeed.parse(response.body);
    } catch (e) {
      print(e);
      // handle any exceptions here
    }
    return null;
  }

