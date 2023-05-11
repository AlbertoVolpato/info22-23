import 'dart:convert';
import 'dart:html';
import 'package:client/components/my_textfield.dart';
import 'package:client/main.dart';
import 'package:client/screens/screen_controller.dart';
import 'package:client/utils/server_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:client/models/user_api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:image_picker/image_picker.dart';

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1();
}

class _ProfileScreen1 extends State<ProfileScreen1> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  XFile? image;
  File? _file;
  Uint8List? webImage;

  final usernameController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  List<UserForPost> Posts = <UserForPost>[];
  List<UserContent> User = <UserContent>[];

  Future<List<UserForPost>> getPostsofUser() async {
    var token = await user.get('user');
    await user.get('user');
    final response = await http.get(
      Uri.parse('$ServerUrl/post&user/$token'),
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var parsedPostList = json.decode(response.body);
        parsedPostList.forEach((index) {
          Posts.add(UserForPost.fromJson(index));
        });
      }
      //print('getting data');

      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    //print(hasMore);

    return Posts;
  }

  Future<List<UserContent>> fetchByToken() async {
    var token = await user.get('user');
    final response = await http.post(
      Uri.parse(ServerUrl + '/userbytoken'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Bypass-Tunnel-Reminder": "i"
      },
      body: jsonEncode(<String, String>{
        'google_token': token,
      }),
    );

    if (response.statusCode == 200) {
      var parsedList = json.decode(response.body);
      parsedList.forEach((index) {
        User.add(UserContent.fromJson(index));
      });
      return User;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  Future getImageWeb(ImageSource media) async {
    //final imageweb = await ImagePickerWeb.getImageAsBytes();
    final imageweb = await picker.pickImage(source: ImageSource.gallery);
    var f = await imageweb!.readAsBytes();
    setState(() {
      webImage = f;
    });
  }

  Future modifyProfile() async{
      if(kIsWeb){

      } else {
        
      }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '13359980221-62s9pb9ffon3gu0gik6bgk9h43ssvogj.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect();
    await user.delete('user');
  }

  Widget _post() {
    return FutureBuilder<List<UserForPost>>(
        future: getPostsofUser(),
        builder: (context, snapshot) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              final post = Posts[index];
              return Container(
                  color: Colors.black,
                  child: Image.network(
                    '$ServerUrl/uploads/' + Posts[index].image[0],
                    fit: BoxFit.cover,
                  ));
            },
            itemCount: Posts.length,
          );
        });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Column(
              children: [
                Text("Username:"),
                SizedBox(
                              height: 10,
                            ),
                MyTextField(controller: usernameController, hintText: User[0].username, obscureText: false, ),
                SizedBox(
                              height: 30,
                            ),
                            Text("Profile Picture:"),
                       SizedBox(
                              height: 10,
                            ),     
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                  child: kIsWeb
                      ? ElevatedButton(
                          //if user click this button, user can upload image from gallery
                          onPressed: () {
                            Navigator.pop(context);
                            getImageWeb(ImageSource.gallery);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.image),
                              Text('From Gallery'),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            ElevatedButton(
                              //if user click this button, user can upload image from gallery
                              onPressed: () {
                                Navigator.pop(context);
                                getImage(ImageSource.gallery);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.image),
                                  Text('From Gallery'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              //if user click this button. user can upload image from camera
                              onPressed: () {
                                Navigator.pop(context);
                                getImage(ImageSource.camera);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.camera),
                                  Text('From Camera'),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(height: 30),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: const Color(0xFF23B66F),
                    
                     onPressed: () {  },
                     child: Text(
                      "Modifica"
                    ),
                  ),
              ],
            ),
          );
        });
  }

void errorAllert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('error'),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserContent>>(
        future: fetchByToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Color(0xFFEDF0F6),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // topbar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            // VerifyToken[0].username,
                            User[0].username,
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
                                  onPressed: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 14),
                            // prifule statistic
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: snapshot.data![0].picture == null
                                        ? Image.asset(
                                            'assets/images/profile.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            headers: const {
                                              "Bypass-Tunnel-Reminder": "i"
                                            },
                                            '$ServerUrl/uploads/picture/${snapshot.data![0].picture}',
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
                                "la bio é in via di sviluppo",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            // buttons

                            const SizedBox(height: 14),
                            Container(
                                margin: EdgeInsets.all(30),
                                child: MaterialButton(
                                  height: 40,
                                  onPressed: () {myAlert();},
                                  child: Text('Modifica profilo'),
                                  color: Color.fromARGB(255, 190, 190, 190),
                                )),
                            const SizedBox(height: 14),
                            // higlights
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                          borderRadius:
                                              BorderRadius.circular(74),
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            headers: {
                                              "Bypass-Tunnel-Reminder": "i"
                                            },
                                            '$ServerUrl/uploads/picture/${User[0].picture}',
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
                                          borderRadius:
                                              BorderRadius.circular(74),
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
                                      children: const [
                                        Spacer(),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: const [
                                        Spacer(),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: const [
                                        Spacer(),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: const [
                                        Spacer(),
                                        Divider(
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
                            //grid post
                            //  _post()
                            _post()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      onPressed: () async {
                        await _handleSignOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenController()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(Icons.exit_to_app, size: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'LogOut',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } // else {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                const Text('Failed to load data'),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await _handleSignOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenController()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.exit_to_app, size: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'LogOut',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
