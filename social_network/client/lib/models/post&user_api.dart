import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<PostsUsersContent>> fetchPostUsers() async {
  final response =
      await http.get(Uri.parse('http://2.34.202.83:5000/post&user'));

  if (response.statusCode == 200) {
    // If the server did rturn a 200 OK response,
    // then parse the JSON.
    //return PostsContent.fromJson(jsonDecode(response.body));
    var parsedPostUsersList = json.decode(response.body);
    List<PostsUsersContent> PostsUsers = <PostsUsersContent>[];
    parsedPostUsersList.forEach((posts) {
      PostsUsers.add(PostsUsersContent.fromJson(posts));
    });
    return PostsUsers;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class PostsUsersContent {
  final String id;
  final String content;
  final String user_id;
  final List image;
  final String username;
  final String email;
  final String picture;
  final String created_at;

  const PostsUsersContent({
    required this.id,
    required this.content,
    required this.user_id,
    required this.image,
    required this.username,
    required this.email,
    required this.picture,
    required this.created_at,
  });

  factory PostsUsersContent.fromJson(Map<String, dynamic> json) {
    return PostsUsersContent(
      id: json['id'],
      content: json['content'],
      user_id: json['user_id'],
      image: json['image'],
      username: json['username'],
      email: json['email'],
      picture: json['picture'],
      created_at: json['created_at'],
    );
  }
}
