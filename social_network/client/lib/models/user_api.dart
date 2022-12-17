import 'dart:async';
import 'dart:convert';

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

Future<UserContent> fetchUserfromId(id) async {
  final response =
      await http.get(Uri.parse('http://2.34.202.83:5000/user/' + id));

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
  final String id;
  final String username;
  final String email;
  final String picture;

  const UserContent({
    required this.id,
    required this.username,
    required this.email,
    required this.picture,
  });

  factory UserContent.fromJson(Map<String, dynamic> json) {
    return UserContent(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      picture: json['picture'],
    );
  }
}
