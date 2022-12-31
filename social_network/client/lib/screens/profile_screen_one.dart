import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:client/models/user_api.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1();
}

class _ProfileScreen1 extends State<ProfileScreen1> {
  List<UserForPost> Posts = <UserForPost>[];
  List<UserContent> User = <UserContent>[];

  Future<List<UserForPost>> getPostsofUser(token) async {
    final response =
        await http.get(Uri.parse('http://2.34.202.83:5000/post&user/$token'));

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var parsedPostList = json.decode(response.body);
        print(response.body);
        parsedPostList.forEach((index) {
          Posts.add(UserForPost.fromJson(index));
        });
      }
      //print('getting data');

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    //print(hasMore);

    return Posts;
  }

  Future<List<UserContent>> fetchByToken(String token) async {
    final response = await http.post(
      Uri.parse('http://2.34.202.83:5000/userbytoken'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'google_token': token,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      var parsedList = json.decode(response.body);
      parsedList.forEach((index) {
        User.add(UserContent.fromJson(index));
      });
    } else {
      throw Exception('Failed to create album.');
    }
    return User;
  }

  @override
  Widget build(BuildContext context) {
    return Text('username');
  }
}
