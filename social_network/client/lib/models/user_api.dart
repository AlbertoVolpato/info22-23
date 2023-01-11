import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:client/utils/server_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<UserContent> fetchUser() async {
  final response = await http.get(Uri.parse(ServerUrl + '/user'));

  if (response.statusCode == 200) {
    // If the server did rturn a 200 OK response,
    // then parse the JSON.
    //print(response.body);

    return UserContent.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<UserContent> fetchUserfromId(token) async {
  final response =
      await http.get(Uri.parse(ServerUrl + '/userbytoken/' + token));

  if (response.statusCode == 200) {
    // If the server did rturn a 200 OK response,
    // then parse the JSON.
    print(response.body);

    return UserContent.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class UserContent {
  final String user_id;
  final String username;
  final String singup_date;
  final String picture;

  const UserContent({
    required this.user_id,
    required this.username,
    required this.singup_date,
    required this.picture,
  });

  factory UserContent.fromJson(Map<String, dynamic> json) {
    return UserContent(
        user_id: json['user_id'],
        username: json['username'],
        singup_date: json['singup_date'],
        picture: json['picture']);
  }
}

class UserForPost {
  final String post_id;
  final String content;
  final String user_id;
  final List<dynamic> image;
  final String created_at;
  final String username;
  final String singup_date;
  final String picture;

  const UserForPost({
    required this.post_id,
    required this.content,
    required this.user_id,
    required this.image,
    required this.created_at,
    required this.username,
    required this.singup_date,
    required this.picture,
  });

  factory UserForPost.fromJson(Map<String, dynamic> json) {
    return UserForPost(
      post_id: json['post_id'],
      content: json['content'],
      user_id: json['user_id'],
      image: json['image'],
      created_at: json['created_at'],
      username: json['username'],
      singup_date: json['singup_date'],
      picture: json['picture'],
    );
  }
}

class PartialUser {
  final String username;
  final String picture;
  final String google_token;

  const PartialUser({
    required this.username,
    required this.picture,
    required this.google_token,
  });

  factory PartialUser.fromJson(Map<String, dynamic> json) {
    return PartialUser(
        username: json['username'],
        picture: json['picture'],
        google_token: json['google_token']);
  }
}

class Username {
  final String username;

  const Username({
    required this.username,
  });

  factory Username.fromJson(Map<String, dynamic> json) {
    return Username(
      username: json['username'],
    );
  }
}

class FullOautInfo {
  final String user_id;

  const FullOautInfo({
    required this.user_id,
  });
  factory FullOautInfo.fromJson(Map<String, dynamic> json) {
    return FullOautInfo(
      user_id: json['user_id'],
    );
  }
}
