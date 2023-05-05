import 'package:client/models/post_like.dart';
import 'package:client/models/user_api.dart';
import 'package:client/utils/server_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:client/models/post_model.dart';
import 'package:client/models/comment_model.dart';
import '../models/post&user_api.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ViewPostScreen extends StatefulWidget {
  final PostsUsersContent post;
  final UserContent user;

  const ViewPostScreen({required this.post, required this.user});

  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  Future<http.Response?> postLike(String user_id, String post_id) async {
    http.Response? response;
    try {
      Map data = {'user_id': user_id, 'post_id': post_id};
      String body = json.encode(data);
      response = await http.post(Uri.parse('$ServerUrl/post-like'),
          headers: {"Content-Type": "application/json"}, body: body);
    } catch (e) {
      print(e.toString());
    }
    return response;
  }

  Future<List<Comment>> getComments(String post_id) async {
    List<Comment> Comments = <Comment>[];
    try {
      final response = await http.get(
        Uri.parse('$ServerUrl/post-like/$post_id'),
      );

      if (response.statusCode == 200) {
        //print('getting data');
        var parsedCommentList = json.decode(response.body);
        parsedCommentList.forEach((comments) {
          Comments.add(Comment.fromJson(comments));
        });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
    return Comments;
  }

  Future<List<LikeModule>> getLike(String post_id) async {
    List<LikeModule> Likes = <LikeModule>[];
    try {
      final response = await http.get(
        Uri.parse('$ServerUrl/post-like/$post_id'),
      );

      if (response.statusCode == 200) {
        //print('getting data');
        var parsedLikeList = json.decode(response.body);
        parsedLikeList.forEach((posts) {
          Likes.add(LikeModule.fromJson(posts));
        });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
    return Likes;
  }

  Future<dynamic> removeLike(String like_id) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse('$ServerUrl/post-like/$like_id'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to remove like.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _like(post_id) {
    return FutureBuilder<List<LikeModule>>(
        future: getLike(post_id),
        builder: (context, AsyncSnapshot<List<LikeModule>> snapshot) {
          var likeLenght = snapshot.data?.length;
          var liked = false;
          var likeNumber = snapshot.data!.length;
          if (snapshot.hasData) {
            for (var i = 0; i < likeLenght!; i++) {
              print(snapshot.data?[i].user_id);
              if (snapshot.data?[i].user_id == widget.user.user_id) {
                liked = true;
                i = likeLenght;
              }
              ;
            }
            if (liked == true) {
              return Row(children: [
                IconButton(
                    icon: const Icon(Icons.favorite),
                    iconSize: 30.0,
                    onPressed: () {
                      print("remove like");
                      setState(() {
                        liked = false;
                        likeNumber = likeNumber - 1;
                        getLike(post_id);
                      });
                      removeLike(snapshot.data![0].like_id);
                    }),
                Text(
                  likeNumber.toString() + " likes",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]);
            } else {
              return Row(children: [
                IconButton(
                    icon: const Icon(Icons.favorite_border),
                    iconSize: 30.0,
                    onPressed: () {
                      print('Like PostModels');
                      setState(() {
                        liked = true;
                        likeNumber = likeNumber + 1;
                        getLike(post_id);
                      });
                      postLike(widget.user.user_id, post_id);
                    }),
                Text(
                  likeNumber.toString() + " likes",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]);
            }
          } else {
            return Row(children: [
              IconButton(
                  icon: const Icon(Icons.favorite_border),
                  iconSize: 30.0,
                  onPressed: () {
                    print('Like PostModels');
                    setState(() {
                      liked = true;
                      likeNumber = likeNumber + 1;
                      getLike(post_id);
                    });
                    postLike(widget.user.user_id, post_id);
                  }),
              Text(
                "0 " + " likes",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]);
          }
        });
  }

  Widget _getComments(String post_id) {
    return FutureBuilder<List<Comment>>(
        future: getComments(post_id),
        builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
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
                                  '$ServerUrl/uploads/picture/${snapshot.data![index].picture}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(snapshot.data![index].content),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                        ),
                        color: Colors.grey,
                        onPressed: () => print('Like comment'),
                      ),
                    ),
                  );
                } else {
                  return Text("non ci sono commenti");
                }
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F6),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 40.0),
              width: double.infinity,
              height: 600.0,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 30.0,
                              color: Colors.black,
                              onPressed: () => Navigator.pop(context),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: ListTile(
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
                                            '$ServerUrl/uploads/picture/${widget.post.picture}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  widget.post.content,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(widget.post.username),
                                trailing: IconButton(
                                  icon: const Icon(Icons.more_horiz),
                                  color: Colors.black,
                                  onPressed: () => print('More'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onDoubleTap: () => print('Like post'),
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
                                    '$ServerUrl/uploads/${widget.post.image[0]}'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  _like(widget.post.post_id),
                                  const SizedBox(width: 20.0),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: const Icon(Icons.chat),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          print('Chat');
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
                                onPressed: () => print('Save post'),
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
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              height: 600.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  _getComments(widget.post.post_id),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 100.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.all(20.0),
                hintText: 'Add a comment',
                prefixIcon: Container(
                  margin: const EdgeInsets.all(4.0),
                  width: 48.0,
                  height: 48.0,
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
                        height: 48.0,
                        width: 48.0,
                        image: NetworkImage(
                            '$ServerUrl/uploads/picture/${widget.user.picture}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: 4.0),
                  width: 70.0,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: const Color(0xFF23B66F),
                    onPressed: () => print('Post comment'),
                    child: const Icon(
                      Icons.send,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
