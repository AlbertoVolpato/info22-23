import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response = await http.get(Uri.parse('http://2.34.202.83:5000/post'));

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
  final List image;
  final String created_at;

  const Album({
    required this.id,
    required this.content,
    required this.user_id,
    required this.image,
    required this.created_at,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      content: json['content'],
      user_id: json['user_id'],
      image: json['image'],
      created_at: json['created_at'],
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
        body: Center(
          child: FutureBuilder(
            future: fetchAlbum(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              snapshot.data?.length;

              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(0, 2),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      child: ClipOval(
                                        child: Image(
                                          height: 50.0,
                                          width: 50.0,
                                          image: AssetImage(
                                              snapshot.data[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data[index].user_id,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle:
                                      Text(snapshot.data[index].created_at),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    color: Colors.black,
                                    onPressed: () => print('More'),
                                  ),
                                ),
                                InkWell(
                                  onDoubleTap: () => print('Like post'),
                                  onTap: () {
                                    //Navigator.push(
                                    //  context,
                                    //  //MaterialPageRoute(
                                    //  //  builder: (context) => ViewPostScreen(
                                    //  //    post: posts[index],
                                    //  //  ),
                                    //  //),
                                    //);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    width: double.infinity,
                                    height: 400.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(0, 5),
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: AssetImage(
                                            snapshot.data[index].imageurl),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon:
                                                    Icon(Icons.favorite_border),
                                                iconSize: 30.0,
                                                onPressed: () =>
                                                    print('Like post'),
                                              ),
                                              Text(
                                                '2,515',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 20.0),
                                          Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.chat),
                                                iconSize: 30.0,
                                                onPressed: () {
                                                  //Navigator.push(
                                                  //  context,
                                                  //  MaterialPageRoute(
                                                  //    builder: (context) =>
                                                  //        ViewPostScreen(
                                                  //      post: posts[index],
                                                  //    ),
                                                  //  ),
                                                  //);
                                                },
                                              ),
                                              Text(
                                                '350',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.bookmark_border),
                                        iconSize: 30.0,
                                        onPressed: () => print('Save post'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
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
