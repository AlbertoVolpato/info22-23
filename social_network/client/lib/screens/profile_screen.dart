import 'package:client/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:client/main.dart';
import 'package:client/models/post&user_api.dart';
import 'package:client/models/user_api.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  List<PostsUsersContent> Posts = <PostsUsersContent>[];
  List<UserContent> VerifyToken = <UserContent>[];

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
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var parsedPostList = json.decode(response.body);
      parsedPostList.forEach((index) {
        VerifyToken.add(UserContent.fromJson(index));
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
    print(VerifyToken[0].user_id);
    await getPosts(VerifyToken[0].user_id);
    return VerifyToken;
  }

  Future<List<PostsUsersContent>> getPosts(userId) async {
    final response =
        await http.get(Uri.parse('http://2.34.202.83:5000/postofuser/$userId'));

    if (response.statusCode == 200) {
      //print('getting data');

      var parsedPostList = json.decode(response.body);
      parsedPostList.forEach((posts) {
        Posts.add(PostsUsersContent.fromJson(posts));
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    //print(hasMore);

    return Posts;
  }

  @override
  void initState() {
    fetchByToken(user.get('user'));
    super.initState();
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    // VerifyToken[0].username,
                    "username",
                    style: TextStyle(
                        fontFamily: 'Billabong',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add_box_outlined),
                        iconSize: 32.0,
                        onPressed: () => print('IGTV'),
                      ),
                      SizedBox(width: 16.0),
                      Container(
                        width: 35.0,
                        child: IconButton(
                          icon: Icon(Icons.dehaze),
                          iconSize: 30.0,
                          onPressed: () => print('Direct Messages'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ), // topbar
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 14),
                    // prifule statistic
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/user0.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              children: const [
                                Text(
                                  '59',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Posts',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: const [
                                Text(
                                  '1,179',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: const [
                                Text(
                                  '1,042',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // bio
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'nadhasnim',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // buttons
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Your fellow amateur',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'solo.to/nadahasnim',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                        margin: EdgeInsets.all(30),
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {},
                          child: Text('Modifica profilo'),
                          color: Color.fromARGB(255, 190, 190, 190),
                        )),

                    const SizedBox(height: 14),
                    // higlights
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/user3.png',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('SavedStory'),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: const Center(
                                  child: Icon(Icons.add, size: 40),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('New'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    // tab menu
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // grid post
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     childAspectRatio: 1 / 1,
                    //     crossAxisSpacing: 2,
                    //     mainAxisSpacing: 2,
                    //   ),
                    //   //itemBuilder: (context, index) {
                    //   //  final post = Posts[index];
                    //   //  return Container(
                    //   //    color: Colors.black,
                    //   //    child: Image.network(
                    //   //      'http:2.34.202.83:5000/uploads/${post.image}',
                    //   //      fit: BoxFit.cover,
                    //   //    ),
                    //   //  );
                    //   //},
                    //   //itemCount: Posts.length,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
