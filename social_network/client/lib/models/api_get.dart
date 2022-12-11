import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(Uri.parse('http://2.34.202.83:3000/post'));

  if (response.statusCode == 200) {
    // If the server did rturn a 200 OK response,
    // then parse the JSON.
    //return Album.fromJson(jsonDecode(response.body));
    var parsedCountryList = json.decode(response.body);
    List<Album> countries = <Album>[];
    parsedCountryList.forEach((country) {
      countries.add(Album.fromJson(country));
    });
    return countries;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String id;
  final String content;
  final String user_id;

  const Album({
    required this.id,
    required this.content,
    required this.user_id,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      content: json['content'],
      user_id: json['user_id'],
    );
  }
}

void main() => runApp(const Post());

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: fetchAlbum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data![1].content);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
