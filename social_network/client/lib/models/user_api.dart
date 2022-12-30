import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<UserContent> fetchUser() async {
  final response = await http.get(Uri.parse('http://2.34.202.83:5000/user'));

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
      await http.get(Uri.parse('http://2.34.202.83:5000/userbytoken/' + token));

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
  final String google_token;

  const UserContent({
    required this.user_id,
    required this.google_token,
  });

  factory UserContent.fromJson(Map<String, dynamic> json) {
    return UserContent(
        user_id: json['user_id'], google_token: json['google_token']);
  }
}

class UserForPost {
  final String id;
  final String username;
  final File picture;
  final String singup_date;
  final String google_token;

  const UserForPost({
    required this.id,
    required this.username,
    required this.picture,
    required this.singup_date,
    required this.google_token,
  });

  factory UserForPost.fromJson(Map<String, dynamic> json) {
    return UserForPost(
        id: json['id'],
        username: json['username'],
        picture: json['picture'],
        singup_date: json['singup_date'],
        google_token: json['google_token']);
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

  final String email;

  const FullOautInfo({
    required this.user_id,
    required this.email,
  });
  factory FullOautInfo.fromJson(Map<String, dynamic> json) {
    return FullOautInfo(
      user_id: json['user_id'],
      email: json['email'],
    );
  }
}
