import 'package:client/models/post&user_api.dart';
import 'package:flutter/material.dart';
import 'package:client/models/post_model.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreen();
}

class _PostScreen extends State<PostScreen> {
  List<PostsUsersContent> Posts = <PostsUsersContent>[];
  List<PostsUsersContent> PostLenght = <PostsUsersContent>[];

  final controller = ScrollController();
  int page = 1;
  int size = 5;
  bool hasMore = true;
  bool isLoading = false;

  Future<List<PostsUsersContent>> getPosts() async {
    if (isLoading) {
      return Posts;
    }
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
        Uri.parse('http://2.34.202.83:5000/post&user?page=$page&size=$size'));

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
    setState(() {
      if (Posts.length < (page * size)) {
        hasMore = false;
      } else {
        page = page + 1;
        isLoading = false;
      }
      //print(hasMore);
    });
    //print(hasMore);

    return Posts;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (hasMore == true) {
          getPosts();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refresh() async {
    Posts.clear();
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 1;
    });
    getPosts();
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Instagram',
            style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 32.0,
                fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.live_tv),
                iconSize: 30.0,
                onPressed: () => print('IGTV'),
              ),
              const SizedBox(width: 16.0),
              Container(
                width: 35.0,
                child: IconButton(
                  icon: const Icon(Icons.send),
                  iconSize: 30.0,
                  onPressed: () => print('Direct Messages'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _stories() {
    return Container(
      height: 97,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
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
                    const Text('Utente'),
                  ],
                ),
              ],
            ),
          );
        }, //image: AssetImage(stories[index - 1]),
      ),
    );
  }

  Widget _post() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Posts.length + 1,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          if (index < Posts.length) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Container(
                width: double.infinity,
                height: 590.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
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
                                    image: NetworkImage(
                                        'http://2.34.202.83:5000/uploads/picture/${Posts[index].picture}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              Posts[index].username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(Posts[index].created_at),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_horiz),
                              color: Colors.black,
                              onPressed: () => print('More'),
                            ),
                          ),
                          InkWell(
                            onDoubleTap: () => print('Like PostModels'),
                            onTap: () {
                              //Navigator.push(
                              //  context,
                              //  MaterialPageRoute(
                              //    builder: (context) =>
                              //        ViewPostModelsScreen(
                              //      PostModels: PostModelss[index],
                              //    ),
                              //  ),
                              //);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              width: double.infinity,
                              height: 400.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 5),
                                    blurRadius: 8.0,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'http://2.34.202.83:5000/uploads/${Posts[index].image[0]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon:
                                              const Icon(Icons.favorite_border),
                                          iconSize: 30.0,
                                          onPressed: () =>
                                              print('Like PostModels'),
                                        ),
                                        const Text(
                                          '2,515',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20.0),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: const Icon(Icons.chat),
                                          iconSize: 30.0,
                                          onPressed: () {
                                            //Navigator.push(
                                            //  context,
                                            //  MaterialPageRoute(
                                            //    builder: (context) =>
                                            //        ViewPostModelsScreen(
                                            //      PostModels: PostModelss[index],
                                            //    ),
                                            //  ),
                                            //);
                                          },
                                        ),
                                        const Text(
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
                                  icon: const Icon(Icons.bookmark_border),
                                  iconSize: 30.0,
                                  onPressed: () => print('Save PostModels'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 34.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          Posts[index].username,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 4.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          Posts[index].content,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (hasMore == false) {
            const SizedBox(height: 20.0);
            return const SizedBox(
              width: 60,
              height: 60,
              child: FittedBox(child: Text('all data loaded')),
            );
          } else {
            const SizedBox(height: 20.0);
            return const SizedBox(
              width: 60,
              height: 60,
              child: FittedBox(child: CircularProgressIndicator()),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        backgroundColor: const Color(0xFFEDF0F6),
        body: ListView(
          controller: controller,
          children: <Widget>[
            _header(),
            const SizedBox(height: 10),
            _stories(),
            _post(),
          ],
        ),
      ),
    );
  }
}
