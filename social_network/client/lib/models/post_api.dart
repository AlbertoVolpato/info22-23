import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<PostsContent>> fetchPost() async {
  final response = await http.get(Uri.parse('http://2.34.202.83:5000/post'));

  if (response.statusCode == 200) {
    // If the server did rturn a 200 OK response,
    // then parse the JSON.
    //return PostsContent.fromJson(jsonDecode(response.body));
    var parsedPostList = json.decode(response.body);
    List<PostsContent> Posts = <PostsContent>[];
    parsedPostList.forEach((posts) {
      Posts.add(PostsContent.fromJson(posts));
    });
    return Posts;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class PostsContent {
  final String id;
  final String content;
  final String user_id;
  final List image;
  final String created_at;

  const PostsContent({
    required this.id,
    required this.content,
    required this.user_id,
    required this.image,
    required this.created_at,
  });

  factory PostsContent.fromJson(Map<String, dynamic> json) {
    return PostsContent(
      id: json['id'],
      content: json['content'],
      user_id: json['user_id'],
      image: json['image'],
      created_at: json['created_at'],
    );
  }
}
